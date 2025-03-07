function eventTable = generateEventTable(~, data, sensorEvents)

    arguments (Input)
        ~
        data (1, 1) mag.Science
        sensorEvents timetable
    end

    arguments (Output)
        eventTable eventtable
    end

    sensorEvents.Mode = categorical(sensorEvents.Mode);
    sensorEvents.Reason = categorical(sensorEvents.Reason);

    % Select sensor.
    sensorName = string(data.Metadata.Sensor);

    if data.Metadata.Primary
        primaryOrSecondary = "Primary";
    else
        primaryOrSecondary = "Secondary";
    end

    % Adapt existing event properties.
    if contains("Sensor", sensorEvents.Properties.VariableNames)

        sensorEvents = sensorEvents(ismissing([sensorEvents.Sensor]) | ([sensorEvents.Sensor] == sensorName), :);
        sensorEvents = removevars(sensorEvents, "Sensor");
    end

    sensorEvents = removeUninterestingVariables(sensorEvents, primaryOrSecondary);

    % Improve ramp mode timestamp estimates.
    sensorEvents = updateRampModeTimestamps(sensorEvents, data.Data);

    % Improve estimates of mode changes.
    sensorEvents = findModeChanges(data.Data, sensorEvents, sensorName);

    % Basic structure for events table.
    eventTable = mag.Science.generateEmptyEventtable();

    % Process range changes.
    % Range changes can be automatic, so add automatic transitions. If they
    % are commanded, correct the times at which they occur.
    ranges = sortrows(data.Data(:, data.Settings.Range));

    if ~isempty(ranges)

        [rangeTable, sensorEvents] = findRangeChanges(ranges, sensorEvents, sensorName);

        if isempty(sensorEvents)

            eventTable = joinEventTables(eventTable, rangeTable);
            eventTable{:, "Mode"} = categorical(missing());
            eventTable{:, ["DataFrequency", "PacketFrequency"]} = double(missing());
        else
            eventTable = joinEventTables(sensorEvents, rangeTable);
        end

    % Just use sensor events.
    else
        eventTable = joinEventTables(eventTable, sensorEvents);
    end

    % Add sensor shutdown.
    shutDownTable = array2timetable(NaN(1, numel(eventTable.Properties.VariableNames)), RowTimes = max(data.Time) + mag.time.Constant.Eps, VariableNames = eventTable.Properties.VariableNames);
    shutDownTable.Mode = categorical(shutDownTable.Mode);
    shutDownTable.Label = sensorName + " Shutdown";
    shutDownTable.Reason = categorical("Command");

    eventTable = sortrows([eventTable; shutDownTable]);

    % Ensure no duplicate times.
    locDuplicate = diff(eventTable.Time) == 0;
    eventTable.Time(locDuplicate) = eventTable.Time(locDuplicate) - mag.time.Constant.Eps;

    % Process variables.
    fillVariables = ["Mode", "DataFrequency", "PacketFrequency", "Range"];
    eventTable(:, fillVariables) = fillmissing(eventTable(:, fillVariables), "previous");

    eventTable{contains(eventTable.Label, "Config"), ["DataFrequency", "PacketFrequency", "Duration"]} = missing();
    eventTable{contains(eventTable.Label, "Ramp"), "Range"} = NaN();

    % Convert to event table.
    eventTable = eventtable(eventTable, EventLabelsVariable = "Label");
end

function sensorEvents = removeUninterestingVariables(sensorEvents, primaryOrSecondary)

    % Remove uninteresting sensor events and rename selected sensor ones.
    switch primaryOrSecondary
        case "Primary"

            sensorEvents = renamevars(sensorEvents, ["PrimaryNormalRate", "PrimaryBurstRate"], ["DataNormalFrequency", "DataBurstFrequency"]);
            sensorEvents = removevars(sensorEvents, regexpPattern("Secondary\w*"));
        case "Secondary"

            sensorEvents = renamevars(sensorEvents, ["SecondaryNormalRate", "SecondaryBurstRate"], ["DataNormalFrequency", "DataBurstFrequency"]);
            sensorEvents = removevars(sensorEvents, regexpPattern("Primary\w*"));
    end

    % Only select active mode data and packet frequency.
    sensorEvents.DataFrequency = NaN([height(sensorEvents), 1]);
    sensorEvents.PacketFrequency = NaN([height(sensorEvents), 1]);

    filter = rowfilter(sensorEvents);

    sensorEvents{filter.Mode == "Normal", "DataFrequency"} = sensorEvents{filter.Mode == "Normal", "DataNormalFrequency"};
    sensorEvents{filter.Mode == "Burst", "DataFrequency"} = sensorEvents{filter.Mode == "Burst", "DataBurstFrequency"};

    sensorEvents{filter.Mode == "Normal", "PacketFrequency"} = sensorEvents{filter.Mode == "Normal", "PacketNormalFrequency"};
    sensorEvents{filter.Mode == "Burst", "PacketFrequency"} = sensorEvents{filter.Mode == "Burst", "PacketBurstFrequency"};

    % Rearrange variables.
    sensorEvents = removevars(sensorEvents, regexpPattern("(Data|Packet)\w+Frequency"));
    sensorEvents = movevars(sensorEvents, ["DataFrequency", "PacketFrequency"], After = "Mode");
end

function events = updateRampModeTimestamps(events, data)

    % Improve ramp mode estimate.
    idxRamp = find(contains([events.Label], "Ramp", IgnoreCase = true));
    idxRamp = vertcat(idxRamp, idxRamp + 1);

    rampEvents = events(idxRamp, :);

    if ~isempty(rampEvents)

        % Correct estimate based on science data.
        data = data(timerange(rampEvents.Time(1) - minutes(5), rampEvents.Time(end) + minutes(5), "closed"), :);

        matches = double.empty(2, 0);
        times = mag.time.emptyTime(2, 0);

        for v = ["x", "y", "z"]

            dv = diff(data.(v));
            m = strfind(dv', mag.process.Ramp.Pattern);

            if ~isempty(m)

                matches(:, end + 1) = [m(1); m(end)]; %#ok<AGROW>
                times(:, end + 1) = data.(data.Properties.DimensionNames{1})(matches(:, end)); %#ok<AGROW>
            end
        end

        if isempty(times)
            return;
        elseif numel(unique(times)) > 2

            warning("Inconsistent ramp mode. Selecting earliest and latest timestamps as beginning and end.");

            idxStart = min(matches(1, :));
            idxEnd = max(matches(end, :));
        else

            idxStart = matches(1);
            idxEnd = matches(end);
        end

        events.Time(idxRamp(1)) = data.t(idxStart);
        events.Time(idxRamp(end)) = data.t(idxEnd + numel(mag.process.Ramp.Pattern) + 1);
    end
end

function events = findModeChanges(data, events, name)

    timeColumn = data.Properties.DimensionNames{1};

    % If there no events were detected, find mode changes by looking at
    % timestamp cadence.
    if isempty(events)

        data = sortrows(data);

        % Find changes in timestamp cadence.
        t = data.(timeColumn);
        dt = milliseconds(diff(t));

        idxRemove = find(ismissing(dt) | (dt < 1) | (dt > 1000)) + 1;
        idxRemove(idxRemove > height(data)) = height(data);
        
        t(idxRemove) = [];
        dt = milliseconds(diff(t));

        idxChange = findchangepts(dt, MinThreshold = 1);
        idxChange(diff(idxChange) == 1) = [];

        % Correct for data that was filtered out.
        for i = idxRemove'

            locUpdate = idxChange >= i;
            idxChange(locUpdate) = idxChange(locUpdate) + 1;
        end

        % Create event details.
        idxChange = [1; idxChange; height(data) + 1];

        for i = 1:(numel(idxChange) - 1)

            d = data(idxChange(i):(idxChange(i+1) - 1), :);
            f = round(1 / seconds(mode(diff(d.(timeColumn)))));

            if f < 8
                m = "Normal";
            else
                m = "Burst";
            end

            e = struct2table(struct(Mode = m, ...
                DataFrequency = f, ...
                PacketFrequency = NaN, ...
                Duration = 0, ...
                Range = NaN, ...
                Label = compose("%s %s (%d)", name, m, f), ...
                Reason = "Command"));
            t = table2timetable(e, RowTimes = d.(timeColumn)(1));

            events = [events; eventtable(t, EventLabelsVariable = "Label")]; %#ok<AGROW>
        end

        % Remove duplicate events.
        events(find(diff(events.DataFrequency) == 0) + 1, :) = [];
    else

        searchWindow = seconds(30);
        data = sortrows(data);

        % Update timestamps for mode changes.
        idxMode = find([true; diff(events.DataFrequency) ~= 0] & ~ismissing(events.DataFrequency) & ~ismissing(events.Duration));

        for i = idxMode'

            % Find window around event and compute actual timestamp difference.
            t = events.Time(i);
            eventWindow = data(withtol(t, searchWindow), :);
            
            % Remove artificial timestamps.
            eventWindow = eventWindow(eventWindow.quality.isScience(), :);

            if isempty(eventWindow)
                continue;
            end

            dt = seconds(diff(eventWindow.(timeColumn)));
            ddt = diff(dt);

            if all(ddt == 0)
                events.Time(i) = eventWindow.t(1);
            elseif all(ddt < 1e-3)

                if seconds(t - eventWindow.t(1)) < 1.5
                    events.Time(i) = eventWindow.t(1);
                else

                    [~, idxMin] = min(abs(t - eventWindow.(timeColumn)));
                    events.Time(i) = eventWindow.(timeColumn)(idxMin);
                end
            else

                [~, idxChange] = max(diff(dt), [], ComparisonMethod = "abs");
                events.Time(i) = eventWindow.(timeColumn)(idxChange + 1);
            end
        end
    end
end

function [rangeTable, events] = findRangeChanges(ranges, events, sensorName)

    % Find range changes.
    locRange = diff(ranges.range) ~= 0;

    rangeTable = vertcat(ranges(1, :), ranges(find(locRange) + 1, "range"));
    rangeTable = renamevars(rangeTable, "range", "Range");
    rangeTable.Properties.DimensionNames(1) = "Time";

    % Update timestamps for commanded range changes.
    idxDelete = [];

    for i = 1:height(rangeTable)

        e = events(withtol(rangeTable.Time(i), minutes(1)), "Range");

        if any(e.Range == rangeTable.Range(i))

            [~, idxMin] = min(abs(events.Time - rangeTable.Time(i)));

            events.Time(idxMin) = rangeTable.Time(i);
            idxDelete(end + 1) = i; %#ok<AGROW>
        end
    end

    rangeTable(idxDelete, :) = [];
    events{~contains(events.Label, "Range"), "Range"} = missing();

    % If the first range change is after the first event (and they are
    % close to each other) update its range.
    if ~isempty(rangeTable)

        firstRange = events(withtol(rangeTable.Time(1), seconds(0.5)), :);

        if ~isempty(firstRange) && ismissing(firstRange.Range) && ~contains(firstRange.Label, "Range")
            events{withtol(rangeTable.Time(1), seconds(0.5)), "Range"} = rangeTable.Range(1);
        end
    end

    % Complete automatic range changes.
    rangeTable.Label = compose("%s Range %d", sensorName, [rangeTable.Range]);
    rangeTable.Reason = categorical(repmat("Auto", size(rangeTable, 1), 1));

    rangeTable = sortrows(rangeTable, "Time");
end

function eventTable = joinEventTables(table1, table2)
    eventTable = outerjoin(table1, table2, MergeKeys = true, Keys = ["Time", intersect(table1.Properties.VariableNames, table2.Properties.VariableNames)]);
end

classdef (Abstract) Event < matlab.mixin.Heterogeneous & matlab.mixin.Copyable & mag.mixin.SetGet & mag.mixin.Crop
% EVENT Interface for MAG events.

    properties
        % COMMANDTIMESTAMP Timestamp of command.
        CommandTimestamp (1, 1) datetime = NaT(TimeZone = "UTC")
        % ACKNOWLEDGETIMESTAMP Timestamp of acknowledge.
        AcknowledgeTimestamp (1, 1) datetime = NaT(TimeZone = "UTC")
        % COMPLETETIMESTAMP Timestamp of completion.
        CompleteTimestamp (1, 1) datetime = NaT(TimeZone = "UTC")
        % TYPE Packet type.
        Type (1, 1) double
        % SUBTYPE Packet sub-type.
        SubType (1, 1) double
    end

    methods (Sealed)

        function sortedThis = sort(this, varargin)
        % SORT Override default sorting algorithm.

            [~, idxSort] = sort([this.CompleteTimestamp], varargin{:});
            sortedThis = this(idxSort);
        end

        function this = crop(this, timeFilter)

            arguments
                this mag.event.Event
                timeFilter {mag.mixin.Crop.mustBeTimeFilter}
            end

            % Crop events.
            timestamps = this.getTimestamps();
            [startTime, endTime] = this.convertToStartEndTime(timeFilter, timestamps);

            if ismissing(startTime) || ismissing(endTime) || (startTime >= endTime)

                this = mag.event.Event.empty();
                return;
            end

            % Find the earliest previous mode change.
            originalEventTable = this.eventtable();

            newEvents = originalEventTable(originalEventTable.Time >= startTime, :);
            croppedEvents = originalEventTable(originalEventTable.Time < startTime, :);
            lastModeChange = croppedEvents(find(contains(croppedEvents.Label, "(" | ")"), 1, "last"), :);

            % Crop events.
            eventTypes = unique([this.Type]);
            locKeep = isbetween(timestamps, startTime, endTime, "closed");

            croppedEvents = this(~locKeep);
            this = this(locKeep);

            % Find the earliest previous mode and range changes.
            lastEvents = mag.event.Event.empty();

            if isempty(this) | (min(this.getTimestamps()) > startTime)

                for i = eventTypes
                    lastEvents = [lastEvents, croppedEvents(find([croppedEvents.Type] == i, 1, "last"))]; %#ok<AGROW>
                end

                % Correct the mode change parameters, as they may be missing.
                % Moreover, the duration will be incorrect.
                locModeChange = arrayfun(@(x) isa(x, "mag.event.ModeChange"), lastEvents);

                if any(locModeChange)

                    e = lastEvents(locModeChange);

                    if ~isempty(lastModeChange)

                        for p = ["Mode", "PrimaryNormalRate", "SecondaryNormalRate", "PacketNormalFrequency", "PrimaryBurstRate", "SecondaryBurstRate", "PacketBurstFrequency"]
                            e.(p) = lastModeChange.(p);
                        end
                    end

                    if (e.Duration > 0) && isequal(e.Mode, "Burst")

                        locNextMode = (newEvents.Time > e.getTimestamps()) & contains(newEvents.Label, "(" | ")");
                        nextModeTime = newEvents.Time(find(locNextMode, 1, "first"));

                        e.Duration = seconds(nextModeTime - startTime);
                    else
                        e.Duration = 0;
                    end
                end

                % Adjust completion time.
                for i = 1:numel(lastEvents)
                    lastEvents(i).CompleteTimestamp = startTime + (i * mag.time.Constant.Eps); % add "eps" seconds so that they are not all the same
                end
            end

            % Re-add events.
            this = [lastEvents, this];
        end
    end

    methods (Static)

        function emptyTable = generateEmptyEventtable()
        % GENERATEEMPTYEVENTTABLE Generate empty timetable for describing
        % events.

            emptyTime = datetime.empty();
            emptyTime.TimeZone = mag.time.Constant.TimeZone;

            emptyTable = struct2table(struct(Time = emptyTime, ...
                Mode = string.empty(0, 1), ...
                PrimaryNormalRate = double.empty(0, 1), ...
                SecondaryNormalRate = double.empty(0, 1), ...
                PacketNormalFrequency = double.empty(0, 1), ...
                PrimaryBurstRate = double.empty(0, 1), ...
                SecondaryBurstRate = double.empty(0, 1), ...
                PacketBurstFrequency = double.empty(0, 1), ...
                Duration = double.empty(0, 1), ...
                Range = double.empty(0, 1), ...
                Sensor = string.empty(0, 1), ...
                Label = string.empty(0, 1), ...
                Reason = string.empty(0, 1)));
            emptyTable = table2timetable(emptyTable, RowTimes = "Time");
        end
    end

    methods (Hidden, Sealed)

        function timetableThis = timetable(this, options)
        % TIMETABLE Convert events to timetable.

            arguments
                this
                options.FillMissing (1, 1) logical = true
            end

            timetableThis = this.generateEmptyEventtable();

            for t = 1:numel(this)

                tt = this(t).convertToTimeTable();
                timetableThis = outerjoin(timetableThis, tt, MergeKeys = true, Keys = ["Time", intersect(timetableThis.Properties.VariableNames, tt.Properties.VariableNames)]);
            end

            timetableThis = sortrows(timetableThis);

            if options.FillMissing
                timetableThis = this.fillMissingDetails(timetableThis);
            end

            timetableThis.Reason = repmat("Command", height(timetableThis), 1);
        end

        function eventtableThis = eventtable(this)
        % EVENTTABLE Convert events to eventtable.

            eventtableThis = this.timetable(FillMissing = false);

            locTimedCommand = ~ismissing(eventtableThis.Duration) & (eventtableThis.Duration ~= 0);
            idxTimedCommand = find(locTimedCommand);

            for i = idxTimedCommand(:)'

                autoEvent = eventtableThis(i, :);
                autoEvent.Time = eventtableThis.Time(i) + seconds(eventtableThis.Duration(i));
                autoEvent.Mode = "Normal"; % auto-exit sends instrument to Normal
                autoEvent.Duration = 0;
                autoEvent.Reason = "Auto";

                if isequal(autoEvent.Mode, "Normal")
                    autoEvent.Label = compose("Normal (%d, %d)", autoEvent.PrimaryNormalRate, autoEvent.SecondaryNormalRate);
                else
                    autoEvent.Label = compose("Burst (%d, %d)", autoEvent.PrimaryBurstRate, autoEvent.SecondaryBurstRate);
                end

                eventtableThis = [eventtableThis; autoEvent]; %#ok<AGROW>
            end

            eventtableThis = sortrows(eventtableThis);
            eventtableThis = eventtable(eventtableThis, EventLabelsVariable = "Label");

            eventtableThis = this.fillMissingDetails(eventtableThis);
        end
    end

    methods (Abstract, Access = protected)

        % CONVERTTOTIMETABLE Convert event to timetable.
        tableThis = convertToTimeTable(this)
    end

    methods (Sealed)

        function timestamps = getTimestamps(this)
        % GETTIMESTAMPS Get timestamps of events, with following priority:
        % if completion time is missing, use acknowledgment time, if that
        % is also missing, use command time.

            timestamps = [this.CompleteTimestamp];
            locMissing = ismissing(timestamps);

            if any(locMissing)

                timestamps(locMissing) = [this(locMissing).AcknowledgeTimestamp];
                locMissing = ismissing(timestamps);
            
                if any(locMissing)
                    timestamps(locMissing) = this(locMissing).CommandTimestamp;
                end
            end

            if isempty(timestamps)

                timestamps = datetime.empty();
                timestamps.TimeZone = mag.time.Constant.TimeZone;
            end
        end
    end

    methods (Static, Access = private)

        function tableThis = fillMissingDetails(tableThis)

            fillVariables = intersect(["Mode", "PrimaryNormalRate", "SecondaryNormalRate", "PacketNormalFrequency", "PrimaryBurstRate", "SecondaryBurstRate", "PacketBurstFrequency", "Range"], tableThis.Properties.VariableNames);
            tableThis(:, fillVariables) = fillmissing(tableThis(:, fillVariables), "previous");

            tableThis{contains(tableThis.Label, "Config"), ["PrimaryNormalRate", "SecondaryNormalRate", "PacketNormalFrequency", "PrimaryBurstRate", "SecondaryBurstRate", "PacketBurstFrequency", "Duration"]} = missing();
            tableThis{contains(tableThis.Label, "Ramp"), "Range"} = missing();
        end
    end
end

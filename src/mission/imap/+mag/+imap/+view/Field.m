classdef Field < mag.imap.view.Science
% FIELD Show magnetic field and optional HK.

    properties
        % EVENTS Event names to show.
        Events (1, :) string {mustBeMember(Events, ["Compression", "Mode", "Range"])} = string.empty()
    end

    methods

        function this = Field(results, options)

            arguments
                results (1, 1) mag.imap.Instrument
                options.?mag.imap.view.Field
            end

            this.Results = results;

            this.assignProperties(options);
        end

        function visualize(this)

            this.Figures = matlab.ui.Figure.empty();

            [primarySensor, secondarySensor] = this.getSensorNames();
            pwrHK = this.Results.HK.getHKType("PW");

            primary = this.Results.Primary;
            secondary = this.Results.Secondary;

            [numScience, scienceData] = this.getScienceData(primary, secondary);
            [numEvents, eventData] = this.getEventData(primary, secondary, primarySensor, secondarySensor);

            if isempty(scienceData)
                return;
            end

            if pwrHK.isPlottable()

                this.Figures = this.Factory.assemble( ...
                    scienceData{:}, ...
                    eventData{:}, ...
                    pwrHK, [mag.graphics.style.Default(Title = compose("%s & ICU Temperatures", primarySensor), YLabel = this.TLabel, Legend = [primarySensor, "ICU"], Charts = mag.graphics.chart.Plot(YVariables = [primarySensor, "ICU"] + "Temperature")), ...
                    mag.graphics.style.Default(Title = compose("%s & ICU Temperatures", secondarySensor), YLabel = this.TLabel, YAxisLocation = "right", Legend = [secondarySensor, "ICU"], Charts = mag.graphics.chart.Plot(YVariables = [secondarySensor, "ICU"] + "Temperature"))], ...
                    Title = this.getFigureTitle(primary, secondary), ...
                    Name = this.getFigureName(primary, secondary), ...
                    Arrangement = [4 + numEvents, numScience], ...
                    LinkXAxes = true, ...
                    WindowState = "maximized");
            else

                this.Figures = this.Factory.assemble( ...
                    scienceData{:}, ...
                    eventData{:}, ...
                    Title = this.getFigureTitle(primary, secondary), ...
                    Name = this.getFigureName(primary, secondary), ...
                    Arrangement = [3 + numEvents, numScience], ...
                    LinkXAxes = true, ...
                    WindowState = "maximized");
            end
        end
    end

    methods (Access = private)

        function [numScience, scienceData] = getScienceData(this, primary, secondary)

            numScience = 0;
            scienceData = {};

            if ~isempty(primary) && primary.HasData

                numScience = numScience + 1;
                scienceData = [scienceData, {primary, ...
                    mag.graphics.style.Stackedplot(Title = this.getFieldTitle(primary), YLabels = ["x [nT]", "y [nT]", "z [nT]", "|B| [nT]"], Layout = [3, 1], ...
                    Charts = mag.graphics.chart.Stackedplot(YVariables = ["X", "Y", "Z", "B"], Filter = primary.Quality.isPlottable()))}];
            end

            if ~isempty(secondary) && secondary.HasData

                numScience = numScience + 1;
                scienceData = [scienceData, {secondary, ...
                    mag.graphics.style.Stackedplot(Title = this.getFieldTitle(secondary), YLabels = ["x [nT]", "y [nT]", "z [nT]", "|B| [nT]"], YAxisLocation = "right", Layout = [3, 1], ...
                    Charts = mag.graphics.chart.Stackedplot(YVariables = ["X", "Y", "Z", "B"], Filter = secondary.Quality.isPlottable()))}];
            end
        end

        function [numEvents, eventData] = getEventData(this, primary, secondary, primarySensor, secondarySensor)

            numEvents = 0;
            eventData = {};

            selectedEvents = this.Events;

            if isempty(selectedEvents) && (any(diff(primary.Compression) ~= 0) || any(diff(secondary.Compression) ~= 0))
                selectedEvents = "Compression";
            end

            for e = selectedEvents

                switch e
                    case "Compression"

                        numEvents = numEvents + 1;
                        ed = {primary, mag.graphics.style.Default(Title = compose("%s Compression", primarySensor), YLabel = "compressed [-]", YLimits = "manual", Charts = mag.graphics.chart.custom.Event(EventOfInterest = "Compression")), ...
                            secondary, mag.graphics.style.Default(Title = compose("%s Compression", secondarySensor), YLabel = "compressed [-]", YLimits = "manual", YAxisLocation = "right", Charts = mag.graphics.chart.custom.Event(EventOfInterest = "Compression"))};

                    case "Mode"

                        numEvents = numEvents + 1;
                        ed = {primary.Events, mag.graphics.style.Default(Title = compose("%s Modes", primarySensor), YLabel = "mode [-]", YLimits = "manual", Charts = mag.graphics.chart.custom.Event(EventOfInterest = "DataFrequency", EndTime = primary.Time(end))), ...
                            secondary.Events, mag.graphics.style.Default(Title = compose("%s Modes", secondarySensor), YLabel = "mode [-]", YLimits = "manual", YAxisLocation = "right", Charts = mag.graphics.chart.custom.Event(EventOfInterest = "DataFrequency", EndTime = secondary.Time(end)))};

                    case "Range"

                        numEvents = numEvents + 1;
                        ed = {primary, mag.graphics.style.Default(Title = compose("%s Ranges", primarySensor), YLabel = "range [-]", YLimits = "manual", Charts = mag.graphics.chart.custom.Event(EventOfInterest = "Range", IgnoreMissing = false, YOffset = 0.25)), ...
                            secondary, mag.graphics.style.Default(Title = compose("%s Ranges", secondarySensor), YLabel = "range [-]", YLimits = "manual", YAxisLocation = "right", Charts = mag.graphics.chart.custom.Event(EventOfInterest = "Range", IgnoreMissing = false, YOffset = 0.25))};

                    otherwise
                        error("Unrecognized event ""%s"".", e);
                end

                eventData = [eventData, ed]; %#ok<AGROW>
            end
        end
    end
end

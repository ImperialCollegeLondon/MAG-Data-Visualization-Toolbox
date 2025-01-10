classdef Timestamp < mag.graphics.view.View
% TIMESTAMP Show analysis of science and I-ALiRT timestamps.

    methods

        function this = Timestamp(results, options)

            arguments
                results (1, 1) mag.imap.Instrument
                options.?mag.imap.view.Timestamp
            end

            this.Results = results;

            this.assignProperties(options);
        end

        function visualize(this)

            this.Figures = matlab.ui.Figure.empty();

            [primarySensor, secondarySensor] = this.getSensorNames();

            primaryScience = this.Results.Primary;
            secondaryScience = this.Results.Secondary;

            modeEventCharts = {primaryScience.Events, mag.graphics.style.Default(Title = compose("%s Modes", primarySensor), YLabel = "mode [-]", YLimits = "manual", Charts = mag.graphics.chart.custom.Event(EventOfInterest = "DataFrequency", EndTime = primaryScience.Time(end))), ...
                secondaryScience.Events, mag.graphics.style.Default(Title = compose("%s Modes", secondarySensor), YLabel = "mode [-]", YLimits = "manual", Charts = mag.graphics.chart.custom.Event(EventOfInterest = "DataFrequency", EndTime = secondaryScience.Time(end)))};

            % Plot difference in primary/secondary science timestamps.
            this.Figures(1) = this.Factory.assemble( ...
                primaryScience, ...
                mag.graphics.style.Default(Title = primarySensor, YLabel = "\Deltat [ms]", YScale = "log", Layout = [2, 1], Charts = mag.graphics.chart.Plot(YVariables = this.getScienceTimingOperation(), Filter = primaryScience.Quality.isScience())), ...
                secondaryScience, ...
                mag.graphics.style.Default(Title = secondarySensor, YLabel = "\Deltat [ms]", YScale = "log", Layout = [2, 1], Charts = mag.graphics.chart.Plot(YVariables = this.getScienceTimingOperation(), Filter = secondaryScience.Quality.isScience())), ...
                modeEventCharts{:}, ...
                Name = "Science Consecutive Timestamp Analysis", ...
                Arrangement = [6, 1], ...
                LinkXAxes = true, ...
                WindowState = "maximized");

            % Plot difference in primary vs. secondary science timestamp.
            matchedSecondaryTime = this.retrieveMatchingTimestamps(primaryScience.Time, secondaryScience.Time, Threshold = 1e2);
            matchedPrimaryTime = this.retrieveMatchingTimestamps(secondaryScience.Time, primaryScience.Time, Threshold = 1e2);

            primaryComparison = table(primaryScience.Time, matchedSecondaryTime, VariableNames = ["p", "s"]);
            secondaryComparison = table(secondaryScience.Time, matchedPrimaryTime, VariableNames = ["s", "p"]);

            this.Figures(2) = this.Factory.assemble( ...
                primaryComparison, ...
                mag.graphics.style.Default(Title = compose("%s vs. %s", primarySensor, secondarySensor), YLabel = "\Deltat [ms]", YScale = "log", Layout = [2, 1], Charts = mag.graphics.chart.Plot(XVariable = "p", YVariables = this.getScienceTimingComparisonOperation("p", "s"), Filter = primaryScience.Quality.isScience())), ...
                secondaryComparison, ...
                mag.graphics.style.Default(Title = compose("%s vs. %s", secondarySensor, primarySensor), YLabel = "\Deltat [ms]", YScale = "log", Layout = [2, 1], Charts = mag.graphics.chart.Plot(XVariable = "s", YVariables = this.getScienceTimingComparisonOperation("s", "p"), Filter = secondaryScience.Quality.isScience())), ...
                modeEventCharts{:}, ...
                Name = "Science Comparison Timestamp Analysis", ...
                Arrangement = [6, 1], ...
                LinkXAxes = true, ...
                WindowState = "maximized");

            % Plot difference in I-ALiRT timestamp.
            if this.Results.IALiRT.isPlottable()

                primaryIALiRT = this.Results.IALiRT.Primary;
                secondaryIALiRT = this.Results.IALiRT.Secondary;

                if numel(primaryIALiRT.Time) == numel(secondaryIALiRT.Time)

                    primaryScienceTime = this.retrieveMatchingTimestamps(primaryIALiRT.Time, primaryScience.Time, Threshold = 1e3);
                    secondaryScienceTime = this.retrieveMatchingTimestamps(secondaryIALiRT.Time, secondaryScience.Time, Threshold = 1e3);

                    timestampComparison = table(primaryScienceTime, primaryIALiRT.Time, secondaryScienceTime, secondaryIALiRT.Time, ...
                        VariableNames = ["ps", "pi", "ss", "si"]);

                    this.Figures(3) = this.Factory.assemble( ...
                        timestampComparison, ...
                        [mag.graphics.style.Default(Title = compose("I-ALiRT %s vs. %s", primarySensor, secondarySensor), YLabel = "\Deltat [ms]", Layout = [2, 1], Charts = mag.graphics.chart.Plot(XVariable = "pi", YVariables = this.getIALIRTTimingComparisonOperation("pi", "si"))), ...
                        mag.graphics.style.Default(Title = compose("%s Science vs. I-ALiRT", primarySensor), YLabel = "\Deltat [ms]", Layout = [2, 1], Charts = mag.graphics.chart.Plot(XVariable = "ps", YVariables = this.getIALIRTTimingComparisonOperation("ps", "pi"))), ...
                        mag.graphics.style.Default(Title = compose("%s Science vs. I-ALiRT", secondarySensor), YLabel = "\Deltat [ms]", Layout = [2, 1], Charts = mag.graphics.chart.Plot(XVariable = "ss", YVariables = this.getIALIRTTimingComparisonOperation("ss", "si")))], ...
                        modeEventCharts{:}, ...
                        Name = "I-ALiRT Timestamp Analysis", ...
                        Arrangement = [8, 1], ...
                        LinkXAxes = true, ...
                        WindowState = "maximized");
                else
                    warning("FOB and FIB I-ALiRT do not have the same size.");
                end
            end
        end
    end

    methods (Static, Access = private)

        function matchedTimeB = retrieveMatchingTimestamps(timeA, timeB, options)

            arguments
                timeA (1, :) datetime
                timeB (1, :) datetime
                options.Threshold (1, 1) double = 1e3
            end

            % Pre-allocate array.
            matchedTimeB = repmat(datetime("Inf", TimeZone = "UTC"), [numel(timeA), 1]);

            % Find location of first match.
            [~, idxMin] = min(abs(timeA(1) - timeB));
            matchedTimeB(1) = timeB(idxMin);

            % Loop over all subsequent matches, now that we know the first
            % one.
            for i = 2:numel(timeA)

                idxStart = idxMin - options.Threshold;
                idxEnd = idxMin + options.Threshold;

                if idxStart < 1
                    idxStart = 1;
                end

                if idxEnd > numel(timeB)
                    idxEnd = numel(timeB);
                end

                [~, idxMin] = min(abs(timeA(i) - timeB(idxStart:idxEnd)));
                idxMin = idxMin + idxStart - 1;

                matchedTimeB(i) = timeB(idxMin);
            end
        end

        function action = getScienceTimingOperation()

            action = mag.graphics.operation.Composition(Operations = [ ...
                mag.graphics.operation.Select(Variables = "dT"), ...
                mag.graphics.operation.Convert(Conversion = @milliseconds)]);
        end

        function action = getScienceTimingComparisonOperation(y1, y2)

            action = mag.graphics.operation.Composition(Operations = [ ...
                mag.graphics.operation.Subtract(Minuend = y1, Subtrahend = y2), ...
                mag.graphics.operation.Convert(Conversion = @milliseconds), ...
                mag.graphics.operation.Convert(Conversion = @abs)]);
        end

        function action = getIALIRTTimingComparisonOperation(y1, y2)

            action = mag.graphics.operation.Composition(Operations = [ ...
                mag.graphics.operation.Subtract(Minuend = y1, Subtrahend = y2), ...
                mag.graphics.operation.Convert(Conversion = @milliseconds)]);
        end
    end
end

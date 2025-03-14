classdef EventFilter < mag.process.Step
% EVENTFILTER Remove data points at events, such as mode and range changes.

    properties
        % MODEVARIABLE Name of mode change variable.
        ModeVariable (1, 1) string = "DataFrequency"
        % ONMODECHANGE How many vectors to remove when mode changes.
        OnModeChange (1, 2) {mustBeA(OnModeChange, ["double", "duration"])} = zeros(1, 2)
        % RANGEVARIABLE Name of range variable.
        RangeVariable (1, 1) string = "Range"
        % ONRANGECHANGE How many vectors to remove when range changes.
        OnRangeChange (1, 2) {mustBeA(OnRangeChange, ["double", "duration"])} = zeros(1, 2)
        % COMPRESSIONVARIABLE Name of compression variable.
        CompressionVariable (1, 1) string = "Compression"
        % ONCOMPRESSIONCHANGE How many vectors to remove when compression
        % changes.
        OnCompressionChange (1, 2) {mustBeA(OnCompressionChange, ["double", "duration"])} = zeros(1, 2)
        % ONLONGPAUSE How many vectors to remove when long pause in the
        % data is detected.
        OnLongPause (1, 2) {mustBeA(OnLongPause, ["double", "duration"])} = zeros(1, 2)
    end

    methods

        function this = EventFilter(options)

            arguments
                options.?mag.process.EventFilter
            end

            this.assignProperties(options);
        end

        function data = apply(this, data, ~)

            arguments
                this (1, 1) mag.process.EventFilter
                data timetable
                ~
            end

            events = data.Properties.Events;
            [startTime, endTime] = bounds(data.Properties.RowTimes);

            if isempty(events)
                events = data;
            else
                events = events(timerange(startTime, endTime, "closed"), :);
            end

            if isempty(events)
                return;
            end

            % Filter data points at mode changes.
            if ~isequal(this.OnModeChange, zeros(1, 2))
                data = this.cropDataWithEvents(events, data, this.ModeVariable, this.OnModeChange);
            end

            % Filter duration at range changes.
            if ~isequal(this.OnRangeChange, zeros(1, 2))
                data = this.cropDataWithEvents(events, data, this.RangeVariable, this.OnRangeChange);
            end

            % Filter duration at compression changes.
            if ~isequal(this.OnCompressionChange, zeros(1, 2))
                data = this.cropDataWithEvents(data, data, this.CompressionVariable, this.OnCompressionChange);
            end

            % Filter out after long pauses.
            if ~isequal(this.OnLongPause, zeros(1, 2))

                times = data.Properties.RowTimes;

                locTimes = diff(times) > seconds(1);
                locTimes = [false; locTimes];

                times = times(locTimes);

                data = this.cropDataWithRange(data, times', this.OnLongPause);
            end

            % Filter out between Config and ramp mode.
            % Ramp mode is surrounded by two Config modes. Remove data from
            % the first to the last Config.
            if isa(events, "eventtable")

                locConfig = contains(events.Label, "Config");
                idxConfig = find(locConfig);

                if (nnz(locConfig) == 2) && any(contains([events.Label(idxConfig(1):idxConfig(end))], "Ramp"))

                    configRange = timerange(events.Time(idxConfig(1)), events.Time(idxConfig(end)), "closed");
                    data{configRange, "quality"} = mag.meta.Quality.Bad;
                end
            end
        end
    end

    methods (Access = private)

        function data = cropDataWithEvents(this, events, data, name, range)

            locEvent = [false; diff(events.(name)) ~= 0];
            data = this.cropDataWithRange(data, events.Properties.RowTimes(locEvent)', range);
        end
    end

    methods (Static, Access = private)

        function data = cropDataWithRange(data, times, range)

            dt = mode(diff(data.Properties.RowTimes));

            for t = times

                if isa(range, "duration")
                    data{timerange(t + range(1), t + range(2), "closed"), "quality"} = mag.meta.Quality.Bad;
                else

                    tEvent = data(withtol(t, dt), :).Properties.RowTimes;

                    if isempty(tEvent)
                        continue;
                    elseif isscalar(tEvent)
                        idxTime = find(data.Properties.RowTimes == tEvent);
                    else
                        [~, idxTime] = min(abs(data.Properties.RowTimes - t));
                    end

                    r = range(1):range(2);
                    r(r == 0) = [];
                    r(r > 0) = r(r > 0) - 1;

                    idxRemove = idxTime + r;
                    idxRemove(idxRemove < 1) = [];

                    data{idxRemove, "quality"} = mag.meta.Quality.Bad;
                end
            end
        end
    end
end

classdef Science < mag.TimeSeries
% SCIENCE Class containing MAG science data.

    properties (Dependent)
        % X x-axis component of the magnetic field.
        X (:, 1) double
        % Y y-axis component of the magnetic field.
        Y (:, 1) double
        % Z z-axis component of the magnetic field.
        Z (:, 1) double
        % XYZ x-, y- and z-axis components of the magnetic field.
        XYZ (:, 3) double
        % B Magnitude of the magnetic field.
        B (:, 1) double
        % RANGE Range values of sensor.
        Range (:, 1) uint8
        % SEQUENCE Sequence number of vectors.
        Sequence (:, 1) uint16
        % EVENTS Events detected.
        Events eventtable
    end

    methods

        function this = Science(scienceData, metaData)

            arguments
                scienceData timetable
                metaData (1, 1) mag.meta.Science
            end

            this.Data = scienceData;
            this.MetaData = metaData;
        end

        function x = get.X(this)
            x = this.Data.x;
        end

        function y = get.Y(this)
            y = this.Data.y;
        end

        function z = get.Z(this)
            z = this.Data.z;
        end

        function xyz = get.XYZ(this)
            xyz = this.Data{:, ["x", "y", "z"]};
        end

        function b = get.B(this)
            b = this.Data.B;
        end

        function range = get.Range(this)
            range = this.Data.range;
        end

        function sequence = get.Sequence(this)
            sequence = this.Data.sequence;
        end

        function events = get.Events(this)
            events = this.Data.Properties.Events;
        end

        function data = computePSD(this, options)
        % COMPUTEPSD Compute the power spectral density of the magnetic field
        % measurements.

            arguments (Input)
                this (1, 1) mag.Science
                options.Start datetime {mustBeScalarOrEmpty} = datetime.empty()
                options.Duration (1, 1) duration = hours(1)
                options.FFTType (1, 1) double {mustBeGreaterThanOrEqual(options.FFTType, 1), mustBeLessThanOrEqual(options.FFTType, 3)} = 2
                options.NW (1, 1) double = 7/2
            end

            arguments (Output)
                data (1, 1) mag.Result
            end

            % Filter out data.
            if isempty(options.Start)

                t = this.Data.t;
                locFilter = true(size(this.Data, 1), 1);
            else

                t = (this.Data.t - options.Start);

                locFilter = t > 0;

                if (options.Duration ~= 0)
                    locFilter = locFilter & (t < options.Duration);
                end
            end

            % Compute PSD.
            dt = seconds(median(diff(t(locFilter))));

            [psd, f] = psdtsh(this.Data{locFilter, ["x", "y", "z"]}, dt, options.FFTType, options.NW);
            psd = psd .^ 0.5;

            magnitude = sqrt(sum(psd.^2, 2));
            data = mag.Result(table(f, psd(:, 1), psd(:, 2), psd(:, 3), magnitude, VariableNames = ["f", "x", "y", "z", "B"]));
        end
    end
end

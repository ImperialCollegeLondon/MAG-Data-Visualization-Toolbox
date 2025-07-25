classdef ScienceCSV < mag.io.in.CSV
% SCIENCECSV Format HelioSwarm science data for CSV import.

    methods

        function data = process(this, rawData, ~)

            arguments (Input)
                this
                rawData table
                ~
            end

            arguments (Output)
                data (1, :) mag.Science
            end

            data = this.processScience(rawData, Mode = "Burst", DataFrequency = 128);
        end
    end

    methods (Access = private)

        function data = processScience(~, rawData, metadataOptions)
        % PROCESSSCIENCE Process science data.

            arguments
                ~
                rawData table
                metadataOptions.?mag.meta.Science
            end

            metadataArgs = namedargs2cell(metadataOptions);
            metadata = mag.meta.Science(metadataArgs{:}, Primary = true);

            % Remove variables.
            rawData = removevars(rawData, regexpPattern("\w_saturation"));

            % Add compression and quality flags.
            if ismember("compression", rawData.Properties.VariableNames)
                rawData.compression = logical(rawData.compression);
            else
                rawData.compression = false(height(rawData), 1);
            end

            if ismember("compression_width_bits", rawData.Properties.VariableNames)

                rawData.compression_width = double(rawData.compression_width_bits);
                rawData = removevars(rawData, "compression_width_bits");
            else
                rawData.compression_width = 16 * ones(height(rawData), 1);
            end

            rawData.quality = repmat(mag.meta.Quality.Regular, height(rawData), 1);

            % Convert timestamps.
            rawData.time = datetime(int64(rawData.time), ConvertFrom = "tt2000", TimeZone = "UTCLeapSeconds");
            rawData.time.TimeZone = mag.time.Constant.TimeZone;
            rawData.time.Format = mag.time.Constant.Format;

            % Add continuity information, for simpler interpolation.
            % Property order:
            %     time, x, y, z, range, compression, compression width,
            %     quality
            rawData.Properties.VariableContinuity = ["continuous", "continuous", "continuous", "continuous", ...
                "step", "step", "step", "step", "event"];

            % Convert to mag.Science.
            data = mag.Science(table2timetable(rawData, RowTimes = "time"), metadata);
        end
    end
end

classdef Calibration < mag.process.Step
% CALIBRATION Correct data by applying scale factor, misalignment and
% offset.

    properties (Constant)
        % FILELOCATION Location of calibration files.
        FileLocation (1, 1) string = fullfile(fileparts(mfilename("fullpath")), "../../calibration")
    end

    properties
        % TEMPERATURE Temperature range selected.
        Temperature (1, 1) string {mustBeMember(Temperature, ["Cold", "Cool", "Room"])} = "Room"
        % DEFAULTCALIBRATIONFILE Default file containing scale factor,
        % misalignment and offset information.
        DefaultCalibrationFile (1, 1) string {mustBeFile} = fullfile(mag.process.Calibration.FileLocation, "default.txt")
        % RANGEVARIABLE Name of range variable.
        RangeVariable (1, 1) string
        % VARIABLES Variables to be converted using calibration
        % information.
        Variables (1, :) string
    end

    methods

        function this = Calibration(options)

            arguments
                options.?mag.process.Calibration
            end

            this.assignProperties(options);
        end

        function data = apply(this, data, metadata)

            arguments
                this
                data timetable
                metadata (1, 1) mag.meta.Science
            end

            ranges = unique(data.(this.RangeVariable));

            % Find existing calibration files.
            calibrationFiles = dir(fullfile(this.FileLocation, "*.txt"));

            availableCalibrations = string(unique(extractBefore(({calibrationFiles.name}), "_")));
            availableCalibrations(strlength(availableCalibrations) == 0) = [];

            % Use correct calibration for sensor.
            if isempty(metadata.Setup) || isempty(metadata.Setup.Model)
                modelName = string.empty();
            elseif contains(metadata.Setup.Model, availableCalibrations, IgnoreCase = true)
                modelName = metadata.Setup.Model;
            elseif startsWith(metadata.Setup.Model, regexpPattern("E|F"))
                modelName = "FM5";
            else
                modelName = string.empty();
            end

            for r = ranges'

                locRange = data.(this.RangeVariable) == r;

                calibrationFile = this.getFileName(r, modelName);
                data{locRange, this.Variables} = this.applyCalibration(data{locRange, this.Variables}, calibrationFile);
            end
        end
    end

    methods (Hidden)

        function calibratedData = applyCalibration(this, uncalibratedData, calibrationFile)

            arguments (Input)
                this
                uncalibratedData (:, 3) double
                calibrationFile (1, 1) string {mustBeFile}
            end

            arguments (Output)
                calibratedData (:, 3) double
            end

            [scale, misalignment, offset] = this.readCalibrationData(calibrationFile);
            calibratedData = offset + (misalignment * (scale .* uncalibratedData)')';
        end
    end

    methods (Access = private)

        function fileName = getFileName(this, range, modelName)

            if isempty(modelName)

                fileName = this.DefaultCalibrationFile;
                return;
            end

            fileName = fullfile(this.FileLocation, compose("%s_r%d_t%s.txt", lower(modelName), range, lower(this.Temperature)));

            if ~isfile(fileName)

                patterns = [regexpPattern("[\w\-]+"), lettersPattern()];

                for pattern = patterns

                    value = lower(extract(modelName, pattern));

                    if ~isempty(value)
                        fileName = fullfile(this.FileLocation, compose("%s_tany.txt", value(1)));
                    else
                        fileName = string.empty();
                    end

                    if isfile(fileName)
                        return;
                    end
                end
            end

            if ~isfile(fileName)
                fileName = this.DefaultCalibrationFile;
            end
        end
    end

    methods (Static, Access = private)

        function [scale, misalignment, offset] = readCalibrationData(calibrationFile)

            arguments (Output)
                scale (1, 3) double
                misalignment (3, 3) double
                offset (1, 3) double
            end

            data = readmatrix(calibrationFile);

            scale = data(1, :);
            misalignment = data(2:4, :);
            offset = data(5, :);
        end
    end
end

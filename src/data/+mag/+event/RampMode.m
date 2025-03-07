classdef RampMode < mag.event.Event
% RAMPMODE Description of a ramp mode event.

    properties
        % SENSOR Sensor going into ramp mode.
        Sensor (1, 1) mag.meta.Sensor = "FOB"
    end

    methods

        function this = RampMode(options)

            arguments
                options.?mag.event.RampMode
            end

            this.assignProperties(options);
        end
    end

    methods (Access = protected)

        function tableThis = convertToTimeTable(this)

            labels = compose("%s Ramp", [this.Sensor]');
            tableThis = timetable(string([this.Sensor]), labels, RowTimes = [this.Timestamp], VariableNames = ["Sensor", "Label"]);
        end
    end
end

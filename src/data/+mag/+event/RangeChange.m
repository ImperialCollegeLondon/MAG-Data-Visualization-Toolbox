classdef RangeChange < mag.event.Event
% RANGECHANGE Description of a range change event.

    properties
        % RANGE Range being changed to.
        Range (1, 1) double {mustBeGreaterThanOrEqual(Range, 0), mustBeLessThanOrEqual(Range, 3)} = 0
        % SENSOR Sensor whose range is changed.
        Sensor (1, 1) mag.meta.Sensor = "FOB"
    end

    methods

        function this = RangeChange(options)

            arguments
                options.?mag.event.RangeChange
            end

            this.assignProperties(options);
        end
    end

    methods (Access = protected)

        function tableThis = convertToTimeTable(this)

            labels = compose("%s Range %d", [this.Sensor]', [this.Range]');
            tableThis = timetable([this.Range], string([this.Sensor]), labels, RowTimes = [this.Timestamp], VariableNames = ["Range", "Sensor", "Label"]);
        end
    end
end

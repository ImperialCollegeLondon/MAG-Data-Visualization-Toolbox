classdef DigitalFilter < mag.process.Step
% DIGITALFILTER Apply digital to data.

    properties (Dependent)
        Name
        Description
        DetailedDescription
    end

    properties
        % VARIABLES Variables to apply filter to.
        Variables (1, :) string
        % COEFFICIENTS Filter coefficients.
        Coefficients (:, 1) double
    end

    methods

        function this = DigitalFilter(options)

            arguments
                options.?mag.process.DigitalFilter
            end

            this.assignProperties(options);
        end

        function value = get.Name(~)
            value = "Apply Digital Filter";
        end

        function value = get.Description(~)
            value = "Apply digital filter using a rational transfer function.";
        end

        function value = get.DetailedDescription(this)
            value = this.Description;
        end

        function data = apply(this, data, ~)

            arguments
                this (1, 1) mag.process.DigitalFilter
                data timetable
                ~
            end

            data{:, this.Variables} = filter(this.Coefficients, 1, data{:, this.Variables});
            data(1:numel(this.Coefficients), :) = [];
        end
    end
end
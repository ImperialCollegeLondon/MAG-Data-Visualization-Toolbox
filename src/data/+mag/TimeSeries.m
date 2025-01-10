classdef (Abstract) TimeSeries < mag.Data & mag.mixin.Crop & mag.mixin.Signal
% TIMESERIES Abstract base class for MAG time series.

    properties
        % DATA Timetable containing data.
        Data timetable
    end

    properties (Dependent)
        % HASDATA Boolean denoting whether data is present.
        HasData (1, 1) logical
        % TIME Timestamp of data.
        Time (:, 1) datetime
        % DT Time derivative.
        dT (:, 1) duration
        IndependentVariable
        DependentVariables
    end

    methods

        function hasData = get.HasData(this)
            hasData = ~isempty(this.Data);
        end

        function time = get.Time(this)
            time = this.Data.(this.Data.Properties.DimensionNames{1});
        end

        function dt = get.dT(this)
            dt = this.computeDerivative(this.Time);
        end

        function independentVariable = get.IndependentVariable(this)
            independentVariable = this.Time;
        end

        function dependentVariables = get.DependentVariables(this)
            dependentVariables = timetable2table(this.Data, ConvertRowTimes = false);
        end
    end

    methods (Sealed)

        function value = isPlottable(this)

            arguments
                this (1, :) mag.TimeSeries
            end

            if isempty(this)

                value = false;
                return;
            end

            value = false(size(this));

            for i = 1:numel(this)
                value(i) = this(i).HasData && (height(this(i).Data) > 1);
            end
        end
    end

    methods (Static, Access = protected)

        function dx = computeDerivative(x)
        % COMPUTEDERIVATIVE Calculate numerical derivative.

            if isempty(x)
                dx = diff(x);
            else
                dx = vertcat(missing(), diff(x));
            end
        end
    end
end

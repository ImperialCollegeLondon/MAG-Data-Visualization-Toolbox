classdef tLine < MAGVisualizationTestCase
% TLINE Unit tests for "mag.graphics.chart.Line" class.

    properties (Constant)
        ClassName = "mag.graphics.chart.Line"
        GraphClassName = "matlab.graphics.chart.decoration.ConstantLine"
    end

    properties (TestParameter)
        Properties = {struct(Name = "Axis", Value = 'x', VerifiableName = "InterceptAxis"), ...
            struct(Name = "Axis", Value = 'y', VerifiableName = "InterceptAxis"), ...
            struct(Name = "Value", Value = -1, VerifiableName = "Value"), ...
            struct(Name = "Value", Value = 0, VerifiableName = "Value"), ...
            struct(Name = "Value", Value = 1, VerifiableName = "Value"), ...
            struct(Name = "Style", Value = '-', VerifiableName = "LineStyle"), ...
            struct(Name = "Style", Value = '--', VerifiableName = "LineStyle"), ...
            struct(Name = "Label", Value = 'Ciao', VerifiableName = "Label"), ...
            struct(Name = "Label", Value = '你好', VerifiableName = "Label")}
    end
end

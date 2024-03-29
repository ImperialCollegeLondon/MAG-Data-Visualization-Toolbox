classdef tDefault < PropertiesTestCase & GridSupportTestCase & LegendSupportTestCase
% TDEFAULT Unit tests for "mag.graphics.style.Default" class.

    properties (Constant)
        ClassName = "mag.graphics.style.Default"
    end

    properties (TestParameter)
        Properties = {struct(Name = "XLabel", Value = 'x value'), ...
            struct(Name = "XLimits", Value = "tickaligned", VerifiableName = "XLim", VerifiableValue = [0, 1]), ...
            struct(Name = "XLimits", Value = [-1, pi], VerifiableName = "XLim"), ...
            struct(Name = "YLimits", Value = "tickaligned", VerifiableName = "YLim", VerifiableValue = [0, 1]), ...
            struct(Name = "YLimits", Value = [-pi, 1], VerifiableName = "YLim"), ...
            struct(Name = "Title", Value = 'the title'), ...
            struct(Name = "YLabel", Value = 'y value'), ...
            struct(Name = "XScale", Value = 'log'), ...
            struct(Name = "YScale", Value = 'log'), ...
            struct(Name = "YAxisLocation", Value = 'right')}
    end
end

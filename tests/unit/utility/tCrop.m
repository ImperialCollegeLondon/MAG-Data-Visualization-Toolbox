classdef tCrop < matlab.mock.TestCase
% TCROP Unit tests for "mag.mixin.Crop" class.

    properties (Constant, Access = private)
        Time (1, :) datetime = datetime(2024, 3, 14, 15, 9, 27:36, TimeZone = "UTC")
    end

    properties (TestParameter)
        SubscriptTime
        StartEndTime
        ValidValue = {timerange(), withtol(), [datetime(), datetime()], hours(3), -days(14), [seconds(15), minutes(9)], [seconds(2), -minutes(3)]}
        InvalidValue = {1, {timerange()}, {withtol(), withtol()}, datetime(), [hours(3), seconds(14), minutes(15)]}
    end

    methods (Static, TestParameterDefinition)

        function SubscriptTime = initializeSubscriptTime()

            time = tCrop.Time;

            SubscriptTime = {struct(Filter = timerange(time(2), time(6), "openleft"), Period = timerange(time(2), time(6), "openleft")), ...
                struct(Filter = withtol(time(5), seconds(2)), Period = withtol(time(5), seconds(2))), ...
                struct(Filter = [time(3), time(6)], Period = timerange(time(3), time(6), "closed")), ...
                struct(Filter = seconds(1), Period = timerange(time(2), time(end), "closed")), ...
                struct(Filter = -seconds(2), Period = timerange(time(1), time(8), "closed")), ...
                struct(Filter = [seconds(3), seconds(8)], Period = timerange(time(4), time(9), "closed")), ...
                struct(Filter = [seconds(3), -seconds(3)], Period = timerange(time(4), time(7), "closed"))};
        end

        function StartEndTime = initializeStartEndTime()

            time = tCrop.Time;

            StartEndTime = {struct(Filter = timerange(time(2), time(6), "openleft"), Start = time(2), End = time(6)), ...
                struct(Filter = withtol(time(5), seconds(2)), Start = time(3), End = time(7)), ...
                struct(Filter = [time(3), time(6)], Start = time(3), End = time(6)), ...
                struct(Filter = seconds(1), Start = time(2), End = time(end)), ...
                struct(Filter = -seconds(2), Start = time(1), End = time(8)), ...
                struct(Filter = [seconds(3), seconds(8)], Start = time(4), End = time(9)), ...
                struct(Filter = [seconds(3), -seconds(3)], Start = time(4), End = time(7))};
        end
    end

    methods (Test)

        % Test that "mustBeTimeFilter" does not error on valid values.
        function mustBeTimeFilter_valid(testCase, ValidValue)

            % Set up.
            crop = testCase.createMock(?mag.mixin.Crop, Strict = true);

            % Exercise and verify.
            crop.mustBeTimeFilter(ValidValue);
        end

        % Test that "mustBeTimeFilter" errors on invalid values.
        function mustBeTimeFilter_invalid(testCase, InvalidValue)

            % Set up.
            crop = testCase.createMock(?mag.mixin.Crop, Strict = true);

            % Exercise and verify.
            testCase.verifyError(@() crop.mustBeTimeFilter(InvalidValue), ?MException, ...
                "Error should be thrown on invalid value.");
        end

        % Test that "convertToTimeSubscript" method accepts supported
        % types.
        function convertToTimeSubscript(testCase, SubscriptTime)

            % Set up.
            crop = testCase.createMock(?mag.mixin.Crop, Strict = true);

            % Exercise.
            timePeriod = crop.convertToTimeSubscript(SubscriptTime.Filter, testCase.Time);

            % Verify.
            testCase.verifyEqual(timePeriod, SubscriptTime.Period, "Time period should match expectation.");
        end

        % Test that "convertToStartEndTime" method accepts supported
        % types.
        function convertToStartEndTime(testCase, StartEndTime)

            % Set up.
            crop = testCase.createMock(?mag.mixin.Crop, Strict = true);

            % Exercise.
            [startTime, endTime] = crop.convertToStartEndTime(StartEndTime.Filter, testCase.Time);

            % Verify.
            testCase.verifyEqual(startTime, StartEndTime.Start, "Start time should match expectation.");
            testCase.verifyEqual(endTime, StartEndTime.End, "End time should match expectation.");
        end

        % Test that "mag.internal.splitFilters" expands scalar filters.
        function splitFilters_scalar(testCase)

            % Set up.
            crop = testCase.createMock(?mag.mixin.Crop, Strict = true);

            % Exercise.
            [filter1, filter2] = crop.splitFilters({3.14}, 2);

            % Verify.
            testCase.verifyEqual(filter1, 3.14, "First filter should match expectation.");
            testCase.verifyEqual(filter2, 3.14, "Second filter should match expectation.");
        end

        % Test that "mag.internal.splitFilters" matches vector filters.
        function splitFilters_vector(testCase)

            % Set up.
            crop = testCase.createMock(?mag.mixin.Crop, Strict = true);

            % Exercise.
            [filter1, filter2] = crop.splitFilters({3.14, 2.15}, 2);

            % Verify.
            testCase.verifyEqual(filter1, 3.14, "First filter should match expectation.");
            testCase.verifyEqual(filter2, 2.15, "Second filter should match expectation.");
        end

        % Test that "mag.internal.splitFilters" errors on incompatible
        % sizes.
        function splitFilters_incompatibleSize(testCase)

            % Set up.
            crop = testCase.createMock(?mag.mixin.Crop, Strict = true);

            % Exercise and verify.
            testCase.verifyError(@() crop.splitFilters({1, 2}, 3), ?MException, ...
                "Error should be thrown when number of filters and expected number do not match.");
        end
    end
end

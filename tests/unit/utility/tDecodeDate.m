classdef tDecodeDate < matlab.unittest.TestCase
% TDECODEDATE Unit tests for "mag.time.decodeDate" function.

    properties (Constant, Access = private)
        ExpectedDate (1, 1) datetime = datetime(2025, 6, 25, TimeZone = mag.time.Constant.TimeZone, Format = mag.time.Constant.Format)
    end

    properties (TestParameter)
        ValidDate = {"25-Jun-2025",  "25-06-2025", "2025-Jun-25", "2025-06-25", "25/Jun/2025",  "25/06/2025", "2025/Jun/25", "2025/06/25"}
        InvalidDate = {"01.02.2003", "12-13-2014"}
    end

    methods (Test)

        % Test that supported dates can be decoded.
        function decodeDate(testCase, ValidDate)

            % Exercise.
            actualTime = mag.time.decodeDate(ValidDate);

            % Verify.
            testCase.verifyEqual(actualTime, testCase.ExpectedDate, "Decoded time should match expectation.");
        end

        % Test that error is thrown when invalid date is used.
        function decodeDate_fail(testCase, InvalidDate)

            testCase.verifyError(@() mag.time.decodeDate(InvalidDate), ?MException, ...
                "Error should be thrown when value does not match regex.");
        end
    end
end

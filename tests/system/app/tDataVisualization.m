classdef tDataVisualization < matlab.uitest.TestCase
% TDATAVISUALIZATION System tests for "DataVisualization" app.

    properties (TestParameter)
        ValidMission = {"HelioSwarm", "IMAP"}
        InvalidMission = {"Solar Orbiter", "Not a Mission"}
    end

    methods (TestClassSetup)

        % Close all figures opened by test.
        function closeTestFigures(testCase)
            testCase.applyFixture(mag.test.fixture.CleanupFigures());
        end
    end

    methods (Test)

        function startApp_validMission(testCase, ValidMission)

            % Exercise.
            app = DataVisualization(ValidMission);
            testCase.addTeardown(@() delete(app));

            % Verify.
            testCase.verifySize(app, [1, 1], "App should have expected size.");
            testCase.verifyClass(app, "DataVisualization", "App should be of expected class.");
        end

        function startApp_invalidMission(testCase, InvalidMission)
            testCase.verifyError(@() DataVisualization(InvalidMission), ?MException, "Error should be thrown on invalid mission.");
        end
    end
end
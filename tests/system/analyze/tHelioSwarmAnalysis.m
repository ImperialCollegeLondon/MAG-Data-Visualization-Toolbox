classdef tHelioSwarmAnalysis < matlab.unittest.TestCase
% THELIOSWARMANALYSIS Tests for HelioSwarm analysis flow.

    properties (Access = private)
        WorkingDirectory (1, 1) matlab.unittest.fixtures.WorkingFolderFixture
    end

    methods (TestClassSetup)

        function useMATLABR2024bOrAbove(testCase)
            testCase.assumeTrue(matlabRelease().Release >= "R2024b", "Only MATLAB older than R2024b is supported for this test.");
        end
    end

    methods (TestMethodSetup)

        function setUpWorkingDirectory(testCase)
            testCase.WorkingDirectory = testCase.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture());
        end

        function copyDataToWorkingDirectory(testCase)

            [status, message] = copyfile(fullfile(testCase.WorkingDirectory.StartingFolder, "test_data", "hs"), fullfile(testCase.WorkingDirectory.Folder));
            testCase.assertTrue(status, sprintf("Copy of test data failed: %s", message));
        end
    end

    methods (Test)

        % Test that full analysis returns expected results and data format.
        function fullAnalysis(testCase)

            % Exercise.
            analysis = mag.hs.Analysis.start(Location = pwd());

            % Verify.
            testCase.verifySubstring(analysis.ScienceFileNames, "science_packets.csv", "Science file names do not match.");
            testCase.verifySubstring(analysis.HKFileNames, "hk_packets.csv", "Science file names do not match.");

            testCase.assertNotEmpty(analysis.Results, "Results should not be empty.");

            testCase.verifyEqualsBaseline(analysis.Results, matlabtest.baselines.MATFileBaseline("results.mat", VariableName = "results"));
        end
    end
end

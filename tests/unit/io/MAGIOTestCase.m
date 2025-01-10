classdef (Abstract) MAGIOTestCase < matlab.unittest.TestCase
% MAGIOTESTCASE Base class for all IO tests.

    properties
        WorkingDirectory matlab.unittest.fixtures.WorkingFolderFixture {mustBeScalarOrEmpty}
    end

    properties (Constant, Access = protected)
        TestDataLocation (1, 1) string {mustBeFolder} = fullfile(fileparts(mfilename("fullpath")), "test_data")
    end

    methods (TestMethodSetup)

        % Create temporary directory for test.
        function createTemporaryDirectory(testCase)
            testCase.WorkingDirectory = testCase.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture());
        end
    end
end

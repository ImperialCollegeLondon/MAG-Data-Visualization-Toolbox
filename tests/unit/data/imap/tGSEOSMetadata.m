classdef tGSEOSMetadata < matlab.unittest.TestCase
% TGSEOSMETADATA Unit tests for "mag.impa.meta.GSEOS" class.

    properties (Constant, Access = private)
        TestData (1, 1) string {mustBeFolder} = fullfile(fileparts(mfilename("fullpath")), "test_data")
    end

    methods (Test)

        % Test that GSEOS files that exist are supported.
        function isSupported(testCase)

            gseosProvider = mag.imap.meta.GSEOS();

            testCase.verifyTrue(gseosProvider.isSupported(fullfile(testCase.TestData, "gseos.msg")), ...
                "GSEOS file should be supported.");
        end

        % Test that files that do not exist are not supported.
        function isNotSupported_doesNotExist(testCase)

            gseosProvider = mag.imap.meta.GSEOS();

            testCase.verifyFalse(gseosProvider.isSupported("file-that_does/not,exist.msg"), ...
                "Nonexistent file should not be supported.");
        end

        % Test that files with invalid GSEOS are not supported.
        function isNotSupported_invalidGSEOS(testCase)

            gseosProvider = mag.imap.meta.GSEOS();

            testCase.verifyFalse(gseosProvider.isSupported(fullfile(testCase.TestData, "invalid_gseos.msg")), ...
                "Invalid GSEOS file should not be supported.");
        end

        % Test that metadata is loaded correctly for nominal tests.
        function load_nominalTest(testCase)

            % Set up.
            gseosFile = fullfile(testCase.TestData, "gseos.msg");
            instrumentMetadata = mag.meta.Instrument();

            % Exercise.
            gseosProvider = mag.imap.meta.GSEOS();
            testCase.assertTrue(gseosProvider.isSupported(gseosFile), "Metadata file should be supported.");

            gseosProvider.load(gseosFile, instrumentMetadata, [], []);

            % Verify.
            testCase.verifyEqual(instrumentMetadata.Mission, mag.meta.Mission.IMAP, "Mission should match expectation.");
            testCase.verifyEqual(instrumentMetadata.Timestamp, datetime("07-May-2024 10:11:48.5910", TimeZone = "UTC"), "Timestamp should match expectation.");
            testCase.verifyEqual(instrumentMetadata.Attempts, [2, 4], "Attempts should match expectation.");

            for emptyProperty = ["Model", "BSW", "ASW", "GSE", "Operator", "Description"]
                testCase.verifyEmpty(instrumentMetadata.(emptyProperty), compose("%s property should be empty.", emptyProperty));
            end
        end

        % Test that metadata is loaded correctly for CPT tests.
        function load_cptTest(testCase)

            % Set up.
            gseosFile = fullfile(testCase.TestData, "cpt_gseos.msg");
            instrumentMetadata = mag.meta.Instrument();

            % Exercise.
            gseosProvider = mag.imap.meta.GSEOS();
            testCase.assertTrue(gseosProvider.isSupported(gseosFile), "Metadata file should be supported.");

            gseosProvider.load(gseosFile, instrumentMetadata, [], []);

            % Verify.
            testCase.verifyEqual(instrumentMetadata.Mission, mag.meta.Mission.IMAP, "Mission should match expectation.");
            testCase.verifyEqual(instrumentMetadata.Timestamp, datetime("06-Mar-2024 21:58:00.1870", TimeZone = "UTC"), "Timestamp should match expectation.");
            testCase.verifyEqual(instrumentMetadata.Attempts, [1, 1], "Attempts should match expectation.");

            testCase.verifyEqual(instrumentMetadata.Model, "FM", "Model should match expectation.");
            testCase.verifyEqual(instrumentMetadata.BSW, "v2.04", "BSW should match expectation.");
            testCase.verifyEqual(instrumentMetadata.ASW, "v3.01+", "BSW should match expectation.");
            testCase.verifyEqual(instrumentMetadata.GSE, "v15.1", "BSW should match expectation.");

            for emptyProperty = ["Operator", "Description"]
                testCase.verifyEmpty(instrumentMetadata.(emptyProperty), compose("%s property should be empty.", emptyProperty));
            end
        end
    end
end

classdef GSEOS < mag.imap.meta.Provider
% GSEOS Load metadata from GSEOS log files.

    properties (Constant, Access = private)
        % EXTENSIONS Extensions supported.
        Extensions = [".msg", ".log"]
        % NAMES Variable names to use to load data.
        Names (1, :) string = ["Type", "Date", "Time", "Source", "A", "B", "Message"]
        % FORMATS Formats to use to load data.
        Formats (1, :) string = ["%C", "%{MM/dd/yy}D", "%{hh:mm:ss.SSS}T", "%C", "%f", "%f", "%q"]
        % METADATAPATTERN Regex pattern to extract metadata from log.
        MetadataPattern (:, 1) string = [ ...
            "BSW:\s*(?<bsw>.*)", ...
            "ASW:\s*(?<asw>.*)", ...
            "GSE:\s*(?<gse>.*)", ...
            "GSEOS:\s*(?<gseos>.*)"]
    end

    methods

        function supported = isSupported(this, fileName)

            arguments
                this (1, 1) mag.imap.meta.GSEOS
                fileName (1, 1) string
            end

            [~, ~, extension] = fileparts(fileName);

            supported = isfile(fileName) && ismember(extension, this.Extensions) && this.isValidGSEOS(fileName);
        end

        function load(this, fileName, instrumentMetadata, ~, ~)

            arguments
                this (1, 1) mag.imap.meta.GSEOS
                fileName (1, 1) string {mustBeFile}
                instrumentMetadata (1, 1) mag.meta.Instrument
                ~
                ~
            end

            rawData = this.readGSEOS(fileName);

            if isempty(rawData)
                return;
            end

            timestamp = datetime(rawData.Date(1) + rawData.Time(1), TimeZone = mag.time.Constant.TimeZone, Format = mag.time.Constant.Format);
            messages = join(rawData.Message, newline);

            % Extract number of activation attempts.
            fobAttempts = regexp(messages, "^MAG_HSK_SID15 ISV_FOB_ACTTRIES = (\d+). DN", "once", "tokens", "dotexceptnewline", "lineanchors");
            fibAttempts = regexp(messages, "^MAG_HSK_SID15 ISV_FIB_ACTTRIES = (\d+). DN", "once", "tokens", "dotexceptnewline", "lineanchors");

            if ~isempty(fobAttempts) && ~isempty(fibAttempts)
                instrumentMetadata.Attempts = [fobAttempts, fibAttempts];
            end

            % Assign instrument metadata.
            instrumentMetadata.Mission = mag.meta.Mission.IMAP;
            instrumentMetadata.Timestamp = timestamp;

            if contains(messages, "CPT", IgnoreCase = true)

                model = regexp(messages, "^MAG_PROG_BTSUCC HW_MODEL = (.*)$", "tokens", "once", "dotexceptnewline", "lineanchors");
                genericData = regexp(messages, join(this.MetadataPattern, "[\s\S]*?"), "names", "dotexceptnewline", "lineanchors");

                if isempty(genericData)
                    return;
                end

                instrumentMetadata.Model = model;
                instrumentMetadata.BSW = genericData.bsw;
                instrumentMetadata.ASW = genericData.asw;
                instrumentMetadata.GSE = genericData.gse;
            end
        end
    end

    methods (Access = private)

        function valid = isValidGSEOS(this, fileName)

            try

                this.readGSEOS(fileName);
                valid = true;
            catch
                valid = false;
            end
        end

        function rawData = readGSEOS(this, fileName)

            dataStore = tabularTextDatastore(fileName, FileExtensions = this.Extensions, TextType = "string", VariableNames = this.Names, TextscanFormats = this.Formats);
            rawData = dataStore.readall(UseParallel = mag.internal.useParallel());
        end
    end
end

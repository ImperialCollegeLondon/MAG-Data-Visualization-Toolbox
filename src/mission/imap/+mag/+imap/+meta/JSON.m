classdef JSON < mag.imap.meta.Provider
% JSON Load metadata from JSON files.

    properties (Constant, Access = private)
        % EXTENSIONS Extensions supported.
        Extensions = ".json"
    end

    methods

        function supported = isSupported(this, fileName)

            arguments
                this (1, 1) mag.imap.meta.JSON
                fileName (1, 1) string
            end

            [~, ~, extension] = fileparts(fileName);

            supported = isfile(fileName) && ismember(extension, this.Extensions) && this.isValidJSON(fileName);
        end

        function load(this, fileName, instrumentMetadata, primarySetup, secondarySetup)

            arguments
                this (1, 1) mag.imap.meta.JSON
                fileName (1, 1) string {mustBeFile}
                instrumentMetadata (1, 1) mag.meta.Instrument
                primarySetup (1, 1) mag.meta.Setup
                secondarySetup (1, 1) mag.meta.Setup
            end

            data = readstruct(fileName, FileType = "json", AllowComments = true, AllowTrailingCommas = true);

            this.applyMetadata(instrumentMetadata, data, "Instrument");
            this.applyMetadata(primarySetup, data, "Primary");
            this.applyMetadata(secondarySetup, data, "Secondary");
        end
    end

    methods (Access = private)

        function applyMetadata(this, metadata, topLevelData, topLevelField)

            if isfield(topLevelData, topLevelField)
                data = topLevelData.(topLevelField);
            else
                return;
            end

            fields = string(fieldnames(data))';

            for field = fields

                if ~isprop(metadata, field)
                    error("Invalid field ""%s"" in JSON file ""%s"".", field, fileName);
                end

                if isstruct(data.(field))
                    this.applyMetadata(metadata.(field), data, field);
                else
                    metadata.(field) = data.(field);
                end
            end
        end
    end

    methods (Static, Access = private)

        function valid = isValidJSON(fileName)

            try

                readstruct(fileName);
                valid = true;
            catch
                valid = false;
            end
        end
    end
end

classdef ScienceMAT < mag.io.out.MAT
% SCIENCEMAT Format HelioSwarm science data for MAT export.

    methods

        function fileName = getExportFileName(this, data)

            arguments (Input)
                this (1, 1) mag.hs.out.ScienceMAT
                data (1, 1) mag.Instrument
            end

            arguments (Output)
                fileName (1, 1) string
            end

            fileName = compose("%s %s (%d)", datestr(data.Science.Metadata.Timestamp, "ddmmyy-hhMM"), ...
                data.Science.Metadata.Mode, data.Science.Metadata.DataFrequency) + this.Extension; %#ok<DATST>
        end

        function exportData = convertToExportFormat(this, data)

            arguments (Input)
                this (1, 1) mag.hs.out.ScienceMAT
                data (1, 1) mag.Instrument
            end

            arguments (Output)
                exportData (1, 1) struct
            end

            exportData.B.Time = data.Science.Time;
            exportData.B.Data = data.Science.XYZ;
            exportData.B.Range = data.Science.Range;
            exportData.B.Compression = data.Science.Compression;
            exportData.B.Quality = categorical(string(data.Science.Quality));
            exportData.B.Metadata = this.flattenStruct(data.Science.Metadata);
        end
    end
end

function data = import(options)
% IMPORT Import data from specified files with specified format.

    arguments (Input)
        options.FileNames (1, :) string {mustBeFile}
        options.Format (1, 1) mag.io.in.Format
        options.ProcessingSteps (1, :) mag.process.Step = mag.process.Step.empty()
    end

    arguments (Output)
        data (1, :) mag.TimeSeries
    end

    data = mag.TimeSeries.empty();

    for fn = options.FileNames

        [rawData, details] = options.Format.load(fn);

        if ~isempty(rawData)
            data = [data, options.Format.process(rawData, details)]; %#ok<AGROW>
        end
    end

    for ps = options.ProcessingSteps

        for d = data
            d.Data = ps.apply(d.Data, d.Metadata);
        end
    end

    % Combine results by type.
    if isempty(data)
        % do nothing
    elseif isa(data, "mag.Science")
        data = combineScience(data);
    elseif isa(data, "mag.HK")
        data = combineHK(data);
    else
        error("Unsupported class ""%s"".", class(data));
    end
end

function combinedData = combineScience(data)
% COMBINESCIENCE Combine science data.

    arguments (Input)
        data (1, :) mag.Science
    end

    arguments (Output)
        combinedData (1, :) mag.Science
    end

    combinedData = mag.Science.empty();

    % Combine data by sensor.
    metadata = [data.Metadata];
    sensors = unique([metadata.Sensor]);

    if isempty(sensors)

        combinedData = data;
        return;
    end

    for s = sensors

        locSelection = [metadata.Sensor] == s;

        selectedData = data(locSelection);
        selectedMetadata = [selectedData.Metadata];

        td = vertcat(selectedData.Data);

        md = selectedMetadata(1).copy();
        md.set(Mode = selectedMetadata.getDisplay("Mode", "Hybrid"), ...
            DataFrequency = selectedMetadata.getDisplay("DataFrequency"), ...
            PacketFrequency = selectedMetadata.getDisplay("PacketFrequency"), ...
            Timestamp = min([selectedMetadata.Timestamp]));

        combinedData(end + 1) = mag.Science(td, md); %#ok<AGROW>
    end
end

function combinedData = combineHK(data)

    arguments (Input)
        data (1, :) mag.HK
    end

    arguments (Output)
        combinedData (1, :) mag.HK
    end

    combinedData = mag.HK.empty();

    % Combine data by sensor.
    metadata = [data.Metadata];
    types = unique([metadata.Type]);

    if isempty(types)

        combinedData = data;
        return;
    end

    for t = types

        locSelection = [metadata.Type] == t;
        selectedData = data(locSelection);

        td = vertcat(selectedData.Data);

        md = selectedData(1).Metadata.copy();
        md.set(Timestamp = min([metadata(locSelection).Timestamp]));

        combinedData(end + 1) = mag.imap.hk.dispatchHKType(td, md); %#ok<AGROW>
    end
end

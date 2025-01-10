function figures = sftPlots(analysis, options)
% SFTPLOTS Create plots for SFT results.
%#ok<*AGROW>

    arguments (Input)
        analysis (1, 1) mag.imap.Analysis
        options.Filter duration {mustBeScalarOrEmpty} = duration.empty()
        options.PSDStart datetime {mustBeScalarOrEmpty} = datetime.empty()
        options.PSDDuration (1, 1) duration = hours(1)
        options.Spectrogram (1, 1) logical = true
        options.SeparateModes (1, 1) logical = true
    end

    arguments (Output)
        figures (1, :) matlab.ui.Figure
    end

    views = mag.graphics.view.View.empty();

    % Crop data.
    if ~isempty(options.Filter)

        croppedAnalysis = analysis.copy();
        croppedAnalysis.Results.cropScience(options.Filter);
    else
        croppedAnalysis = analysis;
    end

    % Separate modes.
    modes = croppedAnalysis.getAllModes();

    if ~options.SeparateModes || isempty(modes)
        modes = croppedAnalysis.Results;
    end

    % Show science and frequency.
    for m = modes

        views(end + 1) = mag.imap.view.Field(m);

        if options.Spectrogram
            views(end + 1) = mag.imap.view.Spectrogram(m);
        end

        if ~isempty(options.PSDStart)

            % Crop the first and last few seconds of the mode, to avoid
            % plotting wrongful information.
            if range(m.TimeRange) > minutes(2)
                m.crop([seconds(30), seconds(-30)]);
            end

            views(end + 1) = mag.imap.view.PSD(m, Start = options.PSDStart, Duration = options.PSDDuration);
        end
    end

    % Show I-ALiRT.
    if ~isempty(croppedAnalysis.Results.IALiRT) && croppedAnalysis.Results.IALiRT.HasData

        tempInstrument = mag.imap.Instrument(Science = croppedAnalysis.Results.IALiRT.Science);
        views(end + 1) = mag.imap.view.Field(tempInstrument);
    end

    % Show science comparison.
    views(end + 1) = mag.imap.view.Comparison(croppedAnalysis.Results);

    % Show timestamp analysis.
    views(end + 1) = mag.imap.view.Timestamp(analysis.Results);

    % Show HK.
    views(end + 1) = mag.imap.view.HK(analysis.Results);

    % Generate figures.
    figures = views.visualizeAll();
end



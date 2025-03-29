classdef VisualizationManager < mag.app.manage.VisualizationManager
% VISUALIZATIONMANAGER Manager for visualization of IMAP analysis.

    properties (Constant, Access = protected)
        EmptyModel = mag.app.imap.Model.empty()
    end

    methods

        function supportedVisualizations = getSupportedVisualizations(~, ~)

            supportedVisualizations = [mag.app.imap.control.AT(), ...
                mag.app.imap.control.CPT(), ...
                mag.app.imap.control.Field(), ...
                mag.app.imap.control.IALiRT(), ...
                mag.app.imap.control.Timestamp(), ...
                mag.app.imap.control.HK(), ...
                mag.app.control.PSD(@mag.imap.view.PSD), ...
                mag.app.control.Spectrogram(@mag.imap.view.Spectrogram), ...
                mag.app.control.SignalAnalyzer(["Outboard", "Inboard"]), ...
                mag.app.control.WaveletAnalyzer(["Outboard", "Inboard"])];
        end

        function figures = visualize(this, analysis)

            if isempty(this.SelectedControl)
                error("mag:app:noViewSelected", "No view selected.");
            end

            if isa(this.SelectedControl, "mag.app.imap.control.AT") || isa(this.SelectedControl, "mag.app.imap.control.CPT")
                args = {analysis};
            else
                args = {analysis.Results};
            end

            command = this.SelectedControl.getVisualizeCommand(args{:});

            if command.NArgOut == 0

                command.call();
                figures = matlab.ui.Figure.empty();
            else
                figures = command.call();
            end
        end
    end
end

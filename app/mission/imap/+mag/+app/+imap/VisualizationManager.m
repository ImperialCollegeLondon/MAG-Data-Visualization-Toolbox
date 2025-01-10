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
                mag.app.imap.control.HK(), ...
                mag.app.control.PSD(@mag.imap.view.PSD), ...
                mag.app.control.Spectrogram(@mag.imap.view.Spectrogram)];
        end

        function figures = visualize(this, analysis)

            if isa(this.SelectedControl, "mag.app.imap.control.AT") || isa(this.SelectedControl, "mag.app.imap.control.CPT")
                args = {analysis};
            else
                args = {analysis.Results};
            end

            command = this.SelectedControl.getVisualizeCommand(args{:});
            figures = command.call();
        end
    end
end

classdef (Sealed) DataVisualization < matlab.mixin.SetGet
% DATAVISUALIZATION App for processing, exporting and visualizing MAG data.

    properties (Constant)
        ExportWorkspace (1, 1) string = "Workspace"
        ExportMAT (1, 1) string = "MAT (Full Analysis)"
    end

    properties (Constant, Access = private)
        AppName (1, 1) string = "MAG Data Visualization App"
    end

    properties (SetAccess = private)
        UIFigure matlab.ui.Figure
        GridLayout matlab.ui.container.GridLayout
        TabGroup matlab.ui.container.TabGroup
        AnalyzeTab matlab.ui.container.Tab
        AnalyzeLayout matlab.ui.container.GridLayout
        AnalyzeSettingsPanel matlab.ui.container.Panel
        VersionLabel matlab.ui.control.Label
        ProcessDataButton matlab.ui.control.Button
        ResetButton matlab.ui.control.Button
        ResultsTab matlab.ui.container.Tab
        ExportTab matlab.ui.container.Tab
        ExportLayout matlab.ui.container.GridLayout
        ExportSettingsPanel matlab.ui.container.Panel
        ExportButtonsLayout matlab.ui.container.GridLayout
        ExportNoteLabel matlab.ui.control.Label
        ExportButton matlab.ui.control.Button
        ExportFormatDropDown matlab.ui.control.DropDown
        FormatDropDownLabel matlab.ui.control.Label
        VisualizeTab matlab.ui.container.Tab
        VisualizeLayout matlab.ui.container.GridLayout
        VisualizeSettingsPanel matlab.ui.container.Panel
        VisualizeButtonsLayout matlab.ui.container.GridLayout
        CloseFiguresButton matlab.ui.control.Button
        SaveFiguresButton matlab.ui.control.Button
        ShowFiguresButton matlab.ui.control.Button
    end

    properties (SetAccess = private)
        SelectMissionDialog mag.app.internal.SelectMissionDialog {mustBeScalarOrEmpty}
        Mission mag.meta.Mission {mustBeScalarOrEmpty}
        Provider mag.app.Provider {mustBeScalarOrEmpty}
        Model mag.app.Model {mustBeScalarOrEmpty} = mag.app.imap.Model.empty()
        ToolbarManager mag.app.manage.ToolbarManager {mustBeScalarOrEmpty}
        AnalysisManager mag.app.manage.AnalysisManager {mustBeScalarOrEmpty}
        ResultsManager mag.app.manage.Manager {mustBeScalarOrEmpty}
        ExportManager mag.app.manage.ExportManager {mustBeScalarOrEmpty}
        VisualizationManager mag.app.manage.VisualizationManager {mustBeScalarOrEmpty}
        AppNotificationHandler mag.app.internal.AppNotificationHandler {mustBeScalarOrEmpty}
    end

    properties (SetObservable, SetAccess = private)
        Figures (1, :) matlab.ui.Figure
    end

    properties (Dependent, Access = private)
        ResultsLocation (1, 1) string {mustBeFolder}
    end

    methods

        function app = DataVisualization(mission)

            arguments (Input)
                mission mag.meta.Mission {mustBeScalarOrEmpty} = string.empty()
            end

            % Create figure and other UI components.
            app.UIFigure = uifigure();
            app.UIFigure.Position = [100, 100, 800, 495];
            app.UIFigure.Name = app.getAppName();
            app.UIFigure.Resize = "off";

            pathToAppIcons = fullfile(fileparts(mfilename("fullpath")), "icons");
            app.ToolbarManager = mag.app.manage.ToolbarManager(app, pathToAppIcons);
            app.ToolbarManager.instantiate(app.UIFigure);

            app.AppNotificationHandler = mag.app.internal.AppNotificationHandler(app.UIFigure, app.ToolbarManager);

            % Initialize app based on mission.
            try
                app.selectMission(mission);
            catch exception

                delete(app);
                rethrow(exception);
            end

            if nargout() == 0
                clear("app");
            end
        end

        function delete(app)
            delete(app.UIFigure)
        end

        function value = get.ResultsLocation(app)

            if isempty(app.Model.Analysis)
                location = app.AnalysisManager.LocationEditField.Value;
            else
                location = app.Model.Analysis.Location;
            end

            value = fullfile(location, compose("Results (v%s)", mag.version()));

            if ~isfolder(value)
                mkdir(value);
            end
        end

        function selectMission(app, mission)
        % SELECTMISSION Select mission to analyze.

            arguments (Input)
                app
                mission mag.meta.Mission {mustBeScalarOrEmpty} = string.empty()
            end

            unlockToolbar = app.ToolbarManager.lock(); %#ok<NASGU>

            % Ask which mission to load, if not provided.
            if isempty(mission)

                app.SelectMissionDialog = mag.app.internal.SelectMissionDialog(app.UIFigure);
                mission = app.SelectMissionDialog.waitForSelection();

                if app.SelectMissionDialog.Aborted
                    error("mag:app:abort", "User aborted.");
                else
                    app.SelectMissionDialog.delete();
                end

                closeProgressBar = app.AppNotificationHandler.overlayProgressBar("Initializing mission..."); %#ok<NASGU>
            end

            app.Mission = mission;

            switch app.Mission
                case mag.meta.Mission.Bartington
                    app.Provider = mag.app.bart.Provider();
                case mag.meta.Mission.HelioSwarm
                    app.Provider = mag.app.hs.Provider();
                case mag.meta.Mission.IMAP
                    app.Provider = mag.app.imap.Provider();
                otherwise
                    error("mag:app:unsupportedMission", "%s mission not supported.", app.Mission.DisplayName);
            end

            % Set managers.
            app.Model = app.Provider.getModel();

            app.AnalysisManager = app.Provider.getAnalysisManager();
            app.ResultsManager = app.Provider.getResultsManager();
            app.ExportManager = app.Provider.getExportManager();
            app.VisualizationManager = app.Provider.getVisualizationManager();

            for manager = [app.AnalysisManager, app.ResultsManager, app.ExportManager, app.VisualizationManager]
                manager.subscribe(app.Model);
            end

            % Create components.
            delete(app.GridLayout);

            app.createComponents();

            app.addlistener("Figures", "PostSet", @app.figuresChanged);
            app.Model.addlistener("AnalysisChanged", @app.modelChangedCallback);

            app.UIFigure.Name = app.getAppName();
        end
    end

    methods (Access = private)

        function name = getAppName(app)

            if isempty(app.Mission)
                name = app.AppName;
            else
                name = compose("%s (%s)", app.AppName, app.Mission.DisplayName);
            end
        end

        function modelChangedCallback(app, model, ~)

            hasModel = model.HasAnalysis;
            hasData = hasModel && (model.Analysis.Results.HasScience || model.Analysis.Results.HasHK);

            if hasModel && ~hasData
                app.AppNotificationHandler.displayAlert("No HK or science data detected.", "No Data", "warning");
            end

            status = matlab.lang.OnOffSwitchState(hasData);

            [app.ExportFormatDropDown.Enable, app.ExportButton.Enable, app.ExportSettingsPanel.Enable, ...
                app.ShowFiguresButton.Enable] = deal(status);
        end

        function figuresChanged(app, varargin)

            figuresAvailable = ~isempty(app.Figures) && any(isvalid(app.Figures));
            [app.SaveFiguresButton.Enable, app.CloseFiguresButton.Enable] = deal(matlab.lang.OnOffSwitchState(figuresAvailable));
        end

        function processDataButtonPushed(app)

            closeProgressBar = app.AppNotificationHandler.overlayProgressBar("Processing data..."); %#ok<NASGU>
            restoreWarningState = app.disableWarningStackTrace(); %#ok<NASGU>

            try
                app.Model.analyze(app.AnalysisManager.getAnalysisOptions());
            catch exception
                app.AppNotificationHandler.displayAlert(exception);
            end
        end

        function resetButtonPushed(app)

            app.closeFiguresButtonPushed();

            app.Model.reset();
            app.Figures = matlab.ui.Figure.empty();

            for manager = [app.AnalysisManager, app.ResultsManager, app.ExportManager, app.VisualizationManager]
                manager.reset();
            end            
        end

        function exportButtonPushed(app)

            closeProgressBar = app.AppNotificationHandler.overlayProgressBar("Exporting..."); %#ok<NASGU>
            restoreWarningState = app.disableWarningStackTrace(); %#ok<NASGU>

            format = app.ExportFormatDropDown.Value;

            switch format
                case app.ExportWorkspace

                    variableName = app.createMissionSpecificVariable();

                    if evalin("base", compose("exist(""%s"", ""var"")", variableName))

                        selectedOption = uiconfirm(app.UIFigure, compose("Variable <code>%s</code> already exists in the MATLAB Workspace.", variableName) + ...
                            " Would you like to overwrite it?", "Variable Already Exists", Interpreter = "html");

                        if ~isequal(selectedOption, "OK")
                            return;
                        end
                    end

                    assignin("base", variableName, eval(variableName));
                case app.ExportMAT

                    fileName = fullfile(app.ResultsLocation, "Data.mat");
                    variableName = app.createMissionSpecificVariable();

                    if isfile(fileName)
                        options = {"-append"};
                    else
                        options = {};
                    end

                    save(fileName, variableName, options{:});
                case cellstr(app.ExportManager.SupportedFormats)

                    try
                        app.Model.export(app.ExportManager.getExportOptions(format, app.ResultsLocation));
                    catch exception
                        app.AppNotificationHandler.displayAlert(exception);
                    end
                otherwise
                    app.AppNotificationHandler.displayAlert(compose("Unrecognized export format option ""%s"".", format));
            end
        end

        function showFiguresButtonPushed(app)

            closeProgressBar = app.AppNotificationHandler.overlayProgressBar("Plotting data..."); %#ok<NASGU>
            restoreWarningState = app.disableWarningStackTrace(); %#ok<NASGU>

            try
                app.Figures = [app.Figures, app.VisualizationManager.visualize(app.Model.Analysis)];
            catch exception
                app.AppNotificationHandler.displayAlert(exception);
            end
        end

        function saveFiguresButtonPushed(app)

            closeProgressBar = app.AppNotificationHandler.overlayProgressBar("Saving figures..."); %#ok<NASGU>
            restoreWarningState = app.disableWarningStackTrace(); %#ok<NASGU>

            try
                mag.graphics.savePlots(app.Figures, app.ResultsLocation);
            catch exception
                app.AppNotificationHandler.displayAlert(exception);
            end
        end

        function closeFiguresButtonPushed(app)

            isValidFigures = isvalid(app.Figures);

            if ~isempty(app.Figures) && any(isValidFigures)

                closeProgressBar = app.AppNotificationHandler.overlayProgressBar("Closing figures..."); %#ok<NASGU>
                restoreWarningState = app.disableWarningStackTrace(); %#ok<NASGU>

                close(app.Figures(isValidFigures));
            end

            % Force UI to refresh, even if no figures were closed.
            app.Figures = matlab.ui.Figure.empty();
        end

        function createComponents(app)

            % Create GridLayout.
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.RowHeight = "1x";

            % Create TabGroup.
            app.TabGroup = uitabgroup(app.GridLayout);
            app.TabGroup.Layout.Row = 1;
            app.TabGroup.Layout.Column = [1 2];

            % Create AnalyzeTab.
            app.AnalyzeTab = uitab(app.TabGroup);
            app.AnalyzeTab.Title = "Analyze";

            % Create AnalyzeLayout.
            app.AnalyzeLayout = uigridlayout(app.AnalyzeTab);
            app.AnalyzeLayout.ColumnWidth = ["1x", "3x", "2x", "1x"];
            app.AnalyzeLayout.RowHeight = ["6x", "1x"];

            % Create AnalyzeSettingsPanel.
            app.AnalyzeSettingsPanel = uipanel(app.AnalyzeLayout);
            app.AnalyzeSettingsPanel.Title = "Settings";
            app.AnalyzeSettingsPanel.Layout.Row = 1;
            app.AnalyzeSettingsPanel.Layout.Column = [1, 4];

            % Populate "Analyze" tab based on mission.
            app.AnalysisManager.instantiate(app.AnalyzeSettingsPanel);

            % Create ProcessDataButton.
            app.ProcessDataButton = uibutton(app.AnalyzeLayout, "push");
            app.ProcessDataButton.ButtonPushedFcn = @(~, ~) app.processDataButtonPushed();
            app.ProcessDataButton.Layout.Row = 2;
            app.ProcessDataButton.Layout.Column = 3;
            app.ProcessDataButton.Text = "Process Data";

            % Create ResetButton.
            app.ResetButton = uibutton(app.AnalyzeLayout, "push");
            app.ResetButton.ButtonPushedFcn = @(~, ~) app.resetButtonPushed();
            app.ResetButton.Layout.Row = 2;
            app.ResetButton.Layout.Column = 4;
            app.ResetButton.Text = "Reset";

            % Create VersionLabel.
            app.VersionLabel = uilabel(app.AnalyzeLayout);
            app.VersionLabel.VerticalAlignment = "bottom";
            app.VersionLabel.Layout.Row = 2;
            app.VersionLabel.Layout.Column = 1;
            app.VersionLabel.Text = compose("v%s", mag.version());

            % Create ResultsTab.
            app.ResultsTab = uitab(app.TabGroup);
            app.ResultsTab.Title = "Results";

            % Populate "Results" tab based on mission.
            app.ResultsManager.instantiate(app.ResultsTab);

            % Create ExportTab.
            app.ExportTab = uitab(app.TabGroup);
            app.ExportTab.Title = "Export";

            % Create ExportLayout.
            app.ExportLayout = uigridlayout(app.ExportTab);
            app.ExportLayout.ColumnWidth = "1x";
            app.ExportLayout.RowHeight = ["4x", "1x"];

            % Create ExportButtonsLayout.
            app.ExportButtonsLayout = uigridlayout(app.ExportLayout);
            app.ExportButtonsLayout.ColumnWidth = ["1x", "1x", "0.5x", "1.5x", "1x"];
            app.ExportButtonsLayout.RowHeight = "1x";
            app.ExportButtonsLayout.Layout.Row = 2;
            app.ExportButtonsLayout.Layout.Column = 1;

            % Create FormatDropDownLabel.
            app.FormatDropDownLabel = uilabel(app.ExportButtonsLayout);
            app.FormatDropDownLabel.HorizontalAlignment = "right";
            app.FormatDropDownLabel.Layout.Row = 1;
            app.FormatDropDownLabel.Layout.Column = 3;
            app.FormatDropDownLabel.Text = "Format:";

            % Create ExportFormatDropDown.
            app.ExportFormatDropDown = uidropdown(app.ExportButtonsLayout);
            app.ExportFormatDropDown.Items = [app.ExportWorkspace, app.ExportMAT, app.ExportManager.SupportedFormats];
            app.ExportFormatDropDown.Enable = "off";
            app.ExportFormatDropDown.Layout.Row = 1;
            app.ExportFormatDropDown.Layout.Column = 4;
            app.ExportFormatDropDown.Value = app.ExportWorkspace;

            % Create ExportButton.
            app.ExportButton = uibutton(app.ExportButtonsLayout, "push");
            app.ExportButton.ButtonPushedFcn = @(~, ~) app.exportButtonPushed();
            app.ExportButton.Enable = "off";
            app.ExportButton.Layout.Row = 1;
            app.ExportButton.Layout.Column = 5;
            app.ExportButton.Text = "Export";

            % Create ExportSettingsPanel.
            app.ExportSettingsPanel = uipanel(app.ExportLayout);
            app.ExportSettingsPanel.Enable = "off";
            app.ExportSettingsPanel.Title = "Settings";
            app.ExportSettingsPanel.Layout.Row = 1;
            app.ExportSettingsPanel.Layout.Column = 1;

            % Populate "Export" tab based on mission.
            app.ExportManager.instantiate(app.ExportSettingsPanel);

            % Create VisualizeTab.
            app.VisualizeTab = uitab(app.TabGroup);
            app.VisualizeTab.Title = "Visualize";

            % Create VisualizeLayout.
            app.VisualizeLayout = uigridlayout(app.VisualizeTab);
            app.VisualizeLayout.ColumnWidth = "1x";
            app.VisualizeLayout.RowHeight = ["4x", "1x"];

            % Create VisualizeSettingsPanel.
            app.VisualizeSettingsPanel = uipanel(app.VisualizeLayout);
            app.VisualizeSettingsPanel.Title = "Settings";
            app.VisualizeSettingsPanel.Layout.Row = 1;
            app.VisualizeSettingsPanel.Layout.Column = 1;

            % Populate "Visualize" tab based on mission.
            app.VisualizationManager.instantiate(app.VisualizeSettingsPanel);

            % Create VisualizeButtonsLayout.
            app.VisualizeButtonsLayout = uigridlayout(app.VisualizeLayout);
            app.VisualizeButtonsLayout.ColumnWidth = ["2x", "2x", "1x", "fit"];
            app.VisualizeButtonsLayout.RowHeight = "1x";
            app.VisualizeButtonsLayout.Layout.Row = 2;
            app.VisualizeButtonsLayout.Layout.Column = 1;

            % Create ShowFiguresButton.
            app.ShowFiguresButton = uibutton(app.VisualizeButtonsLayout, "push");
            app.ShowFiguresButton.ButtonPushedFcn = @(~, ~) app.showFiguresButtonPushed();
            app.ShowFiguresButton.Enable = "off";
            app.ShowFiguresButton.Layout.Row = 1;
            app.ShowFiguresButton.Layout.Column = 2;
            app.ShowFiguresButton.Text = ["Show"; "Figures"];

            % Create SaveFiguresButton.
            app.SaveFiguresButton = uibutton(app.VisualizeButtonsLayout, "push");
            app.SaveFiguresButton.ButtonPushedFcn = @(~, ~) app.saveFiguresButtonPushed();
            app.SaveFiguresButton.Enable = "off";
            app.SaveFiguresButton.Layout.Row = 1;
            app.SaveFiguresButton.Layout.Column = 3;
            app.SaveFiguresButton.Text = ["Save"; "Figures"];

            % Create CloseFiguresButton.
            app.CloseFiguresButton = uibutton(app.VisualizeButtonsLayout, "push");
            app.CloseFiguresButton.ButtonPushedFcn = @(~, ~) app.closeFiguresButtonPushed();
            app.CloseFiguresButton.Enable = "off";
            app.CloseFiguresButton.Layout.Row = 1;
            app.CloseFiguresButton.Layout.Column = 4;
            app.CloseFiguresButton.Text = ["Close"; "Figures"];
        end
    end

    methods (Hidden, Access = private)

        function variableName = createMissionSpecificVariable(app)

            variableName = lower(app.Mission.ShortName) + "Analysis";
            assignin("caller", variableName, app.Model.Analysis.copy());
        end
    end

    methods (Static, Access = private)

        function restoreWarningState = disableWarningStackTrace()

            previousWarningState = warning("off", "backtrace");
            restoreWarningState = onCleanup(@() warning(previousWarningState));
        end
    end
end

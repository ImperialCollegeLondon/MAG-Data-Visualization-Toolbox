classdef AnalysisManager < mag.app.manage.AnalysisManager
% ANALYSISMANAGER Manager for analysis of HelioSwarm data.

    properties (SetAccess = private)
        AnalyzeSettingsLayout matlab.ui.container.GridLayout
        LocationEditField matlab.ui.control.EditField
        LocationEditFieldLabel matlab.ui.control.Label
        BrowseButton matlab.ui.control.Button
        MetadataPatternEditField matlab.ui.control.EditField
        MetadataPatternEditFieldLabel matlab.ui.control.Label
        SciencePatternEditField matlab.ui.control.EditField
        SciencePatternEditFieldLabel matlab.ui.control.Label
        HKPatternEditField matlab.ui.control.EditField
        HKPatternEditFieldLabel matlab.ui.control.Label
    end

    methods

        function instantiate(this, parent)

            % Create AnalyzeSettingsLayout.
            this.AnalyzeSettingsLayout = uigridlayout(parent);
            this.AnalyzeSettingsLayout.ColumnWidth = ["fit", "1x", "fit"];
            this.AnalyzeSettingsLayout.RowHeight = ["1x", "1x", "1x", "1x", "1x", "1x"];

            % Create LocationEditFieldLabel.
            this.LocationEditFieldLabel = uilabel(this.AnalyzeSettingsLayout);
            this.LocationEditFieldLabel.HorizontalAlignment = "right";
            this.LocationEditFieldLabel.Layout.Row = 1;
            this.LocationEditFieldLabel.Layout.Column = 1;
            this.LocationEditFieldLabel.Text = "Location:";

            % Create LocationEditField.
            this.LocationEditField = uieditfield(this.AnalyzeSettingsLayout, "text");
            this.LocationEditField.Layout.Row = 1;
            this.LocationEditField.Layout.Column = 2;

            % Create BrowseButton.
            this.BrowseButton = uibutton(this.AnalyzeSettingsLayout, "push");
            this.BrowseButton.ButtonPushedFcn = @(~, ~) this.browseButtonPushed();
            this.BrowseButton.Layout.Row = 1;
            this.BrowseButton.Layout.Column = 3;
            this.BrowseButton.Text = "Browse";

            % Create MetadataPatternEditFieldLabel.
            this.MetadataPatternEditFieldLabel = uilabel(this.AnalyzeSettingsLayout);
            this.MetadataPatternEditFieldLabel.HorizontalAlignment = "right";
            this.MetadataPatternEditFieldLabel.Layout.Row = 2;
            this.MetadataPatternEditFieldLabel.Layout.Column = 1;
            this.MetadataPatternEditFieldLabel.Text = "Metadata pattern:";

            % Create MetadataPatternEditField.
            this.MetadataPatternEditField = uieditfield(this.AnalyzeSettingsLayout, "text", Enable = "off");
            this.MetadataPatternEditField.Layout.Row = 2;
            this.MetadataPatternEditField.Layout.Column = [2, 3];
            this.MetadataPatternEditField.Placeholder = "Not supported for HelioSwarm yet";

            % Create SciencePatternEditFieldLabel.
            this.SciencePatternEditFieldLabel = uilabel(this.AnalyzeSettingsLayout);
            this.SciencePatternEditFieldLabel.HorizontalAlignment = "right";
            this.SciencePatternEditFieldLabel.Layout.Row = 3;
            this.SciencePatternEditFieldLabel.Layout.Column = 1;
            this.SciencePatternEditFieldLabel.Text = "Science pattern:";

            % Create SciencePatternEditField.
            this.SciencePatternEditField = uieditfield(this.AnalyzeSettingsLayout, "text");
            this.SciencePatternEditField.Layout.Row = 3;
            this.SciencePatternEditField.Layout.Column = [2, 3];

            % Create HKPatternEditFieldLabel.
            this.HKPatternEditFieldLabel = uilabel(this.AnalyzeSettingsLayout);
            this.HKPatternEditFieldLabel.HorizontalAlignment = "right";
            this.HKPatternEditFieldLabel.Layout.Row = 4;
            this.HKPatternEditFieldLabel.Layout.Column = 1;
            this.HKPatternEditFieldLabel.Text = "HK pattern:";

            % Create HKPatternEditField.
            this.HKPatternEditField = uieditfield(this.AnalyzeSettingsLayout, "text");
            this.HKPatternEditField.Layout.Row = 4;
            this.HKPatternEditField.Layout.Column = [2, 3];

            % Reset.
            this.reset();
        end

        function reset(this)

            dummyAnalysis = mag.hs.Analysis();

            this.LocationEditField.Value = string.empty();
            this.MetadataPatternEditField.Value = join(dummyAnalysis.MetadataPattern, pathsep());
            this.SciencePatternEditField.Value = dummyAnalysis.SciencePattern;
            this.HKPatternEditField.Value = join(dummyAnalysis.HKPattern, pathsep());
        end

        function options = getAnalysisOptions(this)

            % Validate location.
            location = this.LocationEditField.Value;

            if isempty(location)
                error("mag:app:EmptyLocation", "Location is empty.");
            elseif ~isfolder(location)
                error("mag:app:NonexistentLocation", "Location ""%s"" does not exist.", location);
            end

            % Retrieve data file patterns.
            if isempty(this.MetadataPatternEditField.Value)
                metadataPattern = string.empty();
            else
                metadataPattern = split(this.MetadataPatternEditField.Value, pathsep())';
            end

            options = {"Location", this.LocationEditField.Value, ...
                "MetadataPattern", metadataPattern, ...
                "SciencePattern", this.SciencePatternEditField.Value, ...
                "HKPattern", this.HKPatternEditField.Value};
        end
    end

    methods (Access = protected)

        function modelChangedCallback(~, ~, ~)
            % do nothing
        end
    end

    methods (Access = private)

        function browseButtonPushed(this)

            location = uigetdir(this.LocationEditField.Value, "Select Data Root");

            if ~isequal(location, 0)
                this.LocationEditField.Value = location;
            end
        end
    end
end

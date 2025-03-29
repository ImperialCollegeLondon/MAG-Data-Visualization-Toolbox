classdef (Abstract) VisualizationManager < mag.app.manage.Manager
% VISUALIZATIONMANAGER Manager for visualization components.

    properties (Abstract, Constant, Access = protected)
        EmptyModel mag.app.Model {mustBeScalarOrEmpty}
    end

    properties (SetAccess = private)
        VisualizationOptionsLayout matlab.ui.container.GridLayout
        VisualizationOptionsPanel matlab.ui.container.Panel
        VisualizationTypeListBox matlab.ui.control.ListBox
    end

    properties (Access = protected)
        SelectedControl mag.app.Control {mustBeScalarOrEmpty}
    end

    methods

        function instantiate(this, parent)

            % Create VisualizationOptionsLayout.
            this.VisualizationOptionsLayout = uigridlayout(parent);
            this.VisualizationOptionsLayout.ColumnWidth = ["1x", "4x"];
            this.VisualizationOptionsLayout.RowHeight = "1x";

            % Create VisualizationTypeListBox.
            this.VisualizationTypeListBox = uilistbox(this.VisualizationOptionsLayout);
            this.VisualizationTypeListBox.ValueIndex = [];
            this.VisualizationTypeListBox.ValueChangedFcn = @(~, ~) this.visualizationTypeListBoxValueChanged();
            this.VisualizationTypeListBox.Enable = "off";
            this.VisualizationTypeListBox.Layout.Row = 1;
            this.VisualizationTypeListBox.Layout.Column = 1;

            this.setVisualizationTypesAndClasses(this.EmptyModel);

            % Create VisualizationOptionsPanel.
            this.VisualizationOptionsPanel = uipanel(this.VisualizationOptionsLayout);
            this.VisualizationOptionsPanel.Enable = "off";
            this.VisualizationOptionsPanel.BorderType = "none";
            this.VisualizationOptionsPanel.Layout.Row = 1;
            this.VisualizationOptionsPanel.Layout.Column = 2;

            % Reset.
            this.reset();
        end

        function reset(this)

            this.SelectedControl = mag.app.Control.empty();

            this.VisualizationTypeListBox.ValueIndex = [];
            this.VisualizationTypeListBox.Enable = "off";
            this.VisualizationOptionsPanel.Enable = "off";

            delete(this.VisualizationOptionsPanel.Children);
        end

        function figures = visualize(this, analysis)
        % VISUALIZE Visualize analysis using selected view.

            if isempty(this.SelectedControl)
                error("mag:app:noViewSelected", "No view selected.");
            end

            command = this.SelectedControl.getVisualizeCommand(analysis.Results);

            if command.NArgOut == 0

                command.call();
                figures = matlab.ui.Figure.empty();
            else
                figures = command.call();
            end
        end
    end

    methods (Abstract)

        % GETSUPPORTEDVISUALIZATIONS Retrieve supported visualization classes.
        supportedVisualizations = getSupportedVisualizations(this, model)
    end

    methods (Access = protected)

        function modelChangedCallback(this, model, ~)

            this.setVisualizationTypesAndClasses(model);

            if model.HasAnalysis

                this.VisualizationTypeListBox.Enable = "on";
                this.VisualizationOptionsPanel.Enable = "on";

                this.visualizationTypeListBoxValueChanged();
            else
                this.reset();
            end
        end
    end

    methods (Access = private)

        function setVisualizationTypesAndClasses(this, model)

            supportedVisualizations = this.getSupportedVisualizations(model);
            itemsData = mag.app.Control.empty();

            if ~isempty(model) && model.HasAnalysis

                for sv = supportedVisualizations

                    if sv.isSupported(model.Analysis.Results)
                        itemsData = [itemsData, sv]; %#ok<AGROW>
                    end
                end
            end

            if isempty(itemsData)
                items = string.empty();
            else

                items = [itemsData.Name];

                [items, idxSorted] = sort(items);
                itemsData = itemsData(idxSorted);
            end

            this.VisualizationTypeListBox.Items = items;
            this.VisualizationTypeListBox.ItemsData = itemsData;
        end

        function visualizationTypeListBoxValueChanged(this)

            if isempty(this.VisualizationTypeListBox.ValueIndex)
                return;
            end

            makePanelVisible = onCleanup(@() set(this.VisualizationOptionsPanel, Visible = "on"));
            this.VisualizationOptionsPanel.Visible = "off";

            this.SelectedControl = this.VisualizationTypeListBox.ItemsData(this.VisualizationTypeListBox.ValueIndex);
            this.SelectedControl.instantiate(this.VisualizationOptionsPanel);
        end
    end
end

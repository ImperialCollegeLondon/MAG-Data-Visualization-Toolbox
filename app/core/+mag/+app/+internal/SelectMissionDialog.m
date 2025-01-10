classdef SelectMissionDialog < handle
% SELECTMISSIONDIALOG Popup dialog to select mission.

    properties (SetAccess = private)
        Parent matlab.ui.Figure
        GridLayout matlab.ui.container.GridLayout
        Panel matlab.ui.container.Panel
        PanelLayout matlab.ui.container.GridLayout
        Label matlab.ui.control.Label
        MissionDropDown matlab.ui.control.DropDown
        SelectButton matlab.ui.control.Button
    end

    properties (SetAccess = private)
        SelectedMission mag.meta.Mission {mustBeScalarOrEmpty}
    end

    properties (Dependent, SetAccess = private)
        Aborted (1, 1) logical
    end

    methods

        function this = SelectMissionDialog(parent)

            this.Parent = parent;

            this.instantiate();
        end

        function mission = waitForSelection(this)

            uiwait(this.Parent);

            mission = this.SelectedMission;
        end

        function delete(this)

            if isvalid(this.Parent)
                uiresume(this.Parent);
            end

            delete(this.GridLayout);
        end

        function value = get.Aborted(this)
            value = isempty(this.SelectedMission);
        end
    end

    methods (Access = private)

        function instantiate(this)

            % Create GridLayout.
            this.GridLayout = uigridlayout(this.Parent);
            this.GridLayout.ColumnWidth = ["1x", "2x", "1x"];
            this.GridLayout.RowHeight = ["2x", "1x", "2x"];

            if isprop(this.Parent, "Theme") && isequal(this.Parent.Theme.BaseColorStyle, "dark")
                this.GridLayout.BackgroundColor = 0.02 * ones(1, 3);
            else
                this.GridLayout.BackgroundColor = 0.98 * ones(1, 3);
            end

            % Create Panel.
            this.Panel = uipanel(this.GridLayout);
            this.Panel.Title = "Select Mission";
            this.Panel.Layout.Row = 2;
            this.Panel.Layout.Column = 2;

            % Create PanelLayout.
            this.PanelLayout = uigridlayout(this.Panel);
            this.PanelLayout.ColumnWidth = ["fit", "2x", "1x"];
            this.PanelLayout.RowHeight = "1x";

            % Create Label.
            this.Label = uilabel(this.PanelLayout);
            this.Label.HorizontalAlignment = "right";
            this.Label.Layout.Row = 1;
            this.Label.Layout.Column = 1;
            this.Label.Text = "Mission:";

            % Create MissionDropDown.
            imap = mag.meta.Mission.IMAP;

            this.MissionDropDown = uidropdown(this.PanelLayout);
            this.MissionDropDown.Items = string(enumeration(imap));
            this.MissionDropDown.ItemsData = enumeration(imap);
            this.MissionDropDown.Layout.Row = 1;
            this.MissionDropDown.Layout.Column = 2;
            this.MissionDropDown.Value = string(imap);

            % Create SelectButton.
            this.SelectButton = uibutton(this.PanelLayout, "push");
            this.SelectButton.ButtonPushedFcn = @(~, ~) this.selectMissionButtonPushed();
            this.SelectButton.Layout.Row = 1;
            this.SelectButton.Layout.Column = 3;
            this.SelectButton.Text = "Select";
        end

        function selectMissionButtonPushed(this)

            this.SelectedMission = this.MissionDropDown.Value;
            uiresume(this.Parent);
        end
    end
end

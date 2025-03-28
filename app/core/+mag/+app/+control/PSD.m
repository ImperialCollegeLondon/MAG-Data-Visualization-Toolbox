classdef PSD < mag.app.Control
% PSD View-controller for generating PSD view.

    properties (Constant)
        Name = "PSD"
    end

    properties (SetAccess = immutable)
        ViewType function_handle {mustBeScalarOrEmpty}
    end

    properties (SetAccess = private)
        Layout matlab.ui.container.GridLayout
        StartDatePicker matlab.ui.control.DatePicker
        StartTimeField matlab.ui.control.EditField
        DurationSpinner matlab.ui.control.Spinner
        SyncYAxesCheckBox matlab.ui.control.CheckBox
    end

    methods

        function this = PSD(viewType)

            arguments
                viewType (1, 1) function_handle
            end

            this.ViewType = viewType;
        end

        function instantiate(this, parent)

            this.Layout = this.createDefaultGridLayout(parent);

            % Start date.
            startLabel = uilabel(this.Layout, Text = "Start date/time:");
            startLabel.Layout.Row = 1;
            startLabel.Layout.Column = 1;

            this.StartDatePicker = uidatepicker(this.Layout);
            this.StartDatePicker.Layout.Row = 1;
            this.StartDatePicker.Layout.Column = 2;

            this.StartTimeField = uieditfield(this.Layout, Placeholder = "HH:mm:ss.SSS");
            this.StartTimeField.Layout.Row = 1;
            this.StartTimeField.Layout.Column = 3;

            % Duration.
            durationLabel = uilabel(this.Layout, Text = "Duration (hours):");
            durationLabel.Layout.Row = 2;
            durationLabel.Layout.Column = 1;

            this.DurationSpinner = uispinner(this.Layout, Value = 1, ...
                Limits = [0, Inf]);
            this.DurationSpinner.Layout.Row = 2;
            this.DurationSpinner.Layout.Column = [2, 3];

            % Sync y-axes.
            this.SyncYAxesCheckBox = uicheckbox(this.Layout, Text = "Sync y-axes");
            this.SyncYAxesCheckBox.Layout.Row = 3;
            this.SyncYAxesCheckBox.Layout.Column = 2;

            % Note.
            noteLabel = uilabel(this.Layout, Text = "Note: does not support hybrid instrument modes.");
            noteLabel.Layout.Row = 5;
            noteLabel.Layout.Column = [1, 3];
        end

        function supported = isSupported(~, results)
            supported = results.HasScience;
        end

        function command = getVisualizeCommand(this, results)

            arguments (Input)
                this
                results (1, 1) mag.Instrument
            end

            arguments (Output)
                command (1, 1) mag.app.Command
            end

            startTime = mag.app.internal.combineDateAndTime(this.StartDatePicker.Value, this.StartTimeField.Value);
            duration = hours(this.DurationSpinner.Value);

            command = mag.app.Command(Functional = @(varargin) this.ViewType(varargin{:}).visualizeAll(), ...
                PositionalArguments = {results}, ...
                NamedArguments = struct(Start = startTime, Duration = duration, SyncYAxes = this.SyncYAxesCheckBox.Value));
        end
    end
end

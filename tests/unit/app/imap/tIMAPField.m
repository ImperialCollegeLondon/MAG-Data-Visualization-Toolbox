classdef tIMAPField < mag.test.case.ViewControllerTestCase
% TIMAPFIELD Unit tests for "mag.app.imap.control.Field" class.

    methods (Test)

        % Test that "instantiate" creates expected elements.
        function instantiate(testCase)

            % Set up.
            panel = testCase.createTestPanel();
            field = mag.app.imap.control.Field();

            % Exercise.
            field.instantiate(panel);

            % Verify.
            testCase.verifyStartEndDateButtons(field, StartDateRow = 1, EndDateRow = 2);

            testCase.assertNotEmpty(field.EventsTree, "Events tree should not be empty.");
            testCase.assertNumElements(field.EventsTree.Children, 3, "Events tree should have 3 children.");
            testCase.assertNotEmpty(field.OverrideNameField, "Override name field should not be empty.");

            testCase.verifyEqual(field.EventsTree.Layout, matlab.ui.layout.GridLayoutOptions(Row = [3, 4], Column = [2, 3]), ...
                "Events tree layout should match expectation.");

            testCase.verifyEqual(field.EventsTree.Children(1).Text, 'Compression', "First tree node should be ""Compression"".");
            testCase.verifyEqual(field.EventsTree.Children(2).Text, 'Mode', "Second tree node should be ""Mode"".");
            testCase.verifyEqual(field.EventsTree.Children(3).Text, 'Range', "Third tree node should be ""Range"".");

            testCase.verifyEqual(field.OverrideNameField.Layout, matlab.ui.layout.GridLayoutOptions(Row = 5, Column = [2, 3]), ...
                "Override name field layout should match expectation.");

            testCase.verifyEqual(field.OverrideNameField.Placeholder, 'Spike 1', "Override name field placeholder should be ""Spike 1"".");
        end

        % Test that "getVisualizeCommand" returns expected command.
        function getVisualizeCommand(testCase)

            % Set up.
            panel = testCase.createTestPanel();

            field = mag.app.imap.control.Field();
            field.instantiate(panel);

            results = mag.imap.Instrument();

            % Exercise.
            command = field.getVisualizeCommand(results);

            % Verify.
            testCase.verifyEqual(command.PositionalArguments, {results}, "Visualize command positional arguments should match expectation.");

            testCase.assertThat(command.NamedArguments, mag.test.constraint.IsField("Events"), """Events"" should be a named argument.");
            testCase.verifyEmpty(command.NamedArguments.Events, """Events"" should be empty when none selected.");

            testCase.assertThat(command.NamedArguments, mag.test.constraint.IsField("Name"), """Name"" should be a named argument.");
            testCase.verifyTrue(ismissing(command.NamedArguments.Name), """Name"" should match expectation.");
        end

        % Test that "getVisualizeCommand" returns expected command, when
        % one event has been selected.
        function getVisualizeCommand_selectedEvents(testCase)

            % Set up.
            panel = testCase.createTestPanel();

            field = mag.app.imap.control.Field();
            field.instantiate(panel);

            field.EventsTree.CheckedNodes = field.EventsTree.Children(2);

            results = mag.imap.Instrument();

            % Exercise.
            command = field.getVisualizeCommand(results);

            % Verify.
            testCase.verifyEqual(command.PositionalArguments, {results}, "Visualize command positional arguments should match expectation.");

            testCase.assertThat(command.NamedArguments, mag.test.constraint.IsField("Events"), """Events"" should be a named argument.");
            testCase.verifyEqual(command.NamedArguments.Events, "Mode", """Events"" should match expectation.");

            testCase.assertThat(command.NamedArguments, mag.test.constraint.IsField("Name"), """Name"" should be a named argument.");
            testCase.verifyTrue(ismissing(command.NamedArguments.Name), """Name"" should match expectation.");
        end

        % Test that "getVisualizeCommand" returns expected command, when
        % more than one event have been selected.
        function getVisualizeCommand_multipleSelectedEvents(testCase)

            % Set up.
            panel = testCase.createTestPanel();

            field = mag.app.imap.control.Field();
            field.instantiate(panel);

            field.EventsTree.CheckedNodes = [field.EventsTree.Children(1), field.EventsTree.Children(3)];

            results = mag.imap.Instrument();

            % Exercise.
            command = field.getVisualizeCommand(results);

            % Verify.
            testCase.verifyEqual(command.PositionalArguments, {results}, "Visualize command positional arguments should match expectation.");

            testCase.assertThat(command.NamedArguments, mag.test.constraint.IsField("Events"), """Events"" should be a named argument.");
            testCase.verifyEqual(command.NamedArguments.Events, ["Compression", "Range"], """Events"" should match expectation.");

            testCase.assertThat(command.NamedArguments, mag.test.constraint.IsField("Name"), """Name"" should be a named argument.");
            testCase.verifyTrue(ismissing(command.NamedArguments.Name), """Name"" should match expectation.");
        end

        % Test that "getVisualizeCommand" returns expected command, when
        % figure name is overridden.
        function getVisualizeCommand_overrideName(testCase)

            % Set up.
            panel = testCase.createTestPanel();

            field = mag.app.imap.control.Field();
            field.instantiate(panel);

            field.OverrideNameField.Value = "Test Name";

            results = mag.imap.Instrument();

            % Exercise.
            command = field.getVisualizeCommand(results);

            % Verify.
            testCase.verifyEqual(command.PositionalArguments, {results}, "Visualize command positional arguments should match expectation.");

            testCase.assertThat(command.NamedArguments, mag.test.constraint.IsField("Events"), """Events"" should be a named argument.");
            testCase.verifyEmpty(command.NamedArguments.Events, """Events"" should be empty when none selected.");

            testCase.assertThat(command.NamedArguments, mag.test.constraint.IsField("Name"), """Name"" should be a named argument.");
            testCase.verifyEqual(command.NamedArguments.Name, 'Test Name', """Name"" should match expectation.");
        end
    end
end

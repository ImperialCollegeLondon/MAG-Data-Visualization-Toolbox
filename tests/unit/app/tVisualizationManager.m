classdef tVisualizationManager < mag.test.ViewControllerTestCase
% TVISUALIZATIONMANAGER Unit tests for
% "mag.app.manage.VisualizationManager" class.

    properties (TestParameter)
        VisualzationClass = {"mag.app.bart.VisualizationManager", "mag.app.hs.VisualizationManager", "mag.app.imap.VisualizationManager"}
    end

    methods (Test)

        % Test that "instantiate" creates expected elements.
        function instantiate(testCase, VisualzationClass)

            % Set up.
            panel = testCase.createTestPanel();
            manager = feval(VisualzationClass);

            % Exercise.
            manager.instantiate(panel);

            % Verify.
            testCase.assertNotEmpty(manager.VisualizationOptionsLayout, "Layout should not be empty.");
            testCase.assertNotEmpty(manager.VisualizationOptionsPanel, "Panel should not be empty.");
            testCase.assertNotEmpty(manager.VisualizationTypeListBox, "List box should not be empty.");
        end

        % Test that "visualize" throws an error when no control is
        % selected.
        function visualiza_noSelection(testCase, VisualzationClass)

            % Set up.
            panel = testCase.createTestPanel();

            manager = feval(VisualzationClass);
            manager.instantiate(panel);

            % Exercise and verify.
            testCase.verifyError(@() manager.visualize([]), "mag:app:noViewSelected", ...
                "Error should be thrown when no view is selected.");
        end
    end
end

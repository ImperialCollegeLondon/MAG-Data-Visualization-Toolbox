classdef CleanupFigures < matlab.unittest.fixtures.Fixture
% CLEANUPFIGURES Close all figures generated by a test.

    properties (SetAccess = immutable)
        % GRAPHICSROOT Root objects for MATLAB graphics.
        GraphicsRoot (1, 1) matlab.ui.Root = groot()
    end

    properties (Access = private)
        % PRETESTFIGURES Handles to figures open before test. Should not be
        % closed by fixture.
        PreTestFigures (1, :) matlab.ui.Figure
    end

    methods

        function fixture = CleanupFigures(root)

            arguments
                root (1, 1) matlab.ui.Root = groot()
            end

            fixture.GraphicsRoot = root;
        end

        function setup(fixture)

            % Store pre-test figures.
            if ~isempty(fixture.GraphicsRoot.Children)
                fixture.PreTestFigures = fixture.GraphicsRoot.Children;
            end
        end

        function teardown(fixture)

            % Close any new figure.
            locTestFigure = ~ismember(fixture.GraphicsRoot.Children, fixture.PreTestFigures);
            close(fixture.GraphicsRoot.Children(locTestFigure));
        end
    end

    methods (Access = protected)

        function bool = isCompatible(~, ~)
            bool = false;
        end
    end
end
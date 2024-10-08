classdef HK < mag.meta.Data
% HK Description of MAG housekeeping data.

    properties
        % TYPE Type of HK data.
        Type string {mustBeScalarOrEmpty, mustBeMember(Type, ["PROCSTAT", "PW", "SCI", "SID15", "STATUS"])}
        % OUTBOARDSETUP Outboard sensor setup.
        OutboardSetup (1, 1) mag.meta.Setup
        % INBOARDSETUP Outboard sensor setup.
        InboardSetup (1, 1) mag.meta.Setup
    end

    methods

        function this = HK(options)

            arguments
                options.?mag.meta.HK
            end

            this.assignProperties(options);
        end
    end
end

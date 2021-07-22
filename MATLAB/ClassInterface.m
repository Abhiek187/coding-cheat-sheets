classdef ClassInterface < handle
    % Interface for the Class object
    % handle allows destructors to be called
    
    methods (Abstract)
        status(obj) % obj = this
    end
end

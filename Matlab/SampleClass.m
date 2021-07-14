classdef (Abstract) SampleClass < ClassInterface
    % Abstract class that implements the Class interface
    
    properties (SetAccess = protected, GetAccess = protected)
        Subject
        Size
        State
    end
    
    methods (Static)
        function out = setgetId(data)
            %SETGETID Initialize or retrieve the static id variable
            persistent Id; % static variable
            
            if nargin
                Id = data;
            else
                out = Id;
            end
        end
    end
    
    methods
        function obj = SampleClass(subject, size, state)
            %SAMPLECLASS Construct an instance of this class
            obj.Subject = subject;
            obj.Size = size;
            obj.State = state;
            SampleClass.setgetId(SampleClass.setgetId() + 1); % no ++ or +=
        end
        
        function delete(obj)
            %DELETE Destructor
            fprintf("You dropped out of %s.\n", obj.Subject)
        end
        
        function disp(obj)
            %DISP Print the class as a string
            fprintf("Welcome to some class! You are student #%d.\n", SampleClass.setgetId());
        end
        
        function status(obj)
            %STATUS Print the status of the class
            fprintf("This %s class has %d students and is %s.\n", obj.Subject, obj.Size, obj.State)
        end
    end
end

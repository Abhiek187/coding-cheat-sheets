classdef (Sealed) MathClass < SampleClass
    % Final class that extends the sample class
    
    methods
        function obj = MathClass(size)
            %MATHCLASS Construct an instance of this class
            obj = obj@SampleClass("Math", size, State.Rowdy);
            disp(obj)
        end
        
        function disp(obj)
            %DISP Print the class as a string
            fprintf("Welcome to math class! You are student #%d.\n", SampleClass.setgetId());
        end
    end
end

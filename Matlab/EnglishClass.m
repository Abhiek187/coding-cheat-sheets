classdef (Sealed) EnglishClass < SampleClass
    % Final class that extends the sample class
    
    methods
        function obj = EnglishClass(size)
            %ENGLISHCLASS Construct an instance of this class
            obj = obj@SampleClass("English", size, State.Calm);
            disp(obj)
        end
        
        function disp(obj)
            %DISP Print the class as a string
            fprintf("Welcome to english class! You are student #%d.\n", SampleClass.setgetId());
        end
    end
end

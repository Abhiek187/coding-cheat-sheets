% No main function here!
disp("Hello Matlab!") % no semicolon for output
% Only fprintf recognizes special characters
fprintf("By the way, you're using Matlab version %s\n", version)

% Variables
myInt = 5e-1; % semicolon to suppress output
myDouble = 6.8755;
myChar = 'Q'; % single quote for chars, double quotes for strings
myLogical = true; % aka a boolean
myString = "This is a string.";
myState = State.Calm;
student = struct("name", "Johnny", "grade", 100);

% Input/Output
name = input("What's your name? ", 's');
fprintf("Hey %s!\n", name)
fprintf("state: %s\n", char(myState))
fprintf("%s got a %d.\n\n", student.name, student.grade)

% Math Operations
fprintf("Adding two numbers: %d + %f = %f\n", myInt, myDouble, myInt + myDouble)
fprintf("Adding a number with a char: %d + %c = %d\n", myInt, myChar, myInt + myChar)
fprintf("Adding a number with a bool: %d + %d = %d\n", myInt, myLogical, myInt + myLogical)
fprintf("Dividing two ints: %d / 2 = %d\n", myInt, myInt / 2)
fprintf("%f ^ %d = %f\n", myDouble, myInt, myDouble .^ myInt)
fprintf("Weird math: 0/0 = %d, 0/0.0 = %f, sqrt(-1) = %f%+fj\n", 0/0, 0/0.0, real(sqrt(-1)), imag(sqrt(-1)))
fprintf("Rounding: %f --> %f\n\n", myDouble, round(myDouble, 3))

% Logical Operators
% && and || behave like normal
fprintf("~%d = %d\n", myLogical, ~myLogical)
fprintf("~~%d = %d\n", myInt, ~~myInt)

% Conditional Operators & Loops
%{
No ternary operator or do-while loop
while behaves like normal
%}
if student.grade > 80
    fprintf("%s did well.\n", student.name)
elseif student.grade > 65
    fprintf("%s passed.\n", student.name)
else
    fprintf("%s failed.\n", student.name)
end

switch myChar
    case {'A', 'E', 'I', 'O', 'U'}
        fprintf("%c is a vowel.\n", myChar) % no break statement :)
    case {'J', 'K', 'Q', 'X', 'Z'}
        fprintf("%c is special.\n", myChar)
    otherwise
        fprintf("%c is common.\n", myChar)
end

for timer = 5:-1:1 % start:step:stop (inclusive)
    disp(timer)
    
    if timer == 1
        fprintf("Blast off!\n\n")
    end
end

% Functions & Methods
max = 10;
fprintf("The sum from 1 to %d = %d\n", max, recursiveSum(max))
fprintf("myString is %d characters long.\n", strlength(myString))
fprintf("substr(1, 8): %s\n", extractBetween(myString, 1, 8))
fprintf("find('s'): %d\n", strfind(myString, 's'))
fprintf('\n') % just print a newline

% Matrices
mat1 = [1 4 7; 2 5 8; 3 6 9];
mat2 = zeros(3);
mat2(1, :) = [8 1 6]; % colon = everything
mat2(2, :) = [3 5 7];
mat2(3, :) = [4 9 2];
[rows, cols] = size(mat1);
fprintf("mat1 and mat2 are %d x %d matrices.\n", rows, cols)

% Indices start at 1, not 0
for r = 1:length(mat1)
    for c = 1:size(mat1, 1)
        fprintf("mat1[%d][%d] = %d\n", r, c, mat1(r, c))
    end
    
    fprintf("mat2[%d] = %d %d %d\n", r, mat2(r, 1), mat2(r, 2), mat2(r, 3))
end

disp("mat1 + mat2 =")
disp(mat1 + mat2)
disp("mat1 - mat2 =")
disp(mat1 - mat2)
disp("mat1 * mat2 =")
disp(mat1 * mat2) % matrix multiplication
disp("mat1 .* mat2 =")
disp(mat1 .* mat2) % element-wise multiplication
disp("|mat2| =")
disp(det(mat2)) % determinant
disp("mat1^T =")
disp(mat1') % transpose; ' and .' are similar for real numbers
disp("mat2^-1 =")
disp(inv(mat2)) % inverse

% Exception Handling
try
    recursiveSum(-1);
catch ME % MException
    fprintf("%s - %s\n\n", ME.identifier, ME.message)
end

% Classes
SampleClass.setgetId(0); % initialize the static id
% class0 = SampleClass("science", 20, State.Rowdy); % SampleClass is abstract
class1 = MathClass(50);
class2 = EnglishClass(30);
class1.status();
class2.status();

require "cmath"

def sumTo(n=1)
	if n < 1
		raise ArgumentError.new("n must be positive")
	end

	if n == 1 then n else n + sumTo(n - 1) end
end

def generic_func(*args)
	puts "#{args}"
end

module ClassModule
	def to_string(subject, id)
		"Welcome to #{subject} class! You are student \##{id}."
	end
end

class SampleClass
	include ClassModule # include = non-static, extend = static
	attr_accessor :subject # read+write access
	attr_accessor :size
	@@id = 0 # static

	def initialize(subject, size)
		@subject = subject # instance
		@size = size
		@@id += 1
	end

	def to_s # toString()
		to_string(@subject, @@id)
	end

	def status
		puts "This #{@subject} class has #{@size} students."
	end
end

class MathClass < SampleClass
	def initialize(size)
		super("math", size)
		puts self
	end
end

class EnglishClass < SampleClass
	def initialize(size)
		super("english", size)
		puts self
	end
end

=begin
No main function here!
=end
puts "Hello Ruby!" # automatic newline
print "By the way, you're running Ruby #{RUBY_VERSION}\n" # no newline

# Variables
myInt = -5
myDouble = 8.3945792e1
myBool = true
myString = "This is a string."
NULL = nil # constant

# Input/Output
print "Enter your name: "
name = gets.chomp
name.capitalize!
puts "Hi #{name}!"
puts "null: #{NULL}"
puts "\n" # prints just a newline

# Math Operations
puts "#{myInt} + #{myDouble} = #{myInt + myDouble}"
puts "Complex math: #{myInt} ^ #{myDouble} = #{myInt ** myDouble}"
puts "#{myInt} mod #{myDouble} = #{myInt % myDouble}"
puts "Weird math: 0/0.0 = #{0/0.0}, sqrt(-1) = #{CMath.sqrt(-1)}"
puts "Rounding: #{myDouble} \u2192 #{myDouble.round(2)}"
puts "\n"

# Logical Operators
# &&, ||, and ! behave like normal

# Conditional Operators & Loops
if myDouble < 0
	puts "myDouble is negative"
elsif myDouble > 0
	puts "myDouble is positive"
else
	puts "myDouble is 0"
end

unless myDouble.to_i % 2 == 0 # unless == if !...
	puts "myDouble as an int (#{myDouble.to_i}) is odd"
end

for i in 1...10 # one less dot includes 10
	next if i % 3 == 0
	puts i
end

i = 5
until i <= 0 # until == while !...
	puts i
	i -= 1
	break if i == 2
end

case i
	when 2
		puts "I stopped at 2"
	else
		puts "I stopped at 0"
end

3.times { print "Ruby is " }
puts "Ruby\n\n"

# Functions & Methods
generic_func("lucky", 7, true)
puts "sum(1, 10) = #{sumTo(10)}"
puts "#{myString} is #{myString.length} characters long"
puts "#{myString} backwards is #{myString.reverse}"
puts "Shouting #{myString} yields #{myString.upcase}"
puts "myString[#{myInt}..-2] = #{myString[myInt..-2]}"
puts "s is located at index #{myString.index('s')}"
puts "\n"

# Arrays & Hashes
myArray = [0, "is", false]
myArray << []
myArray.each { |elem| puts "#{elem}" }

myHash = Hash.new # empty hash
myHash = { # hash with symbolic keys
	:id => 1000101,
	name: "Joe"
}

myHash.each do |key, value|
	puts "#{key} = #{value}"
end

# Exception Handling
begin
	sumTo(-1)
rescue ArgumentError => msg
	puts "Error: #{msg}"
ensure
	puts "\n"
end

# Classes
mathClass = MathClass.new(50)
englishClass = EnglishClass.new(30)
mathClass.status
englishClass.status

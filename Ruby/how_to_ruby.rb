require "cmath"

def sum_to(n=1)
	if n < 1
		raise ArgumentError.new("n must be positive")
	end

	if n == 1 then n else n + sum_to(n - 1) end
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
my_int = -5
my_double = 8.3945792e1
my_bool = true
my_string = "This is a string."
NULL = nil # constant

# Input/Output
print "Enter your name: "
# gets by default will try to read from a file and interfere with ARGV
name = (STDIN.gets || "").chomp
name.capitalize! # ! == in-place
puts "Hi #{name}!"
puts "null: #{NULL}"
puts "\n" # prints just a newline

# Math Operations
puts "#{my_int} + #{my_double} = #{my_int + my_double}"
puts "Complex math: #{my_int} ^ #{my_double} = #{my_int ** my_double}"
puts "#{my_int} mod #{my_double} = #{my_int % my_double}"
puts "Weird math: 0/0.0 = #{0/0.0}, sqrt(-1) = #{CMath.sqrt(-1)}"
puts "Rounding: #{my_double} \u2192 #{my_double.round(2)}"
puts "\n"

# Logical Operators
# &&, ||, and ! behave like normal

# Conditional Operators & Loops
if my_double < 0
	puts "my_double is negative"
elsif my_double > 0
	puts "my_double is positive"
else
	puts "my_double is 0"
end

unless my_double.to_i % 2 == 0 # unless == if !...
	puts "my_double as an int (#{my_double.to_i}) is odd"
end

for i in 1...10 # one less dot includes 10
	next if i % 3 == 0
	puts i
end

if ARGV.length > 0
	for i in 0...ARGV.length
		puts "ARGV[#{i}] = #{ARGV[i]}"
	end
else
	puts "Hmm, you didn't enter any command line arguments."
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
puts "sum(1, 10) = #{sum_to(10)}"
puts "#{my_string} is #{my_string.length} characters long"
puts "#{my_string} backwards is #{my_string.reverse}"
puts "Shouting #{my_string} yields #{my_string.upcase}"
puts "my_string[#{my_int}..-2] = #{my_string[my_int..-2]}"
puts "s is located at index #{my_string.index('s')}"
puts "\n"

# Arrays & Hashes
my_array = [0, "is", false]
my_array << []
my_array.each { |elem| puts "#{elem}" }

my_hash = Hash.new # empty hash
my_hash = { # hash with symbolic keys
	:id => 1000101,
	name: "Joe"
}

my_hash.each do |key, value|
	puts "#{key} = #{value}"
end

# Exception Handling
begin
	sum_to(-1)
rescue ArgumentError => msg
	puts "Error: #{msg}"
ensure
	puts "\n"
end

# Classes
math_class = MathClass.new(50)
english_class = EnglishClass.new(30)
math_class.status
english_class.status

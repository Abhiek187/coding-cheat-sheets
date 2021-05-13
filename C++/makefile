# G++ flags
G++ = g++ -std=c++17 -pedantic-errors -Wall -g3
# File name
FILE = HowToC++
# Binary files
OUTPUTS = $(wildcard *.out) $(wildcard *.o)

# Default make command
all: $(FILE).out

# $@ = left of colon (target), $< = right of colon (prerequisite), $^ = all prerequisites
$(FILE).out: $(FILE).cpp $(FILE).h
	$(G++) -o $@ $^

# Remove all binary files (-f removes error if no files exist)
clean:
	rm -f $(OUTPUTS)

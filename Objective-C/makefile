# GCC flags
GCC = gcc -pedantic-errors -Wall -g3
OBJC = -fobjc-arc -framework Foundation # -lobjc
# File name
FILE = HowToObjectiveC
# Binary files
OUTPUTS = $(wildcard *.out*) $(wildcard *.o)

# Default make command
all: $(FILE).out

# $@ = left of colon (target), $< = right of colon (prerequisite), $^ = all prerequisites
$(FILE).out: $(FILE).m
	$(GCC) $(OBJC) -o $@ $<

# Remove all binary files (-f removes error if no files exist)
clean:
	rm -rf $(OUTPUTS)

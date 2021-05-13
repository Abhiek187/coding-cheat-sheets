# SwiftC flags
SWIFTC = swiftc -g
# File name
FILE = main
# Binary files
OUTPUTS = $(wildcard *.out) $(wildcard *.o)

# Default make command
all: $(FILE).out

# $@ = left of colon (target), $< = right of colon (prerequisite), $^ = all prerequisites
$(FILE).out: $(FILE).swift
	$(SWIFTC) -o $@ $<

# Remove all binary files (-f removes error if no files exist)
clean:
	rm -f $(OUTPUTS)

# What this file does: 
#	Compile main.c into an object file.
#	Assemble startup.s into an object file.
#	Link them using linker.ld into an ELF.
#	Optionally convert the ELF into a .bin. (some flashing/debug tools can use ELF directly)

# variables:
# base name of the output files
TARGET = blink
# compiler driver for bare-metal ARM
CC = arm-none-eabi-gcc
# Converts ELF into raw binary 
OBJCOPY = arm-none-eabi-objcopy

#	-mcpu=cortex-m7: build for Cortex-m7
#	-mthumb: generate thumb code
#	-Wall: 
#	-Wextra
#	-O0: No optimization (for learning)
#	-ffreestanding: tell compiler this is bare-metal
#	-nostdlib: Don't pull in the normal hosted C runtime and std libs. (This is a bare-metal enviroment)

CFLAGS = -mcpu=cortex-m7 -mthumb -Wall -Wextra -O0 -ffreestanding -nostdlib

#	-T linker.ld: tells linker to use the linker script.
#	 -nostdlib: prevents normal system startup/runtime from being linked. (we wrote everything by hand)

LDFLAGS = -T linker.ld -nostdlib

SRCS = main.c startup.s
OBJS = main.o startup.o

#	Basic syntax:
#	target: prereqisites
#	  recipe
#	
#	target: 		the file or action we want.
#	prerequisites: 	things the target depends on
#	recipe: 		the command to run to build it
#
#	$@ is the target name of the current rule
#	$< is the first prerequisite of the current rule
#	$^ is all prereqisites  of the current rule.

# make will try to build those 
all: $(TARGET).elf $(TARGET).bin

$(TARGET).elf: $(OBJS) linker.ld
	$(CC) $(CFLAGS) $(OBJS) $(LDFLAGS) -o $@

main.o: main.c
	$(CC) $(CFLAGS) -c $< -o $@
#expands to: arm-none-eabi-gcc ... -c main.c -o main.o

startup.o: startup.s
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $< $@

# make clean rule, suitable for Windows/Powershell
clean:
	del /Q *.o *.elf *.bin

# tells make that all and clean are not real files, but rules
.PHONY: all clean


# What this file does: 
#	Compile main.c into an object file.
#	Assemble startup.s into an object file.
#	Link them using linker.ld into an ELF.
#	Optionally convert the ELF into a .bin. (some flashing/debug tools can use ELF directly)

# variables:
# base name of the output files
# Note: ":=" is immediate expanstion, as opposed to "=" which is expanded only when used later.
#       Using ":=" make the code more predictable.
TARGET 		:= blink
# compiler driver for bare-metal ARM
CC 			:= arm-none-eabi-gcc
# Converts ELF into raw binary 
OBJCOPY 	:= arm-none-eabi-objcopy

SRC_DIR 	:= src
INC_DIR 	:= include
BUILD_DIR 	:= build
ELF 		:= $(BUILD_DIR)/$(TARGET).elf
BIN 		:= $(BUILD_DIR)/$(TARGET).bin
MAIN_OBJ 	:= $(BUILD_DIR)/main.o
STARTUP_OBJ := $(BUILD_DIR)/startup.o
OBJS 		:= $(MAIN_OBJ) $(STARTUP_OBJ)

#	-mcpu=cortex-m7: build for Cortex-m7
#	-mthumb: generate thumb code
#	-Wall: 
#	-Wextra
#	-O0: No optimization (for learning)
#	-ffreestanding: tell compiler this is bare-metal
#	-nostdlib: Don't pull in the normal hosted C runtime and std libs. (This is a bare-metal enviroment)
#   -I location of include files

CFLAGS := -mcpu=cortex-m7 -mthumb -Wall -Wextra -O0 -ffreestanding -nostdlib -I$(INC_DIR)

#	-T linker.ld: tells linker to use the linker script.
#	 -nostdlib: prevents normal system startup/runtime from being linked. (we wrote everything by hand)

LDFLAGS := -T linker.ld -nostdlib

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

# 	Using "| $(BUILD_DIR)" (order only prerequisite) means - 
#   build/ must exist before we create build/main.o, but if the timestamp
#   of build/ changes - this should not force a rebuild.

#   Note: the link rule reuses CFLAGS, which have two reduntant switches: -I, -ffreestadning.
#         These are igonred while linking so they are harmless, but a cleaner design would be 
# 		  to seperate the flags by purpose.

# make will try to build those 
all: $(ELF) $(BIN)

$(BUILD_DIR):
	mkdir $(BUILD_DIR)

$(ELF): $(OBJS) linker.ld | $(BUILD_DIR)
	$(CC) $(CFLAGS) $(OBJS) $(LDFLAGS) -o $@

$(MAIN_OBJ): $(SRC_DIR)/main.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@
#expands to: arm-none-eabi-gcc ... -c main.c -o main.o

$(STARTUP_OBJ): $(SRC_DIR)/startup.s | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BIN): $(ELF)
	$(OBJCOPY) -O binary $< $@

# make clean rule, suitable for Windows/Powershell
clean:
	del /Q $(BUILD_DIR)\*.o $(BUILD_DIR)\*.elf $(BUILD_DIR)\*.bin

# tells make that all and clean are not real files, but rules
.PHONY: all clean


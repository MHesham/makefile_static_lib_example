TARGET = libfoo.a
SRC_DIR = src
BUILD_DIR = build
OUT_DIR = lib
INC_DIR = inc
CC = gcc
CFLAGS = -Wall -pedantic -std=c99 -I$(INC_DIR)
ARFLAGS = rcs

# get all .c source files from the source directory
# Note: this may not work for recursive source structures
SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
# prefix all source file paths with the build dir and replace the .c extension with .o
OBJ_FILES = $(SRC_FILES:%.c=$(BUILD_DIR)/%.o)

all: dirs $(OUT_DIR)/$(TARGET)

$(OUT_DIR)/$(TARGET): $(OBJ_FILES)
	@echo "[Link $^ to produce $@ static lib]"
	ar $(ARFLAGS) $@ $^

# general rule to make any .o ob file out of its corresponding .c source file
$(OBJ_FILES): $(BUILD_DIR)/%.o: %.c
	@echo "[Compile] $< to $(@D)"
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

# make build and output dirs if they don't exist
dirs:
	@-mkdir -p $(BUILD_DIR)
	@-mkdir -p $(OUT_DIR)
	@echo SRC_FILES=$(SRC_FILES)
	@echo OBJ_FILES=$(OBJ_FILES)

# nuke the build and output dirs
clean:
	@-rm -r $(BUILD_DIR)
	@-rm -r $(OUT_DIR)
	@echo Clean done successfully

rebuild: clean all

# mark rules that don't produce files directly
.PHONY: clean all rebuild dirs


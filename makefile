TARGET = libfoo.a
SRC_DIR = src
BUILD_DIR = build
OUT_DIR = lib
INC_DIR = inc
CC = gcc
CFLAGS = -Wall -pedantic -std=c99 -I$(INC_DIR)
ARFLAGS = rcs

SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES = $(SRC_FILES:.c=.o)

all: dirs $(OUT_DIR)/$(TARGET)

$(OUT_DIR)/$(TARGET): $(OBJ_FILES)
	@echo [Link (Static)]
	@ar $(ARFLAGS) $@ $^

# rule to compile any .c file into a .o file
%.o: %.c
	@echo [Compile] $<
	@mkdir -p $(@D)
	@$(CC) $(CFLAGS) -c $< -o $@

dirs:
	-mkdir -p $(BUILD_DIR)
	-mkdir -p $(OUT_DIR)

clean:
	-rm -r $(BUILD_DIR)
	-rm -r $(OUT_DIR)

rebuild: clean all

.PHONY: clean all rebuild dirs


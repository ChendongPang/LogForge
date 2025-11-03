# === Compiler and flags ===
CC       := gcc
CFLAGS   := -O2 -Wall -Wextra -std=gnu11
LDFLAGS  := -luring -lpthread

# === Source and build paths ===
SRC_DIR  := src
OBJ_DIR  := build
TARGET   := logforge

SRC := $(wildcard $(SRC_DIR)/*.c)
OBJ := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC))

# === Default target ===
.PHONY: all clean debug release

all: $(TARGET)

# === Link step ===
$(TARGET): $(OBJ)
    $(CC) $(OBJ) -o $@ $(LDFLAGS)

# === Compile step ===
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
    @mkdir -p $(OBJ_DIR)
    $(CC) $(CFLAGS) -c $< -o $@

# === Cleaning ===
clean:
    rm -rf $(OBJ_DIR) $(TARGET)

# === Debug/Release shortcuts ===
debug:
    $(MAKE) CFLAGS="-O0 -g -Wall -Wextra -std=gnu11"

release:
    $(MAKE) CFLAGS="-O2 -DNDEBUG -Wall -Wextra -std=gnu11"
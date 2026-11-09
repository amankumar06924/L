CXX := g++
CXXFLAGS := -std=c++20 -Wall -Wextra -Wpedantic -O2 -Iinclude
LDFLAGS := -luser32 -lpsapi -liphlpapi

TARGET := build/sentinelx.exe

SRC := $(wildcard src/*.cpp \
                   src/core/*.cpp \
                   src/platform/windows/*.cpp \
                   src/detection/*.cpp \
                   src/alerts/*.cpp \
                   src/storage/*.cpp)

OBJ := $(patsubst src/%.cpp,build/%.o,$(SRC))

.PHONY: all clean run

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CXX) $(OBJ) -o $@ $(LDFLAGS)

build/%.o: src/%.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

run: $(TARGET)
	./$(TARGET)

clean:
	rm -rf build
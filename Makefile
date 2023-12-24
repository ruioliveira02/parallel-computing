CC = gcc
CFLAGS = -O3 -Wno-unused-result -pg -mavx -fopenmp# none

CXX = nvcc
CXXFLAGS = -O2 -pg -std=c++11 -arch=sm_35 -Wno-deprecated-gpu-targets

SRC = src/
BIN = bin/

.DEFAULT_GOAL = $(BIN)MDcuda.exe

all: $(BIN)MDseq.exe $(BIN)MDpar.exe $(BIN)MDcuda.exe


$(BIN)MDold.exe: $(SRC)MDold.cpp
	$(CC) $(CFLAGS) $< -lm -o $@

$(BIN)MDseq.exe: $(SRC)MDseq.cpp
	$(CC) $(CFLAGS) $< -lm -o $@

$(BIN)MDpar.exe: $(SRC)MDpar.cpp
	module load gcc/11.2.0;\
	$(CC) $(CFLAGS) $< -lm -fopenmp -o $@

$(BIN)MDcuda.exe: $(SRC)MDcuda.cu
	module load gcc/7.2.0;\
	module load cuda/11.3.1;\
	nvcc $(CXXFLAGS) $< -o $@

$(BIN)checker: $(SRC)checker.cpp
	g++ $< -o $@

clean:
	rm -f $(BIN)*

run: $(BIN)MDcuda.exe
	sbatch run.sh

check: $(BIN)checker run
	$(BIN)checker < expected.txt

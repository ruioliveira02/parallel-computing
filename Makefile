CC = gcc
SRC = src/
BIN = bin/
CFLAGS = -O3 -pg -mavx -fopenmp# none

.DEFAULT_GOAL = all

all: $(BIN)MDseq.exe $(BIN)MDpar.exe


$(BIN)MDseq.exe: $(SRC)MDseq.cpp
	$(CC) $(CFLAGS) $(SRC)MDseq.cpp -lm -o $@

$(BIN)MDpar.exe: $(SRC)MDpar.cpp
	$(CC) $(CFLAGS) $(SRC)MDpar.cpp -lm -fopenmp -o $@

$(BIN)checker: $(SRC)checker.cpp
	g++ $(SRC)checker.cpp -o $@

clean:
	rm -f $(BIN)MD*.exe checker

run: $(BIN)MDpar.exe
	$(BIN)MDpar.exe < inputdata.txt > /dev/null

check: $(BIN)checker run
	$(BIN)checker < expected.txt

CC = gcc
SRC = src/
BIN = bin/
CFLAGS = -O3 -Wno-unused-result -pg -mavx -fopenmp# none

.DEFAULT_GOAL = all

all: $(BIN)MDseq.exe $(BIN)MDpar.exe


$(BIN)MDold.exe: $(SRC)MDold.cpp
	$(CC) $(CFLAGS) $< -lm -o $@

$(BIN)MDseq.exe: $(SRC)MDseq.cpp
	$(CC) $(CFLAGS) $< -lm -o $@

$(BIN)MDpar.exe: $(SRC)MDpar.cpp
	$(CC) $(CFLAGS) $< -lm -fopenmp -o $@

$(BIN)checker: $(SRC)checker.cpp
	g++ $< -o $@

clean:
	rm -f $(BIN)*

run: $(BIN)MDpar.exe
	$< < inputdata.txt > /dev/null

check: $(BIN)checker run
	$(BIN)checker < expected.txt

CC = gcc
SRC = src/
CFLAGS = -O3 -pg -mavx -fopenmp# none

.DEFAULT_GOAL = MD.exe

MD.exe: $(SRC)MD.cpp
	$(CC) $(CFLAGS) $(SRC)MD.cpp -lm -o MD.exe

checker: $(SRC)/checker.cpp
	g++ $(SRC)checker.cpp -o checker

assembly: $(SRC)MD.cpp
	$(CC) $(CFLAGS) -S $(SRC)MD.cpp -lm -o assembly

clean:
	rm -f ./MD.exe assembly

run: MD.exe
	./MD.exe < inputdata.txt

check: checker run
	./checker < expected.txt

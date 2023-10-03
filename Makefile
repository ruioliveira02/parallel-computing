CC = gcc
SRC = src/
CFLAGS = -O3 -pg -mavx# none

.DEFAULT_GOAL = MD.exe

MD.exe: $(SRC)/MD.cpp
	$(CC) $(CFLAGS) $(SRC)MD.cpp -lm -o MD.exe

assembly: $(SRC)/MD.cpp
	$(CC) $(CFLAGS) -S $(SRC)MD.cpp -lm -o assembly

clean:
	rm -f ./MD.exe assembly

run: MD.exe
	./MD.exe < inputdata.txt

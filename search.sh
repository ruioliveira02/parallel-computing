USERNAME=pgXXXXX
METRICS=instructions,cycles,L1-dcache-load-misses

scp Makefile $USERNAME@s7edu.di.uminho.pt:~
scp src/MD.cpp $USERNAME@s7edu.di.uminho.pt:~/src

ssh $USERNAME@s7edu.di.uminho.pt "module load gcc/9.3.0
make
echo Starting runs...
srun --partition=cpar perf stat -r 3 -e $METRICS sh -c 'make run > /dev/null' 2> results.txt"

scp $USERNAME@s7edu.di.uminho.pt:~/results.txt results.txt
cat results.txt


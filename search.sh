USERNAME=pg54257

scp Makefile $USERNAME@s7edu.di.uminho.pt:~
scp src/MD.cpp $USERNAME@s7edu.di.uminho.pt:~/src

ssh $USERNAME@s7edu.di.uminho.pt "make
srun --partition=cpar perf stat -r 3 -e cache-misses,cache-references make run"

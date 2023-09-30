USERNAME=pg54257

scp src/MD.cpp $USERNAME@s7edu.di.uminho.pt:~/src

ssh $USERNAME@s7edu.di.uminho.pt "make
srun --partition=cpar perf stat -e cache-misses,cache-references ./MD.exe < inputdata.txt"
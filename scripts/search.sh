USERNAME=pg54257
REMOTE=$USERNAME@s7edu.di.uminho.pt

scp Makefile $REMOTE:~
scp src/MDcuda.cu $REMOTE:~/src
scp scripts/run.sh $REMOTE:~

ssh $REMOTE -t "rm slurm-*.out
make && make run"

scp $REMOTE:~/slurm-*.out results.txt
tail -10 results.txt
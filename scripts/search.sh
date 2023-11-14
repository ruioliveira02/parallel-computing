USERNAME=pg54257
REMOTE=$USERNAME@s7edu.di.uminho.pt
EXEC=MDpar
CPUS=6

scp Makefile $REMOTE:~
scp src/$EXEC.cpp $REMOTE:~/src
scp scripts/run.sh $REMOTE:~

ssh $REMOTE -t "module load gcc/11.2.0
make bin/$EXEC.exe
rm slurm-*.out
(sbatch --partition=cpar --cpus-per-task=$CPUS -W run.sh && pkill -P $$)&
watch tail -25 slurm-*.out"
#srun --partition=cpar perf stat -r 3 -e $METRICS sh -c 'make run > /dev/null' 2> results.txt

scp $REMOTE:~/slurm-*.out results.txt
tail -10 results.txt
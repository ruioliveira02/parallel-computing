#!/bin/sh
#SBATCH --time=1:00
#SBATCH --partition=cpar
#SBATCH --constraint=k20
#SBATCH -W

METRICS=instructions,cycles,L1-dcache-load-misses
REPS=1


perf stat -r $REPS -e $METRICS sh -c "bin/MDcuda.exe < inputdata.txt"

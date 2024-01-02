#!/bin/sh
#SBATCH --time=1:00
#SBATCH --partition=cpar
#SBATCH --constraint=k20
#SBATCH -W

bin/MDcuda.exe < inputdata.txt

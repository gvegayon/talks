#!/bin/bash 
#SBATCH --tasks=1
#SBATCH --array=1-3
#SBATCH --job-name=01-slurm-abcoptim
#SBATCH --output=01-slurm-abcoptim-%A_%a.out

source /usr/usc/R/3.4.0/setup.sh
Rscript --vanilla ~/hpc-with-r/examples/01-slurm-abcoptim.R 


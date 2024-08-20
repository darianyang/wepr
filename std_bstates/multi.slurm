#!/bin/bash
#SBATCH --job-name=multi_analysis
#SBATCH --output=slurm_multi.out
#SBATCH --error=slurm_multi.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cluster=smp
#SBATCH --partition=smp
#SBATCH --mem-per-cpu=64000
#SBATCH --time=23:59:59
#SBATCH --mail-type=END
#SBATCH --mail-user=shp176@pitt.edu

source ~/.bashrc
conda activate we
bash multi.sh

#!/bin/bash
#SBATCH --job-name=v02_100_136_md01
#SBATCH --output=slurm_01.out
#SBATCH --error=slurm_01.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH --cluster=gpu
#SBATCH --partition=a100
#SBATCH --time=47:59:59
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=shp176@pitt.edu

module load gcc/8.2.0 openmpi/4.0.3 amber/22

pmemd.cuda  -O -i md01.in -p 1lst.prmtop -c v02_100_136.ncrst \
          -r md01.ncrst -x md01.nc -o md01.log -inf md01.nfo


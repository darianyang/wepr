#!/bin/bash
#SBATCH --job-name=v01_test_md
#SBATCH --output=slurm_v01.out
#SBATCH --error=slurm_v01.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH --cluster=gpu
#SBATCH --partition=a100
#SBATCH --time=00:59:59
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=shp176@pitt.edu

module load gcc/8.2.0 openmpi/4.0.3 amber/22

pmemd.cuda  -O -i md.in -p 1lst.prmtop -c v01.ncrst \
          -r v01.ncrst -x v01.nc -o v01.log -inf v01.nfo

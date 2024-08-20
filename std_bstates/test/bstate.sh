#!/bin/bash
#SBATCH --job-name=bstate_test_md
#SBATCH --output=slurm_bstate.out
#SBATCH --error=slurm_bstate.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH --cluster=gpu
#SBATCH --partition=a100
#SBATCH --time=00:59:59
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=shp176@pitt.edu

module load gcc/8.2.0 openmpi/4.0.3 amber/22

pmemd.cuda  -O -i md.in -p 1lst.prmtop -c bstate.ncrst \
          -r bstate.ncrst -x bstate.nc -o bstate.log -inf bstate.nfo


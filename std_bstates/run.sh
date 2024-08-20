#!/bin/bash
# run next batch of simulations

# Extract the third column and remove ".ncrst" extension
names=$(awk '{print $3}' bstates.txt | sed 's/\.ncrst$//')

# Loop through the names
for name in $names; do
    echo "$name"
    cd $name

    sbatch run03.slurm 

    cd ..
done


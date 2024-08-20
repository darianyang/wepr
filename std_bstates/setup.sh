#!/bin/bash
# set up mutiple simulations

# loop through each bstate file
for i in *.ncrst ; do
    # maybe strip out the .ncrst

    # only if the directory does not exist
    mkdir $bstate

    cd into it
    cp ../template/* .
    bash temp_sed.sh $bstate
 
    # don't run this line until you ensure code works
    #sbatch md01.slurm

    cd ..
done

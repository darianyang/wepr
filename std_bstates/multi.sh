#!/bin/bash

#conda activate we

# Extract the third column and remove ".ncrst" extension
names=$(awk '{print $3}' bstates.txt | sed 's/\.ncrst$//')

# Loop through the names
for name in $names; do
    echo "$name"
    cd $name

   # CMD="     parm ../1lst.prmtop \n"
   # CMD="$CMD trajin md01.nc 1 last 10\n"
   # CMD="$CMD trajin md02.nc 1 last 10\n"
   # CMD="$CMD trajin md03.nc 1 last 10\n"
   # CMD="$CMD autoimage \n"
   # CMD="$CMD reference ../bstate.ncrst [bs]\n"
    #CMD="$CMD rmsd bb @C,CA,N ref [bs] @C,CA,N out rmsd_bb.dat\n"
   # CMD="$CMD run \n"

    #echo -e $CMD > cpp.in
    #pptraj -i cpp.in

    python ../analyze.py md03.nc pc_600ns.dat &&
    echo "DONE with: ${name}"

    cd ..
done


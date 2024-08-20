#!/bin/bash

#conda activate we

# Extract the third column and remove ".ncrst" extension
names=$(awk '{print $3}' bstates.txt | sed 's/\.ncrst$//')

# string of data names
CMD=""
for name in $names; do
    CMD="$CMD $name/pc_200ns.dat"
    CMD="$CMD $name/pc_400ns.dat"
done

mdap -X $CMD -Xi 1 -Y $CMD -Yi 0 --histrange-x 30 90 --histrange-y 20 55 --xlabel "Opening Angle" --ylabel "Cu(II)-Cu(II) Distance" -nots -o pdist600.pdf

#mdap -X $CMD -Xi 1 --ylabel "Opening Angle" -nots -o time_pc1.pdf -dt "time" -pm line -ts 1 --xlabel "Time (ns)" -lw 0.5 --axvline 200 --grid -ppf ppf.post -Xint 100 &&

#mdap -X $CMD -Xi 0 --ylabel "Cu(II)-Cu(II) Distance ($\AA$)" -nots -o time_pc0.pdf -dt "time" -pm line -ts 1 --xlabel "Time (ns)" -lw 0.5 --axvline 200 --grid -ppf ppf.post -Xint 100


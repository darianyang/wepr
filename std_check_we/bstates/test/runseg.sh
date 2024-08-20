#!/bin/bash

if [ -n "$SEG_DEBUG" ] ; then
  set -x
  env | sort
fi

cd $WEST_SIM_ROOT
mkdir -pv $WEST_CURRENT_SEG_DATA_REF
cd $WEST_CURRENT_SEG_DATA_REF

ln -sv $WEST_SIM_ROOT/common_files/1lst.prmtop .
ln -sv $WEST_SIM_ROOT/common_files/analyze.py .

echo $WEST_PARENT_DATA_REF

if [ "$WEST_CURRENT_SEG_INITPOINT_TYPE" = "SEG_INITPOINT_CONTINUES" ]; then
  sed "s/RAND/$WEST_RAND16/g" $WEST_SIM_ROOT/common_files/md.in > md.in
  ln -sv $WEST_PARENT_DATA_REF/seg.ncrst ./parent.ncrst
elif [ "$WEST_CURRENT_SEG_INITPOINT_TYPE" = "SEG_INITPOINT_NEWTRAJ" ]; then
  sed "s/RAND/$WEST_RAND16/g" $WEST_SIM_ROOT/common_files/md.in > md.in
  #ln -sv $WEST_PARENT_DATA_REF/bstate.ncrst ./parent.ncrst
  ln -sv $WEST_PARENT_DATA_REF ./parent.ncrst
fi

$PMEMD  -O -i md.in   -p 1lst.prmtop -c parent.ncrst \
           -r seg.ncrst -x seg.nc      -o seg.log    -inf seg.nfo &&

python analyze.py parent.ncrst seg.nc

cat pcoord.dat | awk {'print $1,$2'} > $WEST_PCOORD_RETURN

cat pcoord.dat | awk {'print $2'} > $WEST_OPENING_RETURN
cat pcoord.dat | awk {'print $3'} > $WEST_TWISTING_RETURN

cp 1lst.prmtop $WEST_TRAJECTORY_RETURN
cp seg.nc $WEST_TRAJECTORY_RETURN

cp 1lst.prmtop $WEST_RESTART_RETURN
cp seg.ncrst $WEST_RESTART_RETURN/parent.ncrst

cp seg.log $WEST_LOG_RETURN

rm 1lst.prmtop analyze.py pcoord.dat

#!/bin/bash

if [ -n "$SEG_DEBUG" ] ; then
  set -x
  env | sort
fi

cd $WEST_SIM_ROOT

echo $WEST_STRUCT_DATA_REF

#cat $WEST_STRUCT_DATA_REF/pcoord.init | awk {'print $1,$2'} > $WEST_PCOORD_RETURN
python $WEST_SIM_ROOT/common_files/analyze.py $WEST_STRUCT_DATA_REF

cat pcoord.dat | awk {'print $1,$2'} > $WEST_PCOORD_RETURN

cp $WEST_SIM_ROOT/common_files/1lst.prmtop $WEST_TRAJECTORY_RETURN
#cp $WEST_STRUCT_DATA_REF/bstate.ncrst $WEST_TRAJECTORY_RETURN
#cp $WEST_STRUCT_DATA_REF $WEST_TRAJECTORY_RETURN

cp $WEST_SIM_ROOT/common_files/1lst.prmtop $WEST_RESTART_RETURN
#cp $WEST_STRUCT_DATA_REF/bstate.ncrst $WEST_RESTART_RETURN/parent.ncrst
#cp $WEST_STRUCT_DATA_REF $WEST_RESTART_RETURN/parent.ncrst

if [ -n "$SEG_DEBUG" ] ; then
  head -v $WEST_PCOORD_RETURN
fi

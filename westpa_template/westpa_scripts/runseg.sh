#!/bin/bash

if [ -n "$SEG_DEBUG" ] ; then
  set -x
  env | sort
fi

cd $WEST_SIM_ROOT
mkdir -pv $WEST_CURRENT_SEG_DATA_REF
cd $WEST_CURRENT_SEG_DATA_REF

ln -sv $WEST_SIM_ROOT/common_files/system.top .

if [ "$WEST_CURRENT_SEG_INITPOINT_TYPE" = "SEG_INITPOINT_CONTINUES" ]; then
  sed "s/RAND/$WEST_RAND16/g" $WEST_SIM_ROOT/common_files/md.in > md.in
  ln -sv $WEST_PARENT_DATA_REF/seg.rst ./parent.rst
elif [ "$WEST_CURRENT_SEG_INITPOINT_TYPE" = "SEG_INITPOINT_NEWTRAJ" ]; then
  sed "s/RAND/$WEST_RAND16/g" $WEST_SIM_ROOT/common_files/md.in > md.in
  ln -sv $WEST_PARENT_DATA_REF ./parent.rst
fi

$PMEMD -O -i md.in   -p system.top  -c parent.rst \
          -r seg.rst -x seg.nc      -o seg.log    -inf seg.nfo

python $WEST_SIM_ROOT/common_files/pcoord.py seg.nc > $WEST_PCOORD_RETURN
python $WEST_SIM_ROOT/common_files/auxdata.py distance > $WEST_DISTANCE_RETURN

# Clean up
rm -f md.in parent.rst seg.nfo seg.pdb system.top

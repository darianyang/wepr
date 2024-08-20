parm 1lst.prmtop
trajin md01.nc 1 last 10
autoimage
strip :WAT parmout 1lst-dry.prmtop
trajout md01-dry.nc
run
quit

parm 1lst-dry.prmtop
trajin frame1.pdb
matrix distancef1 @CA out dmat_f1.out
run
trajin frame1000.pdb
matrix distancef1000 @CA out dmat_f1000.out
run
quit

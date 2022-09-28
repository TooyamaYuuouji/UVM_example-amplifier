global env

fsdbDumpfile "$env(FSDB_NAME).fsdb"
fsdbDumpvars 0 "amp_tb"
run 

exit

export FSDB_NAME=amp
SEED=1
VERB=UVM_LOW
TEST_NAME=amp_testcase1

all: comp sim

comp:
	vcs -sverilog -full64 +v2k -debug_all -timescale=1ns/1ps -ntb_opts uvm-1.1 -f filelist.f -l comp.log 

sim:
	./simv +ntb_random_seed=${SEED} +UVM_VERBOSITY=${VERB} +UVM_TESTNAME=${TEST_NAME} \
	-ucli -i dump_fsdb_vcs.tcl \
	+fsdb+autoflush \
	-l sim.log

verdi:
	verdi -ssf amp.fsdb -f filelist.f &

clean:
	rm -rf *.log *.vdb *simv* *.h *.key *.fsdb *.conf *.rc
	rm -rf cg_report csrc vdCovLog verdiLog

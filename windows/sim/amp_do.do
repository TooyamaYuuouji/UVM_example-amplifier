# quit the latest sim
quit -sim

.main clear

set WORK_PATH E:/Master/Development/Code/UVM/amplifier/my_amplifier
set TimeTag [clock format [clock seconds] -format "%H_%M_%S"]

cd $WORK_PATH

vlib ./work
vmap work ./work

file mkdir $WORK_PATH/log

vlog -work work $WORK_PATH/src/DUT/*.v

vlog -sv -l $WORK_PATH/log/vlog_$TimeTag.log $WORK_PATH/src/tb/amp_tb.sv
vsim -novopt -c -l $WORK_PATH/log/vsim_$TimeTag.log work.amp_tb
run -all

quit -sim

# quit -f
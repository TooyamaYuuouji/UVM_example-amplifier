`ifndef AMP_SEQ_PKG_SV	
`define AMP_SEQ_PKG_SV	

package amp_seq_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import amp_agent_pkg::*;

`include "amp_seq_set_scaler.sv"
`include "amp_seq_set_base_number.sv"
`include "amp_seq_idle.sv"
`include "amp_case1_seq.sv"

endpackage : amp_seq_pkg

`endif // AMP_SEQ_PKG_SV	

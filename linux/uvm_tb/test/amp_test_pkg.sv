`ifndef AMP_TEST_PKG_SV 
`define AMP_TEST_PKG_SV 

package amp_test_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import amp_agent_pkg::*;
import amp_env_pkg::*;
import amp_seq_pkg::*;

`include "amp_base_test.sv"
`include "amp_testcase1.sv"

endpackage : amp_test_pkg

`endif // AMP_TEST_PKG_SV 

`ifndef AMP_AGENT_PKG_SV
`define AMP_AGENT_PKG_SV

package amp_agent_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "amp_seq_item.sv"
`include "amp_sequencer.sv"
`include "amp_driver.sv"
`include "amp_monitor.sv"
`include "amp_agent_config.sv"
`include "amp_agent.sv"

endpackage : amp_agent_pkg

`endif // AMP_AGENT_PKG_SV

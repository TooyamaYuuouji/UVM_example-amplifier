`ifndef AMP_ENV_PKG_SV
`define AMP_ENV_PKG_SV

package amp_env_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import amp_agent_pkg::*;

`include "amp_env_refm.sv"
`include "amp_env_scb.sv"
`include "amp_env.sv"

endpackage : amp_env_pkg

`endif // AMP_ENV_PKG_SV

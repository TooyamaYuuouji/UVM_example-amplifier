`ifndef AMP_ENV_SV
`define AMP_ENV_SV

class amp_env extends uvm_env;
    `uvm_component_utils(amp_env)
    
    amp_agent_config agt_cfg;

    amp_env_refm    refm;
    amp_env_scb     scb;
    amp_agent       i_agt;
    amp_agent       o_agt;


    uvm_tlm_analysis_fifo #(amp_seq_item) iagt_refm_fifo;
    uvm_tlm_analysis_fifo #(amp_seq_item) oagt_scb_fifo;
    uvm_tlm_analysis_fifo #(amp_seq_item) refm_scb_fifo;

    extern function      new(string name = "amp_env", uvm_component parent = null);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern function void report_phase(uvm_phase phase);
endclass : amp_env

function amp_env::new(string name = "amp_env", uvm_component parent = null);
    super.new(name, parent);

    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

function void amp_env::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(amp_agent_config)::get(this, "", "agt_cfg", agt_cfg))
        `uvm_error("NO CONFIG", $sformatf("No config for: %s. Check tests", get_full_name()))

    refm  = amp_env_refm::type_id::create("refm", this);
    scb   = amp_env_scb::type_id::create("scb", this);
    i_agt = amp_agent::type_id::create("i_agt", this);
    i_agt.is_active = agt_cfg.i_agt_is_active;
    o_agt = amp_agent::type_id::create("o_agt", this);
    o_agt.is_active = agt_cfg.o_agt_is_active;

    iagt_refm_fifo = new("iagt_refm_fifo", this);
	oagt_scb_fifo = new("oagt_scb_fifo", this);
	refm_scb_fifo = new("refm_scb_fifo", this);
endfunction : build_phase

function void amp_env::connect_phase(uvm_phase phase);
	super.connect_phase(phase);

	i_agt.mon.ap.connect(iagt_refm_fifo.analysis_export);
	refm.gp.connect(iagt_refm_fifo.blocking_get_export);

	o_agt.mon.ap.connect(oagt_scb_fifo.analysis_export);
	scb.act_gp.connect(oagt_scb_fifo.blocking_get_export);

	refm.ap.connect(refm_scb_fifo.analysis_export);
	scb.exp_gp.connect(refm_scb_fifo.blocking_get_export);
endfunction : connect_phase

function void amp_env::report_phase(uvm_phase phase);
	super.report_phase(phase);

	if(i_agt.mon.mon_item_num == o_agt.mon.mon_item_num)
		`uvm_info(get_type_name(), "mon_item_num check ok", UVM_LOW)
	else
		`uvm_error("ENV ERROR", "mon_item_num check error")
endfunction : report_phase

`endif // AMP_ENV_SV
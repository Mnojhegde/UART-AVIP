
class master_agent extends uvm_agent;
  `uvm_component_utils(master_agent)

  // Declaring handle for master agent config class 
  master_agent_config master_agent_cfg_h;

  // Handle for master sequencer
  master_sequencer master_seqr_h;
  
  // Creating a Handle for master driver proxy
  master_driver_proxy master_drv_proxy_h;
  
  // Declaring a handle for master monitor proxy
  master_monitor_proxy master_mon_proxy_h;

  // Decalring a handle for master_coverage
  master_coverage master_cov_h;

  
  //-------------------------------------------------------
  // Extern Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern void end_of_elaboration_phase(uvm_phase phase);
  extern function void start_of_simulation_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass : master_agent

//--------------------------------------------------------------------------------------------
// Construct: new
//--------------------------------------------------------------------------------------------
function  master_agent::new(string name="master_agent",uvm_component parent = null);
  super.new(name,parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//--------------------------------------------------------------------------------------------
function void master_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db #(master_agent_config)::get(this,"","master_agent_config",master_agent_cfg_h)) begin
    `uvm_fatal("FATAL_MA_CANNOT_GET_master_AGENT_CONFIG","cannot get master_agent_cfg_h from uvm_config_db");
  end

  if(master_agent_cfg_h.is_active == UVM_ACTIVE) begin
    master_drv_proxy_h=master_driver_proxy::type_id::create("master_driver_proxy",this);
    master_seqr_h=master_sequencer::type_id::create("master_sequencer",this);
  end

  master_mon_proxy_h=master_monitor_proxy::type_id::create("master_monitor_proxy",this);

  if(master_agent_cfg_h.has_coverage) begin
    master_cov_h = master_coverage::type_id::create("master_cov_h",this);
  end

  if(master_agent_cfg_h.has_coverage) begin
    master_cov_h.master_agent_cfg_h = master_agent_cfg_h;
    // connect monitor port to coverage
  end

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
//--------------------------------------------------------------------------------------------
function void master_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  
  if(master_agent_cfg_h.is_active == UVM_ACTIVE) begin
    master_drv_proxy_h.master_agent_cfg_h = master_agent_cfg_h;
    master_seqr_h.master_agent_cfg_h = master_agent_cfg_h;

    //Connecting the ports
    master_drv_proxy_h.seq_item_port.connect(master_seqr_h.seq_item_export);
  end
  
  master_mon_proxy_h.master_agent_cfg_h = master_agent_cfg_h;
  
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
/
//--------------------------------------------------------------------------------------------
function void master_agent::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
//--------------------------------------------------------------------------------------------
function void master_agent::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
//--------------------------------------------------------------------------------------------
task master_agent::run_phase(uvm_phase phase);

  phase.raise_objection(this, "master_agent");

  super.run_phase(phase);

  // Work here

  phase.drop_objection(this);

endtask : run_phase


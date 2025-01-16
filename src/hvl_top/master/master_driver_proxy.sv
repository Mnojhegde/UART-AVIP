class master_driver_proxy extends uvm_driver#(master_tx);
  `uvm_component_utils(master_driver_proxy)
  
  virtual master_driver_bfm master_drv_bfm_h;
  
  // Declaring handle for device0 agent config class 
  master_agent_config master_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_driver_proxy", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern function void start_of_simulation_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass : master_driver_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//--------------------------------------------------------------------------------------------
    function master_driver_proxy::new(string name = "master_driver_proxy",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//--------------------------------------------------------------------------------------------
function void master_driver_proxy::build_phase(uvm_phase phase);  
  super.build_phase(phase);

  if(!uvm_config_db #(virtual master_driver_bfm)::get(this,"","master_driver_bfm",master_drv_bfm_h)) begin
    `uvm_fatal("FATAL_MDP_CANNOT_GET_master_DRIVER_BFM","cannot get() master_drv_bfm_h");
  end

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
//--------------------------------------------------------------------------------------------
function void master_driver_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
//--------------------------------------------------------------------------------------------
function void master_driver_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
//--------------------------------------------------------------------------------------------
function void master_driver_proxy::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
//--------------------------------------------------------------------------------------------
task master_driver_proxy::run_phase(uvm_phase phase);

  super.run_phase(phase);

  seq_item_port.get_next_item(req);
  // Work here
  seq_item_port.item_done();

endtask : run_phase

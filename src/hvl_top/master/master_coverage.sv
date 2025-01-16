class master_coverage extends uvm_subscriber#(master_tx);
  `uvm_component_utils(master_coverage)

  // Declaring handle for device0 agent configuration class 
  master_agent_config master_agent_cfg_h;

  //-------------------------------------------------------
  // Extern Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_coverage", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern function void start_of_simulation_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern function void write(master_tx t);

endclass : master_coverage

//--------------------------------------------------------------------------------------------
// Construct: new
//--------------------------------------------------------------------------------------------
function master_coverage::new(string name = "master_coverage", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//--------------------------------------------------------------------------------------------
function void device0_coverage::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
//--------------------------------------------------------------------------------------------
function void device0_coverage::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
//--------------------------------------------------------------------------------------------
function void device0_coverage::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
//--------------------------------------------------------------------------------------------
function void device0_coverage::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
//--------------------------------------------------------------------------------------------
task device0_coverage::run_phase(uvm_phase phase);

  phase.raise_objection(this, "device0_coverage");

  super.run_phase(phase);


  phase.drop_objection(this);

endtask : run_phase

//--------------------------------------------------------------------------------------------
// Function: write
//--------------------------------------------------------------------------------------------
function void device0_coverage::write(device0_tx t);
//  device0_tx device0_tx_h;
//  this.device0_tx_h = t;
// cg.sample(device0_agent_cfg_h, device0_tx_cov_data);     
endfunction: write

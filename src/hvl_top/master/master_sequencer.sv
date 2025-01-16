class master_sequencer extends uvm_sequencer #(master_tx);
  
  `uvm_component_utils(master_sequencer)

endclass : master_sequencer




  function master_sequencer::new(string name = "master_sequencer",uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

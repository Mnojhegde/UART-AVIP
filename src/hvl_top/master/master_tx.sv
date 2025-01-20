class master_tx extends uvm_sequence_item;

  `uvm_object_utils(master_tx)

  rand bit [`character_length-1:0] m_tx;
  bit [`character_length-1:0] m_rx;

  extern function new(string name = "master_tx");

endclass


function master_tx::new(string name = "master_tx");
  super.new(name);
endfunction : new

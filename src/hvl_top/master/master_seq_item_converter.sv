class master_seq_item_converter extends uvm_object;
  `uvm_object_utils(master_seq_item_converter)
  
  extern function new(string name = "master_seq_item_converter");

endclass

function master_seq_item_converter::new(string name = "master_seq_item_converter");
  super.new(name);
endfunction : new
    

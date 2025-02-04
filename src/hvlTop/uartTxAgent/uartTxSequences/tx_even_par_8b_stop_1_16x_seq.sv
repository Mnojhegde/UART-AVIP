`ifndef TXEVENPAR8BSTOP116XSEQ_INCLUDED_
`define TXEVENPAR8BSTOP116XSEQ_INCLUDED_

class tx_even_par_8b_stop_1_16x_seq extends UartTxBaseSequence;
  `uvm_object_utils(tx_even_par_8b_stop_1_16x_seq)

   extern function new(string name = "tx_even_par_8b_stop_1_16x_seq");
  extern virtual task body();

endclass : tx_even_par_8b_stop_1_16x_seq

function  tx_even_par_8b_stop_1_16x_seq :: new(string name= "tx_even_par_8b_stop_1_16x_seq");
  super.new(name);
endfunction : new

task tx_even_par_8b_stop_1_16x_seq :: body();
  super.body();
 
  `uvm_info(get_type_name(),$sformatf("tx_even_par_8b_stop_1_16x_seq"),UVM_LOW);

  req = UartTxTransaction :: type_id :: create("req");

  repeat(1) begin 
  start_item(req);
  if( !(req.randomize()))
   `uvm_fatal(get_type_name(),"Randomization failed")
  req.print(); 
  finish_item(req);
  end 
endtask : body
 
`endif   


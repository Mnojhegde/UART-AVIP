`ifndef UARTTXSEQUENCER_INCLUDED_
`define UARTTXSEQUENCER_INCLUDED_

class UartTxSequencer extends uvm_sequencer#(UartTxTransaction);
  `uvm_component_utils(UartTxSequencer)

  extern function void new(string name="UartTxSequencer",this);
endclass : UartTxSequencer

function void UartTxSequencer :: new(string name = "UartTxSequencer" , uvm_component parent = null);
  super.new(name,parent);
endfunction : new

`endif

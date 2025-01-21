`ifndef UARTTXSEQUENCER_INCLUDED_
`define UARTTXSEQUENCER_INCLUDED_

class UartTxSequencer extends uvm_sequencer#(UartTxTransaction);
  `uvm_component_utils(UartTxSequencer)

  extern function new(string name="UartTxSequencer",uvm_component parent = null);
endclass : UartTxSequencer

function UartTxSequencer :: new(string name = "UartTxSequencer" , uvm_component parent = null);
  super.new(name,parent);
endfunction : new

`endif

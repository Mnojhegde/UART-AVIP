
`ifndef UARTRXSEQUENCER_INCLUDED_
`define UARTRXSEQUENCER_INCLUDED_

class UartRxSequencer extends uvm_sequencer#(UartRxTransaction);
  `uvm_component_utils(UartRxSequencer)

  extern function new(string name="UartRxSequencer", uvm_component parent = null);
endclass : UartRxSequencer

function UartRxSequencer :: new(string name = "UartRxSequencer" , uvm_component parent = null);
  super.new(name,parent);
endfunction : new

`endif

`ifndef UARTVIRTUALSEQUENCER_INCLUDED_
`define UARTVIRTUALSEQUENCER_INLCUDED_

class UartVirtualSequencer extends uvm_sequencer;
  `uvm_component_utils(UartVirtualSequencer)
  
  UartTxSequencer uartTxSequencer;
  UartRxSequencer uartRxSequencer;

  extern function new( string name = "UartVirtualSequencer" , uvm_component parent = null);

endclass : UartVirtualSequencer

function UartVirtualSequencer :: new(string name = "UartVirtualSequencer" , uvm_component parent = null);
  super.new(name,parent);
endfunction : new

`endif
 

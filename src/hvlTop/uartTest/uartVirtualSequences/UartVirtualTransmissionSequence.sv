`ifndef UARTVIRTUALTRANSMISSIONSEQUENCE_INCLUDED_
`define UARTVIRTUALTRANSMISSIONSEQUENCE_INCLUDED_

class UartVirtualTransmissionSequence extends UartVirtualBaseSequence;
  `uvm_object_utils(UartVirtualTransmissionSequence)
  `uvm_declare_p_sequencer(UartVirtualSequencer)
  
  UartTxBaseSequence uartTxBaseSequence;
  UartRxBaseSequence uartRxBaseSequence;


  extern function new(string name = "UartVirtualTransmissionSequence");
  extern virtual task body();

endclass : UartVirtualTransmissionSequence

function UartVirtualTransmissionSequence :: new(string name = "UartVirtualTransmissionSequence" );
  super.new(name);
endfunction : new


task UartVirtualTransmissionSequence :: body();
  super.body();
  uartTxBaseSequence = UartTxBaseSequence :: type_id :: create("uartTxBaseSequence");
  uartRxBaseSequence = UartRxBaseSequence :: type_id :: create("uartRxBaseSequence");
  
  begin 
    uartTxBaseSequence.start(p_sequencer.uartTxSequencer);
    uartRxBaseSequence.start(p_sequencer.uartRxSequencer);
  end 


endtask : body

`endif


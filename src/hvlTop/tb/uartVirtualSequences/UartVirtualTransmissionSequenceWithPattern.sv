`ifndef UARTVIRTUALTRANSMISSIONSEQUENCEWITHPATTERN_INCLUDED_
`define UARTVIRTUALTRANSMISSIONSEQUENCEWITHPATTERN_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: uart_virtual_seqs
//--------------------------------------------------------------------------------------------
class UartVirtualTransmissionSequenceWithPattern extends UartVirtualBaseSequence;
  `uvm_object_utils(UartVirtualTransmissionSequenceWithPattern)
  `uvm_declare_p_sequencer(UartVirtualSequencer)
  
  UartTxBaseSequence uartTxBaseSequence;
  UartRxBaseSequence uartRxBaseSequence;
  UartTxAgentConfig uartTxAgentConfig;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "UartVirtualTransmissionSequenceWithPattern");
  extern virtual task body();

endclass : UartVirtualTransmissionSequenceWithPattern
    
//--------------------------------------------------------------------------------------------
// Constructor:new
//
// Paramters:
// name - Instance name of the virtual_sequence
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function UartVirtualTransmissionSequenceWithPattern :: new(string name = "UartVirtualTransmissionSequenceWithPattern" );
  super.new(name);
endfunction : new
    
//--------------------------------------------------------------------------------------------
// task:body
// Creates the required ports
//
// Parameters:
// phase - stores the current phase
//--------------------------------------------------------------------------------------------

task UartVirtualTransmissionSequenceWithPattern :: body();
  super.body();
  uartTxBaseSequence = UartTxBaseSequence :: type_id :: create("uartTxBaseSequence");
  uartRxBaseSequence = UartRxBaseSequence :: type_id :: create("uartRxBaseSequence");
  if(!(uvm_config_db#(UartTxAgentConfig) :: get(null,"","uartTxAgentConfig",uartTxAgentConfig)))
    `uvm_fatal("[VIRTUAL SEQUENCE]",$sformatf("failed to get the config"))
  begin 
 //   uartTxBaseSequence.start(p_sequencer.uartTxSequencer);
     `uvm_do_on_with(uartTxBaseSequenceWithPattern , p_sequencer.uartTxSequencer,{packetsNeeded ==uartTxAgentConfig.packetsNeeded;patternToTransmit==uartTxAgentConfig.patternToTransmit;})
 //  uartRxBaseSequence.start(p_sequencer.uartRxSequencer);
  end 


endtask : body

`endif

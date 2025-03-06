`ifndef UARTVIRTUALTRANSMISSIONSEQUENCE_INCLUDED_
`define UARTVIRTUALTRANSMISSIONSEQUENCE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: uart_virtual_seqs
//--------------------------------------------------------------------------------------------
class UartVirtualTransmissionSequence extends UartVirtualBaseSequence;
  `uvm_object_utils(UartVirtualTransmissionSequence)
  `uvm_declare_p_sequencer(UartVirtualSequencer)
  
  UartTxBaseSequence uartTxBaseSequence;
  UartRxBaseSequence uartRxBaseSequence;
  UartTxAgentConfig uartTxAgentConfig;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "UartVirtualTransmissionSequence");
  extern virtual task body();
  extern task setConfig(UartTxAgentConfig uartTxAgentConfig);
endclass : UartVirtualTransmissionSequence
    
//--------------------------------------------------------------------------------------------
// Constructor:new
//
// Paramters:
// name - Instance name of the virtual_sequence
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function UartVirtualTransmissionSequence :: new(string name = "UartVirtualTransmissionSequence" );
  super.new(name);
   // uartTxBaseSequence = UartTxBaseSequence :: type_id :: create("uartTxBaseSequence");
   uartRxBaseSequence = UartRxBaseSequence :: type_id :: create("uartRxBaseSequence");

endfunction : new
    
//--------------------------------------------------------------------------------------------
// task:body
// Creates the required ports
//
// Parameters:
// phase - stores the current phase
//--------------------------------------------------------------------------------------------

task UartVirtualTransmissionSequence :: body();
//  uartTxBaseSequence = UartTxBaseSequence :: type_id :: create("uartTxBaseSequence");
  //uartRxBaseSequence = UartRxBaseSequence :: type_id :: create("uartRxBaseSequence");
  //if(!(uvm_config_db#(UartTxAgentConfig) :: get(null,"","uartTxAgentConfig",uartTxAgentConfig)))
    //`uvm_fatal("[VIRTUAL SEQUENCE]",$sformatf("failed to get the config"))
 
 
 //if (uartTxBaseSequence == null)
   //  `uvm_fatal("[VIRTUAL SEQUENCE]", "Failed to create uartTxBaseSequence")
 
  //uartTxBaseSequence.setConfig(this.uartTxAgentConfig);
 

 //if (uartTxBaseSequence.uartTxAgentConfig_ == null)
     //`uvm_fatal("[VIRTUAL SEQUENCE]", "uartTxAgentConfig is NULL after setConfig")
 //   uartTxBaseSequence.start(p_sequencer.uartTxSequencer);
  fork 
  `uvm_do_on_with(uartTxBaseSequence , p_sequencer.uartTxSequencer,{packetsNeeded ==uartTxAgentConfig.packetsNeeded;})
   uartTxBaseSequence.setConfig(this.uartTxAgentConfig);
 join
 //uartTxBaseSequence.packetsNeeded = uartTxAgentConfig.packetsNeeded;
 //uartTxBaseSequence.start(p_sequencer.uartTxSequencer);

 
 //  uartRxBaseSequence.start(p_sequencer.uartRxSequencer);
  

endtask : body

task UartVirtualTransmissionSequence :: setConfig(UartTxAgentConfig uartTxAgentConfig);
  this.uartTxAgentConfig = uartTxAgentConfig;
endtask 


`endif

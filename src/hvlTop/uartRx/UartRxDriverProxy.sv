`ifndef UARTRXDRIVERPROXY_INCLUDED_
`define UARTRXDRIVERPROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: UartRxDriverProxy
// This is the proxy driver on the HVL side
//--------------------------------------------------------------------------------------------
class UartRxDriverProxy extends uvm_driver #(UartRxTransaction);
  `uvm_component_utils(UartRxDriverProxy)
   // Variable:  uartRxDriverBfm;
   // Handle for receiver driver bfm
   virtual UartRxDriverBfm uartRxDriverBfm;
   UartRxPacketStruct uartRxPacketStruct;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  
  extern function new( string name = "UartRxDriverProxy" , uvm_component parent = null);
  extern virtual function void build_phase( uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass : UartRxDriverProxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - UartRxDriverProxy
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function UartRxDriverProxy :: new( string name = "UartRxDriverProxy" , uvm_component parent = null);
  super.new(name,parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Description_here:uartRxDriverBfm congiguration is obtained in build phase
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void UartRxDriverProxy :: build_phase( uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(virtual UartRxDriverBfm) :: get(this, "" , "uartRxDriverBfm",uartRxDriverBfm)))
   begin 
    `uvm_fatal(get_type_name(),$sformatf("FAILED TO GET VIRTUAL BFM HANDLE "))
   end 
endfunction : build_phase
    
//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
    task UartRxDriverProxy :: run_phase(uvm_phase phase);
  seq_item_port.get_next_item(req);
  UartRxSeqItemConverter :: fromRxClass(req,uartRxPacketStruct);
  `uvm_info("BFM",$sformatf("data in driver is %p",uartRxPacketStruct.receiving_data),UVM_LOW)
  seq_item_port.item_done();
endtask : run_phase
`endif
 

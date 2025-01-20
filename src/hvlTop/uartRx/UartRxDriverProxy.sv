`ifndef UARTRXDRIVERPROXY_INCLUDED_
`define UARTRXDRIVERPROXY_INCLUDED_

class UartRxDriverProxy extends uvm_driver #(UartRxTransaction);
  `uvm_component_utils(UartRxDriverProxy)
 
  virtual UartRxDriverBfm uartRxDriverBfm;

  extern function void new( string name = "UartRxDriverProxy" , uvm_component parent = null);
  extern virtual function void build_phase( uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
enclass : UartRxDriverProxy

function void UartRxDriverProxy :: new( string name = "UartRxDriverProxy" , uvm_component parent = null);
  super.new(name,parent);
endfunction : new

function void UartRxDriverProxy :: build_phase( uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(UvmRxDriverBfm) :: get(this, "" , "uartRxDriverBfm",uartRxDriverBfm)))
   begin 
    `uvm_fatal(get_type_name(),$sformatf("FAILED TO GET VIRTUAL BFM HANDLE "))
   end 
endfunction : build_phase

task UartRxDriverProxy :: run_phase();
  seq_item_port.get_next_item(req);
  UartRxSeqItemConverter :: fromRxClass(req,uartRxPacketStruct);
  `uvm_info("BFM",$sformatf("data in driver is %p",UartRxPacketStruct.receiving_data))
  seq_item_port.item_done();
endtask : run_phase
`endif
 



`ifndef UARTTxDRIVERPROXY_INCLUDED_
`define UARTTxDRIVERPROXY_INCLUDED_

class UartTxDriverProxy extends uvm_driver#(UartTxTransaction);
  `uvm_component_utils(UartTxDriverProxy)
 
  virtual UartTxDriverBfm uartTxDriverBfm;
  UartTxPacketStruct uartTxPacketStruct;
  extern function new( string name = "UartTxDriverProxy" , uvm_component parent);
  extern virtual function void build_phase( uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass : UartTxDriverProxy

function UartTxDriverProxy :: new( string name = "UartTxDriverProxy" , uvm_component parent );
  super.new(name,parent);
endfunction : new

function void UartTxDriverProxy :: build_phase( uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(virtual UartTxDriverBfm) :: get(this, "" , "uartTxDriverBfm",uartTxDriverBfm)))
   begin 
    `uvm_fatal(get_type_name(),$sformatf("FAILED TO GET VIRTUAL BFM HANDLE "))
   end 
endfunction : build_phase

    task UartTxDriverProxy :: run_phase(uvm_phase phase);
  seq_item_port.get_next_item(req);
  UartTxSeqItemConverter :: fromTxClass(req,uartTxPacketStruct);
  `uvm_info("BFM",$sformatf("data in driver is %p",uartTxPacketStruct.transmission_data),UVM_LOW)
  seq_item_port.item_done();
endtask : run_phase
`endif
 

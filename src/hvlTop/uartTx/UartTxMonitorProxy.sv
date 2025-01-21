`ifndef UARTTXMONITORPROXY_INCLUDED_
`define UARTTXMONITORPROXY_INCLUDED_

class UartTxMonitorProxy extends uvm_monitor;
  `uvm_component_utils(UartTxMonitorProxy)
 
  virtual UartTxMonitorBfm uartTxMonitorBfm;
  
  uvm_analysis_port#(UartTxTransaction) uartTxMonitorAnalysisPort;

  extern function  new( string name = "UartTxMonitorProxy" , uvm_component parent = null);
  extern virtual function void build_phase( uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass : UartTxMonitorProxy

function  UartTxMonitorProxy :: new( string name = "UartTxMonitorProxy" , uvm_component parent = null);
  super.new(name,parent);
  uartTxMonitorAnalysisPort = new("uartTxMonitorAnalysisPort",this);
endfunction : new

function void UartTxMonitorProxy :: build_phase( uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(virtual UartTxMonitorBfm) :: get(this, "" , "uartTxMonitorBfm",uartTxMonitorBfm)))
   begin 
    `uvm_fatal(get_type_name(),$sformatf("FAILED TO GET VIRTUAL BFM HANDLE "))
   end 
endfunction : build_phase

task UartTxMonitorProxy :: run_phase(uvm_phase phase);
  UartTxTransaction uartTxTransaction;
 
  `uvm_info(get_type_name(), $sformatf("Inside the TX_monitor_proxy"), UVM_LOW);
endtask : run_phase
`endif
 

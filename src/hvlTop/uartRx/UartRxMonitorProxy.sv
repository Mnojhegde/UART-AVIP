`ifndef UARTRXMONITORPROXY_INCLUDED_
`define UARTRXMONITORPROXY_INCLUDED_

class UartRxMonitorProxy extends uvm_monitor;
  `uvm_component_utils(UartRxMonitorProxy)
 
  virtual UartRxMonitorBfm uartRxMonitorBfm;
  
  uvm_analysis_port#(UartRxTransaction) Uart_Rx_Analysis_Port;

  extern function void new( string name = "UartRxMonitorProxy" , uvm_component parent = null);
  extern virtual function void build_phase( uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
enclass : UartRxMonitorProxy

function void UartRxMonitorProxy :: new( string name = "UartRxMonitorProxy" , uvm_component parent = null);
  super.new(name,parent);
   Uart_Rx_Analysis_Port = new("Uart_Rx_Analysis_Port",this);
endfunction : new

function void UartRxMonitorProxy :: build_phase( uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(UvmRxMonitorBfm) :: get(this, "" , "uartRxMonitorBfm",uartRxMonitorBfm)))
   begin 
    `uvm_fatal(get_type_name(),$sformatf("FAILED TO GET VIRTUAL BFM HANDLE "))
   end 
endfunction : build_phase

task UartRxMonitorProxy :: run_phase();
  UartRxTransaction uartRxTransaction;
 
  `uvm_info(get_type_name(), $sformatf("Inside the RX_monitor_proxy"), UVM_LOW);
  uartRxTransaction = UartRxTransaction::type_id::create("uartRxTransaction");
  	
  uartRxMonitorBfm.WaitForReset();
  
  forever begin
    UartRxPacketStruct uartRxPacketStruct;
    UartRxTransaction uartRxTransactionClone;
    
    //UartRxConfigConverter :: fromRxClass(uartRxTransaction,uartRxPacketStruct);   //task under progress
    //uartRxMonitorBfm.sampe_data(uartRxPacketStruct);                              //task under progress
    UartRxSeqItemConverter :: toRxClass(uartRxPacketStruct,uartRxTransaction);
    
    `uvm_info(get_type_name(),$sformatf("Received packet from RX monitor bfm: , \n %s", uartRxTransaction.sprint()),UVM_HIGH)
    
    $cast(uartRxTransactionClone, uartRxTransaction.clone());
    `uvm_info(get_type_name(),$sformatf("Sending packet via analysis_port: , \n %s", uartRxTransactionClone.sprint()),UVM_HIGH)
    Uart_Rx_Analysis_Port.write(uartRxTransactionClone);
  end
endtask : run_phase
`endif
 

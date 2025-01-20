`ifndef UARTTXMONITORPROXY_INCLUDED_
`define UARTTXMONITORPROXY_INCLUDED_

class UartTxMonitorProxy extends uvm_monitor;
  `uvm_component_utils(UartTxMonitorProxy)
 
  virtual UartTxMonitorBfm uartTxMonitorBfm;
  
  uvm_analysis_port#(UartTxTransaction) Uart_Tx_Analysis_Port;

  extern function void new( string name = "UartTxMonitorProxy" , uvm_component parent = null);
  extern virtual function void build_phase( uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
enclass : UartTxMonitorProxy

function void UartTxMonitorProxy :: new( string name = "UartTxMonitorProxy" , uvm_component parent = null);
  super.new(name,parent);
  Uart_Tx_Analysis_Port = new("Uart_Tx_Analysis_Port",this);
endfunction : new

function void UartTxMonitorProxy :: build_phase( uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(UvmTxMonitorBfm) :: get(this, "" , "uartTxMonitorBfm",uartTxMonitorBfm)))
   begin 
    `uvm_fatal(get_type_name(),$sformatf("FAILED TO GET VIRTUAL BFM HANDLE "))
   end 
endfunction : build_phase

task UartTxMonitorProxy :: run_phase();
  UartTxTransaction uartTxTransaction;
 
  `uvm_info(get_type_name(), $sformatf("Inside the TX_monitor_proxy"), UVM_LOW);
  uartTxTransaction = UartTxTransaction::type_id::create("uartTxTransaction");
  	
  uartTxMonitorBfm.WaitForReset();
  
  forever begin
    UartTxPacketStruct uartTxPacketStruct;
    UartTxTransaction uartTxTransactionClone;
    
    UartTxConfigConverter :: fromTxClass(uartTxTransaction,uartTxPacketStruct);
    uartTxMonitorBfm.sampe_data(uartTxPacketStruct);
    UartTxSeqItemConverter :: toTxClass(uartTxPacketStruct,uartTxTransaction);
    
    `uvm_info(get_type_name(),$sformatf("Received packet from RX monitor bfm: , \n %s", uartTxTransaction.sprint()),UVM_HIGH)
    
    $cast(uartTxTransactionClone, uartTxTransaction.clone());
    `uvm_info(get_type_name(),$sformatf("Sending packet via analysis_port: , \n %s", uartTxTransactionClone.sprint()),UVM_HIGH)
    Uart_Tx_Analysis_Port.write(uartTxTransactionClone);
  end
endtask : run_phase
`endif
 

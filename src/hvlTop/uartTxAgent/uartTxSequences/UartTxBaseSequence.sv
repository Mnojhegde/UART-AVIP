`ifndef UARTTXBASESEQUENCE_INCLUDED_
`define UARTTXBASESEQUENCE_INCLUDED_

class UartTxBaseSequence extends uvm_sequence#(UartTxTransaction);
  `uvm_object_utils(UartTxBaseSequence)
  
  extern function new(string name = "UartTxBaseSequence");
  extern virtual task body();
  extern task setConfig(UartTxAgentConfig uartTxAgentConfig);
  rand int packetsNeeded;
  UartTxAgentConfig uartTxAgentConfig_;
endclass : UartTxBaseSequence

function  UartTxBaseSequence :: new(string name= "UartTxBaseSequence");
  super.new(name);
 
endfunction : new

task UartTxBaseSequence :: body();
 // super.body();

//  if(!(uvm_config_db#(UartTxAgentConfig) :: get(null,"","uartTxAgentConfig",uartTxAgentConfig_)))
  //   `uvm_fatal("[VIRTUAL SEQUENCE]",$sformatf("failed to get the config"))

  if (uartTxAgentConfig_ == null)
      `uvm_fatal("[TX SEQUENCE]", "uartTxAgentConfig_ is NULL in body")
 req = UartTxTransaction :: type_id :: create("req");
//  repeat(packetsNeeded)begin 
  start_item(req);
  if(!(req.randomize()))
   `uvm_fatal("[tx sequence]","randomization failed")

  req.print();
  finish_item(req);
  // uartTxAgentConfig_.randomize();
    //     $display("\n \n \n+++++++++++++++++++++++++++++++++++++++++++++++++++++the baud rate from test is %s",this.uartTxAgentConfig_.uartBaudRate.name());

//  end

endtask : body

task UartTxBaseSequence::setConfig(UartTxAgentConfig uartTxAgentConfig);
 this.uartTxAgentConfig_ = uartTxAgentConfig;
 
  if (this.uartTxAgentConfig_ == null)
        `uvm_fatal("[TX SEQUENCE]", "uartTxAgentConfig_ is NULL inside setConfig")
	    else
	          `uvm_info("[TX SEQUENCE]", "uartTxAgentConfig_ successfully set", UVM_MEDIUM)
endtask
 
`endif   

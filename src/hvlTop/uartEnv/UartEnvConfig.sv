`ifndef UARTENVCONFIG_INCLUDED_
`define UARTENVCONFIG_INCLUDED_

class UartEnvConfig extends uvm_object;
  `uvm_object_utils(UartEnvConfig)

  bit hasvirtualsequencer;
  bit hasscoreboard;
  UartTxAgentConfig uartTxAgentConfig;
  UartRxAgentConfig uartRxAgentConfig;

  extern function new(string name = "UartEnvConfig");
 
 endclass : UartEnvConfig

 function UartEnvConfig :: new(string name = "UartEnvConfig");
   super.new(name);
 endfunction : new

`endif

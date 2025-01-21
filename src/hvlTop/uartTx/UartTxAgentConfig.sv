`ifndef UARTTXAGENTCONFIG_INCLUDED_
`define UARTTXAGENTCONFIG_INCLUDED_

class UartTxAgentConfig extends uvm_object;
  `uvm_object_utils(UartTxAgentConfig)
  
  uvm_active_passive_enum is_active;
  bit hascoverage;
  bit hasparity;

  extern function new(string name = "UartTxAgentConfig");

endclass : UartTxAgentConfig

function UartTxAgentConfig :: new(string name = "UartTxAgentConfig");
  super.new(name);
endfunction : new

`endif

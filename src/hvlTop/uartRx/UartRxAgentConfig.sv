
`ifndef UARTRXAGENTCONFIG_INCLUDED_
`define UARTRXAGENTCONFIG_INCLUDED_

class UartRxAgentConfig extends uvm_object;
  `uvm_object_utils(UartRxAgentConfig)
  
  uvm_active_passive_enum is_active;
  bit hascoverage;
  bit hasparity;

  extern function void new(string name = "UartRxAgentConfig");

endclass : UartRxAgentConfig

    function void UartRxAgentConfig :: new(string name = "UartRxAgentConfig");
  super.new(name);
endfunction : new

`endif    

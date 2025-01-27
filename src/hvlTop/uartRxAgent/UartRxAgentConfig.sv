`ifndef UARTRXAGENTCONFIG_INCLUDED_
`define UARTRXAGENTCONFIG_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: UartRxAgentConfig
//  Used as the configuration class for slave agent and it's components
//--------------------------------------------------------------------------------------------
class UartRxAgentConfig extends uvm_object;
  `uvm_object_utils(UartRxAgentConfig)
  
  //Variable: is_active
  //Used to declare whether the agent is active or passive
  uvm_active_passive_enum is_active;

  //Variable: has_coverage
  //Used to set whether we need to create coverage or not
  bit hasCoverage;

 
  //Variable: has_coverage 
  bit hasParity;

  //no. of stop bit required
  rand stop_bit_e stop_bit;

  //oversamping method
  rand over_sampling_e over_sampling;

  //no. of data bit tranferred
  rand data_type_e data_type;

  //no. of parity bit required
  rand parity_type_e parity_type;

  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "UartRxAgentConfig");

endclass : UartRxAgentConfig

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name -  UartRxAgentConfig
//--------------------------------------------------------------------------------------------
function UartRxAgentConfig :: new(string name = "UartRxAgentConfig");
  super.new(name);
endfunction : new

`endif    

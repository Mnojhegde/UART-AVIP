`ifndef UARTENVCONFIG_INCLUDED_
`define UARTENVCONFIG_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: UartEnvConfig
// Used for setting various configurations for the environment
//--------------------------------------------------------------------------------------------
class UartEnvConfig extends uvm_object;
  `uvm_object_utils(UartEnvConfig)
 
  // Variable: hasvirtualsequencer
  bit hasvirtualsequencer;
  
  // Variable: hasscoreboard
  bit hasscoreboard;
  UartTxAgentConfig uartTxAgentConfig;
  UartRxAgentConfig uartRxAgentConfig;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "UartEnvConfig");
 
 endclass : UartEnvConfig

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - UartEnvConfig
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
 function UartEnvConfig :: new(string name = "UartEnvConfig");
   super.new(name);
 endfunction : new

`endif

`ifndef UARTTXAGENTCONFIG_INCLUDED_
`define UARTTXAGENTCONFIG_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: UartTxAgentConfig 
// Used as the configuration class for device0 agent and it's components
//--------------------------------------------------------------------------------------------
class UartTxAgentConfig extends uvm_object;
  `uvm_object_utils(UartTxAgentConfig)

  // Variable: is_active
  // Used for creating the agent in either passive or active mode
  uvm_active_passive_enum is_active;

  // config variables required for transmitting data
  bit hasCoverage;
  rand hasParityEnum hasParity;
  overSamplingEnum uartOverSamplingMethod;
  rand baudRateEnum uartBaudRate;
  rand dataTypeEnum uartDataType;
  rand parityTypeEnum uartParityType;
  rand stopBitEnum uartStopBit;
   int packetsNeeded;
  rand bit parityErrorInjection;
  rand bit framingErrorInjection;
  rand bit breakingErrorInjection;
  bit patternNeeded;
  logic[DATA_WIDTH-1:0]patternToTransmit;
  bit OverSampledBaudFrequencyClk;  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "UartTxAgentConfig");

endclass : UartTxAgentConfig

//--------------------------------------------------------------------------------------------
// Construct: new
// name - UartTxAgentConfig 
//--------------------------------------------------------------------------------------------
function UartTxAgentConfig :: new(string name = "UartTxAgentConfig");
  super.new(name);
endfunction : new

`endif

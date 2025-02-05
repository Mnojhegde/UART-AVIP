// `ifndef UARTRXCONFIGCONVERTER_INCLUDED_
// `define UARTRXCONFIGCONVERTER_INCLUDED_
// //--------------------------------------------------------------------------------------------
// // Class: UartRxAgentConfig 
// // Used as the configuration class for device0 agent and it's components
// //--------------------------------------------------------------------------------------------

// class UartRxConfigConverter extends uvm_object;
//   `uvm_object_utils(UartRxConfigConverter)
//   extern function new( string name = "uartRxConfigConverter");
//   extern static function void from_Class(input UartRxAgentConfig uartRxAgentConfig, output UartConfigStruct uartConfigStruct);
// endclass :UartRxConfigConverter
    

// function UartRxConfigConverter :: new(string name = "uartRxConfigConverter");
//   super.new(name);
// endfunction : new

// function void UartRxConfigConverter :: from_Class(input UartRxAgentConfig uartRxAgentConfig, output UartConfigStruct uartConfigStruct);
//   uartConfigStruct.uartOverSamplingMethod =  uartRxAgentConfig.uartOverSamplingMethod;
//   uartConfigStruct.uartBaudRate =  uartRxAgentConfig.uartBaudRate;
//   uartConfigStruct.uartDataType = uartRxAgentConfig.uartDataType;
//   uartConfigStruct.uartParityType = uartRxAgentConfig.uartParityType;
//   uartConfigStruct.uartParityEnable = uartRxAgentConfig.hasParity;
//   uartConfigStruct.uartParityErrorInjection = uartRxAgentConfig.parityErrorInjection;
// endfunction : from_Class
    
// `endif



// `ifndef UARTTXCONFIGCONVERTER_INCLUDED_
// `define UARTTXCONFIGCONVERTER_INCLUDED_

class UartTxConfigConverter extends uvm_object;
  `uvm_object_utils(UartTxConfigConverter)

  extern function new(string name = "uartTxConfigConverter");
  extern static function void from_Class(ref UartTxAgentConfig uartTxAgentConfig, ref UartConfigStruct uartConfigStruct);
endclass : UartTxConfigConverter

function UartTxConfigConverter::new(string name = "uartTxConfigConverter");
  super.new(name);
endfunction : new

function void UartTxConfigConverter::from_Class(ref UartTxAgentConfig uartTxAgentConfig, ref UartConfigStruct uartConfigStruct);
  uartConfigStruct.uartOverSamplingMethod = uartTxAgentConfig.uartOverSamplingMethod;
  uartConfigStruct.uartBaudRate = uartTxAgentConfig.uartBaudRate;
  uartConfigStruct.uartDataType = uartTxAgentConfig.uartDataType;
  uartConfigStruct.uartParityType = uartTxAgentConfig.uartParityType;
  uartConfigStruct.uartParityEnable = uartTxAgentConfig.hasParity;
  uartConfigStruct.uartParityErrorInjection = uartTxAgentConfig.parityErrorInjection;
endfunction : from_Class

// `endif

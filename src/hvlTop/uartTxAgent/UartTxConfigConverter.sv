`ifndef UARTTXCONFIGCONVERTER_INCLUDED_
`define UARTTXCONFIGCONVERTER_INCLUDED_

class UartTxConfigConverter extends uvm_object;
  `uvm_object_utils(UartTxConfigConverter)
  

  extern function new( string name = "UartTxConfigConverter");
    extern static function void fromTxClass(input UartTxAgentConfig uartTxAgentConfig, output UartConfigStruct uartConfigStruct);
    extern static function void toTxClass(input UartConfigStruct uartConfigStruct, output UartTxAgentConfig uartTxAgentConfig);
endclass :UartTxConfigConverter
    

function UartTxConfigConverter :: new(string name = "uartTxConfigConverter");
  super.new(name);
endfunction : new

function void UartTxConfigConverter :: fromTxClass(input uartTxAgentConfig uartTxAgentConfig, output uartConfigStruct uartConfigStruct);
  uartConfigStruct.uartOversamplingMethod =  uartTxAgentConfig.uartOversamplingMethod;
  uartConfigStruct.uartBaudRate =  uartTxAgentConfig.uartBaudRate;
  uartConfigStruct.uartDataType = uartTxAgentConfig.uartDataType;
  uartConfigStruct.uartParityType = uartTxAgentConfig.uartParityType;
  uartConfigStruct.uartParityEnable = uartTxAgentConfig.hasParity;
endfunction : fromTxClass


`endif
 
  

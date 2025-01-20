`ifndef UARTTXSEQITEMCONVERTER_INCLUDED_
`define UARTTXSEQITEMCONVERTER_INCLUDED_

class UartTxSeqItemConverter extends uvm_object;
  `uvm_object_utils(UartTxSeqItemConverter)

  extern function void new( string name = "UartTxSeqItemConverter");
  extern function void fromTxClass(input UartTxTransaction uartTxTransaction, output UartTxPacketStruct uartTxPacketStruct);
  extern function void toTxClass(input UartTxPacketStruct uartTxPacketStruct, output UartTxTransaction uartTxTransaction);
endclass :UartTxSeqItemConverter

function void UartTxSeqItemConverter :: new(string name = "uartTxSeqItemConverter");
  super.new(name);
endfunction : new


function void UartTxSeqItemConverter :: fromTxClass(input UartTxTransaction uartTxTransaction, output UartTxPacketStruct uartTxPacketStruct);
  int total_transmission = uartTxTransaction.transmission_data.size();

  uartTxPacketStruct.transmission_data = new[uartTxTransaction.transmission_data.size()];

  for(int transmission_number=0 ; transmission_number < total_transmission; transmission_number++)
   begin 
     uartTxPacketStruct.transmission_data[transmission_number] = uartTxTransaction.transmission_data[transmission_number];
   end 
   uartTxPacketStruct.parity = uartTxTransaction.parity;
 endfunction : fromTxClass

function void UartTxSeqItemConverter :: toTxClass(input UartTxPacketStruct uartTxPacketStruct, output UartTxTransaction uartTxTransaction);
  int total_transmission = uartTxPacketStruct.transmission_data.size();

  uartTxTransaction.transmission_data = new[uartTxPacketStruct.transmission_data.size()];

  for(int transmission_number=0 ; transmission_number < total_transmission; transmission_number++)
   begin 
     uartTxTransaction.transmission_data[transmission_number] = uartTxPacketStruct.transmission_data[transmission_number];
   end 
   uartTxTransaction.parity = uartTxPacketStruct.parity;
endfunction : toTxClass

`endif
 
  



`ifndef UARTRXSEQITEMCONVERTER_INCLUDED_
`define UARTRXSEQITEMCONVERTER_INCLUDED_

class UartRxSeqItemConverter extends uvm_object;
  `uvm_object_utils(UartRxSeqItemConverter)

  extern function void new( string name = "UartRxSeqItemConverter");
  extern function void fromRxClass(input UartRxTransaction uartRxTransaction, output UartRxPacketStruct uartRxPacketStruct);
  extern function void toRxClass(input UartRxPacketStruct uartRxPacketStruct, output UartRxTransaction uartRxTransaction);
endclass :UartRxSeqItemConverter

function void UartRxSeqItemConverter :: new(string name = "uartRxSeqItemConverter");
  super.new(name);
endfunction : new


function void UartRxSeqItemConverter :: fromRxClass(input UartRxTransaction uartRxTransaction, output UartRxPacketStruct uartRxPacketStruct);
  int total_receiving = uartRxTransaction.receiving_data.size();

  uartRxPacketStruct.receiving_data = new[uartRxTransaction.receiving_data.size()];

  for(int receiving_number=0 ; receiving_number < total_receiving; receiving_number++)
   begin 
     uartRxPacketStruct.receiving_data[receiving_number] = uartRxTransaction.receiving_data[receiving_number];
   end 
   uartRxPacketStruct.parity = uartRxTransaction.parity;
 endfunction : fromRxClass

function void UartRxSeqItemConverter :: toRxClass(input UartRxPacketStruct uartRxPacketStruct, output UartRxTransaction uartRxTransaction);
  int total_receiving = uartRxPacketStruct.receiving_data.size();

  uartRxTransaction.receiving_data = new[uartRxPacketStruct.receiving_data.size()];

  for(int receiving_number=0 ; receiving_number < total_receiving; receiving_number++)
   begin 
     uartRxTransaction.receiving_data[receiving_number] = uartRxPacketStruct.receiving_data[receiving_number];
   end 
   uartRxTransaction.parity = uartRxPacketStruct.parity;
endfunction : toRxClass
   
`endif
 
  

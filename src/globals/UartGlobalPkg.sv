`ifndef UARTGLOBALPKG_INCLUDED_
`define UARTGLOBALPKG_INCLUDED_

package UartGlobalPkg;

  typedef struct { bit[3:0] transmission_data[]; bit parity;} UartTxPacketStruct;
  typedef struct { bit[3:0] receiving_data[]; bit parity;} UartRxPacketStruct;

endpackage : UartGlobalPkg
`endif

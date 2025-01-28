`ifndef UARTTXCOVERPARAMETER_INCLUDED_
`define UARTTXCOVERPARAMETER_INCLUDED_

package UartTxCoverParameter;
  parameter DATA_WIDTH = 5;
  parameter PARITY_ENABLED = 0;
 typedef enum bit  {EVEN_PARITY , ODD_PARITY}PARITY_TYPE;
endpackage : UartTxCoverParameter

`endif

`ifndef_UARTTXASSERTIONS_INCLUDED_
`define_UARTTXASSERTIONS_INCLUDED_

import UartGlobalPkg :: *;
import UartTxCoverParameter :: *;

interface UartTxAssertions ( input bit clk , input bit tx);
  import uvm_pkg :: *;
  `include " macros.svh"

endinterface : UartTxAssertions

`endif
  

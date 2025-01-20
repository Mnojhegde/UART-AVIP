
`ifndef UARTTXPKG_INCLUDED_
`define UARTTXPKG_INCLUDED_

package UartTxPkg;
  `include "uvm_macros.svh"
  import uvm_pkg :: *;
  `include "UartTxAgentConfig.sv"
  `include "UartTxTransaction.sv"
  `include "UartTxSeqItemConverter.sv"
  `include "UartTxsequencer.sv"
  `include "UartTxDriverProxy.sv"
 // `include "UartTxMonitorProxy.sv"
  `include "UartTxAgent.sv"
endpackage : UartTxPkg

`endif

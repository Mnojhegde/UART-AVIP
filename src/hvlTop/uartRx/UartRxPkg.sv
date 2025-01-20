

`ifndef UARTRxPKG_INCLUDED_
`define UARTRxPKG_INCLUDED_

package UartRxPkg;
  `include "uvm_macros.svh"
  import uvm_pkg :: *;
  `include "UartRxAgentConfig.sv"
  `include "UartRxTransaction.sv"
  `include "UartRxSeqItemConverter.sv"
  `include "UartRxsequencer.sv"
  `include "UartRxDriverProxy.sv"
 // `include "UartRxMonitorProxy.sv"
  `include "UartRxAgent.sv"
endpackage : UartRxPkg

`endif

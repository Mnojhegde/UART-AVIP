`ifndef UARTENVPKG_INCLUDED_
`define UARTENVPKG_INCLUDED_

package UartEnvPkg;
  `include "uvm_macros.svh"
  import uvm_pkg :: *;
  import UartGlobalPkg :: *;
  import UartTxPkg :: *;
  import UartRxPkg :: *;

  `include "UartEnvConfig.sv"
  `include "UartVirtualSequencer.sv"
  `include "UartScoreboard.sv"
  `include "UartEnv.sv"
endpackage : UartEnvPkg
`endif

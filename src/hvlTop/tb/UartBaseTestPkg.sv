`ifndef UARTBASETESTPKG_INCLUDED_
`define UARTBASETESTPKG_INCLUDED_

package UartBaseTestPkg;
  `include "uvm_macros.svh"
  import uvm_pkg :: *;
  import UartGlobalPkg :: *;
  import UartTxPkg ::*;
  import UartRxPkg :: *;
  import UartEnvPkg :: *;
  import UartTxSequencePkg :: *;
  import UartRxSequencePkg :: *;
  import UartVirtualSequencePkg::*;

  `include "UartBaseTest.sv"
endpackage : UartBaseTestPkg
`endif

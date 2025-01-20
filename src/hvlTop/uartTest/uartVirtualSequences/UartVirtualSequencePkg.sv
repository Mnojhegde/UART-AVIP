`ifndef UARTVIRTUALSEQUENCEPKG_INCLUDED_
`define UARTVIRTUALSEQUENCEPKG_INCLUDED_

package UartVirtualSequencePkg;
  `include "uvm_macros.svh"
  import uvm_pkg :: *;
  import UartGlobalPkg :: *;
  import UartEnvPkg::*;
  import UartTxPkg::*;
  import UartRxPkg::*;
  import UartTxSequencePkg::*;
  import UartRxSequencePkg::*;

  `include "UartVirtualBaseSequence.sv"
  `include "UartVirtualTransmissionSequence.sv"
endpackage

`endif

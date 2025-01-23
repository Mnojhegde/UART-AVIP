`ifndef UARTENVPKG_INCLUDED_
`define UARTENVPKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: UartEnvPkg
// Includes all the files related to uart env
//--------------------------------------------------------------------------------------------
package UartEnvPkg;
  
  //-------------------------------------------------------
  // Importing uvm packages
  //-------------------------------------------------------  
  `include "uvm_macros.svh"
  import uvm_pkg :: *;

  //-------------------------------------------------------
  // Importing the required packages
  //-------------------------------------------------------
  import UartGlobalPkg :: *;
  import UartTxPkg :: *;
  import UartRxPkg :: *;

  //-------------------------------------------------------
  // Including the required files
  //-------------------------------------------------------
  `include "UartEnvConfig.sv"
  `include "UartVirtualSequencer.sv"
  `include "UartScoreboard.sv"
  `include "UartEnv.sv"
  
endpackage : UartEnvPkg

`endif

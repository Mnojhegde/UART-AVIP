`ifndef UARTBASETESTPKG_INCLUDED_
`define UARTBASETESTPKG_INCLUDED_
//--------------------------------------------------------------------------------------------
// Package:UartBaseTestPkg
//--------------------------------------------------------------------------------------------
package UartBaseTestPkg;
  `include "uvm_macros.svh"
  
  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  import uvm_pkg :: *;
  import UartGlobalPkg :: *;

  //-------------------------------------------------------
  // Importing the required packages
  //-------------------------------------------------------
  import UartTxPkg ::*;
  import UartRxPkg :: *;
  import UartEnvPkg :: *;
  import UartTxSequencePkg :: *;
  import UartRxSequencePkg :: *;
  import UartVirtualSequencePkg::*;
  
  //including base_test for testing
  
  `include "UartBaseTest.sv"
  `include "UartEvenParityTest.sv"
  `include "UartOddParityTest.sv"
  `include "UartEvenParityWithErrorTest.sv"
  `include "UartOddParityWithErrorTest.sv"
  `include "UartSample13BaudRate4800Datatype5EvenParityStopbit1.sv"
  `include "UartSample16BaudRate4800Datatype5EvenParityStopbit1.sv"

endpackage : UartBaseTestPkg
`endif

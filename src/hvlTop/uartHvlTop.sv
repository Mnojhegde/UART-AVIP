`ifndef HVLTOP_INCLUDED_
`define HVLTOP_INCLUDED_

module HvlTop;
  import uvm_pkg :: *;
  import UartBaseTestPkg :: *;

  initial 
    begin 
      run_test("UartBaseTest");
    end
endmodule : HvlTop

`endif

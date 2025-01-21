`ifndef UARTTXTRANSACTION_INCLUDED_ 
`define UARTTXTRANSACTION_INCLUDED_

class UartTxTransaction extends uvm_sequence_item;
  `uvm_object_utils(UartTxTransaction)

  rand bit[3 : 0]transmission_data[];
  bit parity;

  constraint set_number_of_transmissionn_range{ soft transmission_data.size() inside {[1:10]};}
  constraint set_transmission_data_range{ foreach(transmission_data[i]) transmission_data[i] inside{[1:$]};}

  extern function new(string name = "UartTxTransaction");
  extern function void do_copy(uvm_object rhs);
    extern function void do_print(uvm_printer printer);
      extern function bit do_compare(uvm_object rhs, uvm_comparer comparer = null);
endclass : UartTxTransaction

function UartTxTransaction :: new(string name = "UartTxTransaction");
  super.new(name);
endfunction : new

function void UartTxTransaction :: do_copy(uvm_object rhs);
  UartTxTransaction rhs1;

  if(! $cast(rhs1,rhs))
   `uvm_fatal("do_copy","casting failed during copying");

  super.copy(rhs);
  this.transmission_data = rhs1.transmission_data;
  this.parity = rhs1.parity;
endfunction : do_copy
  
    function bit UartTxTransaction :: do_compare(uvm_object rhs, uvm_comparer comparer = null);
  UartTxTransaction rhs1;
  if(! $cast(rhs1,rhs))
   `uvm_fatal("do_compare","Casting failed during comparing");

      return (super.compare(rhs,comparer) && this.transmission_data == rhs1.transmission_data && this.parity == rhs1.parity);
endfunction : do_compare

function void UartTxTransaction :: do_print(uvm_printer printer);
  super.do_print(printer);
  foreach(this.transmission_data[i])
    printer.print_field($sformatf("Transmission_data[%0d]",i),transmission_data[i],$bits(transmission_data[i]),UVM_BIN);
  printer.print_field("parity",parity,$bits(parity),UVM_BIN);
endfunction : do_print

`endif

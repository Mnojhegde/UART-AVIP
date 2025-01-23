`ifndef UARTRXCOVERAGE_INCLUDED_
`define UARTRXCOVERAGE_INCLUDED_

class UartRxCoverage extends uvm_subscriber #(UartRxTransaction);
  `uvm_component_utils(UartRxCoverage)
 
  UartRxAgentConfig uartRxAgentConfig;
  
  
  covergroup UartRxCovergroup with function sample (UartRxAgentConfig cfg, UartRxTransaction packet);
    option.per_instance = 1;

     RX : coverpoint packet.receiving_data{
     option.comment = "rx";
     bins UART_RX = {[1:$]};
   }

endgroup: UartRxCovergroup

  extern function new(string name = "UartRxCoverage", uvm_component parent = null);
  extern function void write(UartRxTransaction t);
  extern virtual function void report_phase(uvm_phase phase);

endclass : UartRxCoverage


function  UartRxCoverage::new(string name = "UartRxCoverage", uvm_component parent = null);
  super.new(name, parent);
  UartRxCovergroup = new();
endfunction : new


function void UartRxCoverage::write(UartRxTransaction t);
  
  `uvm_info(get_type_name(),$sformatf("Before calling SAMPLE METHOD"),UVM_HIGH);
  foreach(t.receiving_data[i]) begin
    UartRxCovergroup.sample(uartRxAgentConfig,t);
  end
  `uvm_info(get_type_name(),"After calling SAMPLE METHOD",UVM_HIGH);

endfunction : write


function void  UartRxCoverage::report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("UART RX Agent Coverage = %0.2f %%",  UartRxCovergroup.get_coverage()), UVM_NONE);
endfunction: report_phase

`endif

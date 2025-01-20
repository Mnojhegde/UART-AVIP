`ifndef UARTTXCOVERAGE_INCLUDED_
`define UARTTXCOVERAGE_INCLUDED_

class UartTxCoverage extends uvm_subscriber #(UartTxTransaction);
  `uvm_component_utils(UartTxCoverage)
 
  UartTxAgentConfig uartTxAgentConfig;
  

  covergroup UartTxCovergroup with function sample (UartTxAgentConfig cfg, UartTxTransaction packet);
    option.per_instance = 1;

   
   TX : coverpoint packet.transmission_data{
     option.comment = "tx";
     bins UART_TX = {[1:$]};
   }

   PR : coverpoint packet.parity{
     option.comment = "parity";
     bins UART_PARITY = {[0:1]};
   }
    
endgroup: UartTxCovergroup

  extern function new(string name = "UartTxCoverage", uvm_component parent = null);
    extern function void write(UartTxTransaction t);
  extern virtual function void report_phase(uvm_phase phase);

endclass : UartTxCoverage


 function  UartTxCoverage::new(string name = "UartTxCoverage", uvm_component parent = null);
  super.new(name, parent);
  UartTxCovergroup = new();
endfunction : new


    function void UartTxCoverage::write(UartTxTransaction t);
  
  `uvm_info(get_type_name(),$sformatf("Before calling SAMPLE METHOD"),UVM_HIGH);
  foreach(t.transmission_data[i]) begin
    UartTxCovergroup.sample(uartTxAgentConfig,t);
  end
  `uvm_info(get_type_name(),"After calling SAMPLE METHOD",UVM_HIGH);

endfunction : write


function void  UartTxCoverage::report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("UART TX Agent Coverage = %0.2f %%",  UartTxCovergroup.get_coverage()), UVM_NONE);
endfunction: report_phase

`endif

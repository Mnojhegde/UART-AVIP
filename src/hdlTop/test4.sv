module set;
 bit x=1;
 int y;
 bit clk;
 always #5 clk=~clk;

 always @(posedge clk)
  x=0;

initial begin 
 @(negedge x)
  $display("negedge detected at %t",$time);
end 

 initial begin 
 #20;
 $finish;
end 


always@(posedge clk)
 $display("THE VALUE OF X IS %0d and y is%0d @%t",x,y,$time);

endmodule 

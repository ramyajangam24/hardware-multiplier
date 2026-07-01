`include "multi.v"
module tb;
reg start;
reg clk,res;
reg [35:0]ain;
reg [35:0]bin;
wire ready;
wire [71:0]prod;
mult dut(.start(start),.clk(clk),.res(res),.ain(ain),.bin(bin),.ready(ready),.prod(prod));
always#5 clk=~clk;
initial begin
clk=0;
res=1;
start=0;
ain=0;
bin=0;
#1;
res=0;
repeat(5)begin
@(posedge clk);
#1;
start=1;
ain=$random;
bin=$random;

@(posedge clk);
#1;
start=0;
wait(ready==1);
#1;
$display("ain=%b(%0d),bin=%b(%0d),prod=%0d",ain,ain,bin,bin,prod);
end
$stop;
end
endmodule

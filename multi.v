module mult( start,clk,res,ain,bin,ready,prod);
input start;
input clk,res;
input [35:0]ain;//9 digits(9*4=36)
input [35:0]bin;
output reg ready;
output reg [71:0]prod;//36*2=72
reg [1:0]state;
reg [71:0]rega;
reg [35:0]regb;
reg [1:0]count;
localparam IDLE=2'b00;
localparam EXEC=2'b01;
localparam DONE=2'b10;
always@(posedge clk)begin
if(res)begin
state<=IDLE;
rega<=8'b0;
regb<=4'b0;
count<=0;
ready<=0;
prod<=0;
end
else begin
case(state)
IDLE:begin
ready<=1;
if(start==1)
begin
rega<={4'b0,ain};
regb<={bin};
ready<=0;
prod<=0;
state<=EXEC;
end
end
EXEC:begin
if(regb[0]==1'b1)
prod<=prod+rega;
rega<=rega<<1;
regb<=regb>>1;
count<=count+1;
if(count==3||regb==4'b0)
begin
state<=DONE;
end
else state<=EXEC;
end
DONE:
begin
ready<=1;
state<=IDLE;
end
default:state<=IDLE;
endcase
end
end
endmodule
//# ain=0100(4),bin=0001(1),prod=4
//# ain=1001(9),bin=0011(3),prod=27
//# ain=1101(13),bin=1101(13),prod=169
//# ain=0101(5),bin=0010(2),prod=10
//# ain=0001(1),bin=1101(13),prod=13

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:42:14 06/11/2021 
// Design Name: 
// Module Name:    simple_calculator 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module simple_calculator(
	 input rst,
    input [3:0] A,
    input [3:0] B,
    input [1:0]sel,
	 input signA,signB,
    output [7:0] O
    );
reg [7:0] aptemp,bptemp,atemp,btemp;
wire [7:0] add,sub,apptemp,bpptemp,antemp,bntemp;
wire [15:0] mul;
wire temp0;

twos_complement8bit x0(apptemp,antemp);
twos_complement8bit x1(bpptemp,bntemp);


always@(A or B or sel or rst or signA or signB)

if (rst==1)
begin 
atemp <= 8'd0;
btemp <= 8'd0;
end
 
else if(rst==0)
begin
aptemp <= {4'd0,A};
bptemp <= {4'd0,B};

case(signA)
0 : atemp <= aptemp;
1 : atemp <= antemp;
default : atemp <= 8'dX;
endcase


case(signB)
0 : btemp <= bptemp;
1 : btemp <= bntemp;
default : btemp <= 8'dX;
endcase

end

assign apptemp = aptemp;
assign bpptemp = bptemp;

endmodule

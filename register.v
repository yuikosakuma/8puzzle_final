module register (src0, src1, dst, we, data, clk, rst_n, data0, data1, comp, ord);
	input wire clk, rst_n;
	input wire [3:0] src0, src1;//[3:0]?
	input wire [3:0] dst;
	input wire we;
	input wire [39:0] data;
	output wire [39:0] data0, data1;
	//for seg
	output wire comp;
	output wire [33:0] ord;

	reg [39:0] regis [15:0];

`include "def.h"
`include "register.h"

//info about puzzle
//where is 0 for 1st 4bit
	//parameter [39:0] INIT = 40'b0101_0001_0010_0011_0100_0101_0000_0111_1000_0110,//2steps
	parameter [39:0] INIT = 40'b0000_0000_0101_0010_0001_0100_0011_0111_1000_0110,//6steps
	//parameter [39:0] INIT = 40'b0001_0101_0000_0010_0001_0100_0011_0111_1000_0110,//7steps
					IDEAL = 40'b1000_0001_0010_0011_0100_0101_0110_0111_1000_0000,
					TEMP = 40'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
          
//info about slide          
//DEPTH for 4bit, direction for 0 t0 29bit
	//parameter[3:0] DEPTH = 4'b0000;
    parameter[33:0] DIRECTION = 34'b0000_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00;

always @(posedge clk) begin
	if (!rst_n) begin
	//initial condition
		regis[0] <= INIT;
		regis[1] <= IDEAL;
		regis[2] <= TEMP;
		regis[3] <= DIRECTION;
		regis[4] <= 0;//TEMP_DIRECTION
		regis[5] <= 0;
		regis[6] <= 0;
		regis[7] <= 0;
	end else begin
		if (we) begin
			regis[dst] <= data;
		end else begin
			regis[dst] <= regis[dst];
		end
	end
end

assign data0 = regis[src0];
assign data1 = regis[src1];

//io
assign comp = (regis[TEMP_ADDR] == IDEAL)? 1:0;//flag if solved
assign ord = regis[DIRECTION_ADDR];//keep depth and direction

endmodule



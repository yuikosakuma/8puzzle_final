module register (src0, src1, dst, we, data, clk, rst_n, data0, data1);
	input wire clk, rst_n;
	input wire [4:0] src0, src1;//[3:0]?
	input wire [4:0] dst;
	input wire we;
	input wire [16:0] data;
	output wire [16:0] data0, data1;

	reg [16:0] regis [31:0];

	parameter [3:0] INIT_0 = 4'b0001, 
					INIT_1 = 4'b0010,
					INIT_2 = 4'b0011,
					INIT_3 = 4'b0100,
					INIT_4 = 4'b0000,//0101
					INIT_5 = 4'b0101,//X0000
					INIT_6 = 4'b0111,
					INIT_7 = 4'b1000,//1000
					INIT_8 = 4'b0110,

					IDEAL_0 = 4'b0001, 
					IDEAL_1 = 4'b0010,
					IDEAL_2 = 4'b0011,
					IDEAL_3 = 4'b0100,
					IDEAL_4 = 4'b0101,
					IDEAL_5 = 4'b0110,
					IDEAL_6 = 4'b0111,
					IDEAL_7 = 4'b1000,
					IDEAL_8 = 4'b0000;
/*
					TEMP_0_ADDR = 4'b0001, 
					TEMP_1_ADDR = 4'b0001, 
					TEMP_2_ADDR = 4'b0001, 
					TEMP_3_ADDR = 4'b0001, 
					TEMP_4_ADDR = 4'b0001, 
					TEMP_5_ADDR = 4'b0001, 
					TEMP_6_ADDR = 4'b0001, 
					TEMP_7_ADDR = 4'b0001, 
					TEMP_8_ADDR = 4'b0001;
//					SPACE_ADDR = 4'b0001,
//					TEMP_SPACE_ADDR = 4'b0001;
*/
	//parameter[16:0]SLIDENUM = 17'b000_00_00_00_00_00_00_00,
	parameter[16:0]SLIDENUM = 17'b000_00_00_00_00_00_00_00,
					ZERO = 17'b000_00_00_00_00_00_00_00;
					//TEMP_SLIDENUM_ADDR = 17'b000_00_00_00_00_00_00_00;
//	parameter[2:0] ZERO_3 = 3'b000;

always @(posedge clk) begin
	if (!rst_n) begin
	//initial condition
		regis[0] <= INIT_0;
		regis[1] <= INIT_1;
		regis[2] <= INIT_2;
		regis[3] <= INIT_3;
		regis[4] <= INIT_4;
		regis[5] <= INIT_5;
		regis[6] <= INIT_6;
		regis[7] <= INIT_7;
		regis[8] <= INIT_8;
	//ideal condition
		regis[9] <= IDEAL_0;
		regis[10] <= IDEAL_1;
		regis[11] <= IDEAL_2;
		regis[12] <= IDEAL_3;
		regis[13] <= IDEAL_4;
		regis[14] <= IDEAL_5;
		regis[15] <= IDEAL_6;
		regis[16] <= IDEAL_7;
		regis[17] <= IDEAL_8;

		//temp condition
		//regis represents place in puzzle
		regis[18] <= 0;
		regis[19] <= 0;
		regis[20] <= 0;
		regis[21] <= 0;
		regis[22] <= 0;
		regis[23] <= 0;
		regis[24] <= 0;
		regis[25] <= 0;
		regis[26] <= 0;

		//slide number
//		regis[27] <= SLIDENUM_ADDR;
		regis[27] <= SLIDENUM;
		//temp slide number
//		regis[28] <= TEMP_SLIDENUM_ADDR;
		regis[28] <= 0;
		//00 address(SPACE_ADDR)
		regis[29] <= 0;//SPACE_ADDR
		//temp_00address(TEMP_SPACE_ADDR)
		regis[30] <= 0;//SPACE_ADDR
		//0
		regis[31] <= ZERO;
//		regis[31] <= 0;
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


endmodule



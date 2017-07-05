module register (src0, src1, dst, we, data, clk, rst_n, data0, data1);
	input wire clk, rst_n;
	input wire [4:0] src0, src1;//[3:0]?
	input wire [4:0] dst;
	input wire we;
	input wire [7:0] data;
	output wire [7:0] data0, data1;

	reg [7:0] regis [35:0];

	parameter [35:0] INIT = 36'b0001_0010_0011_0100_0101_0000_0111_1000_0110, 
					IDEAL = 36'b0001_0010_0011_0100_0101_0110_0111_1000_0000;
	parameter[3:0] DEPTH = 4'b0000;
    parameter[29:0] DIRECTION = 30'b00_00_00_00_00_00_00_00_00_00_00_00_00_00_00;,

always @(posedge clk) begin
	if (!rst_n) begin
	//initial condition
		regis[0] <= INIT;
		regis[1] <= IDEAL;
		regis[2] <= 0;
		regis[3] <= DEPTH;
		regis[4] <= DIRECTION;
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


endmodule



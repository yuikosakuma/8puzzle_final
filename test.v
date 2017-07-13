`timescale 1ps/1ps

module test;
	reg clk, rst_n;
	reg [4:0]btn;
	wire[6:0]seg0, seg1, seg2, seg3;

	top top0(clk, rst_n, btn, seg0, seg1, seg2, seg3);

	always #50 clk = ~clk;

	initial begin
		$dumpfile("top_test.vcd");
		$dumpvars(0, top0);
		$dumplimit(100000000000);
		$monitor($stime, "clk:%b rst:%b", clk, rst_n);
		rst_n = 0;
		clk = 0;
	#150
		rst_n = 1;
//	#100000000
	#10000
	$finish;
	end
endmodule


//module io(comp, cnt, ord, btn, seg, clk, rst_n);
module io(comp, ord, btn, seg0, seg1, seg2, seg3, clk, rst_n);

	input comp;
	input [33:0] ord;
	input btn;
	output reg [6:0] seg0;
	output reg [6:0] seg1;
	output reg [6:0] seg2;
	output reg [6:0] seg3;
	input clk, rst_n;

	reg [11:0] buff [3:0];
	reg bt1, bt2;
//	reg [3:0] count;
	reg [3:0] btn_flag;
	reg [4:0] sort_num;

`include "def.h"
	
	parameter[6:0]

		SEG_U = 7'b1000001,
		SEG_P = 7'b0001100,
		SEG_D = 7'b0100001,
		SEG_O = 7'b0100011,
		SEG_L = 7'b1000111,
		SEG_E = 7'b0000110,
		SEG_R = 7'b0001000,
		SEG_I = 7'b1111001,
		SEG_0 = 7'b1000000,
		SEG_1 = 7'b1111001,
		SEG_2 = 7'b0100100,
		SEG_3 = 7'b0110000,
		SEG_4 = 7'b0011001,
		SEG_5 = 7'b0010010,
		SEG_6 = 7'b0000010,
		SEG_7 = 7'b1011000,
		SEG_8 = 7'b0000000,
		SEG_9 = 7'b0010000,
		SEG_NONE = 7'b0000000;

	always @(posedge clk) begin
		if(!rst_n) begin
			//seg <= 7'b0000000;
			//count <= 4'b0000;
			btn_flag <= 4'b0000;
			sort_num <= 5'b00000;
		end else begin
//			assign seg <= buff[count];
//			count　<= count + 1;
			seg0 <= buff[0];
			seg1 <= buff[1];
			seg2 <= buff[2];
			seg3 <= buff[3];
			bt1 <= btn;
			bt2 <= bt1;
		end
		
		if (bt1 & ~bt2) begin
			if (btn_flag == ord[33:30]) begin
				btn_flag <= 4'b0000;
				sort_num <= 2*btn_flag;
			end else begin
				btn_flag <= btn_flag + 1;
				sort_num <= 2*(btn_flag + 1);
			end
		end
	end
	always @(*) begin
		if(comp) begin
			case ((ord & (34'b11 << sort_num)) >> sort_num)
			UP : begin
				buff[3] = SEG_U;
				buff[2] = SEG_P;
			end
			DOWN : begin
				buff[3] = SEG_D;
				buff[2] = SEG_O;
			end
			RIGHT : begin
				buff[3] = SEG_R;
				buff[2] = SEG_I;
			end
			LEFT : begin
				buff[3] = SEG_L;
				buff[2] = SEG_E;
			end
			endcase
		end else begin
			buff[3] = SEG_NONE;
			buff[2] = SEG_NONE;
		end
	end

	always @(*) begin
		if(comp) begin
			case (btn_flag)
			0 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_1;
			end
			1 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_2;
			end
			2 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_3;
			end
			3 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_4;
			end
			4 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_5;
			end
			5 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_6;
			end
			6 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_7;
			end
			7 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_8;
			end
			8 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_9;
			end
			9 : begin
				buff[1] = SEG_1;
				buff[0] = SEG_0;
			end
			10 : begin
				buff[1] = SEG_1;
				buff[0] = SEG_1;
			end
			11 : begin
				buff[1] = SEG_1;
				buff[0] = SEG_2;
			end
			12 : begin
				buff[1] = SEG_1;
				buff[0] = SEG_3;
			end
			13 : begin
				buff[1] = SEG_1;
				buff[0] = SEG_4;
			end
			14 : begin
				buff[1] = SEG_1;
				buff[0] = SEG_5;
			end
			15 : begin
				buff[1] = SEG_1;
				buff[0] = SEG_6;
			end
			endcase
		end else begin
			buff[1] = SEG_NONE;
			buff[0] = SEG_NONE;
		end
	end
endmodule

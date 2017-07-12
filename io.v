module io(comp, cnt, ord, btn, seg, clk, rst_n);
// 初期の盤面は別途与えられるので初期状態入力の機構は用意していません

	input comp;            // 経路の探索が終了したかどうかのフラグ
	input [33:0] ord;      // 手数と移動方向をレジスタから受け取る
	input btn; 　           // 押すと0、離すと1が伝わる
	output reg [6:0] seg0;  // LEDの点灯を管理
	output reg [6:0] seg1;  // LEDの点灯を管理
	output reg [6:0] seg2;  // LEDの点灯を管理
	output reg [6:0] seg3;  // LEDの点灯を管理
	input clk, rst_n;

	reg [6:0] buff [3:0];  // LEDで表示する内容を保持
	// 3:移動方向の左側文字 2:移動方向の右側文字 1:手数の10の位 0:手数の1の位
//	reg [3:0] count;       // LEDに表示する情報を示す // 1クロックごとに1文字表示
	reg [3:0] btn_flag;    // ボタン入力回数を保持する
	reg [4:0] sort_num;     // ord のどこの手を提示するかを示す

`include "def.h"
// このコードで使っているparameter: UP,DOWN,RIGHT,LEFT

　　　　// アクティブ点灯方式(1ならば点灯?)
　　　　// 7セグなので7bit(コンマをあらわすLEDは無い想定)
　　　　// 各数字や文字とLED点灯箇所との関連づけ
	parameter[6:0]
		SEG_U = 7'b0111110,
		SEG_P = 7'b1100111,
		SEG_D = 7'b0111101,
		SEG_O = 7'b0011101,
		SEG_L = 7'b1110111,
		SEG_E = 7'b0110000,
		SEG_R = 7'b0001110,
		SEG_I = 7'b1001111,
		SEG_1 = 7'b0110000,
		SEG_2 = 7'b1101101,
		SEG_3 = 7'b1111001,
		SEG_4 = 7'b0110011,
		SEG_5 = 7'b1011011,
		SEG_6 = 7'b1011111,
		SEG_7 = 7'b1110000,
		SEG_8 = 7'b1111111,
		SEG_9 = 7'b1111011,
		SEG_0 = 7'b1111110,
		SEG_NONE = 7'b0000000; // 点灯なし

	always @(posedge clk) begin
		if(!rst_n) begin
			seg <= 7'b0;
			count <= 4'b0;
			btn_flag <= 4'b1;
			sort_num <= 5'b0;
		end else begin // LEDに信号を送ります
//			assign seg <= buff[count];
//			count　<= count + 1;
			assign seg0 <= buff[0];
			assign seg1 <= buff[1];
			assign seg2 <= buff[2];
			assign seg3 <= buff[3];
		end
	end

	always @(posedge btn) begin
		btn_flag <= btn_flag + 1;
		sort_num <= 2*(btn_flag-1);
	end

	always @(*) begin
		if(comp) begin
			case (ord[sort_num+1:sort_num])
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
				buff[0] = SEG_0;
			end
			1 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_1;
			end
			2 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_2;
			end
			3 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_3;
			end
			4 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_4;
			end
			5 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_5;
			end
			6 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_6;
			end
			7 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_7;
			end
			8 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_8;
			end
			9 : begin
				buff[1] = SEG_0;
				buff[0] = SEG_9;
			end
			10 : begin
				buff[1] = SEG_1;
				buff[0] = SEG_0;
			end
			11 : begin
				buff[1] = SEG_1;
				buff[0] = SEG_1;
			end
			12 : begin
				buff[1] = SEG_1;
				buff[0] = SEG_2;
			end
			13 : begin
				buff[1] = SEG_1;
				buff[0] = SEG_3;
			end
			14 : begin
				buff[1] = SEG_1;
				buff[0] = SEG_4;
			end
			15 : begin
				buff[1] = SEG_1;
				buff[0] = SEG_5;
			end
			endcase
		end else begin
			buff[1] = SEG_none;
			buff[0] = SEG_none;
		end
	end
endmodule

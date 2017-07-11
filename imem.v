module imem(pc, op);
	input wire [7:0] pc;
	output reg [15:0] op;

	`include "def.h"
	`include "register.h"

parameter [7:0] TO_INIT = 0,
				TO_OVERWRITE_3DIGIT = 10,
				TO_SLIDE_UP = 22,
				TO_SLIDE_DOWN = 35,
				TO_SLIDE_RIGHT = 48,
				TO_SLIDE_LEFT = 61,
				TO_SLIDE_UP_3 = 74,
				TO_SLIDE_UP_4 = 78,
				TO_SLIDE_UP_5 = 82,
				TO_SLIDE_UP_6 = 86,
				TO_SLIDE_UP_7 = 90,
				TO_SLIDE_UP_8 = 94,
				TO_SLIDE_DOWN_0 = 98,
				TO_SLIDE_DOWN_1 = 102,
				TO_SLIDE_DOWN_2 = 106,
				TO_SLIDE_DOWN_3 = 110,
				TO_SLIDE_DOWN_4 = 114,
				TO_SLIDE_DOWN_5 = 118,
				TO_SLIDE_RIGHT_0 = 122,
				TO_SLIDE_RIGHT_1 = 126,
				TO_SLIDE_RIGHT_3 = 130,
				TO_SLIDE_RIGHT_4 = 134,
				TO_SLIDE_RIGHT_6 = 138,
				TO_SLIDE_RIGHT_7 = 142,
				TO_SLIDE_LEFT_1 = 146,
				TO_SLIDE_LEFT_2 = 150,
				TO_SLIDE_LEFT_4 = 154,
				TO_SLIDE_LEFT_5 = 158,
				TO_SLIDE_LEFT_7 = 162,
				TO_SLIDE_LEFT_8 = 166,
				TO_CHECKER = 170,
				TO_CHECK_1 = 173,
				TO_CHECK_2 = 176,
				TO_CHECK_3 = 179,
				TO_CHECK_4 = 182,
				TO_CHECK_5 = 185,
				TO_CHECK_6 = 188,
				TO_CHECK_7 = 191,
				TO_CHECK_8 = 194,
				TO_OVERWRITE_SEQUENCE = 197,
				TO_FIN = 199;

always@(pc) begin
	case (pc)
//=======INIT===========
//copy i.c state to tmp register
	0 : begin
		op[15:12] <= COPY;
		op[11:8] <= TEMP_ADDR;
		op[7:4] <= INIT_ADDR;
		op[3:0] <= 4'bx;
	end

//========CHECK DEPTH_IF_15TH======
	1 : begin
		op[15:12] <= CHECK_4;
		op[11:8] <= DIRECTION_ADDR;
		op[7:4] <= FIFTEENTH;
		op[3:0] <= 4'bx;
	end
//if yes, jump to INIT
	2 : begin
	  op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_OVERWRITE_SEQUENCE;
	end

//read DIRECTION
	3 : begin
		op[15:12] <= REFERENCE;
		op[11:7] <= TEMP_DIRECTION_ADDR;
		op[6:2] <= DIRECTION_ADDR;
		op[1:0] <= 2'bx;
	end

//======CHECK DIRECTION=====
//check up
	4 : begin
		op[15:12] <= CHECK;
		op[11:6] <= 5'bx;
		op[5:2] <= TEMP_DIRECTION_ADDR;
		op[1:0] <= UP;
	end
	5 : begin
		op[15:12] <= JNZ;//JNZ
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECK_POSSIBLE_UP;//TO_SLIDE_UP
	end
//check temp_slidenum_addr if down
	6 : begin
		op[15:12] <= CHECK;
		op[11:6] <= 5'bx;
		op[5:2] <= TEMP_DIRECTION_ADDR;
		op[1:0] <= DOWN;
	end
	7 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECK_POSSIBLE_DOWN;
	end
//check temp_slidenum_addr if right
	8 : begin
		op[15:12] <= CHECK;
		op[11:6] <= 5'bx;
		op[5:2] <= TEMP_DIRECTION_ADDR;
		op[1:0] <= RIGHT;
	end
	9 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECK_POSSIBLE_RIGHT;
	end
//check temp_slidenum_addr if left
	10 : begin
		op[15:12] <= CHECK;
		op[11:6] <= 5'bx;
		op[5:2] <= TEMP_SLIDENUM_ADDR;
		op[1:0] <= LEFT;
	end
	11 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECK_POSSIBLE_LEFT;
	end

//========CHECK_POSSIBLE==========
//TO_CHECK_UP
	12 : begin
		op[15:12] <= POSSIBLE_UP;
		op[11:4] <= 8'bx;
		op[3:0] <= TEMP_ADDR;
	end
	13 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_UP;
	end
  14 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_INIT;
	end

//CHECK_DOWN
	15 : begin
		op[15:12] <= POSSIBLE_DOWN;
		op[11:4] <= 8'bx;
		op[3:0] <= TEMP_ADDR;
	end
	16 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_DOWN;
	end
  17 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_INIT;
	end
//CHECK_RIGHT
	18 : begin
		op[15:12] <= POSSIBLE_RIGHT;
		op[11:4] <= 8'bx;
		op[3:0] <= TEMP_ADDR;
	end
	19 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_RIGHT;
	end
  20 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_INIT;
	end
//CHECK_LEFT
	21 : begin
		op[15:12] <= POSSIBLE_LEFT;
		op[11:4] <= 8'bx;
		op[3:0] <= TEMP_ADDR;
	end
	22 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_LEFT;
	end
  23 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_INIT;
	end

//========SLIDE
//TO_UP
	24 : begin
		op[15:12] <= TO_UP;
		op[11:8] <= TEMP_DIRECTION_ADDR;
		op[7:4] <= TEMP_DIRECTION_ADDR;
		op[3:0] <= 2'bx;
	end
	25 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//TO_DOWN
	26 : begin
		op[15:12] <= TO_DOWN;
		op[11:8] <= TEMP_DIRECTION_ADDR;
		op[7:4] <= TEMP_DIRECTION_ADDR;
		op[3:0] <= 2'bx;
	end
	27 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//TO_RIGHT
	28 : begin
		op[15:12] <= TO_RIGHT;
		op[11:8] <= TEMP_DIRECTION_ADDR;
		op[7:4] <= TEMP_DIRECTION_ADDR;
		op[3:0] <= 2'bx;
	end
	29 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//TO_LEFT
	30 : begin
		op[15:12] <= TO_LEFT;
		op[11:8] <= TEMP_DIRECTION_ADDR;
		op[7:4] <= TEMP_DIRECTION_ADDR;
		op[3:0] <= 2'bx;
	end
	31 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end

//=======CHECKER=========
	32 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[7:4] <= TEMP_ADDR;
		op[3:0] <= IDEAL_ADDR;
	end
	33 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_FIN;
	end
	34 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_OVERWRITE_DIRECTION;
	end

//======OVERWRITE_DIRECTION=====
	35 : begin
		op[15:12] <= INC;
		op[11:7] <= DIRECTION_ADDR;
		op[6:2] <= DIRECTION_ADDR;
		op[1:0] <= 2'bx;
	end
	198 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_INIT;
	end

//=====FIN======
	199 : begin
	end
/*	122 : begin
		op[15:12] <- JMP;
		op[11:7] <= 4'bx;
		op[6:0] <= TO_FIN;
	end
*/
	endcase
end

endmodule



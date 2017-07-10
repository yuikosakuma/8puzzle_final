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
		op[7:0] <= TO_CHECK_POSSIBLE;//TO_SLIDE_UP
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
		op[7:0] <= TO_CHECK_POSSIBLE;
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
		op[7:0] <= TO_CHECK_POSSIBLE;
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
		op[7:0] <= TO_CHECK_POSSIBLE;
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
//CHECK_DOWN
	14 : begin
		op[15:12] <= POSSIBLE_DOWN;
		op[11:4] <= 8'bx;
		op[3:0] <= TEMP_ADDR;
	end
	15 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_DOWN;
	end
//CHECK_RIGHT
	16 : begin
		op[15:12] <= POSSIBLE_RIGHT;
		op[11:4] <= 8'bx;
		op[3:0] <= TEMP_ADDR;
	end
	17 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_RIGHT;
	end
//CHECK_LEFT
	18 : begin
		op[15:12] <= POSSIBLE_LEFT;
		op[11:4] <= 8'bx;
		op[3:0] <= TEMP_ADDR;
	end
	19 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_LEFT;
	end

//========SLIDE
//TO_UP
	20 : begin
		op[15:12] <= TO_UP;
		op[11:8] <= TEMP_DIRECTION_ADDR;
		op[7:4] <= TEMP_DIRECTION_ADDR;
		op[3:0] <= 2'bx;
	end
	21 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//TO_DOWN
	22 : begin
		op[15:12] <= TO_DOWN;
		op[11:8] <= TEMP_DIRECTION_ADDR;
		op[7:4] <= TEMP_DIRECTION_ADDR;
		op[3:0] <= 2'bx;
	end
	23 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//TO_RIGHT
	23 : begin
		op[15:12] <= TO_RIGHT;
		op[11:8] <= TEMP_DIRECTION_ADDR;
		op[7:4] <= TEMP_DIRECTION_ADDR;
		op[3:0] <= 2'bx;
	end
	24 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//TO_LEFT
	25 : begin
		op[15:12] <= TO_LEFT;
		op[11:8] <= TEMP_DIRECTION_ADDR;
		op[7:4] <= TEMP_DIRECTION_ADDR;
		op[3:0] <= 2'bx;
	end
	23 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end

//=======CHECKER=========
	170 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_0_ADDR;
		op[4:0] <= IDEAL_0_ADDR;
	end
	171 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECK_1;
	end
	172 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_OVERWRITE_3DIGIT;
	end
//check 1
	173 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_1_ADDR;
		op[4:0] <= IDEAL_1_ADDR;
	end
	174 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECK_2;
	end
	175 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_OVERWRITE_3DIGIT;
	end
//check 2
	176 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_2_ADDR;
		op[4:0] <= IDEAL_2_ADDR;
	end
	177 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECK_3;
	end
	178 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_OVERWRITE_3DIGIT;
	end
//check 3
	179 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_3_ADDR;
		op[4:0] <= IDEAL_3_ADDR;
	end
	180 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECK_4;
	end
	181 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_OVERWRITE_3DIGIT;
	end
//check 4
	182 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_4_ADDR;
		op[4:0] <= IDEAL_4_ADDR;
	end
	183 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECK_5;
	end
	184 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_OVERWRITE_3DIGIT;
	end
//check 5
	185 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_5_ADDR;
		op[4:0] <= IDEAL_5_ADDR;
	end
	186 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECK_6;
	end
	187 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_OVERWRITE_3DIGIT;
	end
//check 6
	188 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_6_ADDR;
		op[4:0] <= IDEAL_6_ADDR;
	end
	189 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECK_7;
	end
	190 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_OVERWRITE_3DIGIT;
	end
//check 7
	191 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_7_ADDR;
		op[4:0] <= IDEAL_7_ADDR;
	end
	192 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECK_8;
	end
	193 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_OVERWRITE_3DIGIT;
	end
//check 8
	194 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_8_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	195 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_FIN;
	end
	196 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_OVERWRITE_3DIGIT;
	end
//======OVERWRITE_SEQUENCE=====
	197 : begin
//		op[15:12] <= INC_3;//INC
		op[15:12] <= INC;
		op[11:7] <= SLIDENUM_ADDR;
		op[6:2] <= SLIDENUM_ADDR;
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



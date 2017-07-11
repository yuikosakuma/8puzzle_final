module imem(pc, op);
	input wire [5:0] pc;
	output reg [15:0] op;

	`include "def.h"
	`include "register.h"

parameter [7:0] TO_INIT = 0,
				TO_CHECK_POSSIBLE_UP = 12,
				TO_CHECK_POSSIBLE_DOWN = 15,
				TO_CHECK_POSSIBLE_RIGHT = 18,
				TO_CHECK_POSSIBLE_LEFT = 21,
				TO_SLIDE_UP = 24,
				TO_SLIDE_DOWN = 26,
				TO_SLIDE_RIGHT = 28,
				TO_SLIDE_LEFT = 30,
				TO_CHECKER = 32,
				TO_FIN = 38;

always@(pc) begin
	case (pc)
//=======INIT===========
//copy i.c state to tmp register
	0 : begin
		op[15:11] <= COPY;
		op[10:7] <= TEMP_ADDR;
		op[6:3] <= INIT_ADDR;
		op[2:0] <= 3'bx;
	end

//========CHECK DEPTH_IF_15TH======
	1 : begin
		op[15:11] <= CHECK_4;
		op[10:7] <= DIRECTION_ADDR;
		op[6:3] <= FIFTEENTH;
		op[2:0] <= 3'bx;
	end
//if yes, jump to INIT
	2 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_INIT;
	end

//read DIRECTION
	3 : begin
		op[15:11] <= REFERENCE;
		op[10:7] <= TEMP_DIRECTION_ADDR;
		op[6:3] <= DIRECTION_ADDR;
		op[1:0] <= 2'bx;
	end

//======CHECK DIRECTION=====
//check up
	4 : begin
		op[15:11] <= CHECK;
		op[10:6] <= 4'bx;
		op[5:2] <= TEMP_DIRECTION_ADDR;
		op[1:0] <= UP;
	end
	5 : begin
		op[15:11] <= JNZ;//JNZ
		op[10:6] <= 5'bx;
		op[5:0] <= TO_CHECK_POSSIBLE_UP;//TO_SLIDE_UP
	end
//check temp_slidenum_addr if down
	6 : begin
		op[15:11] <= CHECK;
		op[10:6] <= 5'bx;
		op[5:2] <= TEMP_DIRECTION_ADDR;
		op[1:0] <= DOWN;
	end
	7 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_CHECK_POSSIBLE_DOWN;
	end
//check temp_slidenum_addr if right
	8 : begin
		op[15:11] <= CHECK;
		op[10:6] <= 5'bx;
		op[5:2] <= TEMP_DIRECTION_ADDR;
		op[1:0] <= RIGHT;
	end
	9 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_CHECK_POSSIBLE_RIGHT;
	end
//check temp_slidenum_addr if left
	10 : begin
		op[15:11] <= CHECK;
		op[10:6] <= 5'bx;
		op[5:2] <= TEMP_DIRECTION_ADDR;
		op[1:0] <= LEFT;
	end
	11 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_CHECK_POSSIBLE_LEFT;
	end

//========CHECK_POSSIBLE==========
//TO_CHECK_UP
	12 : begin
		op[15:11] <= POSSIBLE_UP;
		op[10:4] <= 7'bx;
		op[3:0] <= TEMP_ADDR;
	end
	13 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_SLIDE_UP;
	end
	14 : begin
		op[15:11] <= JMP;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_INIT;
	end

//CHECK_DOWN
	15 : begin
		op[15:11] <= POSSIBLE_DOWN;
		op[10:4] <= 7'bx;
		op[3:0] <= TEMP_ADDR;
	end
	16 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_SLIDE_DOWN;
	end
	17 : begin
		op[15:11] <= JMP;
		op[10:6] <= 4'bx;
		op[5:0] <= TO_INIT;
	end
//CHECK_RIGHT
	18 : begin
		op[15:11] <= POSSIBLE_RIGHT;
		op[10:4] <= 7'bx;
		op[3:0] <= TEMP_ADDR;
	end
	19 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_SLIDE_RIGHT;
	end
	20 : begin
		op[15:11] <= JMP;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_INIT;
	end
//CHECK_LEFT
	21 : begin
		op[15:11] <= POSSIBLE_LEFT;
		op[10:4] <= 7'bx;
		op[3:0] <= TEMP_ADDR;
	end
	22 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_SLIDE_LEFT;
	end
	23 : begin
		op[15:11] <= JMP;
		op[10:6] <= 3'bx;
		op[5:0] <= TO_INIT;
	end

//========SLIDE
//TO_UP
	24 : begin
		op[15:11] <= TO_UP;
		op[10:7] <= TEMP_DIRECTION_ADDR;
		op[6:3] <= TEMP_DIRECTION_ADDR;
		op[2:0] <= 3'bx;
	end
	25 : begin
		op[15:11] <= JMP;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_CHECKER;
	end
//TO_DOWN
	26 : begin
		op[15:11] <= TO_DOWN;
		op[10:7] <= TEMP_DIRECTION_ADDR;
		op[6:3] <= TEMP_DIRECTION_ADDR;
		op[2:0] <= 3'bx;
	end
	27 : begin
		op[15:11] <= JMP;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_CHECKER;
	end
//TO_RIGHT
	28 : begin
		op[15:11] <= TO_RIGHT;
		op[10:7] <= TEMP_DIRECTION_ADDR;
		op[6:3] <= TEMP_DIRECTION_ADDR;
		op[2:0] <= 3'bx;
	end
	29 : begin
		op[15:11] <= JMP;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_CHECKER;
	end
//TO_LEFT
	30 : begin
		op[15:11] <= TO_LEFT;
		op[10:7] <= TEMP_DIRECTION_ADDR;
		op[6:3] <= TEMP_DIRECTION_ADDR;
		op[2:0] <= 3'bx;
	end
	31 : begin
		op[15:11] <= JMP;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_CHECKER;
	end

//=======CHECKER=========
	32 : begin
		op[15:11] <= COMP;
		op[10:8] <= 3'bx;
		op[7:4] <= TEMP_ADDR;
		op[3:0] <= IDEAL_ADDR;
	end
	33 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_FIN;
	end
/*
	34 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_OVERWRITE_DIRECTION;
	end
*/
//======OVERWRITE_DIRECTION=====
//overwrite direction(up, down, right, left)
	34 : begin
		op[15:11] <= INC;
		op[10:7] <= DIRECTION_ADDR;
		op[6:3] <= DIRECTION_ADDR;
		op[2:0] <= 3'bx;
	end
//overwrite depth
	35 : begin
		op[15:11] <= INC_DEPTH;
		op[10:7] <= DIRECTION_ADDR;
		op[6:3] <= DIRECTION_ADDR;
		op[2:0] <= 3'bx;
	end
//========WHERE_ZERO=========
	36 : begin
		op[15:11] <= WHERE_ZERO;
		op[10:7] <= DIRECTION_ADDR;
		op[6:3] <= DIRECTION_ADDR;
		op[2:0] <= 3'bx;
	end
	37 : begin
		op[15:11] <= JMP;
		op[10:6] <= 5'bx;
		op[6:0] <= TO_INIT;
	end

//=====FIN======
	38 : begin
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



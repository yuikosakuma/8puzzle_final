module imem(pc, op);
	input wire [5:0] pc;
	output reg [15:0] op;

	`include "def.h"
	`include "register.h"

parameter [7:0] TO_INIT = 0,
				TO_CHECK_DEPTH = 2,
				TO_CHECK_POSSIBLE_UP = 13,
				TO_CHECK_POSSIBLE_DOWN = 17,
				TO_CHECK_POSSIBLE_RIGHT = 21,
				TO_CHECK_POSSIBLE_LEFT = 25,
				TO_SLIDE_UP = 29,
				TO_SLIDE_DOWN = 31,
				TO_SLIDE_RIGHT = 33,
				TO_SLIDE_LEFT = 35,
				TO_CHECKER = 37,
				TO_FIN = 41;

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
	1 : begin
		op[15:11] <= INIT_DEPTH;
		op[10:7] <= DIRECTION_ADDR;
		op[6:3] <= DIRECTION_ADDR;
		op[2:0] <= 3'bx;
	end


//========CHECK DEPTH_IF_15TH======
	2 : begin
		op[15:11] <= CHECK_4;
		op[10:7] <= DIRECTION_ADDR;
		op[6:3] <= FOURTEENTH;
		op[2:0] <= 3'bx;
	end
//if yes, jump to INIT
	3 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_INIT;
	end

//read DIRECTION
	4 : begin
		op[15:11] <= REFERENCE;
		op[10:7] <= TEMP_DIRECTION_ADDR;
		op[6:3] <= DIRECTION_ADDR;
		op[1:0] <= 2'bx;
	end

//======CHECK DIRECTION=====
//check up
	5 : begin
		op[15:11] <= CHECK;
		op[10:6] <= 4'bx;
		op[5:2] <= TEMP_DIRECTION_ADDR;
		op[1:0] <= UP;
	end
	6 : begin
		op[15:11] <= JNZ;//JNZ
		op[10:6] <= 5'bx;
		op[5:0] <= TO_CHECK_POSSIBLE_UP;//TO_SLIDE_UP
	end
//check temp_slidenum_addr if down
	7 : begin
		op[15:11] <= CHECK;
		op[10:6] <= 5'bx;
		op[5:2] <= TEMP_DIRECTION_ADDR;
		op[1:0] <= DOWN;
	end
	8 : begin
		op[15:11] <= JNZ;
		op[11:6] <= 5'bx;
		op[5:0] <= TO_CHECK_POSSIBLE_DOWN;
	end
//check temp_slidenum_addr if right
	9 : begin
		op[15:11] <= CHECK;
		op[10:6] <= 5'bx;
		op[5:2] <= TEMP_DIRECTION_ADDR;
		op[1:0] <= RIGHT;
	end
	10 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_CHECK_POSSIBLE_RIGHT;
	end
//check temp_slidenum_addr if left
	11 : begin
		op[15:11] <= CHECK;
		op[10:6] <= 5'bx;
		op[5:2] <= TEMP_DIRECTION_ADDR;
		op[1:0] <= LEFT;
	end
	12 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_CHECK_POSSIBLE_LEFT;
	end

//========CHECK_POSSIBLE==========
//TO_CHECK_UP
	13 : begin
		op[15:11] <= POSSIBLE_UP;
		op[10:4] <= 7'bx;
		op[3:0] <= TEMP_ADDR;
	end
	14 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_SLIDE_UP;
	end
//overwrite direction(up, down, right, left)
	15 : begin
		op[15:11] <= INC;
		op[10:7] <= DIRECTION_ADDR;
		op[6:3] <= DIRECTION_ADDR;
		op[2:0] <= 3'bx;
	end
	16 : begin
		op[15:11] <= JMP;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_INIT;
	end

//CHECK_DOWN
	17 : begin
		op[15:11] <= POSSIBLE_DOWN;
		op[10:4] <= 7'bx;
		op[3:0] <= TEMP_ADDR;
	end
	18 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_SLIDE_DOWN;
	end
//overwrite direction(up, down, right, left)
	19 : begin
		op[15:11] <= INC;
		op[10:7] <= DIRECTION_ADDR;
		op[6:3] <= DIRECTION_ADDR;
		op[2:0] <= 3'bx;
	end
	20 : begin
		op[15:11] <= JMP;
		op[10:6] <= 4'bx;
		op[5:0] <= TO_INIT;
	end
//CHECK_RIGHT
	21 : begin
		op[15:11] <= POSSIBLE_RIGHT;
		op[10:4] <= 7'bx;
		op[3:0] <= TEMP_ADDR;
	end
	22 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_SLIDE_RIGHT;
	end
//overwrite direction(up, down, right, left)
	23 : begin
		op[15:11] <= INC;
		op[10:7] <= DIRECTION_ADDR;
		op[6:3] <= DIRECTION_ADDR;
		op[2:0] <= 3'bx;
	end
	24 : begin
		op[15:11] <= JMP;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_INIT;
	end
//CHECK_LEFT
	25 : begin
		op[15:11] <= POSSIBLE_LEFT;
		op[10:4] <= 7'bx;
		op[3:0] <= TEMP_ADDR;
	end
	26 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_SLIDE_LEFT;
	end
//overwrite direction(up, down, right, left)
	27 : begin
		op[15:11] <= INC;
		op[10:7] <= DIRECTION_ADDR;
		op[6:3] <= DIRECTION_ADDR;
		op[2:0] <= 3'bx;
	end
	28 : begin
		op[15:11] <= JMP;
		op[10:6] <= 3'bx;
		op[5:0] <= TO_INIT;
	end

//========SLIDE
//TO_UP
	29 : begin
		op[15:11] <= TO_UP;
		op[10:7] <= TEMP_ADDR;
		op[6:3] <= TEMP_ADDR;
		op[2:0] <= 3'bx;
	end
	30 : begin
		op[15:11] <= JMP;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_CHECKER;
	end
//TO_DOWN
	31 : begin
		op[15:11] <= TO_DOWN;
		op[10:7] <= TEMP_ADDR;
		op[6:3] <= TEMP_ADDR;
		op[2:0] <= 3'bx;
	end
	32 : begin
		op[15:11] <= JMP;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_CHECKER;
	end
//TO_RIGHT
	33 : begin
		op[15:11] <= TO_RIGHT;
		op[10:7] <= TEMP_ADDR;
		op[6:3] <= TEMP_ADDR;
		op[2:0] <= 3'bx;
	end
	34 : begin
		op[15:11] <= JMP;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_CHECKER;
	end
//TO_LEFT
	35 : begin
		op[15:11] <= TO_LEFT;
		op[10:7] <= TEMP_ADDR;
		op[6:3] <= TEMP_ADDR;
		op[2:0] <= 3'bx;
	end
	36 : begin
		op[15:11] <= JMP;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_CHECKER;
	end

//=======CHECKER=========
	37 : begin
		op[15:11] <= COMP;
		op[10:8] <= 3'bx;
		op[7:4] <= TEMP_ADDR;
		op[3:0] <= IDEAL_ADDR;
	end
	38 : begin
		op[15:11] <= JNZ;
		op[10:6] <= 5'bx;
		op[5:0] <= TO_FIN;
	end

//======OVERWRITE_DIRECTION=====
/*//overwrite direction(up, down, right, left)
	39 : begin
		op[15:11] <= INC;
		op[10:7] <= DIRECTION_ADDR;
		op[6:3] <= DIRECTION_ADDR;
		op[2:0] <= 3'bx;
	end
*/
//overwrite depth
	39 : begin
		op[15:11] <= INC_DEPTH;
		op[10:7] <= DIRECTION_ADDR;
		op[6:3] <= DIRECTION_ADDR;
		op[2:0] <= 3'bx;
	end
	40 : begin
		op[15:11] <= JMP;
		op[10:6] <= 5'bx;
		op[6:0] <= TO_CHECK_DEPTH;
	end

//=====FIN======
	41 : begin
		op[15:11] <= STORE;
		op[10:7] <= TEMP_DIRECTION_ADDR;
		op[6:3] <= DIRECTION_ADDR;
		op[2:0] <= 2'bx;
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



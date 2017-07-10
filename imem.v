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
/*
	3 : begin
		op[15:12] <= REFERENCE;
		op[11:7] <= TEMP_SLIDENUM_ADDR;
		op[6:2] <= SLIDENUM_ADDR;
		op[1:0] <= 2'bx;
	end
 */ 
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
	21 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECK_POSSIBLE;
	end

//========CHECK_POSSIBLE==========
//TO_CHECK_UP
	22 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_3_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	23 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_UP;
	end
//CHECK_UP_4
	24 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_4_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	25 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_UP;
	end
//CHECK_UP_5
	26 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_5_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	27 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_UP;
	end
//CHECK_UP_6
	28 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_6_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	29 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_UP_6;
	end
//CHECK_UP_7
	30 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_7_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	31 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_UP_7;
	end
//CHECK_UP_8
	32 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_8_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	33 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_UP_8;
	end
//JMP if not in 3-8
	34 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_OVERWRITE_SEQUENCE;
	end
//TO_CHECK_DOWN
//========SLIDE_DOWN==========
//TO_CHECK_DOWN
	35 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_0_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	36 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_DOWN_0;
	end
//CHECK_DOWN_1
	37 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_1_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	38 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_DOWN_1;
	end
//CHECK_DOWN_2
	39 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_2_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	40 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_DOWN_2;
	end
//CHECK_DOWN_3
	41 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_3_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	42 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_DOWN_3;
	end
//CHECK_DOWN_4
	43 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_4_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	44 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_DOWN_4;
	end
//CHECK_DOWN_5
	45 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_5_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	46 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_DOWN_5;
	end
//JMP if not in 0-5
	47 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_OVERWRITE_SEQUENCE;
	end

//TO_CHECK_RIGHT
//========SLIDE_RIGHT==========
//TO_CHECK_RIGHT
	48 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_0_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	49 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_RIGHT_0;
	end
	50 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_1_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	51 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_RIGHT_1;
	end
	52 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_3_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	53 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_RIGHT_3;
	end
	54 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_4_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	55 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_RIGHT_4;
	end
	56 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_6_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	57 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_RIGHT_6;
	end
	58 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_7_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	59 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_RIGHT_7;
	end
//JMP if not in 0,1,3,4,6,7
	60 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_OVERWRITE_SEQUENCE;
	end
//TO_CHECK_LEFT
//========SLIDE_LEFT==========
//TO_CHECK_LEFT
	61 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_1_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	62 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_LEFT_1;
	end
	63 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_2_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	64 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_LEFT_2;
	end
	65 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_4_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	66 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_LEFT_4;
	end
	67 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_5_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	68 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_LEFT_5;
	end
	69 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_7_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	70 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_LEFT_7;
	end
	71 : begin
		op[15:12] <= COMP;
		op[11:10] <= 2'bx;
		op[9:5] <= TEMP_8_ADDR;
		op[4:0] <= IDEAL_8_ADDR;
	end
	72 : begin
		op[15:12] <= JNZ;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_SLIDE_LEFT_8;
	end
//JMP if not in 1,2,4,5,7,8
	73 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_OVERWRITE_SEQUENCE;
	end

//========SLIDE
//SLIDE_UP_3
	74 : begin
		op[15:12] <= TO_UP;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_3_ADDR;
		op[1:0] <= 2'bx;
	end
	75 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_3_ADDR;
		op[6:2] <= TEMP_0_ADDR;
		op[1:0] <= 2'bx;
	end
	76 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_0_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	77 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_UP_4
	78 : begin
		op[15:12] <= TO_UP;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_4_ADDR;
		op[1:0] <= 2'bx;
	end
	79 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_4_ADDR;
		op[6:2] <= TEMP_1_ADDR;
		op[1:0] <= 2'bx;
	end
	80 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_1_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	81 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_UP_5
	82 : begin
		op[15:12] <= TO_UP;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_5_ADDR;
		op[1:0] <= 2'bx;
	end
	83 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_5_ADDR;
		op[6:2] <= TEMP_2_ADDR;
		op[1:0] <= 2'bx;
	end
	84 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_2_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	85 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_UP_6
	86 : begin
		op[15:12] <= TO_UP;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_6_ADDR;
		op[1:0] <= 2'bx;
	end
	87 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_6_ADDR;
		op[6:2] <= TEMP_3_ADDR;
		op[1:0] <= 2'bx;
	end
	88 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_3_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	89 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_UP_7
	90 : begin
		op[15:12] <= TO_UP;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_7_ADDR;
		op[1:0] <= 2'bx;
	end
	91 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_7_ADDR;
		op[6:2] <= TEMP_4_ADDR;
		op[1:0] <= 2'bx;
	end
	92 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_4_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	93 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_UP_8
	94 : begin
		op[15:12] <= TO_UP;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_8_ADDR;
		op[1:0] <= 2'bx;
	end
	95 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_8_ADDR;
		op[6:2] <= TEMP_5_ADDR;
		op[1:0] <= 2'bx;
	end
	96 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_8_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	97 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_DOWN_0
	98 : begin
		op[15:12] <= TO_DOWN;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_0_ADDR;
		op[1:0] <= 2'bx;
	end
	99 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_0_ADDR;
		op[6:2] <= TEMP_3_ADDR;
		op[1:0] <= 2'bx;
	end
	100 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_3_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	101 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_DOWN_1
	102 : begin
		op[15:12] <= TO_DOWN;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_1_ADDR;
		op[1:0] <= 2'bx;
	end
	103 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_1_ADDR;
		op[6:2] <= TEMP_3_ADDR;
		op[1:0] <= 2'bx;
	end
	104 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_3_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	105 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_DOWN_2
	106 : begin
		op[15:12] <= TO_DOWN;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_2_ADDR;
		op[1:0] <= 2'bx;
	end
	107 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_2_ADDR;
		op[6:2] <= TEMP_5_ADDR;
		op[1:0] <= 2'bx;
	end
	108 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_5_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	109 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_DOWN_3
	110 : begin
		op[15:12] <= TO_DOWN;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_3_ADDR;
		op[1:0] <= 2'bx;
	end
	111 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_3_ADDR;
		op[6:2] <= TEMP_6_ADDR;
		op[1:0] <= 2'bx;
	end
	112 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_6_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	113 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_DOWN_4
	114 : begin
		op[15:12] <= TO_DOWN;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_4_ADDR;
		op[1:0] <= 2'bx;
	end
	115 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_4_ADDR;
		op[6:2] <= TEMP_7_ADDR;
		op[1:0] <= 2'bx;
	end
	116 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_7_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	117 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_DOWN_5
	118 : begin
		op[15:12] <= TO_DOWN;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_5_ADDR;
		op[1:0] <= 2'bx;
	end
	119 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_5_ADDR;
		op[6:2] <= TEMP_8_ADDR;
		op[1:0] <= 2'bx;
	end
	120 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_8_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	121 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_RIGHT_0
	122 : begin
		op[15:12] <= TO_RIGHT;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_0_ADDR;
		op[1:0] <= 2'bx;
	end
	123 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_0_ADDR;
		op[6:2] <= TEMP_1_ADDR;
		op[1:0] <= 2'bx;
	end
	124 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_1_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	125 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_RIGHT_1
	126 : begin
		op[15:12] <= TO_RIGHT;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_1_ADDR;
		op[1:0] <= 2'bx;
	end
	127 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_1_ADDR;
		op[6:2] <= TEMP_2_ADDR;
		op[1:0] <= 2'bx;
	end
	128 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_2_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	129 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_RIGHT_3
	130 : begin
		op[15:12] <= TO_RIGHT;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_3_ADDR;
		op[1:0] <= 2'bx;
	end
	131 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_3_ADDR;
		op[6:2] <= TEMP_4_ADDR;
		op[1:0] <= 2'bx;
	end
	132 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_4_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	133 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_RIGHT_4
	134 : begin
		op[15:12] <= TO_RIGHT;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_4_ADDR;
		op[1:0] <= 2'bx;
	end
	135 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_4_ADDR;
		op[6:2] <= TEMP_5_ADDR;
		op[1:0] <= 2'bx;
	end
	136 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_5_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	137 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_RIGHT_6
	138 : begin
		op[15:12] <= TO_RIGHT;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_6_ADDR;
		op[1:0] <= 2'bx;
	end
	139 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_6_ADDR;
		op[6:2] <= TEMP_7_ADDR;
		op[1:0] <= 2'bx;
	end
	140 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_7_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	141 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_RIGHT_7
	142 : begin
		op[15:12] <= TO_RIGHT;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_7_ADDR;
		op[1:0] <= 2'bx;
	end
	143 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_7_ADDR;
		op[6:2] <= TEMP_8_ADDR;
		op[1:0] <= 2'bx;
	end
	144 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_8_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	145 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_LEFT_1
	146 : begin
		op[15:12] <= TO_LEFT;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_1_ADDR;
		op[1:0] <= 2'bx;
	end
	147 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_1_ADDR;
		op[6:2] <= TEMP_0_ADDR;
		op[1:0] <= 2'bx;
	end
	148 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_0_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	149 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_LEFT_2
	150 : begin
		op[15:12] <= TO_LEFT;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_2_ADDR;
		op[1:0] <= 2'bx;
	end
	151 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_2_ADDR;
		op[6:2] <= TEMP_1_ADDR;
		op[1:0] <= 2'bx;
	end
	152 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_1_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	153 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_LEFT_4
	154 : begin
		op[15:12] <= TO_LEFT;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_4_ADDR;
		op[1:0] <= 2'bx;
	end
	155 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_4_ADDR;
		op[6:2] <= TEMP_3_ADDR;
		op[1:0] <= 2'bx;
	end
	156 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_3_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	157 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_LEFT_5
	158 : begin
		op[15:12] <= TO_LEFT;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_5_ADDR;
		op[1:0] <= 2'bx;
	end
	159 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_5_ADDR;
		op[6:2] <= TEMP_4_ADDR;
		op[1:0] <= 2'bx;
	end
	160 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_4_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	161 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_LEFT_7
	162 : begin
		op[15:12] <= TO_LEFT;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_7_ADDR;
		op[1:0] <= 2'bx;
	end
	163 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_7_ADDR;
		op[6:2] <= TEMP_6_ADDR;
		op[1:0] <= 2'bx;
	end
	164 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_6_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	165 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end
//SLIDE_LEFT_8
	166 : begin
		op[15:12] <= TO_LEFT;
		op[11:7] <= TEMP_SPACE_ADDR;
		op[6:2] <= TEMP_8_ADDR;
		op[1:0] <= 2'bx;
	end
	167 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_8_ADDR;
		op[6:2] <= TEMP_7_ADDR;
		op[1:0] <= 2'bx;
	end
	168 : begin
		op[15:12] <= COPY;
		op[11:7] <= TEMP_7_ADDR;
		op[6:2] <= TEMP_SPACE_ADDR;
		op[1:0] <= 2'bx;
	end
	169 : begin
		op[15:12] <= JMP;
		op[11:8] <= 4'bx;
		op[7:0] <= TO_CHECKER;
	end

//=======CHECKER=========
//check 0
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



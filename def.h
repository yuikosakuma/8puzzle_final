parameter [3:0]
	/*
	AND = 4'h0, 
	OR = 4'h1,
	ADD = 4'h2,
	SUB = 4'h3,
	INC = 4'h4,
	DEC = 4'h5,
	COMP = 4'h6,
	CHECK = 4'h7,
	LOAD = 4'h8, 
	STORE= 4'h9,
	LI = 4'ha,
	JMP = 4'hb, 
	JNZ = 4'hc,
*/
	INC = 4'h0,
	INC_3 = 4'h1,
	COPY = 4'h2,
	COPY_3 = 4'h3,
	COMP = 4'h4,
	CHECK = 4'h5,
	CHECK_3 = 4'h6,
	REFERENCE = 4'h7,
	TO_UP = 4'h8,
	TO_DOWN = 4'h9,
	TO_RIGHT = 4'ha,
	TO_LEFT = 4'hb,
	STORE = 4'hc,
	LI = 4'hd,
	JMP = 4'he,
	JNZ = 4'hf;

//DEPTH max 15
parameter[2:0]
	ZERO = 4'b0000,
	FIRST = 4'b0001,
	SECOND = 4'b0010,
	THIRD = 4'b0011,
	FOURTH = 4'b0100,
	FIFTH = 4'b0101,
	SIXTH = 4'b0110,
	SEVENTH = 4'b0111;
	EIGHTH = 4'b1000;
	NINETH = 4'b1001;
	TENTH = 4'b1010;
	ELEVENTH = 4'b1011;
	TWELVETH = 4'b1100;
	THIRTEENTH = 4'b1101;
	FOURTEENTH = 4'b1110;
	FIFTEENTH = 4'b1111;

parameter[1:0]
	UP = 2'b00,
	DOWN = 2'b01,
	RIGHT = 2'b10,
	LEFT = 2'b11;


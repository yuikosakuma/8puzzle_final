module alu(in0, in1, op, zf, out);

	input wire [39:0] in0, in1;
	input wire [4:0] op;
	output reg zf;
	output reg [39:0] out;
`include "def.h"
`include "register.h"

always @(*) begin
	case(op)
		INC : begin
			out <= in1 + 1;
			zf <= 0;
		end
		INC_DEPTH : begin
			out<= {in1[33:30] +4'b0001, 30'b00_00_00_00_00_00_00_00_00_00_00_00_00_00_00}+{4'b0000, in1[29:0]};
			zf <= 0;
		end
		
		COPY : begin
			out <= in1;
			zf <= 0;
		end

		COMP : begin
			zf <= (in0 == in1) ? 1:0;
		end

		//check 2bit
		CHECK : begin
			//zf <= (in0[33:30] == in1[33:30]) ? 1:0;
			zf <= (in0[1:0] == in1[1:0]) ? 1:0;
		end
		//check 4bit
		CHECK_4 : begin
			//zf <= (in0[16:14] == in1[16:14]) ? 1:0;
			zf <= (in0[33:30] == in1[33:30]) ? 1:0;
		end
		//making flag
		POSSIBLE_UP : begin
			if(in0[39:36] == THIRD)begin zf <= 1;
			end else if (in0[39:36] == FOURTH)begin zf <= 1;
			end else if (in0[39:36] == FIFTH)begin zf <= 1;
			end else if (in0[39:36] == SIXTH)begin zf <= 1;
			end else if (in0[39:36] == SEVENTH)begin zf <= 1;
			end else if (in0[39:36] == EIGHTH)begin zf <= 1;
			end else begin zf <= 0;
			end
			//zf <= (in0[39:36] == THIRD|FOURTH|FIFTH|SIXTH|SEVENTH|EIGHTH) ? 1:0;
		end
	
		POSSIBLE_DOWN : begin
			if(in0[39:36] == ZERO)begin zf <= 1;
			end else if (in0[39:36] == FIRST)begin zf <= 1;
			end else if (in0[39:36] == SECOND)begin zf <= 1;
			end else if (in0[39:36] == THIRD)begin zf <= 1;
			end else if (in0[39:36] == FOURTH)begin zf <= 1;
			end else if (in0[39:36] == FIFTH)begin zf <= 1;
			end else begin zf <= 0;
			end
			//zf <= (in0[39:36] == ZERO|FIRST|SECOND|THIRD|FOURTH|FIFTH) ? 1:0;
		end
		
		POSSIBLE_RIGHT : begin
			if(in0[39:36] == ZERO)begin zf <= 1;
			end else if (in0[39:36] == FIRST)begin zf <= 1;
			end else if (in0[39:36] == THIRD)begin zf <= 1;
			end else if (in0[39:36] == FOURTH)begin zf <= 1;
			end else if (in0[39:36] == SIXTH)begin zf <= 1;
			end else if (in0[39:36] == SEVENTH)begin zf <= 1;
			end else begin zf <= 0;
			end
			//zf <= (in0[39:36] == ZERO|FIRST|THIRD|FOURTH|SIXTH|SEVENTH) ? 1:0;
		end

		POSSIBLE_LEFT : begin
			if(in0[39:36] == FIRST)begin zf <= 1;
			end else if (in0[39:36] == SECOND)begin zf <= 1;
			end else if (in0[39:36] == FOURTH)begin zf <= 1;
			end else if (in0[39:36] == FIFTH)begin zf <= 1;
			end else if (in0[39:36] == SEVENTH)begin zf <= 1;
			end else if (in0[39:36] == EIGHTH)begin zf <= 1;
			end else begin zf <= 0;
			end
			//zf <= (in0[39:36] == FIRST|SECOND|FOURTH|FIFTH|SEVENTH|EIGHTH) ? 1:0;
		end

		REFERENCE : begin
			case(in1[33:30])
				ZERO: out <= {34'b11 & in1};
				FIRST: out <= {(34'b11 << 2) & in1} >> 2;
				SECOND: out <= {(34'b11 << 4) & in1} >> 4;
				THIRD: out <= {(34'b11 << 6) & in1} >> 6;
				FOURTH: out <= {(34'b11 << 8) & in1} >> 8;
				FIFTH: out <= {(34'b11 << 10) & in1} >> 10;
				SIXTH: out <= {(34'b11 << 12) & in1} >> 12;
				SEVENTH: out <= {(34'b11 << 14) & in1} >> 14;
				EIGHTH: out <= {(34'b11 << 16) & in1} >> 16;
				NINETH: out <= {(34'b11 << 18) & in1} >> 18;
				TENTH: out <= {(34'b11 << 20) & in1} >> 20;
				ELEVENTH: out <= {(34'b11 << 22) & in1} >> 22;
				TWELFTH: out <= {(34'b11 << 24) & in1} >> 24;
				THIRTEENTH: out <= {(34'b11 << 26) & in1} >> 26;
				FOURTEENTH: out <= {(34'b11 << 28) & in1} >> 28;
			/*
				ZERO: out <= {34'b0000_00_00_00_00_00_00_00_00_00_00_00_00_00_00, in1[1:0]};
				FIRST: out <= {34'b0000_00_00_00_00_00_00_00_00_00_00_00_00_00_00, in1[3:2]};
				SECOND: out <= {34'b0000_00_00_00_00_00_00_00_00_00_00_00_00_00_00,in1[5:4]};
				THIRD: out <= {34'b0000_00_00_00_00_00_00_00_00_00_00_00_00_00_00, in1[7:6]};
				FOURTH: out <= {34'b0000_00_00_00_00_00_00_00_00_00_00_00_00_00_00, in1[9:8]};
				FIFTH: out <= {34'b0000_00_00_00_00_00_00_00_00_00_00_00_00_00_00, in1[11:10]};
				SIXTH: out <= {34'b0000_00_00_00_00_00_00_00_00_00_00_00_00_00_00,in1[13:12]};
				SEVENTH: out <= {34'b0000_00_00_00_00_00_00_00_00_00_00_00_00_00_00,in1[15:14]};
				EIGHTH: out <= {34'b0000_00_00_00_00_00_00_00_00_00_00_00_00_00_00,in1[17:16]};
				NINETH: out <= {34'b0000_00_00_00_00_00_00_00_00_00_00_00_00_00_00,in1[19:18]};
				TENTH: out <= {34'b0000_00_00_00_00_00_00_00_00_00_00_00_00_00_00,in1[21:20]};
				ELEVENTH: out <= {34'b0000_00_00_00_00_00_00_00_00_00_00_00_00_00_00,in1[23:22]};
				TWELFTH: out <= {34'b0000_00_00_00_00_00_00_00_00_00_00_00_00_00_00,in1[25:24]};
				THIRTEENTH: out <= {34'b0000_00_00_00_00_00_00_00_00_00_00_00_00_00_00,in1[27:26]};
				FOURTEENTH: out <= {34'b0000_00_00_00_00_00_00_00_00_00_00_00_00_00_00,in1[28:27]};
				*/
			endcase
			zf <= 0;
		end
		
		
		TO_UP : begin
			if(in1[39:36] == 4'b0011)begin
                    out <= {4'b0000, in1[23:20], in1[31:28], in1[27:24], in1[35:32], in1[19:16], in1[15:12], in1[11:8], in1[7:4], in1[3:0]};
			end else if (in1[39:36] == 4'b0100)begin
                    out <= {4'b0001, in1[35:32], in1[19:16], in1[27:24], in1[23:20], in1[31:28], in1[15:12], in1[11:8], in1[7:4], in1[3:0]};
			end else if (in1[39:36] == 4'b0101)begin
                    out <= {4'b0010, in1[35:32], in1[31:28], in1[15:12], in1[23:20], in1[19:16], in1[27:24], in1[11:8], in1[7:4], in1[3:0]};
			end else if(in1[39:36] == 4'b0110)begin
                    out <= {4'b0011, in1[35:32], in1[31:28], in1[27:24], in1[11:8], in1[19:16], in1[15:12], in1[23:20], in1[7:4], in1[3:0]};
			end else if(in1[39:36] == 4'b0111)begin
                    out <= {4'b0100, in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[7:4], in1[15:12], in1[11:8], in1[19:16], in1[3:0]};
			end else begin
				out <= {4'b0101, in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[19:16], in1[3:0], in1[11:8], in1[7:4], in1[15:12]};
			end
			zf <= 0;
		end

		TO_DOWN : begin
			if(in1[39:36] == 4'b0000)begin
                    out <= {4'b0011, in1[23:20], in1[31:28], in1[27:24], in1[35:32], in1[19:16], in1[15:12], in1[11:8], in1[7:4], in1[3:0]};
			end else if (in1[39:36] == 4'b0001)begin
                    out <= {4'b0100, in1[35:32], in1[19:16], in1[27:24], in1[23:20], in1[31:28], in1[15:12], in1[11:8], in1[7:4], in1[3:0]};
			end else if (in1[39:36] == 4'b0010)begin
                    out <= {4'b0101, in1[35:32], in1[31:28], in1[15:12], in1[23:20], in1[19:16], in1[27:24], in1[11:8], in1[7:4], in1[3:0]};
			end else if(in1[39:36] == 4'b0011)begin
                    out <= {4'b0110, in1[35:32], in1[31:28], in1[27:24], in1[11:8], in1[19:16], in1[15:12], in1[23:20], in1[7:4], in1[3:0]};
			end else if(in1[39:36] == 4'b0100)begin
                    out <= {4'b0111, in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[7:4], in1[15:12], in1[11:8], in1[19:16], in1[3:0]};
			end else if(in1[39:36] == 4'b0101)begin 
                    out <= {4'b1000, in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[19:16], in1[3:0], in1[11:8], in1[7:4], in1[15:12]};
			end
			zf <= 0;
		end

		TO_RIGHT : begin
			if(in1[39:36] == 4'b0000)begin
                    out <= {4'b0001, in1[31:28], in1[35:32], in1[27:24], in1[23:20], in1[19:16], in1[15:12], in1[11:8], in1[7:4], in1[3:0]};
			end else if (in1[39:36] == 4'b0001)begin
                    out <= {4'b0010, in1[35:32], in1[27:24], in1[31:28], in1[23:20], in1[19:16], in1[15:12], in1[11:8], in1[7:4], in1[3:0]};
			end else if (in1[39:36] == 4'b0011)begin
                    out <= {4'b0100, in1[35:32], in1[31:28], in1[27:24], in1[19:16], in1[23:20], in1[15:12], in1[11:8], in1[7:4], in1[3:0]};
			end else if(in1[39:36] == 4'b0100)begin
                    out <= {4'b0101, in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[15:12], in1[19:16], in1[11:8], in1[7:4], in1[3:0]};
			end else if(in1[39:36] == 4'b0110)begin
                    out <= {4'b0111, in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[19:16], in1[15:12], in1[7:4], in1[11:8], in1[3:0]};
			end else if(in1[39:36] == 4'b0111)begin 
                    out <= {4'b1000, in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[19:16], in1[15:12], in1[11:8], in1[3:0], in1[11:8]};
			end
			zf <= 0;
		end
		
		TO_LEFT : begin
			if(in1[39:36] == 4'b0001)begin
                    out <= {4'b0000, in1[31:28], in1[35:32], in1[27:24], in1[23:20], in1[19:16], in1[15:12], in1[11:8], in1[7:4], in1[3:0]};
			end else if (in1[39:36] == 4'b0010)begin
                    out <= {4'b0001, in1[35:32], in1[27:24], in1[31:28], in1[23:20], in1[19:16], in1[15:12], in1[11:8], in1[7:4], in1[3:0]};
			end else if (in1[39:36] == 4'b0100)begin
                    out <= {4'b0011, in1[35:32], in1[31:28], in1[27:24], in1[19:16], in1[23:20], in1[15:12], in1[11:8], in1[7:4], in1[3:0]};
			end else if(in1[39:36] == 4'b0101)begin
                    out <= {4'b0100, in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[15:12], in1[19:16], in1[11:8], in1[7:4], in1[3:0]};
			end else if(in1[39:36] == 4'b0111)begin
                    out <= {4'b0110, in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[19:16], in1[15:12], in1[7:4], in1[11:8], in1[3:0]};
			end else if(in1[39:36] == 4'b1000)begin 
                    out <= {4'b0111, in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[19:16], in1[15:12], in1[11:8], in1[3:0], in1[11:8]};
			end
			zf <= 0;
		end

		INIT_DEPTH : begin
			out <= {4'b0000, in1[29:0]};
			zf <= 0;
		end

/*
		LOAD : begin
			out <= in0;
			zf <= 0;
		end
*/

		STORE : begin
			out <= in0;
			zf <= 0;
		end

		LI : begin
			out <= in0;
			zf <= 0;
		end

		default : begin
			out <= 0;
			zf <= 0;
		end
		endcase

end
endmodule


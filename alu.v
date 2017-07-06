module alu(in0, in1, op, zf, out);

	input wire [3:0] in0;
    input wire [35:0] in1;
	input wire [3:0] op;
	output reg zf;
	output reg [16:0] out;
    output reg [3:0] ou0;
    output reg [35:0] ou1;
`include "def.h"
`include "register.h"

always @(*) begin
	case(op)
	/*
		AND : begin
			out <= in0 & in1;
			zf <= 0;
		end
		OR : begin
			out <= in0 | in1;
			zf <= 0;
		end
		ADD : begin
			out <= in0 + in1;
			zf <= 0;
		end
		SUB : begin
			out <= (in0>in1) ? in0 - in1 : in1 - in0;
			zf <= 0;
		end
		INC : begin
			out <= in0 + 1;
			zf <= 0;
		end
		DEC : begin
			out <= in0 - 1;
			zf <= 0;
		end
	*/
		
		INC : begin
			out <= in1 + 1;
			zf <= 0;
		end
		INC_3 : begin
//			out[16:14] <= in1[16:14] + 1;
			out<= {in1[16:14] +3'b001, 14'b00_00_00_00_00_00_00}+{3'b000, in1[13:0]};
			zf <= 0;
		end
		COPY : begin
			out <= in1;
			zf <= 0;
		end
		//INIT first 3bit
		COPY_3 : begin
			//out[16:14] <= in1[2:0];
		//	out[16:14] <= in1[16:14];
			out <= {3'b000, in1[13:0]};
			zf <= 0;
		end
		COMP : begin
			zf <= (in0 == in1) ? 1:0;
		end
		//check 2bit
		CHECK : begin
			zf <= (in0[16:15] == in1[16:15]) ? 1:0;
		end
		//check 3bit
		CHECK_3 : begin
			//zf <= (in0[16:14] == in1[16:14]) ? 1:0;
			zf <= (in0[2:0] == in1[16:14]) ? 1:0;
		end
		//making flag
		REFERENCE : begin
			case(in1[16:14])
				FIRST: out <= {in1[1:0], 15'b000_00_00_00_00_00_00};
				SECOND: out <= {in1[3:2], 15'b000_00_00_00_00_00_00};
				THIRD: out <= {in1[5:4], 15'b000_00_00_00_00_00_00};
				FOURTH: out <= {in1[7:6], 15'b000_00_00_00_00_00_00};
				FIFTH: out <= {in1[9:8], 15'b000_00_00_00_00_00_00};
				SIXTH: out <= {in1[11:10], 15'b000_00_00_00_00_00_00};
				SEVENTH: out <= {in1[13:12], 15'b000_00_00_00_00_00_00};
			endcase
			zf <= 0;
		end
/*
		TO_UP : begin
			if(in1 == TEMP_3_ADDR)begin
					TEMP_3_ADDR <= TEMP_0_ADDER;
			end else if (in1 == TEMP_4_ADDR)begin
					TEMP_4_ADDR <= TEMP_1_ADDER;
					TEMP_1_ADDR <= {ZERO, 1'b0};
			end else if (in1 == TEMP_5_ADDR)begin
					TEMP_5_ADDR <= TEMP_2_ADDER;
					TEMP_2_ADDR <= {ZERO, 1'b0};
			end else if(in1 == TEMP_6_ADDR)begin
					TEMP_6_ADDR <= TEMP_3_ADDER;
					TEMP_3_ADDR <= {ZERO, 1'b0};
			end else if(in1 == TEMP_7_ADDR)begin
					TEMP_7_ADDR <= TEMP_4_ADDER;
					TEMP_4_ADDR <= {ZERO, 1'b0};
			end else if(in1 == TEMP_8_ADDR)begin 
					TEMP_8_ADDR <= TEMP_5_ADDER;
					TEMP_5_ADDR <= {ZERO, 1'b0};
			end
			zf <= 0;
		end
*/

		TO_UP : begin
			if(in0 == 0011)begin
                    ou0 <= in1[23:20], in1[31:28], in1[27:24], in1[35:32], in1[19:16], in1[15:12], in1[11:8], in1[7:4], in1[3:0];
                    ou1 <= 0000
			end else if (in0 == 0100)begin
                    ou0 <= in1[35:32], in1[19:16], in1[27:24], in1[23:20], in1[31:28], in1[15:12], in1[11:8], in1[7:4], in1[3:0];
                    ou1 <= 0001
			end else if (in0 == 0101)begin
                    ou0 <= in1[35:32], in1[31:28], in1[15:12], in1[23:20], in1[19:16], in1[27:24], in1[11:8], in1[7:4], in1[3:0];
                    ou1 <= 0010
			end else if(in0 == 0110)begin
                    ou0 <= in1[35:32], in1[31:28], in1[27:24], in1[11:8], in1[19:16], in1[15:12], in1[23:20], in1[7:4], in1[3:0];
                    ou1 <= 0010
			end else if(in0 == 0111)begin
                    ou0 <= in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[7:4], in1[15:12], in1[11:8], in1[19:16], in1[3:0];
                    ou1 <= 0011
			end else if(in0 == 1000)begin 
                    ou0 <= in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[19:16], in1[3:0], in1[11:8], in1[7:4], in1[15:12];
                    ou1 <= 0100
			end
			zf <= 0;
		end
		TO_DOWN : begin
			if(in0 == 0000)begin
                    ou0 <= in1[23:20], in1[31:28], in1[27:24], in1[35:32], in1[19:16], in1[15:12], in1[11:8], in1[7:4], in1[3:0];
                    ou1 <= 0011
			end else if (in0 == 0001)begin
                    ou0 <= in1[35:32], in1[19:16], in1[27:24], in1[23:20], in1[31:28], in1[15:12], in1[11:8], in1[7:4], in1[3:0];
                    ou1 <= 0100
			end else if (in0 == 0010)begin
                    ou0 <= in1[35:32], in1[31:28], in1[15:12], in1[23:20], in1[19:16], in1[27:24], in1[11:8], in1[7:4], in1[3:0];
                    ou1 <= 0101
			end else if(in0 == 0011)begin
                    ou0 <= in1[35:32], in1[31:28], in1[27:24], in1[11:8], in1[19:16], in1[15:12], in1[23:20], in1[7:4], in1[3:0];
                    ou1 <= 0110
			end else if(in0 == 0100)begin
                    ou0 <= in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[7:4], in1[15:12], in1[11:8], in1[19:16], in1[3:0];
                    ou1 <= 0111
			end else if(in0 == 0101)begin 
                    ou0 <= in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[19:16], in1[3:0], in1[11:8], in1[7:4], in1[15:12];
                    ou1 <= 1000
			end
			zf <= 0;
		end

		to_right : begin
			if(in0 == 0000)begin
                    ou0 <= in1[31:28], in1[35:32], in1[27:24], in1[23:20], in1[19:16], in1[15:12], in1[11:8], in1[7:4], in1[3:0];
                    ou1 <= 0001
			end else if (in0 == 0001)begin
                    ou0 <= in1[35:32], in1[27:24], in1[31:28], in1[23:20], in1[19:16], in1[15:12], in1[11:8], in1[7:4], in1[3:0];
                    ou1 <= 0010
			end else if (in0 == 0011)begin
                    ou0 <= in1[35:32], in1[31:28], in1[27:24], in1[19:16], in1[23:20], in1[15:12], in1[11:8], in1[7:4], in1[3:0];
                    ou1 <= 0100
			end else if(in0 == 0100)begin
                    ou0 <= in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[15:12], in1[19:16], in1[11:8], in1[7:4], in1[3:0];
                    ou1 <= 0101
			end else if(in0 == 0110)begin
                    ou0 <= in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[19:16], in1[15:12], in1[7:4], in1[11:8], in1[3:0];
                    ou1 <= 0111
			end else if(in0 == 0111)begin 
                    ou0 <= in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[19:16], in1[15:12], in1[11:8], in1[3:0], in1[11:8];
                    ou1 <= 1000
			end
			zf <= 0;
		end
		
		TO_LEFT : begin
			if(in0 == 0001)begin
                    ou0 <= in1[31:28], in1[35:32], in1[27:24], in1[23:20], in1[19:16], in1[15:12], in1[11:8], in1[7:4], in1[3:0];
                    ou1 <= 0000
			end else if (in0 == 0010)begin
                    ou0 <= in1[35:32], in1[27:24], in1[31:28], in1[23:20], in1[19:16], in1[15:12], in1[11:8], in1[7:4], in1[3:0];
                    ou1 <= 0001
			end else if (in0 == 0100)begin
                    ou0 <= in1[35:32], in1[31:28], in1[27:24], in1[19:16], in1[23:20], in1[15:12], in1[11:8], in1[7:4], in1[3:0];
                    ou1 <= 0011
			end else if(in0 == 0101)begin
                    ou0 <= in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[15:12], in1[19:16], in1[11:8], in1[7:4], in1[3:0];
                    ou1 <= 0100
			end else if(in0 == 0111)begin
                    ou0 <= in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[19:16], in1[15:12], in1[7:4], in1[11:8], in1[3:0];
                    ou1 <= 0110
			end else if(in0 == 1000)begin 
                    ou0 <= in1[35:32], in1[31:28], in1[27:24], in1[23:20], in1[19:16], in1[15:12], in1[11:8], in1[3:0], in1[11:8];
                    ou1 <= 0111
			end
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


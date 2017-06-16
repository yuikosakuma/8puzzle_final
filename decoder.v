module decoder(op, zf, pc_in, pc_we, src0, src1, dst, reg_we, sel1, sel2, data, alu_op, mem_we);
	input wire [15:0] op;
	input wire zf;
	output reg [7:0] pc_in;
	output reg pc_we;
	output reg [4:0] src0, src1, dst;//[3:0]?
	output reg reg_we;
	output reg sel1, sel2;
	output reg [16:0] data;//7?
	output reg [3:0] alu_op;
	output reg mem_we;

`include "def.h"

always @(*) begin
	case (op[15:12])
/*
	AND : begin
		alu_op <= op[15:12];
		dst <= op[11:8];
		src1 <= op[7:4];
		src0 <= op[3:0];
		pc_in <= 0;
		pc_we <= 1;
		reg_we <= 1;
		sel1 <= 0;
		sel2 <= 0;
		data <= 0;
		mem_we <= 0;
	end
	
	OR : begin
		alu_op <= op[15:12];
		dst <= op[11:8];
		src1 <= op[7:4];
		src0 <= op[3:0];
		pc_in <= 0;
		pc_we <= 1;
		reg_we <= 1;
		sel1 <= 0;
		sel2 <= 0;
		data <= 0;
		mem_we <= 0;
	end
*/
/*
	JMP : begin
		pc_in <= op[6:0];
		pc_we <= 1;
	end

	
	JNZ : begin
		pc_in <= op[6:0];
		pc_we <= zf;
	end
*/
	JMP : begin
		alu_op <= op[15:12];
		dst <= 0;
		src1 <= 0;
		src0 <= 0;
		pc_in <= op[7:0];
		pc_we <= 1;
		reg_we <= 0;
		sel1 <= 0;
		sel2 <= 0;
		data <= 0;
		mem_we <= 0;
	end
	JNZ : begin
		alu_op <= op[15:12];
		dst <= 0;
		src1 <= 0;
		src0 <= 0;
		pc_in <= op[7:0];
		pc_we <= zf;
		reg_we <= 0;
		sel1 <= 0;
		sel2 <= 0;
		data <= 0;
		mem_we <= 0;
	end
	INC : begin
		alu_op <= op[15:12];
		dst <= op[11:7];
		src1 <= op[6:2];
		src0 <= 0;
		pc_in <= 0;
		pc_we <= 0; //1?
		reg_we <= 1;
		sel1 <= 0;
		sel2 <= 0;
		data <= 0;
		mem_we <= 0;
	end

	INC_3 : begin
		alu_op <= op[15:12];
		dst <= op[11:7];
		src1 <= op[6:2];
		src0 <= 0;
		pc_in <= 0;
		pc_we <= 0; //1?
		reg_we <= 1;//1
		sel1 <= 0;
		sel2 <= 0;
		data <= 0;
		mem_we <= 0;
	end

	COPY : begin
		alu_op <= op[15:12];
		dst <= op[11:7];
		src1 <= op[6:2];
		src0 <= 0;
		pc_in <= 0;
		pc_we <= 0;
		reg_we <= 1;
		sel1 <= 1;//1??
		sel2 <= 0;
		data <= op[1:0];
		mem_we <= 0;
	end
	COPY_3 : begin
		alu_op <= op[15:12];
		dst <= op[11:7];
		src1 <= op[6:2];
		src0 <= 0;
		pc_in <= 0;
		pc_we <= 0;
		reg_we <= 1;
		sel1 <= 1;
		sel2 <= 0;
		data <= op[1:0];
		mem_we <= 0;
	end
//copy number 3bit
/*
	COPY_3 : begin
		alu_op <= op[15:12];
		dst <= op[11:7];
		src1 <= op[6:2];
		src0 <= 0;
		pc_in <= 0;
		pc_we <= 0;
		reg_we <= 1;
		sel1 <= 0;
		sel2 <= 0;
		data <= op[2:0];
		mem_we <= 0;
	end
*/

	COMP : begin
		alu_op <= op[15:12];
		dst <= 0;
		src1 <= op[9:5];
		src0 <= op[4:0];
		pc_in <= 0;
		pc_we <= 0;//zf
		reg_we <= 0;
		sel1 <= 1;
		sel2 <= 0;
//		data <= op[6:0];
		data <= 0;
		mem_we <= 0;
	end

//check 2bit
	CHECK : begin
		alu_op <= op[15:12];
		dst <= 0;
		src1 <= op[6:2];
		src0 <= 0;
		pc_in <= 0;
		pc_we <= zf;
		reg_we <= 0;
		sel1 <= 0;
		sel2 <= 0;
		data <= {op[1:0], 15'b00000_00000_00000};
//		data <= {op[6:0], 10b'00000_00000};
		mem_we <= 0;
	end

	CHECK_3 : begin
		alu_op <= op[15:12];
		dst <= 0;
		src1 <= op[11:7];
		src0 <= 0;//[6:0]
		pc_in <= 0;
		pc_we <= 0;
		reg_we <= 0;
		sel1 <= 0;
		sel2 <= 0;
		data <= op[6:4];
		mem_we <= 0;
	end
	REFERENCE : begin
		alu_op <= op[15:12];
		dst <= op[11:7];
		src1 <= op[6:2];
		src0 <= 0;
		pc_in <= 0;
		pc_we <= 0;
		reg_we <= 1;
		sel1 <= 1; //1???
		sel2 <= 0; //0???
		data <= 0;
		mem_we <= 0;
	end

	TO_UP : begin
		alu_op <= op[15:12];
		dst <= op[11:7];
		src1 <= op[6:2];
		src0 <= 0;
		pc_in <= 0;
		pc_we <= 0;
		reg_we <= 1;
		sel1 <= 0; //1???
		sel2 <= 1; //0???
		data <= 0;
		mem_we <= 0;
	end

	TO_DOWN : begin
		alu_op <= op[15:12];
		dst <=  op[11:7];
		src1 <= op[6:2];
		src0 <= 0;
		pc_in <= 0;
		pc_we <= 0;
		reg_we <= 1;
		sel1 <= 0; //1???
		sel2 <= 1; //0???
		data <= 0;
		mem_we <= 0;
	end

	TO_RIGHT : begin
		alu_op <= op[15:12];
		dst <= op[11:7];
		src1 <= op[6:2];
		src0 <= 0;
		pc_in <= 0;
		pc_we <= 0;
		reg_we <= 1;
		sel1 <= 0; //1???
		sel2 <= 1; //0???
		data <= 0;
	end

	TO_LEFT : begin
		alu_op <= op[15:12];
		dst <= op[11:7];
		src1 <= op[6:2];
		src0 <= 0;
		pc_in <= 0;
		pc_we <= 0;
		reg_we <= 1;
		sel1 <= 0; //1???
		sel2 <= 1; //0???
		data <= 0;
		mem_we <= 0;
		mem_we <= 0;
	end

	STORE : begin
		alu_op <= op[15:12];
		dst <= 0;
		src1 <= op[11:8];
		src0 <= op[7:4];
		pc_in <= 0;
		pc_we <= 0;
		reg_we <= 0;
		sel1 <= 1;
		sel2 <= 0;
		data <= 0;
		mem_we <= 1;
	end

	LI : begin
		alu_op <= op[15:12];
		dst <= op[11:8];
		src1 <= 0;
		src0 <= 0;
		pc_in <= 0;
		pc_we <= 0;
		reg_we <= 1;
		sel1 <= 1;
		sel2 <= 0;
		data <= op[7:0];
		mem_we <= 0;
	end


	default : begin
		pc_we <= 0;
	end

	endcase
end

endmodule


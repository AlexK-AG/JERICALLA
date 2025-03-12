module Jericalla (
    input [16:0] instruction,  // Entrada de 17 bits que contiene las instrucciones
    output reg [31:0] result,  // Salida de 32 bits
    output reg zf              // Salida del flag zf
);

    reg en;
    reg [3:0] dir1, dir2, dirW;
    reg [3:0] op;
    wire [31:0] data1, data2, ram_out;
    
    ROM rom_inst (
        .dir1R2(dir1),
        .dir2R2(dir2),
        .data1(data1),
        .data2(data2)
    );
    
    ALU alu_inst (
        .data1(data1),
        .data2(data2),
        .op(op),
        .dataOut(result),
		.zf(zf)
    );
    
    RAM ram_inst (
        .En(en),
        .dirR(dirW),
        .dataIn(result),
        .DS(ram_out)
    );
    
always @(*) begin
        if (en) begin
            dir1 = 4'b0100; 
            dir2 = 4'b0110; 
            op = 4'b0010; 
            dirW = 4'b0011;
        end else begin
            dirW = 4'b0011; 
        end
    end

endmodule

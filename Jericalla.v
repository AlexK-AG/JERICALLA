module Jericalla (
    input [16:0] instruction,  // Entrada de 17 bits que contiene las instrucciones
    output [31:0] ram_out, // Salida de 32 bits (proveniente de la RAM)
    output zf              // Salida del flag zf (proveniente de la ALU)
);

    reg en;
    reg [3:0] dir1, dir2, dirW;
    reg [3:0] op;
    wire [31:0] data1, data2, result;

    // Instancia del módulo ROM
    ROM rom_inst (
        .dir1R2(dir1),
        .dir2R2(dir2),
        .data1(data1),
        .data2(data2)
    );

    // Instancia del módulo ALU
    ALU alu_inst (
        .data1(data1),
        .data2(data2),
        .op(op),
        .dataOut(result),
        .zf(zf)
    );

    // Instancia del módulo RAM
    RAM ram_inst (
        .En(en),
        .dirR(dirW),
        .dataIn(result),
        .DS(ram_out)
    );

    // Decodificación de la instrucción de 17 bits
    always @(*) begin
        en = instruction[16];          // Bit 16: enable
        dir1 = instruction[15:12];     // Bits 15-12: dir1
        dir2 = instruction[11:8];      // Bits 11-8: dir2
        op = instruction[7:4];         // Bits 7-4: op
        dirW = instruction[3:0];       // Bits 3-0: dirW
    end

endmodule

`timescale 1ns/1ps
module Jericalla_tb;

    reg [16:0] instruction;  // Instrucción de 17 bits
    wire [31:0] ram_out;     // Salida de 32 bits (proveniente de la RAM)
    wire zf;                 // Salida del flag zf (proveniente de la ALU)

    // Instancia del módulo Jericalla
    Jericalla jericalla_inst (
        .instruction(instruction), // Conecta la instrucción
        .ram_out(ram_out),         // Conecta la salida de la RAM
        .zf(zf)                    // Conecta el flag zf
    );

    initial begin
		#100;
        	instruction = 17'b1_0100_0110_0000_0001; 
		#100;
		instruction = 17'b1_0100_0110_0001_0010;
		#100;
		instruction = 17'b1_0100_0110_0010_0011;
		#100;
		instruction = 17'b1_0100_0110_0110_0100;
		#100;
		instruction = 17'b1_0100_0110_0111_0101;
		#100;
		instruction = 17'b1_0100_0110_1100_0110;
        #100; // Espera un tiempo para que se procese
    end

endmodule

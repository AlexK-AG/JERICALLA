module ROM (
	input [3:0] dir1R2,
	input [3:0] dir2R2,
	output reg [31:0] data1,
	output reg [31:0] data2
);

reg [31:0]memRom[0:15];

module ROM_TB ();

	initial
	begin
		#100;
		$readmemb("datos.txt", memRom);
	end
endmodule

    always @(*) begin
        data1 = memRom[dir1R2]; 
        data2 = memRom[dir2R2]; 
    end
	
endmodule
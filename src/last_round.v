`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2021 01:42:03 PM
// Design Name: 
// Module Name: last_round
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module last_round(
    input clk,
    input data_active_in,
    output reg data_active_out,
    input [127:0] data_in,
    input [127:0] key_in,
    output [127:0] data_out
    );    
    
    wire [127:0] data_out_sbox;
    generate
        for (genvar i=0; i < 16; i = i + 1) begin : gen_blk
            sbox sbox_i (.data_in(data_in[i * 8  + 7 : i * 8]), .data_out(data_out_sbox[i*8+7:i*8]));
        end
    endgenerate
    
    
    
    reg [127:0] data_out_shift;
    wire [127:0] data_out_shift_prereg;
        shift_rows shift_rows_1 (.data_in(data_out_sbox), .data_out(data_out_shift_prereg));
        
    wire [127:0] data_out_prereg;
    
    assign data_out_prereg = data_out_shift ^ key_in;
        
    reg [127:0] data_out_reg;
    always @(posedge clk)
    begin
	data_out_shift <= data_out_shift_prereg;
        data_out_reg <= data_out_prereg;
        
    end
    
    
    reg tmp_data_active;
    always @(posedge clk) begin
	    tmp_data_active <= data_active_in;
	    data_active_out <= tmp_data_active;
    end
   
    assign data_out = data_out_reg;

endmodule

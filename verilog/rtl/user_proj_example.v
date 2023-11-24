// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

module user_proj_example (
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    //input wb_rst_i,
 //   input wbs_stb_i,
   // input wbs_cyc_i,
   // input wbs_we_i,
//    input [3:0] wbs_sel_i,
 //   input [31:0] wbs_dat_i,
//    input [31:0] wbs_adr_i,
  //  output wbs_ack_o,
 //   output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
//    input  [127:0] la_data_in,
 //   output [127:0] la_data_out,
 //   input  [127:0] la_oenb,

    // IOs
    input  [22:0] io_in,
    output [11:0] io_out
 //   output [BITS-1:0] io_oeb,

    // IRQ
   // output [2:0] irq
);
    

wire [10:0]product;
wire done;

pes_fpmul u1(.clk(wb_clk_i),.in_ready(io_in[22]),.a(io_in[21:11]),.b(io_in[10:0]),.product(io_out[11:1]),.done(io_out[0]));
assign io_out={product,done};
endmodule
module pes_fpmul(
input clk,in_ready,
input [10:0] a,b,
output  reg [10:0]product,
output reg done
);

reg sign_a,sign_b,sign_p;
reg [5:0] exp_a,exp_b,exp_p;
reg [3:0] man_a,man_b,man_p;
reg [5:0] temp_expa,temp_expb,temp_expp;
reg [4:0] temp_mana,temp_manb;
reg [9:0]temp_manp;

always@(posedge clk) begin
if(a==0||b==0)begin
product=0;
done=1'b1;
end
else begin
if(in_ready)begin
{sign_a,exp_a,man_a}<=a;
{sign_b,exp_b,man_b}<=b;
temp_mana<={1'b1,man_a};
temp_manb<={1'b1,man_b};
temp_expa<=exp_a-6'd31;
temp_expb<=exp_b-6'd31;

sign_p<=sign_a^sign_b;
temp_expp <= temp_expa+temp_expb;
temp_manp <= temp_mana*temp_manb;
if(temp_manp[9]) begin
man_p<=temp_manp[8:5];
exp_p<=temp_expp+6'd32;
product<={sign_p,exp_p,man_p};
done<=1'b1;
end
else if(temp_manp[9]==0)begin
man_p<=temp_manp[7:4];
exp_p<=temp_expp+6'd31;
product<={sign_p,exp_p,man_p};
done<=1'b1;
end
end
end
end
endmodule
`default_nettype wire

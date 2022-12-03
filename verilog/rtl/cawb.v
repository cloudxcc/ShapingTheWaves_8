//
// Copyright 2022 Tobias Strauch, Munich, Bavaria
//
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
//
// Design includes
//    Whishbone logic and
//    Calendar design
//

module cawb (
`ifdef USE_POWER_PINS
   inout vccd1,	// User area 1 1.8V supply
   inout vssd1,	// User area 1 digital ground
`endif
   input wb_clk_i,
   input wb_rst_i,
   input wbs_stb_i,
   input wbs_cyc_i,
   input wbs_we_i,
   input [3:0] wbs_sel_i,
   input [31:0] wbs_dat_i,
   input [31:0] wbs_adr_i,
   output wbs_ack_o,
   output [31:0] wbs_dat_o,

   input [127:0] la_data_in,
   output [127:0] la_data_out,
   input  [127:0] la_oenb,
   output [2:0] irq,

   output rstn_reg,
      
   output cubev_pli_clk0,
   output cubev_pli_csb0,
   output cubev_pli_web0,
   output [3:0] cubev_pli_wmask0,
   output [7:0] cubev_pli_addr0,
   output [31:0] cubev_pli_din0,
   input [31:0] cubev_pli_dout0,

   output cubev_phi_clk0,
   output cubev_phi_csb0,
   output cubev_phi_web0,
   output [3:0] cubev_phi_wmask0,
   output [7:0] cubev_phi_addr0,
   output [31:0] cubev_phi_din0,
   input [31:0] cubev_phi_dout0,

   input ca_dbus_valid,
   output ca_dbus_ack,
   input ca_dbus_com,
   input [2:0] ca_dbus_tid,
   input [31:0] ca_dbus_data,
   output ca_time_valid,
   input ca_time_ack,
   output [22:0] ca_time_data,
   output ca_match_valid,
   input ca_match_ack,
   output [31:0] ca_command,

   output cubev_ca_clk0,
   output cubev_ca_csb0,
   output cubev_ca_web0,
   output [3:0] cubev_ca_wmask0,
   output [7:0] cubev_ca_addr0,
   output [31:0] cubev_ca_din0,
   input [31:0] cubev_ca_dout0,
   output cubev_ca_clk1,
   output cubev_ca_csb1,
   output [7:0] cubev_ca_addr1,
   input [31:0] cubev_ca_dout1);



assign cubev_ca_clk0 = wb_clk_i;
assign cubev_ca_csb0 = 1'b0;
assign cubev_ca_wmask0 = 4'hf;
assign cubev_ca_clk1 = wb_clk_i;
assign cubev_ca_csb1 = 1'b0;


assign cubev_pli_clk0 = wb_clk_i;
assign cubev_pli_csb0 = 1'b0;
assign cubev_pli_wmask0 = 4'hf;
assign cubev_pli_addr0 = prog_addra[8:1];
assign cubev_pli_din0 = prog_dina;

assign cubev_phi_clk0 = wb_clk_i;
assign cubev_phi_csb0 = 1'b0;
assign cubev_phi_wmask0 = 4'hf;
assign cubev_phi_addr0 = prog_addra[8:1];
assign cubev_phi_din0 = prog_dina;

///////////////////////////////////////////////////
// Program prog_l and ptog_h memory
///////////////////////////////////////////////////
reg prog_wea;
reg [10:0] prog_addra;
reg [31:0] prog_dina;
reg wbs_ack_o;
reg wbs_ack_int;
reg rstn_reg;

assign wbs_dat_o = cubev_pli_dout0 ^ cubev_phi_dout0;
assign irq = 0;
reg [127:0] la_data_out;

always @(negedge wb_clk_i) begin 
   la_data_out[ 31: 0] <= cubev_pli_dout0;
   la_data_out[ 63:32] <= cubev_phi_dout0;
   //la_data_out[ 71:64] <= cubev_pli_pcl[11:3];
   //la_data_out[ 79:72] <= cubev_phi_pch[11:3];
   la_data_out[    95] <= ca_match_valid;
   la_data_out[127:96] <= ca_command;     
end


assign cubev_phi_web0 = ~(prog_wea & prog_addra[0]);
assign cubev_pli_web0 = ~(prog_wea & !prog_addra[0]);

always @(negedge wb_clk_i or posedge wb_rst_i)
if (wb_rst_i) begin
   prog_wea <= 0;
   prog_addra <= 0;
   prog_dina <= 0;
   wbs_ack_o <= 0;
   rstn_reg <= 0;
end else begin
   prog_wea <= 0;
   wbs_ack_o <= wbs_ack_int & !wbs_ack_o;
   wbs_ack_int <= 0;
   if (la_data_in[64]) begin
      prog_wea <= 1'b1;
      prog_addra <= la_data_in[42:32];
      prog_dina <= la_data_in[31:0];
   end else
   if (la_data_in[65]) begin
      rstn_reg <= 1'b1;
   end else
   if (wbs_cyc_i && wbs_stb_i) begin
      if (wbs_adr_i[31:16] == 16'h3000) begin
         if (wbs_we_i) begin
            prog_wea <= ~wbs_ack_int;
            prog_addra <= wbs_adr_i[12:2];
            prog_dina <= wbs_dat_i;
         end
         if (wbs_adr_i[11:0] == 12'h7FC)
            rstn_reg <= 1'b1;
      end
   end
end                       

assign prog_h_addr0 = prog_addra;
assign prog_l_addr0 = prog_addra;
assign prog_h_din = prog_dina;
assign prog_l_din = prog_dina;

///////////////////////////////////////////////////
// Negative edge registers to overcome potential
// hold time violations for the external Calendar
// memory.
///////////////////////////////////////////////////
reg cubev_ca_web0;
reg [7:0] cubev_ca_addr0;
reg [31:0] cubev_ca_din0;
reg [7:0] cubev_ca_addr1;

wire cubev_ca_wea_int;
wire [8:0] cubev_ca_addra_int;
wire [31:0] cubev_ca_dina_int;
wire [8:0] cubev_ca_addrb_int;

always @(negedge wb_clk_i or posedge wb_rst_i)
if (wb_rst_i) begin
   cubev_ca_web0 <= 0;
   cubev_ca_addr0 <= 0;
   cubev_ca_din0 <= 0;
   cubev_ca_addr1 <= 0;
end else begin
   cubev_ca_web0 <= cubev_ca_wea_int;
   cubev_ca_addr0 <= cubev_ca_addra_int[7:0];
   cubev_ca_din0 <= cubev_ca_dina_int;
   cubev_ca_addr1 <= cubev_ca_addrb_int[7:0];
end                       

///////////////////////////////////////////////////
// Instantiation of the Calendar design
///////////////////////////////////////////////////
ca i_ca (.clk_const(wb_clk_i),
         .rstn(rstn_reg),
         .test_overflow(1'b0),

         .ca_dbus_valid(ca_dbus_valid),
         .ca_dbus_ack(ca_dbus_ack),
         .ca_dbus_com(ca_dbus_com),
         .ca_dbus_tid(ca_dbus_tid),
         .ca_dbus_data(ca_dbus_data),
         .ca_time_valid(ca_time_valid),
         .ca_time_ack(ca_time_ack),
         .ca_time_data(ca_time_data),
         .ca_match_valid(ca_match_valid),
         .ca_match_ack(ca_match_ack),
         .ca_command(ca_command),
         .cubev_ca_wea(cubev_ca_wea_int),
         .cubev_ca_addra(cubev_ca_addra_int),
         .cubev_ca_dina(cubev_ca_dina_int),
         .cubev_ca_douta(cubev_ca_dout0),
         .cubev_ca_addrb(cubev_ca_addrb_int),
         .cubev_ca_doutb(cubev_ca_dout1));
         
endmodule

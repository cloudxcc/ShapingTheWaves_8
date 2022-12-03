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

//`default_nettype none


module minisoc #(
   parameter BITS = 32
)(
`ifdef USE_POWER_PINS
   inout vccd1,	// User area 1 1.8V supply
   inout vssd1,	// User area 1 digital ground
`endif

   // IOs
   //input  [`MPRJ_IO_PADS-1:0] io_in,
   //output [`MPRJ_IO_PADS-1:0] io_out,
   //output [`MPRJ_IO_PADS-1:0] io_oeb,
   input  [38-1:0] io_in,
   output [38-1:0] io_out,
   output [38-1:0] io_oeb, 
   
   input rstn_reg,

   output ca_dbus_valid,
   input ca_dbus_ack,
   output ca_dbus_com,
   output [2:0] ca_dbus_tid,
   output [31:0] ca_dbus_data,
   input ca_time_valid,
   output ca_time_ack,
   input [22:0] ca_time_data,
   input ca_match_valid,
   output ca_match_ack,
   input [31:0] ca_command,

   output cubev_pli_rstn,
   output cubev_pli_clk1,
   output cubev_pli_csb1,
   output [7:0] cubev_pli_addr1,
   input [31:0] cubev_pli_dout1,

   output cubev_phi_rstn,
   output cubev_phi_clk1,
   output cubev_phi_csb1,
   output [7:0] cubev_phi_addr1,
   input [31:0] cubev_phi_dout1,
                
   output cubev_dli_rstn,
   output cubev_dli_clk0,
   output cubev_dli_csb0,
   output cubev_dli_web0,
   output [3:0] cubev_dli_wmask0,
   output [7:0] cubev_dli_addr0,
   output [31:0] cubev_dli_din0,
   input [31:0] cubev_dli_dout0,
   output cubev_dli_clk1,
   output cubev_dli_csb1,
   output [7:0] cubev_dli_addr1,
   input [31:0] cubev_dli_dout1,

   output cubev_dhi_rstn,
   output cubev_dhi_clk0,
   output cubev_dhi_csb0,
   output cubev_dhi_web0,
   output [3:0] cubev_dhi_wmask0,
   output [7:0] cubev_dhi_addr0,
   output [31:0] cubev_dhi_din0,
   input [31:0] cubev_dhi_dout0,
   output cubev_dhi_clk1,
   output cubev_dhi_csb1,
   output [7:0] cubev_dhi_addr1,
   input [31:0] cubev_dhi_dout1,
                
   output cubev_rf1_rstn,
   output cubev_rf1_clk0,
   output cubev_rf1_csb0,
   output cubev_rf1_web0,
   output [3:0] cubev_rf1_wmask0,
   output [7:0] cubev_rf1_addr0,
   output [31:0] cubev_rf1_din0,
   input [31:0] cubev_rf1_dout0,
   output cubev_rf1_clk1,
   output cubev_rf1_csb1,
   output [7:0] cubev_rf1_addr1,
   input [31:0] cubev_rf1_dout1,
                
   output cubev_rf2_rstn,
   output cubev_rf2_clk0,
   output cubev_rf2_csb0,
   output cubev_rf2_web0,
   output [3:0] cubev_rf2_wmask0,
   output [7:0] cubev_rf2_addr0,
   output [31:0] cubev_rf2_din0,
   input [31:0] cubev_rf2_dout0,
   output cubev_rf2_clk1,
   output cubev_rf2_csb1,
   output [7:0] cubev_rf2_addr1,
   input [31:0] cubev_rf2_dout1,
                
   output cubev_reg_0_rstn,
   output cubev_reg_0_clk0,
   output cubev_reg_0_csb0,
   output cubev_reg_0_web0,
   output [3:0] cubev_reg_0_wmask0,
   output [7:0] cubev_reg_0_addr0,
   output [31:0] cubev_reg_0_din0,
   input [31:0] cubev_reg_0_dout0,
   output cubev_reg_0_clk1,
   output cubev_reg_0_csb1,
   output [7:0] cubev_reg_0_addr1,
   input [31:0] cubev_reg_0_dout1,
                
   output cubev_reg_1_rstn,
   output cubev_reg_1_clk0,
   output cubev_reg_1_csb0,
   output cubev_reg_1_web0,
   output [3:0] cubev_reg_1_wmask0,
   output [7:0] cubev_reg_1_addr0,
   output [31:0] cubev_reg_1_din0,
   input [31:0] cubev_reg_1_dout0,
   output cubev_reg_1_clk1,
   output cubev_reg_1_csb1,
   output [7:0] cubev_reg_1_addr1,
   input [31:0] cubev_reg_1_dout1,
                
   output cubev_reg_2_rstn,
   output cubev_reg_2_clk0,
   output cubev_reg_2_csb0,
   output cubev_reg_2_web0,
   output [3:0] cubev_reg_2_wmask0,
   output [7:0] cubev_reg_2_addr0,
   output [31:0] cubev_reg_2_din0,
   input [31:0] cubev_reg_2_dout0,
   output cubev_reg_2_clk1,
   output cubev_reg_2_csb1,
   output [7:0] cubev_reg_2_addr1,
   input [31:0] cubev_reg_2_dout1,
                
   output cubev_reg_3_rstn,
   output cubev_reg_3_clk0,
   output cubev_reg_3_csb0,
   output cubev_reg_3_web0,
   output [3:0] cubev_reg_3_wmask0,
   output [7:0] cubev_reg_3_addr0,
   output [31:0] cubev_reg_3_din0,
   input [31:0] cubev_reg_3_dout0,
   output cubev_reg_3_clk1,
   output cubev_reg_3_csb1,
   output [7:0] cubev_reg_3_addr1,
   input [31:0] cubev_reg_3_dout1,
                
   output cubev_reg_4_rstn,
   output cubev_reg_4_clk0,
   output cubev_reg_4_csb0,
   output cubev_reg_4_web0,
   output [3:0] cubev_reg_4_wmask0,
   output [7:0] cubev_reg_4_addr0,
   output [31:0] cubev_reg_4_din0,
   input [31:0] cubev_reg_4_dout0,
   output cubev_reg_4_clk1,
   output cubev_reg_4_csb1,
   output [7:0] cubev_reg_4_addr1,
   input [31:0] cubev_reg_4_dout1,
                
   output cubev_reg_5_rstn,
   output cubev_reg_5_clk0,
   output cubev_reg_5_csb0,
   output cubev_reg_5_web0,
   output [3:0] cubev_reg_5_wmask0,
   output [7:0] cubev_reg_5_addr0,
   output [31:0] cubev_reg_5_din0,
   input [31:0] cubev_reg_5_dout0,
   output cubev_reg_5_clk1,
   output cubev_reg_5_csb1,
   output [7:0] cubev_reg_5_addr1,
   input [31:0] cubev_reg_5_dout1);

wire clk_root;


//reg rstn;
//always @(posedge clk_root) //or posedge wb_rst_i)
//if (wb_rst_i)
//   rstn <= 1'b0;
//else
//   rstn <= rstn_reg;
wire rstn = rstn_reg;

////////////////////////////////////////////////////////////////////
// wave_cnt is static and only relevant for internal clock domain. 
// Nevertheless, I want to propagate it to the internal logic
// by a register chain. By using wb_clk_i I generate unconstraint paths
// (which is what I want).
////////////////////////////////////////////////////////////////////
reg [1:0] wave_cnt_cap;
always @(posedge clk_root or negedge rstn_reg)
if (~rstn_reg)
   wave_cnt_cap <= 2'b00;
else
   wave_cnt_cap <= io_in[35:34];

/*
reg [1:0] wave_cnt_wb_clk_i;
always @(posedge clk_root or posedge rstn_reg)
if (~rstn_reg)
   wave_cnt_wb_clk_i <= 1'b0;
else
   wave_cnt_wb_clk_i <= wave_cnt_cap;
*/

wire clk_debug;
wire clk_debug_n;
assign io_out[35] = clk_debug;
assign io_out[36] = clk_debug_n;

reg wr_clk_sel = 1'b0;
reg wr_conf = 1'b0;

always @(*) begin 
case (cubev_reg_5_dout1[28]) 
   1'b1 : wr_clk_sel <= 1'b1;
   1'b0 : wr_clk_sel <= 1'b0;
   default : wr_clk_sel <= 1'b0;
endcase
case (cubev_reg_5_dout1[27]) 
   1'b1 : wr_conf <= 1'b1;
   1'b0 : wr_conf <= 1'b0;
   default : wr_conf <= 1'b0;
endcase
end

clock_gen i_cg ( .clk_in(io_in[32]),
                 .resetn(rstn_reg),
                 .wr_clk_sel(wr_clk_sel & rstn),
                 .wr_conf(wr_conf & rstn),
                 //.wr_dbg(wr_clk_dbg),
                 //.cubev_dli_din0(cubev_dli_din0),
                 //.cubev_dhi_din0(cubev_dhi_din0),
                 .ext_run_en(io_in[33]),
                 .clk_root(clk_root),
                 .clk_debug(clk_debug),
                 .clk_debug_n(clk_debug_n));

// prog routing
/*wire prog_h_clk;
wire prog_l_clk;
wire prog_h_wen;
wire prog_l_wen;
wire [10:0] prog_h_addr0;
wire [10:0] prog_l_addr0;
wire [31:0] prog_h_din;
wire [31:0] prog_l_din;
*/
//wire [31:0] prog_h_dout;
//wire [31:0] prog_l_dout;

// minisoc routing
//wire cubev_pli_clk;
//wire cubev_phi_clk;
wire [13:0] cubev_pli_pcl;
wire [13:0] cubev_phi_pch;
//wire [31:0] instrl;
//wire [31:0] instrh;
//reg [31:0] cubev_pli_instrl_reg;
//reg [31:0] cubev_phi_instrh_reg;

assign cubev_pli_rstn = rstn;
assign cubev_pli_clk1 = clk_root; 
assign cubev_pli_csb1 = 1'b0;
assign cubev_pli_addr1 = cubev_pli_pcl[11:3];

assign cubev_phi_rstn = rstn;
assign cubev_phi_clk1 = clk_root;
assign cubev_phi_csb1 = 1'b0;
assign cubev_phi_addr1 = cubev_phi_pch[11:3];

assign cubev_dli_rstn = rstn;
assign cubev_dli_clk0 = clk_root;
assign cubev_dli_csb0 = 1'b0;
assign cubev_dli_clk1 = clk_root;
assign cubev_dli_csb1 = 1'b0;
assign cubev_dli_addr1 = cubev_dli_addr0;

assign cubev_dhi_rstn = rstn;
assign cubev_dhi_clk0 = clk_root;
assign cubev_dhi_csb0 = 1'b0;
assign cubev_dhi_clk1 = clk_root;
assign cubev_dhi_csb1 = 1'b0;
assign cubev_dhi_addr1 = cubev_dhi_addr0;

assign cubev_rf1_rstn = rstn;
assign cubev_rf1_clk0 = clk_root;
assign cubev_rf1_wmask0 = 4'hf;
assign cubev_rf1_clk1 = clk_root;
assign cubev_rf1_csb1 = 1'b0;

assign cubev_rf2_rstn = rstn;
assign cubev_rf2_clk0 = clk_root;
assign cubev_rf2_wmask0 = 4'hf;
assign cubev_rf2_clk1 = clk_root;
assign cubev_rf2_csb1 = 1'b0;

///////////////////////////////////////////////////
// REG 0
///////////////////////////////////////////////////
assign cubev_reg_0_rstn = rstn;
assign cubev_reg_0_clk0 = clk_root;
assign cubev_reg_0_web0 = cubev_reg_0_csb0;
assign cubev_reg_0_wmask0 = 4'hf;
assign cubev_reg_0_addr0 = {5'h00, cubev_reg_0_tidwr};
assign cubev_reg_0_clk1 = clk_root;
assign cubev_reg_0_csb1 = 1'b0;
assign cubev_reg_0_addr1 = {5'h00, cubev_reg_0_tidrd0};

///////////////////////////////////////////////////
// REG 1
///////////////////////////////////////////////////
assign cubev_reg_1_rstn = rstn;
assign cubev_reg_1_clk0 = clk_root;
assign cubev_reg_1_web0 = cubev_reg_1_csb0;
assign cubev_reg_1_wmask0 = 4'hf;
assign cubev_reg_1_addr0 = {5'h00, cubev_reg_1_tidwr};
assign cubev_reg_1_clk1 = clk_root;
assign cubev_reg_1_csb1 = 1'b0;
assign cubev_reg_1_addr1 = {5'h00, cubev_reg_1_tidrd0};

///////////////////////////////////////////////////
// REG 2
///////////////////////////////////////////////////
assign cubev_reg_2_rstn = rstn;
assign cubev_reg_2_clk0 = clk_root;
assign cubev_reg_2_web0 = cubev_reg_2_csb0;
assign cubev_reg_2_wmask0 = 4'hf;
assign cubev_reg_2_addr0 = {5'h00, cubev_reg_2_tidwr};
assign cubev_reg_2_clk1 = clk_root;
assign cubev_reg_2_csb1 = 1'b0;
assign cubev_reg_2_addr1 = {5'h00, cubev_reg_2_tidrd0};

///////////////////////////////////////////////////
// REG 3
///////////////////////////////////////////////////
assign cubev_reg_3_rstn = rstn;
assign cubev_reg_3_clk0 = clk_root;
assign cubev_reg_3_web0 = cubev_reg_3_csb0;
assign cubev_reg_3_wmask0 = 4'hf;
assign cubev_reg_3_addr0 = {5'h00, cubev_reg_3_tidwr};
assign cubev_reg_3_clk1 = clk_root;
assign cubev_reg_3_csb1 = 1'b0;
assign cubev_reg_3_addr1 = {5'h00, cubev_reg_3_tidrd0};

///////////////////////////////////////////////////
// REG 4
///////////////////////////////////////////////////
assign cubev_reg_4_rstn = rstn;
assign cubev_reg_4_clk0 = clk_root;
assign cubev_reg_4_web0 = cubev_reg_4_csb0;
assign cubev_reg_4_wmask0 = 4'hf;
assign cubev_reg_4_addr0 = {5'h00, cubev_reg_4_tidwr};
assign cubev_reg_4_clk1 = clk_root;
assign cubev_reg_4_csb1 = 1'b0;
assign cubev_reg_4_addr1 = {5'h00, cubev_reg_4_tidrd0};

///////////////////////////////////////////////////
// REG 5
///////////////////////////////////////////////////
assign cubev_reg_5_rstn = rstn;
assign cubev_reg_5_clk0 = clk_root;
assign cubev_reg_5_web0 = cubev_reg_5_csb0;
assign cubev_reg_5_wmask0 = 4'hf;
assign cubev_reg_5_addr0 = {5'h00, cubev_reg_5_tidwr};
assign cubev_reg_5_clk1 = clk_root;
assign cubev_reg_5_csb1 = 1'b0;
assign cubev_reg_5_addr1 = {5'h00, cubev_reg_5_tidrd0};

//////////////////////////////////////
// Data high memory
//////////////////////////////////////
/*
wire cubev_dhi_clk0;
wire cubev_dhi_csb0;
wire cubev_dhi_web0;
wire [3:0] cubev_dhi_wmask0;
wire [7:0] cubev_dhi_addr0;
wire [31:0] cubev_dhi_din0;
wire [31:0] cubev_dhi_dout0;
wire cubev_dhi_clk1;
wire cubev_dhi_csb1;
wire [7:0] cubev_dhi_addr1;
wire [31:0] cubev_dhi_dout1;
*/
                
//wire [31:0] dbus_rdwr_add; 

/*
wire ca_dbus_valid;
wire ca_dbus_ack;
wire ca_dbus_com;
wire [2:0] ca_dbus_tid;
wire [31:0] ca_dbus_data;
wire ca_time_valid;
wire ca_time_ack;
wire [22:0] ca_time_data;
wire ca_match_valid;
wire ca_match_ack;
wire [31:0] ca_command; 
*/
/*
cawb cai (
   .wb_clk_i(wb_clk_i),
   .rstn(~wb_rst_i),
   .wb_rst_i(wb_rst_i),
   .wbs_ack_o(wbs_ack_o),
   .wbs_cyc_i(wbs_cyc_i),
   .wbs_stb_i(wbs_stb_i),
   .wbs_we_i(wbs_we_i),
   .wbs_adr_i(wbs_adr_i),
   .wbs_dat_i(wbs_dat_i),
   .la_data_in(la_data_in),
   
   .rstn_reg(rstn_reg),
   
   .cubev_pli_clk0(cubev_pli_clk0),
   .cubev_pli_csb0(cubev_pli_csb0),
   .cubev_pli_web0(cubev_pli_web0),
   .cubev_pli_wmask0(cubev_pli_wmask0),
   .cubev_pli_addr0(cubev_pli_addr0),
   .cubev_pli_din0(cubev_pli_din0),
   .cubev_pli_dout0(cubev_pli_dout0),
   
   .cubev_phi_clk0(cubev_phi_clk0),
   .cubev_phi_csb0(cubev_phi_csb0),
   .cubev_phi_web0(cubev_phi_web0),
   .cubev_phi_wmask0(cubev_phi_wmask0),
   .cubev_phi_addr0(cubev_phi_addr0),
   .cubev_phi_din0(cubev_phi_din0),
   .cubev_phi_dout0(cubev_phi_dout0),

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

   .cubev_ca_clk0(cubev_ca_clk0),
   .cubev_ca_csb0(cubev_ca_csb0),
   .cubev_ca_web0(cubev_ca_web0),
   .cubev_ca_wmask0(cubev_ca_wmask0),
   .cubev_ca_addr0(cubev_ca_addr0),
   .cubev_ca_din0(cubev_ca_din0),
   .cubev_ca_dout0(cubev_ca_dout0),
   .cubev_ca_clk1(cubev_ca_clk1),
   .cubev_ca_csb1(cubev_ca_csb1),
   .cubev_ca_addr1(cubev_ca_addr1),
   .cubev_ca_dout1(cubev_ca_dout1));
*/

///////////////////////////////////////////////////
// RF1
///////////////////////////////////////////////////
wire cubev_rf1_clk;
wire cubev_rf1_cs;
wire cubev_rf1_we;
wire [7:0] cubev_rf1_wr_add;
wire [31:0] cubev_rf1_din;
wire [7:0] cubev_rf1_rd_add;
wire [31:0] cubev_rf1_dout;
//reg [31:0] cubev_rf1_dout_reg;

///////////////////////////////////////////////////
// RF2
///////////////////////////////////////////////////
wire cubev_rf2_clk;
wire cubev_rf2_cs;
wire cubev_rf2_we;
wire [7:0] cubev_rf2_wr_add;
wire [31:0] cubev_rf2_din;
wire [7:0] cubev_rf2_rd_add;
wire [31:0] cubev_rf2_dout;
//reg [31:0] cubev_rf2_dout_reg;

///////////////////////////////////////////////////
// Reg Model
///////////////////////////////////////////////////
/*
wire [31:0] cubev_reg_0_din;
wire [31:0] cubev_reg_1_din;
wire [31:0] cubev_reg_2_din;
wire [31:0] cubev_reg_3_din;
wire [31:0] cubev_reg_4_din;
wire [31:0] cubev_reg_5_din;
wire [31:0] cubev_reg_0_dout;
wire [31:0] cubev_reg_1_dout;
wire [31:0] cubev_reg_2_dout;
wire [31:0] cubev_reg_3_dout;
wire [31:0] cubev_reg_4_dout;
wire [31:0] cubev_reg_5_dout;
*/
//reg [31:0] cubev_reg_0_dout_reg;
//reg [31:0] cubev_reg_1_dout_reg;
//reg [31:0] cubev_reg_2_dout_reg;
//reg [31:0] cubev_reg_3_dout_reg;
//reg [31:0] cubev_reg_4_dout_reg;
//reg [31:0] cubev_reg_5_dout_reg;

/*
wire cubev_dhi_web0;
wire [3:0] cubev_dhi_wmask0;
wire [7:0] cubev_dhi_addr;
wire [31:0] cubev_dhi_din0; 
wire [31:0] cubev_dhi_dout1;

wire cubev_dli_web0;
wire [3:0] cubev_dli_wmask0;
wire [7:0] cubev_dli_addr;
wire [31:0] cubev_dli_din0; 
wire [31:0] cubev_dli_dout1; 
*/

wire cubev_reg_0_clk;
wire cubev_reg_0_cs;
wire [2:0] cubev_reg_0_tidwr;
wire [2:0] cubev_reg_0_tidrd0;
wire cubev_reg_1_clk;
wire cubev_reg_1_cs;
wire [2:0] cubev_reg_1_tidwr;
wire [2:0] cubev_reg_1_tidrd0;
wire cubev_reg_2_clk;
wire cubev_reg_2_cs;
wire [2:0] cubev_reg_2_tidwr;
wire [2:0] cubev_reg_2_tidrd0;
wire cubev_reg_3_clk;
wire cubev_reg_3_cs;
wire [2:0] cubev_reg_3_tidwr;
wire [2:0] cubev_reg_3_tidrd0;
wire cubev_reg_4_clk;
wire cubev_reg_4_cs;
wire [2:0] cubev_reg_4_tidwr;
wire [2:0] cubev_reg_4_tidrd0;
wire cubev_reg_5_clk;
wire cubev_reg_5_cs;
wire [2:0] cubev_reg_5_tidwr;
wire [2:0] cubev_reg_5_tidrd0;

wavesync wsi ( .clk_root(clk_root),
               .rstn(rstn),
               .wave_cnt(wave_cnt_cap), 
               .gpio_out(io_out[35:0]),
               .gpio_in(io_in[37:0]),
               .gpio_oeb(io_oeb[37:0]),
                            
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
               
               //.cubev_pli_clk(cubev_pli_clk),
               //.cubev_phi_clk(cubev_phi_clk),
               .cubev_pli_pcl(cubev_pli_pcl),
               .cubev_phi_pch(cubev_phi_pch),
               .cubev_pli_instrl_reg(cubev_pli_dout1),
               .cubev_phi_instrh_reg(cubev_phi_dout1),
               
               //.cubev_dhi_clk(cubev_dhi_clk),
               .cubev_dhi_web0(cubev_dhi_web0),
               .cubev_dhi_wmask0(cubev_dhi_wmask0),
               .cubev_dhi_addr(cubev_dhi_addr0),
               .cubev_dhi_din0(cubev_dhi_din0),
               .cubev_dhi_dout1(cubev_dhi_dout1),
               
               //.cubev_dli_clk(cubev_dli_clk),
               .cubev_dli_web0(cubev_dli_web0),
               .cubev_dli_wmask0(cubev_dli_wmask0),
               .cubev_dli_addr(cubev_dli_addr0),
               .cubev_dli_din0(cubev_dli_din0),
               .cubev_dli_dout1(cubev_dli_dout1),
               
               .cubev_rf1_cs(cubev_rf1_csb0),
               .cubev_rf1_we(cubev_rf1_web0),
               .cubev_rf1_wr_add(cubev_rf1_addr0),
               .cubev_rf1_din(cubev_rf1_din0),
               .cubev_rf1_rd_add(cubev_rf1_addr1),
               .cubev_rf1_dout(cubev_rf1_dout1),
                            
               .cubev_rf2_cs(cubev_rf2_csb0),
               .cubev_rf2_we(cubev_rf2_web0),
               .cubev_rf2_wr_add(cubev_rf2_addr0),
               .cubev_rf2_din(cubev_rf2_din0),
               .cubev_rf2_rd_add(cubev_rf2_addr1),
               .cubev_rf2_dout(cubev_rf2_dout1),
               
               .cubev_reg_0_cs(cubev_reg_0_csb0),
               .cubev_reg_0_tidwr(cubev_reg_0_tidwr),
               .cubev_reg_0_din(cubev_reg_0_din0),
               .cubev_reg_0_tidrd0(cubev_reg_0_tidrd0),
               .cubev_reg_0_dout(cubev_reg_0_dout1),
               
               .cubev_reg_1_cs(cubev_reg_1_csb0),
               .cubev_reg_1_tidwr(cubev_reg_1_tidwr),
               .cubev_reg_1_din(cubev_reg_1_din0),
               .cubev_reg_1_tidrd0(cubev_reg_1_tidrd0),
               .cubev_reg_1_dout(cubev_reg_1_dout1),
               
               .cubev_reg_2_cs(cubev_reg_2_csb0),
               .cubev_reg_2_tidwr(cubev_reg_2_tidwr),
               .cubev_reg_2_din(cubev_reg_2_din0),
               .cubev_reg_2_tidrd0(cubev_reg_2_tidrd0),
               .cubev_reg_2_dout(cubev_reg_2_dout1),
               
               .cubev_reg_3_cs(cubev_reg_3_csb0),
               .cubev_reg_3_tidwr(cubev_reg_3_tidwr),
               .cubev_reg_3_din(cubev_reg_3_din0),
               .cubev_reg_3_tidrd0(cubev_reg_3_tidrd0),
               .cubev_reg_3_dout(cubev_reg_3_dout1),
               
               .cubev_reg_4_cs(cubev_reg_4_csb0),
               .cubev_reg_4_tidwr(cubev_reg_4_tidwr),
               .cubev_reg_4_din(cubev_reg_4_din0),
               .cubev_reg_4_tidrd0(cubev_reg_4_tidrd0),
               .cubev_reg_4_dout(cubev_reg_4_dout1),
               
               .cubev_reg_5_cs(cubev_reg_5_csb0),
               .cubev_reg_5_tidwr(cubev_reg_5_tidwr),
               .cubev_reg_5_din(cubev_reg_5_din0),
               .cubev_reg_5_tidrd0(cubev_reg_5_tidrd0),
               .cubev_reg_5_dout(cubev_reg_5_dout1));

///////////////////////////////////////////////////
// CA RAM
///////////////////////////////////////////////////
/*
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_cai (
  .clk0(cubev_ca_clk),
  .csb0(1'b0),
  .web0(cubev_ca_wea),
  .wmask0(4'hf),
  .addr0({2'b00, cubev_ca_addra[5:0]}),
  .din0(cubev_ca_dina),
  .dout0(cubev_ca_douta),
  .clk1(cubev_ca_clk),
  .csb1(1'b0),
  .addr1({2'b00, cubev_ca_addrb[5:0]}),
  .dout1(cubev_ca_doutb));
*/

///////////////////////////////////////////////////
// CUBE-V Prog L
///////////////////////////////////////////////////
/*
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_pli
     (
      .clk0   (prog_l_clk),
      .csb0   (1'b0),
      .web0   (prog_l_wen),
      .wmask0 (4'hf),
      .addr0  (prog_l_addr0[9:1]),
      .din0   (prog_l_din),
      .dout0  (prog_l_dout),
      .clk1   (cubev_pli_clk),
      .csb1   (1'b0),
      .addr1  (cubev_pli_pcl[11:3]),
      .dout1  (instrl)
      );
*/

//always @ (posedge cubev_pli_clk1)
//   cubev_pli_instrl_reg <= cubev_pli_dout1;

///////////////////////////////////////////////////
// CUBE-V Prog H
///////////////////////////////////////////////////

/*
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_phi 
     (
      .clk0   (prog_h_clk),
      .csb0   (1'b0),
      .web0   (prog_h_wen),
      .wmask0 (4'hf),
      .addr0  (prog_h_addr0[9:1]),
      .din0   (prog_h_din),
      .dout0  (prog_h_dout),
      .clk1   (cubev_phi_clk),
      .csb1   (1'b0),
      .addr1  (cubev_phi_pch[11:3]),
      .dout1  (instrh)
      );
*/

//always @ (posedge cubev_phi_clk1)
//   cubev_phi_instrh_reg <= cubev_phi_dout1;

///////////////////////////////////////////////////
// CUBE-V Dat H
///////////////////////////////////////////////////

//reg [31:0] cubev_dhi_dout1_reg;

/*
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_dhi
     (
      .clk0   (cubev_dhi_clk),
      .csb0   (1'b0),
      .web0   (cubev_dhi_web0),
      .wmask0 (cubev_dhi_wmask0),                     
      .addr0  (cubev_dhi_addr),
      .din0   (cubev_dhi_din0),
      .dout0  (),
      .clk1   (cubev_dhi_clk),
      .csb1   (1'b0),
      .addr1  (cubev_dhi_addr),
      .dout1  (cubev_dhi_dout1_int)
      );
*/
      
//always @ (posedge cubev_dhi_clk1)
//   cubev_dhi_dout1_reg <= cubev_dhi_dout1;

///////////////////////////////////////////////////
// CUBE-V Dat L
///////////////////////////////////////////////////

//reg [31:0] cubev_dli_dout1_reg;

/*
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_dli
     (
      .clk0   (cubev_dli_clk),
      .csb0   (1'b0),
      .web0   (cubev_dli_web0),
      .wmask0 (cubev_dli_wmask0),
      .addr0  (cubev_dli_addr),
      .din0   (cubev_dli_din0),
      .dout0  (),
      .clk1   (cubev_dli_clk),
      .csb1   (1'b0),
      .addr1  (cubev_dli_addr),
      .dout1  (cubev_dli_dout1_int)
      );
*/

//always @ (posedge cubev_dli_clk1)
//   cubev_dli_dout1_reg <= cubev_dli_dout1;

///////////////////////////////////////////////////
// RF1
///////////////////////////////////////////////////

/*
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_rf1i (
  .clk0(cubev_rf1_clk),
  .csb0(cubev_rf1_cs),
  .web0(cubev_rf1_we),
  .wmask0(4'hf),
  .addr0(cubev_rf1_wr_add),
  .din0(cubev_rf1_din),
  .dout0(),
  .clk1(cubev_rf1_clk),
  .csb1(1'b0),
  .addr1(cubev_rf1_rd_add),
  .dout1(cubev_rf1_dout));
*/

//always @ (posedge cubev_rf1_clk1)
//   cubev_rf1_dout_reg <= cubev_rf1_dout1;

///////////////////////////////////////////////////
// RF2
///////////////////////////////////////////////////

/*
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_rf2i (
  .clk0(cubev_rf2_clk),
  .csb0(cubev_rf2_cs),
  .web0(cubev_rf2_we),
  .wmask0(4'hf),
  .addr0(cubev_rf2_wr_add),
  .din0(cubev_rf2_din),
  .dout0(),
  .clk1(cubev_rf2_clk),
  .csb1(1'b0),
  .addr1(cubev_rf2_rd_add),
  .dout1(cubev_rf2_dout));
*/

//always @ (posedge cubev_rf2_clk1)
//   cubev_rf2_dout_reg <= cubev_rf2_dout1;

///////////////////////////////////////////////////
// Regs
///////////////////////////////////////////////////

/*
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_0 (
  .clk0(cubev_reg_0_clk),
  .csb0(cubev_reg_0_cs),
  .web0(cubev_reg_0_cs),
  .wmask0(4'hf),
  .addr0({5'h00, cubev_reg_0_tidwr}),
  .din0(cubev_reg_0_din),
  .dout0(),
  .clk1(cubev_reg_0_clk),
  .csb1(1'b0),
  .addr1({5'h00, cubev_reg_0_tidrd0}),
  .dout1(cubev_reg_0_dout));
*/

//always @ (posedge cubev_reg_0_clk1)
//   cubev_reg_0_dout_reg <= cubev_reg_0_dout1;

/*
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_1 (
  .clk0(cubev_reg_1_clk),
  .csb0(cubev_reg_1_cs),
  .web0(cubev_reg_1_cs),
  .wmask0(4'hf),
  .addr0({5'h00, cubev_reg_1_tidwr}),
  .din0(cubev_reg_1_din),
  .dout0(),
  .clk1(cubev_reg_1_clk),
  .csb1(1'b0),
  .addr1({5'h00, cubev_reg_1_tidrd0}),
  .dout1(cubev_reg_1_dout));
*/
  
//always @ (posedge cubev_reg_1_clk1)
//   cubev_reg_1_dout_reg <= cubev_reg_1_dout1;

/*
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_2 (
  .clk0(cubev_reg_2_clk),
  .csb0(cubev_reg_2_cs),
  .web0(cubev_reg_2_cs),
  .wmask0(4'hf),
  .addr0({5'h00, cubev_reg_2_tidwr}),
  .din0(cubev_reg_2_din),
  .dout0(),
  .clk1(cubev_reg_2_clk),
  .csb1(1'b0),
  .addr1({5'h00, cubev_reg_2_tidrd0}),
  .dout1(cubev_reg_2_dout));
*/
  
//always @ (posedge cubev_reg_2_clk1)
//   cubev_reg_2_dout_reg <= cubev_reg_2_dout1;

/*
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_3 (
  .clk0(cubev_reg_3_clk),
  .csb0(cubev_reg_3_cs),
  .web0(cubev_reg_3_cs),
  .wmask0(4'hf),
  .addr0({5'h00, cubev_reg_3_tidwr}),
  .din0(cubev_reg_3_din),
  .dout0(),
  .clk1(cubev_reg_3_clk),
  .csb1(1'b0),
  .addr1({5'h00, cubev_reg_3_tidrd0}),
  .dout1(cubev_reg_3_dout));
*/

//always @ (posedge cubev_reg_3_clk1)
//   cubev_reg_3_dout_reg <= cubev_reg_3_dout1;

/*
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_4 (
  .clk0(cubev_reg_4_clk),
  .csb0(cubev_reg_4_cs),
  .web0(cubev_reg_4_cs),
  .wmask0(4'hf),
  .addr0({5'h00, cubev_reg_4_tidwr}),
  .din0(cubev_reg_4_din),
  .dout0(),
  .clk1(cubev_reg_4_clk),
  .csb1(1'b0),
  .addr1({5'h00, cubev_reg_4_tidrd0}),
  .dout1(cubev_reg_4_dout));
*/
  
//always @ (posedge cubev_reg_4_clk1)
//   cubev_reg_4_dout_reg <= cubev_reg_4_dout1;

/*
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_5 (
  .clk0(cubev_reg_5_clk),
  .csb0(cubev_reg_5_cs),
  .web0(cubev_reg_5_cs),
  .wmask0(4'hf),
  .addr0({5'h00, cubev_reg_5_tidwr}),
  .din0(cubev_reg_5_din),
  .dout0(),
  .clk1(cubev_reg_5_clk),
  .csb1(1'b0),
  .addr1({5'h00, cubev_reg_5_tidrd0}),
  .dout1(cubev_reg_5_dout));
*/
  
//always @ (posedge cubev_reg_5_clk1)
//   cubev_reg_5_dout_reg <= cubev_reg_5_dout1;

endmodule


//`default_nettype wire

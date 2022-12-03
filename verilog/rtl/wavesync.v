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

module wavesync (clk_root,
                rstn,
                wave_cnt,
                wr_clk_sel,
                wr_clk_val,
                gpio_out,
                gpio_in,
                gpio_oeb,

                ca_dbus_valid,
                ca_dbus_ack,
                ca_dbus_com,
                ca_dbus_tid,
                ca_dbus_data,
                ca_time_valid,
                ca_time_ack,
                ca_time_data,
                ca_match_valid,
                ca_match_ack,
                ca_command,

                //cubev_phi_clk,
                //cubev_pli_clk,
                cubev_pli_pcl,
                cubev_phi_pch,
                cubev_pli_instrl_reg,
                cubev_phi_instrh_reg,
                
                //cubev_dhi_clk,
                cubev_dhi_web0,
                cubev_dhi_wmask0,
                cubev_dhi_addr,
                cubev_dhi_din0, 
                cubev_dhi_dout1, 
                
                //cubev_dli_clk,
                cubev_dli_web0,
                cubev_dli_wmask0,
                cubev_dli_addr,
                cubev_dli_din0, 
                cubev_dli_dout1, 

                //cubev_rf1_clk,
                cubev_rf1_cs,
                cubev_rf1_we,
                cubev_rf1_wr_add,
                cubev_rf1_din,
                cubev_rf1_rd_add,
                cubev_rf1_dout,
                
                //cubev_rf2_clk,
                cubev_rf2_cs,
                cubev_rf2_we,
                cubev_rf2_wr_add,
                cubev_rf2_din,
                cubev_rf2_rd_add,
                cubev_rf2_dout,
                
                //cubev_reg_0_clk,
                cubev_reg_0_cs,
                cubev_reg_0_tidwr,
                cubev_reg_0_din,
                cubev_reg_0_tidrd0,
                cubev_reg_0_dout,
                
                //cubev_reg_1_clk,
                cubev_reg_1_cs,
                cubev_reg_1_tidwr,
                cubev_reg_1_din,
                cubev_reg_1_tidrd0,
                cubev_reg_1_dout,
                
                //cubev_reg_2_clk,
                cubev_reg_2_cs,
                cubev_reg_2_tidwr,
                cubev_reg_2_din,
                cubev_reg_2_tidrd0,
                cubev_reg_2_dout,
                
                //cubev_reg_3_clk,
                cubev_reg_3_cs,
                cubev_reg_3_tidwr,
                cubev_reg_3_din,
                cubev_reg_3_tidrd0,
                cubev_reg_3_dout,
                
                //cubev_reg_4_clk,
                cubev_reg_4_cs,
                cubev_reg_4_tidwr,
                cubev_reg_4_din,
                cubev_reg_4_tidrd0,
                cubev_reg_4_dout,
                
                //cubev_reg_5_clk,
                cubev_reg_5_cs,
                cubev_reg_5_tidwr,
                cubev_reg_5_din,
                cubev_reg_5_tidrd0,
                cubev_reg_5_dout);

input clk_root;
input rstn;
input [1:0] wave_cnt;
output wr_clk_sel;
output wr_clk_val;

output [35:0] gpio_out;
input [37:0] gpio_in;
output [37:0] gpio_oeb;


output ca_dbus_valid;
input ca_dbus_ack;
output ca_dbus_com;
output [2:0] ca_dbus_tid;
output [31:0] ca_dbus_data;
input ca_time_valid;
output ca_time_ack;
input [22:0] ca_time_data;
input ca_match_valid;
output ca_match_ack;
input [31:0] ca_command;

//output cubev_phi_clk;
//output cubev_pli_clk;
output [13:0] cubev_pli_pcl;
output [13:0] cubev_phi_pch;
input [31:0] cubev_pli_instrl_reg;
input [31:0] cubev_phi_instrh_reg;

//output cubev_dhi_clk;
output cubev_dhi_web0; 
output [3:0] cubev_dhi_wmask0;
output [7:0] cubev_dhi_addr;
output [31:0] cubev_dhi_din0;
input [31:0] cubev_dhi_dout1;

//output cubev_dli_clk;
output cubev_dli_web0; 
output [3:0] cubev_dli_wmask0;
output [7:0] cubev_dli_addr;
output [31:0] cubev_dli_din0;
input [31:0] cubev_dli_dout1;
 

//output cubev_rf1_clk;
output cubev_rf1_cs;
output cubev_rf1_we;
output [7:0] cubev_rf1_wr_add;
output [31:0] cubev_rf1_din;
output [7:0] cubev_rf1_rd_add;
input  [31:0] cubev_rf1_dout;

//output cubev_rf2_clk;
output cubev_rf2_cs;
output cubev_rf2_we;
output [7:0] cubev_rf2_wr_add;
output [31:0] cubev_rf2_din;
output [7:0] cubev_rf2_rd_add;
input  [31:0] cubev_rf2_dout;

//output cubev_reg_0_clk;
output cubev_reg_0_cs;
output [2:0] cubev_reg_0_tidwr;
output [31:0] cubev_reg_0_din;
output [2:0] cubev_reg_0_tidrd0;
input [31:0] cubev_reg_0_dout;

//output cubev_reg_1_clk;
output cubev_reg_1_cs;
output [2:0] cubev_reg_1_tidwr;
output [31:0] cubev_reg_1_din;
output [2:0] cubev_reg_1_tidrd0;
input [31:0] cubev_reg_1_dout;

//output cubev_reg_2_clk;
output cubev_reg_2_cs;
output [2:0] cubev_reg_2_tidwr;
output [31:0] cubev_reg_2_din;
output [2:0] cubev_reg_2_tidrd0;
input [31:0] cubev_reg_2_dout;

//output cubev_reg_3_clk;
output cubev_reg_3_cs;
output [2:0] cubev_reg_3_tidwr;
output [31:0] cubev_reg_3_din;
output [2:0] cubev_reg_3_tidrd0;
input [31:0] cubev_reg_3_dout;

//output cubev_reg_4_clk;
output cubev_reg_4_cs;
output [2:0] cubev_reg_4_tidwr;
output [31:0] cubev_reg_4_din;
output [2:0] cubev_reg_4_tidrd0;
input [31:0] cubev_reg_4_dout;

//output cubev_reg_5_clk;
output cubev_reg_5_cs;
output [2:0] cubev_reg_5_tidwr;
output [31:0] cubev_reg_5_din;
output [2:0] cubev_reg_5_tidrd0;
input [31:0] cubev_reg_5_dout;

wire [1:0] wave_sim = 0; //wave_cnt;

reg wr_clk_sel;
reg wr_clk_val;
//wire wr_clk_dbg;
reg [63:0] dbus_wr_data_final; 
 
//assign cubev_phi_clk = clk_root;
//assign cubev_pli_clk = clk_root;
//assign cubev_dhi_clk = clk_root;
//assign cubev_dli_clk = clk_root;
//assign cubev_rf1_clk = clk_root;
//assign cubev_rf2_clk = clk_root;
//assign cubev_reg_0_clk = clk_root;
//assign cubev_reg_1_clk = clk_root;
//assign cubev_reg_2_clk = clk_root;
//assign cubev_reg_3_clk = clk_root;
//assign cubev_reg_4_clk = clk_root;
//assign cubev_reg_5_clk = clk_root;

reg [2:0] tidrd [7:0];
reg [2:0] tidwr;

wire [2:0] tidrd0 = tidrd[0];
wire [2:0] tidrd2 = tidrd[2];

assign cubev_reg_0_cs = ~(cubev_reg_cs); // & cubev_reg_din0_valid);
assign cubev_reg_0_tidwr = tidwr;
assign cubev_reg_0_tidrd0 = tidrd0;
assign cubev_reg_1_cs = ~(cubev_reg_cs); // & cubev_reg_din0_valid);
assign cubev_reg_1_tidwr = tidwr;
assign cubev_reg_1_tidrd0 = tidrd0;
assign cubev_reg_2_cs = ~(cubev_reg_cs); // & cubev_reg_din2_valid);
assign cubev_reg_2_tidwr = tidwr;
assign cubev_reg_2_tidrd0 = tidrd0;
assign cubev_reg_3_cs = ~(cubev_reg_cs); // & cubev_reg_din2_valid);
assign cubev_reg_3_tidwr = tidwr;
assign cubev_reg_3_tidrd0 = tidrd0;
assign cubev_reg_4_cs = ~cubev_reg_cs;
assign cubev_reg_4_tidwr = tidwr;
assign cubev_reg_4_tidrd0 = tidrd0;
assign cubev_reg_5_cs = ~cubev_reg_cs;
assign cubev_reg_5_tidwr = tidwr;
assign cubev_reg_5_tidrd0 = tidrd0;

reg [31:0] cubev_reg_0_dout_int;
reg [31:0] cubev_reg_1_dout_int;
reg [31:0] cubev_reg_2_dout_int;
reg [31:0] cubev_reg_3_dout_int;
reg [31:0] cubev_reg_4_dout_int;
reg [31:0] cubev_reg_5_dout_int;
reg [31:0] cubev_reg_0_dout_reg [2:0];
reg [31:0] cubev_reg_1_dout_reg [2:0];
reg [31:0] cubev_reg_2_dout_reg [2:0];
reg [31:0] cubev_reg_3_dout_reg [2:0];
reg [31:0] cubev_reg_4_dout_reg [2:0];
reg [31:0] cubev_reg_5_dout_reg [2:0];
reg [31:0] cubev_reg_0_dout_sim [1:0];
reg [31:0] cubev_reg_1_dout_sim [1:0];
reg [31:0] cubev_reg_2_dout_sim [1:0];
reg [31:0] cubev_reg_3_dout_sim [1:0];
reg [31:0] cubev_reg_4_dout_sim [1:0];
reg [31:0] cubev_reg_5_dout_sim [1:0];

always @ (posedge clk_root) begin
   for (i = 0; i < 2; i = i + 1) begin
      cubev_reg_0_dout_reg[i + 1] <= cubev_reg_0_dout_reg[i + 0];
      cubev_reg_1_dout_reg[i + 1] <= cubev_reg_1_dout_reg[i + 0];
      cubev_reg_2_dout_reg[i + 1] <= cubev_reg_2_dout_reg[i + 0];
      cubev_reg_3_dout_reg[i + 1] <= cubev_reg_3_dout_reg[i + 0];
      cubev_reg_4_dout_reg[i + 1] <= cubev_reg_4_dout_reg[i + 0];
      cubev_reg_5_dout_reg[i + 1] <= cubev_reg_5_dout_reg[i + 0];
   end
   cubev_reg_0_dout_reg[0] <= cubev_reg_0_dout;
   cubev_reg_1_dout_reg[0] <= cubev_reg_1_dout;
   cubev_reg_2_dout_reg[0] <= cubev_reg_2_dout;
   cubev_reg_3_dout_reg[0] <= cubev_reg_3_dout;
   cubev_reg_4_dout_reg[0] <= cubev_reg_4_dout;
   cubev_reg_5_dout_reg[0] <= cubev_reg_5_dout;
end

integer i;

always @ (posedge clk_root)
begin
   cubev_reg_0_dout_sim[1] <= cubev_reg_0_dout_sim[0];
   cubev_reg_1_dout_sim[1] <= cubev_reg_1_dout_sim[0];
   cubev_reg_2_dout_sim[1] <= cubev_reg_2_dout_sim[0];
   cubev_reg_3_dout_sim[1] <= cubev_reg_3_dout_sim[0];
   cubev_reg_4_dout_sim[1] <= cubev_reg_4_dout_sim[0];
   cubev_reg_5_dout_sim[1] <= cubev_reg_5_dout_sim[0];
   cubev_reg_0_dout_sim[0] <= cubev_reg_0_dout_reg[1];
   cubev_reg_1_dout_sim[0] <= cubev_reg_1_dout_reg[1];
   cubev_reg_2_dout_sim[0] <= cubev_reg_2_dout_reg[1];
   cubev_reg_3_dout_sim[0] <= cubev_reg_3_dout_reg[1];
   cubev_reg_4_dout_sim[0] <= cubev_reg_4_dout_reg[1];
   cubev_reg_5_dout_sim[0] <= cubev_reg_5_dout_reg[1];
end

always @ (*) 
case (wave_sim)
   2: begin
         cubev_reg_0_dout_int <= cubev_reg_0_dout_sim[1];
         cubev_reg_1_dout_int <= cubev_reg_1_dout_sim[1];
         cubev_reg_2_dout_int <= cubev_reg_2_dout_sim[1];
         cubev_reg_3_dout_int <= cubev_reg_3_dout_sim[1];
         cubev_reg_4_dout_int <= cubev_reg_4_dout_sim[1];
         cubev_reg_5_dout_int <= cubev_reg_5_dout_sim[1];
      end
   1: begin
         cubev_reg_0_dout_int <= cubev_reg_0_dout_sim[0];
         cubev_reg_1_dout_int <= cubev_reg_1_dout_sim[0];
         cubev_reg_2_dout_int <= cubev_reg_2_dout_sim[0];
         cubev_reg_3_dout_int <= cubev_reg_3_dout_sim[0];
         cubev_reg_4_dout_int <= cubev_reg_4_dout_sim[0];
         cubev_reg_5_dout_int <= cubev_reg_5_dout_sim[0];
      end
   0: begin
         cubev_reg_0_dout_int <= cubev_reg_0_dout_reg[1];
         cubev_reg_1_dout_int <= cubev_reg_1_dout_reg[1];
         cubev_reg_2_dout_int <= cubev_reg_2_dout_reg[1];
         cubev_reg_3_dout_int <= cubev_reg_3_dout_reg[1];
         cubev_reg_4_dout_int <= cubev_reg_4_dout_reg[1];
         cubev_reg_5_dout_int <= cubev_reg_5_dout_reg[1];
      end
   default : ;
endcase

reg [31:0] cubev_reg_0_dout_late;
reg [31:0] cubev_reg_1_dout_late;
reg [31:0] cubev_reg_2_dout_late;
reg [31:0] cubev_reg_3_dout_late;
reg [31:0] cubev_reg_4_dout_late;
reg [31:0] cubev_reg_5_dout_late;

always @ (posedge clk_root) begin
case (wave_cnt)
   2: begin
         cubev_reg_0_dout_late <= cubev_reg_0_dout_reg[2];
         cubev_reg_1_dout_late <= cubev_reg_1_dout_reg[2];
         cubev_reg_2_dout_late <= cubev_reg_2_dout_reg[2];
         cubev_reg_3_dout_late <= cubev_reg_3_dout_reg[2];
         cubev_reg_4_dout_late <= cubev_reg_4_dout_reg[2];
         cubev_reg_5_dout_late <= cubev_reg_5_dout_reg[2];
      end
   1: begin
         cubev_reg_0_dout_late <= cubev_reg_0_dout_reg[1];
         cubev_reg_1_dout_late <= cubev_reg_1_dout_reg[1];
         cubev_reg_2_dout_late <= cubev_reg_2_dout_reg[1];
         cubev_reg_3_dout_late <= cubev_reg_3_dout_reg[1];
         cubev_reg_4_dout_late <= cubev_reg_4_dout_reg[1];
         cubev_reg_5_dout_late <= cubev_reg_5_dout_reg[1];
      end
   default : begin
         cubev_reg_0_dout_late <= cubev_reg_0_dout_reg[0];
         cubev_reg_1_dout_late <= cubev_reg_1_dout_reg[0];
         cubev_reg_2_dout_late <= cubev_reg_2_dout_reg[0];
         cubev_reg_3_dout_late <= cubev_reg_3_dout_reg[0];
         cubev_reg_4_dout_late <= cubev_reg_4_dout_reg[0];
         cubev_reg_5_dout_late <= cubev_reg_5_dout_reg[0];
      end
   //default : ;
endcase
end

wire dbus_wr_en;
wire [31:0] dbus_rdwr_add; 

///////////////////////////////////////////////////////////
// CA time data handshake
///////////////////////////////////////////////////////////
reg [22:0] ca_time;
reg ca_time_ack;
reg hs_valid_meta;
reg [1:0] hs_state_flex;
 
always @ (posedge clk_root or negedge rstn)
if (~rstn) begin
   hs_state_flex <= 0;
   ca_time_ack <= 1;
   ca_time <= 0;
   hs_valid_meta <= 0;
end else begin
   case (hs_state_flex) 
   0: if (hs_valid_meta) begin // <---
         ca_time_ack <= 1'b0;
         hs_state_flex <= 1; // <---
      end
   1: begin
         hs_state_flex <= 2;
         ca_time <= ca_time_data;
      end
   2: if (!hs_valid_meta) begin // <---
         hs_state_flex <= 0; 
         ca_time_ack <= 1'b1;
      end
   endcase
   hs_valid_meta <= ca_time_valid;
end

///////////////////////////////////////////////////////////
// CA dbus handshake
///////////////////////////////////////////////////////////
wire ca_wr_com = wr_add_ca_com;
wire ca_wr_et  = wr_add_ca_et;

reg [1:0] ca_dbus_state_write;
reg ca_stalled_by_ca;

reg ca_dbus_ack_meta;
reg ca_dbus_valid_d;
reg ca_dbus_valid;
reg ca_dbus_com_d;
reg ca_dbus_com;
reg [2:0] ca_dbus_tid_d;
reg [2:0] ca_dbus_tid;
reg [31:0] ca_dbus_data_d;
reg [31:0] ca_dbus_data;

always @ (posedge clk_root or negedge rstn)
if (~rstn) begin
   ca_dbus_state_write <= 0;
   ca_stalled_by_ca <= 0;
   ca_dbus_ack_meta <= 0;
   ca_dbus_valid_d <= 0;
   ca_dbus_valid <= 0;
   ca_dbus_com_d <= 0;
   ca_dbus_com <= 0;
   ca_dbus_tid_d <= 0;
   ca_dbus_tid <= 0;
   ca_dbus_data_d <= 0;
   ca_dbus_data <= 0;
end else begin
   ca_dbus_valid <= ca_dbus_valid_d;
   ca_dbus_com <= ca_dbus_com_d;
   ca_dbus_tid <= ca_dbus_tid_d;
   ca_dbus_data <= ca_dbus_data_d;
   case (ca_dbus_state_write) 
   0: if (ca_wr_com | ca_wr_et) begin
         ca_dbus_state_write <= 1;
         ca_dbus_valid_d <= 1;
         ca_dbus_com_d <= ca_wr_com;
         ca_stalled_by_ca <= 1'b1;
         ca_dbus_tid_d <= tidrd2;
         ca_dbus_data_d <= dbus_wr_data;
      end
   1: if (ca_dbus_ack_meta) begin
         ca_dbus_state_write <= 2;
         ca_dbus_valid_d <= 0;
      end
   2: if (!ca_dbus_ack_meta) begin
         ca_stalled_by_ca <= 0;
         ca_dbus_state_write <= 0;
      end
   endcase 
   ca_dbus_ack_meta <= ca_dbus_ack;
end

///////////////////////////////////////////////////////////
// central thread handling 
///////////////////////////////////////////////////////////
parameter TC_START       = 18'h00000;
parameter TC_KILL        = 18'h00004;
parameter TC_SAK         = 18'h00008;
parameter CLK_SEL        = 18'h00010;
//parameter CLK_DBG        = 18'h00014;
parameter CLK_VAL        = 18'h00018;
parameter EXT_PATH       = 18'h00020;

wire kill = thread_pipe_valid_bus[2] & !pc_set[2] & cubev_reg_5_dout[31]; //dbus_wr_en & dbus_rdwr_add_per & (dbus_rdwr_add[17:0] == TC_KILL);
wire start = thread_pipe_valid_bus[2] & !pc_set[2] & cubev_reg_5_dout[30]; //dbus_wr_en & dbus_rdwr_add_per & (dbus_rdwr_add[17:0] == TC_START);
wire sak = thread_pipe_valid_bus[2] & !pc_set[2] & cubev_reg_5_dout[29]; //dbus_wr_en & dbus_rdwr_add_per & (dbus_rdwr_add[17:0] == TC_SAK);

always @ (*) begin
   case (thread_pipe_valid_bus[2] & !pc_set[2] & dbus_wr_en & dbus_rdwr_add_per)
   1'b1 :    begin
               wr_clk_sel = (dbus_rdwr_add[17:0] == CLK_SEL);
               wr_clk_val = (dbus_rdwr_add[17:0] == CLK_VAL);
             end
   1'b0 :    begin
               wr_clk_sel = 1'b0;
               wr_clk_val = 1'b0;
             end
   default : begin
               wr_clk_sel = 1'b0;
               wr_clk_val = 1'b0;
             end
   endcase
end

reg [1:0] ext_path_reg;
always @(posedge clk_root or negedge rstn)
if (~rstn)
   ext_path_reg <= 0;
else
   ext_path_reg <= {ext_path_reg[0], cubev_reg_5_dout[25]};
   
wire ext_path_rd = dbus_rd_req_reg[1] & ext_path_reg[1];

reg [31:0] ext_rf_cap;
always @(posedge clk_root or negedge rstn)
if (~rstn) begin
   ext_rf_cap <= 0;
end else begin             
   ext_rf_cap <= {ext_rf_cap[30:0], cubev_rf1_din[31]};
end

parameter FIFO_DEPTH = 3;
   
reg [7:0] tid_active;
reg [2:0] tid_fifo [FIFO_DEPTH - 1:0];
reg fifo_full;
reg [2:0] tid_fifo_ptr;
wire [2:0] tid_fifo_ptr_p1 = tid_fifo_ptr + 1;
wire [2:0] tid_fifo_ptr_m1 = tid_fifo_ptr - 1;

wire tid_fifo_4 = tid_next_avail >= 7;


wire [3:0] tid_next_avail = !tid_active[0] ? 0 :
                            !tid_active[1] ? 1 :
                            !tid_active[2] ? 2 :
                            !tid_active[3] ? 3 :
                            !tid_active[4] ? 4 :
                            !tid_active[5] ? 5 :
                            !tid_active[6] ? 6 : 7 ; /*:
                            !tid_active[7] ? 7 :
                            !tid_active[8] ? 8 :
                            !tid_active[9] ? 9 :
                            !tid_active[10] ? 10 :
                            !tid_active[11] ? 11 :
                            !tid_active[12] ? 12 :
                            !tid_active[13] ? 13 :
                            !tid_active[14] ? 14 : 15; */


reg [7:0] thread_pipe_valid_bus;
reg [7:0] thread_stalled_bus;
reg [5:0] pc_set;
reg [29:0] pc_set_data [6:0];
reg [29:0] pc_set_data_int;
reg cubev_reg_wea; 
                         
reg ca_match_ack;
reg ca_match_valid_meta; 
reg [31:0] ca_command_saved;
reg gpio_event_cap; 


reg pc_set_int;
reg [2:0] init_state;

parameter CA_COM = 18'h01000;
parameter CA_ET  = 18'h01004;

wire wr_add_ca_com = thread_pipe_valid_bus[2] & !pc_set[2] & dbus_wr_en & dbus_rdwr_add_per & 
                     ca_per & (dbus_rdwr_add[3:0] == 4'h0); //(dbus_rdwr_add[17:0] == CA_COM);
wire wr_add_ca_et = thread_pipe_valid_bus[2] & !pc_set[2] & dbus_wr_en & dbus_rdwr_add_per & 
                    ca_per & (dbus_rdwr_add[3:0] == 4'h4); //(dbus_rdwr_add[17:0] == CA_ET);

always @(posedge clk_root or negedge rstn)
if (~rstn) begin
   thread_stalled_bus <= 0;
end else begin
   thread_stalled_bus = {thread_stalled_bus[6:3], ca_stalled_by_ca &
                                                  (wr_add_ca_com | wr_add_ca_et), 3'b000};
end

reg [2:0] tid_fifo_p1_next;
reg p1_update;

always @(*) begin
p1_update <= 1'b0; 
tid_fifo_p1_next <= 0;
      ///////////////////////////////////////////
      // handle incoming thread
      ///////////////////////////////////////////
      case (wave_cnt)
      /*
         3: begin
               if (start & thread_pipe_valid_bus[4]) begin
                  tid_fifo_p1_next <= tidrd4;
                  tid_fifo_ptr_p1_next <= tid_fifo_ptr_p1;
               end
               thread_pipe_valid_bus <= {thread_pipe_valid_bus[4:0], 1'b1};
            end
      */
         2: begin
               if (thread_pipe_valid_bus[6]) begin
                  tid_fifo_p1_next <= tidrd[6];
                  p1_update <= 1'b1;
               end
            end
         1: begin
               if (thread_pipe_valid_bus[5]) begin
                  tid_fifo_p1_next <= tidrd[5];
                  p1_update <= 1'b1;
               end
            end
         0: begin
               if (thread_pipe_valid_bus[4]) begin
                  tid_fifo_p1_next <= tidrd[4];
                  p1_update <= 1'b1;
               end
            end
         default : ;
      endcase
end

reg [2:0] tid_fifo_m1_next;
reg m1_update;

always @(*) begin
m1_update <= 1'b0; 
tid_fifo_m1_next <= 0;
         case (wave_cnt)
         /*
            3: begin
                  ///////////////////////////////////////////
                  // handle incoming thread
                  ///////////////////////////////////////////
                  if (thread_pipe_valid_bus[4] == 1'b1) begin
                     tid_fifo[tid_fifo_ptr_m1] <= tidrd4;
                  end else begin
                     tid_fifo_ptr <= tid_fifo_ptr_m1;
                  end
               thread_pipe_valid_bus <= {thread_pipe_valid_bus[4:0], 1'b1};
               end
         */
            2: begin
                  ///////////////////////////////////////////
                  // handle incoming thread
                  ///////////////////////////////////////////
                  if (thread_pipe_valid_bus[6] == 1'b1) begin
                     tid_fifo_m1_next <= tidrd[6];
                     m1_update <= 1'b1;
                  end
               end
            1: begin
                  ///////////////////////////////////////////
                  // handle incoming thread
                  ///////////////////////////////////////////
                  if (thread_pipe_valid_bus[5] == 1'b1) begin
                     tid_fifo_m1_next <= tidrd[5];
                     m1_update <= 1'b1;
                  end
               end
            0: begin
                  ///////////////////////////////////////////
                  // handle incoming thread
                  ///////////////////////////////////////////
                  if (thread_pipe_valid_bus[4] == 1'b1) begin
                     tid_fifo_m1_next <= tidrd[4];
                     m1_update <= 1'b1;
                  end
               end
            default : ;
         endcase
end

wire [2:0] wave_cnt_p3 = 3 + wave_cnt;

always @(posedge clk_root or negedge rstn)
if (~rstn) begin
   pc_set_int <= 0;
   pc_set_data_int <= 0;
end else begin
   pc_set_int <= pc_set[wave_cnt_p3];
   pc_set_data_int <= pc_set_data[wave_cnt_p3];
end

always @(posedge clk_root or negedge rstn)
if (~rstn) begin
   thread_pipe_valid_bus <= 0;
   init_state <= 0;
   tid_active <= 0;
   pc_set <= 0;
   for (i = 0; i < 8; i = i + 1) begin
      pc_set_data[i] <= 0;
      tidrd[i] = 0;
   end
   for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
      tid_fifo[i] <= 0;
   end
   tid_fifo_ptr <= 0;
   ca_match_ack <= 0;
   ca_match_valid_meta <= 0;
   gpio_event_ack <= 0;
   gpio_event_cap <= 0;
   ca_gpio_match <= 0; 
   ca_command_saved <= 0;
end else begin
   pc_set <= {pc_set[4:0], 1'b0};
   for (i = 5; i > 0; i = i - 1) begin
      pc_set_data[i] <= pc_set_data[i - 1];
   end
   pc_set_data[0] <= 0;
   gpio_event_ack <= 0;
   ca_gpio_match <= 0;
   //////////////////////////////////////////////////////// init_state
   if (init_state == 0) begin //{1'b0, wave_cnt}) begin
      //init_state <= 1'b0;
      thread_pipe_valid_bus <= 8'b000001;
      pc_set <= 5'h01;
      init_state <= init_state + 1;
      tidrd[0] <= 0;
      tid_active[tid_next_avail] <= 1'b1;
   end else 
   //////////////////////////////////////////////////////// execute direct start
   if (start | sak) begin // & !fifo_full) begin
      ///////////////////////////////////////////
      // start new thread from dbus_wr_data
      ///////////////////////////////////////////
      pc_set_data[0] <= dbus_wr_data[29:0];
      pc_set[0] <= 1'b1;
      tidrd[0] <= tid_next_avail;
      tid_active[tid_next_avail] <= 1'b1;
      ///////////////////////////////////////////
      // handle incoming thread
      ///////////////////////////////////////////
      if (p1_update) begin
         tid_fifo[tid_fifo_ptr] <= tid_fifo_p1_next;
         tid_fifo_ptr <= tid_fifo_ptr_p1;
      end
      thread_pipe_valid_bus <= {thread_pipe_valid_bus[6:0], 1'b1};
   end else 
   //////////////////////////////////////////////////////// execute ca command
   if (ca_match_ack & !tid_fifo_4 & ca_command_saved[30]) begin
      ///////////////////////////////////////////
      // start new thread from dbus_wr_data
      ///////////////////////////////////////////
      pc_set_data[0] <= ca_command_saved[29:0];
      pc_set[0] <= 1'b1;
      tidrd[0] <= tid_next_avail;
      tid_active[tid_next_avail] <= 1'b1;
      ///////////////////////////////////////////
      // handle incoming thread
      ///////////////////////////////////////////
      if (p1_update) begin
         tid_fifo[tid_fifo_ptr] <= tid_fifo_p1_next;
         tid_fifo_ptr <= tid_fifo_ptr_p1;
      end
      thread_pipe_valid_bus <= {thread_pipe_valid_bus[6:0], 1'b1};
      ca_match_ack <= 1'b0;
   end else 
   //////////////////////////////////////////////////////// execute ca command
   if (gpio_event & !tid_fifo_4) begin
      ///////////////////////////////////////////
      // start new thread from dbus_wr_data
      ///////////////////////////////////////////
      pc_set_data[0] <= gpio_command_out[29:0];
      pc_set[0] <= 1'b1;
      tidrd[0] <= tid_next_avail;
      tid_active[tid_next_avail] <= 1'b1;
      gpio_event_ack <= 1;
      ///////////////////////////////////////////
      // handle incoming thread
      ///////////////////////////////////////////
      if (p1_update) begin
         tid_fifo[tid_fifo_ptr] <= tid_fifo_p1_next;
         tid_fifo_ptr <= tid_fifo_ptr_p1;
      end
      thread_pipe_valid_bus <= {thread_pipe_valid_bus[6:0], 1'b1};
      gpio_event_cap <= 1'b0;
   end else 
   //////////////////////////////////////////////////////// execute thread from fifo
   if (!(tid_fifo_ptr == 0)) begin
         ///////////////////////////////////////////
         // start new thread from fifo
         ///////////////////////////////////////////
         tidrd[0] <= tid_fifo[0];
         ///////////////////////////////////////////
         // shift FIFO
         ///////////////////////////////////////////
         for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
            tid_fifo[i] <= tid_fifo[i + 1];
         end
         if (m1_update)
            tid_fifo[tid_fifo_ptr_m1] <= tid_fifo_m1_next;
         else
            tid_fifo_ptr <= tid_fifo_ptr_m1;
         thread_pipe_valid_bus <= {thread_pipe_valid_bus[6:0], 1'b1};
   end else
   //////////////////////////////////////////////////////// re-enter thread
   if (1) begin
      case (wave_cnt)
      /*
         3: begin
               thread_pipe_valid_bus <= {thread_pipe_valid_bus[4:0], thread_pipe_valid_bus[4]}; // | pc_set_bus[4]};
               //pc_set_bus <= {pc_set_bus[4:0], 1'b0};
               if (thread_pipe_valid_bus[4])
                  tidrd0 <= tidrd4;
            end
      */
         2: begin
               if (thread_pipe_valid_bus[6])
                  tidrd[0] <= tidrd[6];
               else
                  tidrd[0] <= 4'h0; //4'bxxxx;
               thread_pipe_valid_bus <= {thread_pipe_valid_bus[6:0], thread_pipe_valid_bus[6]}; // | pc_set_bus[3]};
            end
         1: begin
               if (thread_pipe_valid_bus[5])
                  tidrd[0] <= tidrd[5];
               else
                  tidrd[0] <= 4'h0; //4'bxxxx;
               thread_pipe_valid_bus <= {thread_pipe_valid_bus[6:0], thread_pipe_valid_bus[5]}; // | pc_set_bus[1]};
            end
         0: begin
               if (thread_pipe_valid_bus[4])
                  tidrd[0] <= tidrd[4];
               else
                  tidrd[0] <= 4'h0; //4'bxxxx;
               thread_pipe_valid_bus <= {thread_pipe_valid_bus[6:0], thread_pipe_valid_bus[4]}; // | pc_set_bus[1]};
            end
         default : ;
      endcase
   end
   //////////////////////////////////////////////////////// killing a thread
   if (kill | sak) begin
      thread_pipe_valid_bus[3] <= 1'b0;
      tid_active[tidrd[2]] <= 1'b0;
   end
   //////////////////////////////////////////////////////// handshake for ca -> gpio command
   if (ca_match_ack & !ca_command_saved[30]) begin
      ca_match_ack <= 1'b0;
      ca_gpio_match <= 1'b1;
   end else
   //////////////////////////////////////////////////////// 
   if (ca_match_valid_meta) begin
      ca_match_ack <= 1'b1;
      ca_command_saved <= ca_command;
   end
   if (gpio_event) begin
      gpio_event_cap <= 1'b1;
   end
   for (i = 7; i > 0; i = i - 1) begin
      tidrd[i] = tidrd[i - 1];
   end
   ca_match_valid_meta <= ca_match_valid;
end

assign cubev_reg_cs = cubev_reg_wea;

always @ (*) begin
cubev_reg_wea <= thread_pipe_valid_bus[4] & !thread_stalled_bus[4];
tidwr <= tidrd[4];
case (wave_cnt)
/*   3: begin
         //pc_set <= pc_set_bus[5];
         cubev_reg_wea <= thread_pipe_valid_bus[5];
         tidwr <= tidrd5;
      end
*/
   2: begin
         cubev_reg_wea <= thread_pipe_valid_bus[6] & !thread_stalled_bus[6];
         tidwr <= tidrd[6];
      end
   1: begin
         cubev_reg_wea <= thread_pipe_valid_bus[5] & !thread_stalled_bus[5];
         tidwr <= tidrd[5];
      end
   0: begin
         cubev_reg_wea <= thread_pipe_valid_bus[4] & !thread_stalled_bus[4];
         tidwr <= tidrd[4];
      end
   default : ;
endcase   
end

///////////////////////////////////////////////////
// RF1
///////////////////////////////////////////////////
wire [4:0] cubev_rf1_wr_add_int;
assign cubev_rf1_wr_add = {tidwr[2:0], cubev_rf1_wr_add_int};
wire [31:0] cubev_rf1_din;
reg [31:0] cubev_rf1_dout_int;
reg [31:0] cubev_rf1_dout_sim [2:0];

always @ (posedge clk_root)
begin
   for (i = 2; i > 0; i = i - 1)
      cubev_rf1_dout_sim[i] <= cubev_rf1_dout_sim[i - 1];
   cubev_rf1_dout_sim[0] <= cubev_rf1_dout;
end

always @ (*) 
case (wave_sim)
   //3: cubev_rf1_dout_int <= cubev_rf1_dout_sim[2];
   2: cubev_rf1_dout_int <= cubev_rf1_dout_sim[1];
   1: cubev_rf1_dout_int <= cubev_rf1_dout_sim[0];
   0: cubev_rf1_dout_int <= cubev_rf1_dout;
   default : ;
endcase

assign cubev_rf1_cs = cubev_rf2_cs;
assign cubev_rf1_rd_add = {tidrd2[2:0], cubev_reg_5_dout[17:13]};

///////////////////////////////////////////////////
// RF2
///////////////////////////////////////////////////
wire [4:0] cubev_rf2_wr_add_int;
assign cubev_rf2_wr_add = {tidwr[2:0], cubev_rf2_wr_add_int};
wire [31:0] cubev_rf2_din;

reg [31:0] cubev_rf2_dout_int;
reg [31:0] cubev_rf2_dout_sim [2:0];

always @ (posedge clk_root)
begin
   for (i = 2; i > 0; i = i - 1)
      cubev_rf2_dout_sim[i] <= cubev_rf2_dout_sim[i - 1];
   cubev_rf2_dout_sim[0] <= cubev_rf2_dout;
end

always @ (*) 
case (wave_sim)
   //3: cubev_rf2_dout_int <= cubev_rf2_dout_sim[2];
   2: cubev_rf2_dout_int <= cubev_rf2_dout_sim[1];
   1: cubev_rf2_dout_int <= cubev_rf2_dout_sim[0];
   0: cubev_rf2_dout_int <= cubev_rf2_dout;
   default : ;
endcase

reg cubev_rf2_cs;
always @ (*) begin 
cubev_rf2_cs = ~(thread_pipe_valid_bus[4] & !thread_stalled_bus[4]);
case (wave_cnt)
   //3: cubev_rf1_cs = thread_pipe_valid_bus[5];
   2: cubev_rf2_cs = ~(thread_pipe_valid_bus[6] & !thread_stalled_bus[6]);
   1: cubev_rf2_cs = ~(thread_pipe_valid_bus[5] & !thread_stalled_bus[5]);
   default : cubev_rf2_cs = ~(thread_pipe_valid_bus[4] & !thread_stalled_bus[4]);
endcase
end

assign cubev_rf2_rd_add = {tidrd2[2:0], cubev_reg_5_dout[22:18]};

///////////////////////////////////////////////////
// P RAM
///////////////////////////////////////////////////
wire [13:0] pc; 

reg [2:0] pc_d [1:0];
always @ (posedge clk_root or negedge rstn)
if (!rstn) begin
   pc_d[0] <= 0;
   pc_d[1] <= 0;
end else begin
   pc_d[1] <= pc_d[0];
   pc_d[0] <= pc[2:0];
end

wire [31:0] instrl;                 
wire [31:0] instrh;                 
reg [31:0] instr;
wire [31:0] pc_d1 = pc_d[1];
always @ (pc_d1 or cubev_phi_instrh_reg or cubev_pli_instrl_reg) begin
case (pc_d1[2:1])
   2'b00 : instr <= cubev_pli_instrl_reg;
   2'b01 : instr <= {cubev_phi_instrh_reg[15:0], cubev_pli_instrl_reg[31:16]};
   2'b10 : instr <= cubev_phi_instrh_reg;
   2'b11 : instr <= {cubev_pli_instrl_reg[15:0], cubev_phi_instrh_reg[31:16]};
   default : instr <= 32'h00000000; //32'hxxxxxxxx;
endcase
end   

assign cubev_pli_pcl = pc[2] ? (pc + 4) : pc;
assign cubev_phi_pch = pc;

///////////////////////////////////////////////////
// Sequential Memory Model (P-RAM)
///////////////////////////////////////////////////

assign pc = cubev_reg_4_dout[31:19];

reg [31:0] instr_int;
reg [31:0] instr_sim [2:0];

always @ (posedge clk_root)
begin
   for (i = 3; i >= 0; i = i - 1)
      instr_sim[i] <= instr_sim[i - 1];
   instr_sim[0] <= instr;
end

always @ (*) 
case (wave_sim)
   //3: instr_int <= instr_sim[2];
   2: instr_int <= instr_sim[1];
   1: instr_int <= instr_sim[0];
   0: instr_int <= instr;
   default : ;
endcase

///////////////////////////////////////////////////
// Sequential Memory Model (D-RAM)
///////////////////////////////////////////////////
assign cubev_dhi_web0 = !dbus_wr_en;
assign cubev_dhi_wmask0 = dbus_rdwr_be_final[7:4];
assign cubev_dhi_addr = dbus_rdwr_add[9:2];
assign cubev_dhi_din0 = dbus_wr_data_final[63:32];

assign cubev_dli_web0 = !dbus_wr_en;
assign cubev_dli_wmask0 = dbus_rdwr_be_final[3:0];
assign cubev_dli_addr = dbus_rdwr_add[9:2];
assign cubev_dli_din0 = dbus_wr_data_final[31:0];

wire [31:0] dbus_wr_data;
wire dbus_rd_req;
wire [31:0] dbus_rd_i_data;

assign dbus_wr_en = cubev_reg_5_dout[11];
assign dbus_wr_data = cubev_reg_3_dout;
assign dbus_rd_req = cubev_reg_5_dout[12];

assign dbus_rdwr_add = {14'h0000, cubev_reg_4_dout[17:0]};
wire dbus_rdwr_add_per = cubev_reg_4_dout[18]; 
wire ca_per = cubev_reg_5_dout[26]; 

wire dbus_rdwr_gpio_base = dbus_rdwr_add_per & (dbus_rdwr_add[17:16] == 2'h3);

///////////////////////////////////////////////////
// dbus_rdwr_be_final
///////////////////////////////////////////////////
wire [6:0] opcode_i_s2 = cubev_reg_1_dout[6:0];
wire instr_i_load_s2  = opcode_i_s2 == 7'b0000011;
wire instr_i_store_s2 = opcode_i_s2 == 7'b0100011;
wire [1:0] dbus_rdwr_width = (instr_i_load_s2 | instr_i_store_s2) ? cubev_reg_1_dout[13:12] : 2;
wire [3:0] dbus_rdwr_be = dbus_wr_en ?
                    ((dbus_rdwr_width == 0) ? 4'h1 :
                     (dbus_rdwr_width == 1) ? 4'h3 : 4'hf) : 0;

reg [7:0] dbus_rdwr_be_final; 
always @ (dbus_rdwr_add or dbus_rdwr_be) begin
dbus_rdwr_be_final = 8'h00;
case (dbus_rdwr_add[2:0])
   0:       begin
               dbus_rdwr_be_final = {4'h0, dbus_rdwr_be};
            end
   1:       begin
               dbus_rdwr_be_final = {3'h0, dbus_rdwr_be, 1'h0};
            end
   2:       begin
               dbus_rdwr_be_final = {2'h0, dbus_rdwr_be, 2'h0};
            end
   3:       begin
               dbus_rdwr_be_final = {1'h0, dbus_rdwr_be, 3'h0};
            end
   4:       begin
               dbus_rdwr_be_final = {dbus_rdwr_be, 4'h0};
            end
   5:       begin
               dbus_rdwr_be_final = {dbus_rdwr_be[2:0], 4'h0, dbus_rdwr_be[3]};
            end
   6:       begin
               dbus_rdwr_be_final = {dbus_rdwr_be[1:0], 4'h0, dbus_rdwr_be[3:2]};
            end
   7:       begin
               dbus_rdwr_be_final = {dbus_rdwr_be[0], 4'h0, dbus_rdwr_be[3:1]};
            end
   default: begin end
endcase
end


///////////////////////////////////////////////////
// dbus_wr_data_final
///////////////////////////////////////////////////
always @ (dbus_rdwr_add or dbus_wr_data) begin
case (dbus_rdwr_add[2:0])
   0:       begin
               dbus_wr_data_final = {32'hxxxxxxxx, dbus_wr_data};
            end
   1:       begin
               dbus_wr_data_final = {24'hxxxxxx, dbus_wr_data, 8'hxx};
            end
   2:       begin
               dbus_wr_data_final = {16'hxxxx, dbus_wr_data, 16'hxxxx};
            end
   3:       begin
               dbus_wr_data_final = {8'hxx, dbus_wr_data, 24'hxxxxxx};
            end
   4:       begin
               dbus_wr_data_final = {dbus_wr_data, 32'hxxxxxxxx};
            end
   5:       begin
               dbus_wr_data_final = {dbus_wr_data[23:0], 32'hxxxxxxxx, dbus_wr_data[31:24]};
            end
   6:       begin
               dbus_wr_data_final = {dbus_wr_data[15:0], 32'hxxxxxxxx, dbus_wr_data[31:16]};
            end
   7:       begin
               dbus_wr_data_final = {dbus_wr_data[7:0], 32'hxxxxxxxx, dbus_wr_data[31:8]};
            end
   default: begin end
endcase
end

///////////////////////////////////////////////////
// D RAM read
///////////////////////////////////////////////////

reg [31:0] dbus_rd_data;

reg [2:0] dbus_rdwr_add_sel_d [1:0];
always @ (posedge clk_root) begin
   dbus_rdwr_add_sel_d[1] <= dbus_rdwr_add_sel_d[0];
   dbus_rdwr_add_sel_d[0] <= dbus_rdwr_add[2:0];
end

wire [2:0] dbus_rdwr_add_sel_d1 = dbus_rdwr_add_sel_d[1];

wire [63:0] dbus_rd_data_final_reg = {cubev_dhi_dout1, cubev_dli_dout1};

always @ (dbus_rdwr_add_sel_d1 or dbus_rd_data_final_reg) begin
case (dbus_rdwr_add_sel_d1[2:0])
   0:       begin
               dbus_rd_data = dbus_rd_data_final_reg[31:0];
            end
   1:       begin
               dbus_rd_data = dbus_rd_data_final_reg[39:8];
            end
   2:       begin
               dbus_rd_data = dbus_rd_data_final_reg[47:16];
            end
   3:       begin
               dbus_rd_data = dbus_rd_data_final_reg[55:24];
            end
   4:       begin
               dbus_rd_data = dbus_rd_data_final_reg[63:32];
            end
   5:       begin
               dbus_rd_data = {dbus_rd_data_final_reg[7:0], dbus_rd_data_final_reg[63:40]};
            end
   6:       begin
               dbus_rd_data = {dbus_rd_data_final_reg[15:0], dbus_rd_data_final_reg[63:48]};
            end
   7:       begin
               dbus_rd_data = {dbus_rd_data_final_reg[23:0], dbus_rd_data_final_reg[63:56]};
            end
   default: begin end
endcase
end

wire [31:0] dbus_rd_data_out_gpio;
wire gpio_event;
reg gpio_event_ack;
wire [31:0] gpio_command_out;
//wire ca_match;
wire [31:0] ca_gpio_command = ca_command_saved;
reg ca_gpio_match;


/////////////////////////////////////////////////
reg [1:0] dbus_rd_req_reg;
reg [1:0] dbus_rdwr_add_per_reg;
reg [17:0] dbus_rdwr_add_reg [1:0];
reg [22:0] ca_time_reg [1:0];
reg [7:0] dbus_rd_data_out_gpio_reg [1:0];

always @(posedge clk_root or negedge rstn)
if (~rstn) begin
   dbus_rd_req_reg <= 0;
   dbus_rdwr_add_per_reg <= 0;
   for (i = 0; i < 2; i = i + 1) begin
      dbus_rdwr_add_reg[i] <= 0;
      ca_time_reg[i] <= 0;
      dbus_rd_data_out_gpio_reg[i] <= 0;
   end
end else begin
   dbus_rd_req_reg <= {dbus_rd_req_reg[0], dbus_rd_req};
   dbus_rdwr_add_per_reg <= {dbus_rdwr_add_per_reg[0], dbus_rdwr_add_per};
   for (i = 1; i > 0; i = i - 1) begin
      dbus_rdwr_add_reg[i] <= dbus_rdwr_add_reg[i - 1];
      ca_time_reg[i] <= ca_time_reg[i - 1];
      dbus_rd_data_out_gpio_reg[i] <= dbus_rd_data_out_gpio_reg[i - 1];
   end
   dbus_rdwr_add_reg[0] <= dbus_rdwr_add;
   ca_time_reg[0] <= ca_time[22:0];
   dbus_rd_data_out_gpio_reg[0] <= dbus_rd_data_out_gpio;
end

/////////////////////////////////////////////////
reg [31:0] dbus_rd_data_per_tmp;
reg dbus_rd_data_per_valid_tmp;

always @ (*) begin
   dbus_rd_data_per_valid_tmp <= 1'b0;
   dbus_rd_data_per_tmp <= 0;
   /*
   if (pc_set[4]) begin
      dbus_rd_data_per_valid_tmp <= 1'b1;
      dbus_rd_data_per_tmp <= {16'h0000, pc_set_data[4][29:14]};
   end else
   */
   if (dbus_rd_req_reg[1]) begin
      if (dbus_rdwr_add_per_reg[1] & (dbus_rdwr_add_reg[1][17:12] == 6'h30)) begin
         dbus_rd_data_per_valid_tmp <= 1'b1;
         dbus_rd_data_per_tmp <= {24'h000000, dbus_rd_data_out_gpio_reg[1][7:0]};
      end else 
      if (dbus_rdwr_add_per_reg[1] & (dbus_rdwr_add_reg[1][17:0] == 18'h1008)) begin
         dbus_rd_data_per_valid_tmp <= 1'b1;
         dbus_rd_data_per_tmp <= {9'h000, ca_time_reg[1]};
      end
   end
end

reg [31:0] dbus_rd_data_per_sim [4:0];
reg [4:0] dbus_rd_data_per_valid_sim;

always @ (posedge clk_root) 
begin
   for (i = 4; i > 0; i = i - 1)
      dbus_rd_data_per_sim[i] <= dbus_rd_data_per_sim[i - 1];
   dbus_rd_data_per_sim[0] <= dbus_rd_data_per_tmp;
   dbus_rd_data_per_valid_sim <= {dbus_rd_data_per_valid_sim[3:0], dbus_rd_data_per_valid_tmp};
end

reg [31:0] dbus_rd_data_per;
reg dbus_rd_data_per_valid;

always @ (*) 
case (wave_sim)
   //3: dbus_rd_data_int <= dbus_rd_data_sim[2];
   2: begin
         dbus_rd_data_per <= dbus_rd_data_per_sim[1];
         dbus_rd_data_per_valid <= dbus_rd_data_per_valid_sim[1];
      end
   1: begin
         dbus_rd_data_per <= dbus_rd_data_per_sim[0];
         dbus_rd_data_per_valid <= dbus_rd_data_per_valid_sim[0];
      end
   0: begin
         dbus_rd_data_per <= dbus_rd_data_per_tmp;
         dbus_rd_data_per_valid <= dbus_rd_data_per_valid_tmp;
      end
   default : ;
endcase


reg [31:0] dbus_rd_data_d;
reg [31:0] dbus_rd_data_sim [2:0];

always @ (posedge clk_root) 
begin
   for (i = 2; i > 0; i = i - 1)
      dbus_rd_data_sim[i] <= dbus_rd_data_sim[i - 1];
   dbus_rd_data_sim[0] <= ext_path_rd ? ext_rf_cap : dbus_rd_data;
end

always @ (*) 
case (wave_sim)
   //3: dbus_rd_data_int <= dbus_rd_data_sim[2];
   2: dbus_rd_data_d <= dbus_rd_data_sim[1];
   1: dbus_rd_data_d <= dbus_rd_data_sim[0];
   0: dbus_rd_data_d <= ext_path_rd ? ext_rf_cap : dbus_rd_data;
   default : ;
endcase

wire [31:0] dbus_rd_data_int = dbus_rd_data_per_valid ? dbus_rd_data_per :
                               dbus_rd_data_d;


cubev_rv32imc_p3 i_core (.pc_s2_next(),
                         .instr(instr_int),
                         .pc_set_int(pc_set_int),
                         .pc_set_data_int(pc_set_data_int),
                         .dbus_rd_add(),
                         .dbus_wr_add(),
                         .dbus_rdwr_width(),
                         .dbus_rd_i_req(),
                         .dbus_rd_i_data(dbus_rd_data_int),
                         .dbus_wr_en(),                
                         .dbus_wr_data(),
                         .cubev_rf1_we(cubev_rf1_we),
                         .cubev_rf1_wr_add(cubev_rf1_wr_add_int),
                         .cubev_rf1_din(cubev_rf1_din),
                         .cubev_rf1_rd_add(),
                         .cubev_rf1_dout(cubev_rf1_dout_int),
                         .cubev_rf2_we(cubev_rf2_we),
                         .cubev_rf2_wr_add(cubev_rf2_wr_add_int),
                         .cubev_rf2_din(cubev_rf2_din),
                         .cubev_rf2_rd_add(),
                         .cubev_rf2_dout(cubev_rf2_dout_int),
                         .cubev_reg_din0(cubev_reg_0_din),
                         .cubev_reg_din0_valid(cubev_reg_din0_valid),
                         .cubev_reg_din1(cubev_reg_1_din),
                         .cubev_reg_din2(cubev_reg_2_din),
                         .cubev_reg_din2_valid(cubev_reg_din2_valid),
                         .cubev_reg_din3(cubev_reg_3_din),
                         .cubev_reg_din4(cubev_reg_4_din),
                         .cubev_reg_din5(cubev_reg_5_din),
                         .cubev_reg_dout0(cubev_reg_0_dout_int),
                         .cubev_reg_dout1(cubev_reg_1_dout_int),
                         .cubev_reg_dout2(cubev_reg_2_dout_int),
                         .cubev_reg_dout3(cubev_reg_3_dout_int),
                         .cubev_reg_dout4(cubev_reg_4_dout_int),
                         .cubev_reg_dout5(cubev_reg_5_dout_int),
                         .cubev_reg_dout0_late(cubev_reg_0_dout_late),
                         .cubev_reg_dout1_late(cubev_reg_1_dout_late),
                         .cubev_reg_dout2_late(cubev_reg_2_dout_late),
                         .cubev_reg_dout3_late(cubev_reg_3_dout_late),
                         .cubev_reg_dout4_late(cubev_reg_4_dout_late),
                         .cubev_reg_dout5_late(cubev_reg_5_dout_late));

assign gpio_oeb[37:32] = 0;

gpio i_gpio (.clk(clk_root),
             .rstn(rstn),
             .gpio_dir_reg(gpio_oeb[31:0]),
             .gpio_out_reg(gpio_out[31:0]),
             .gpio_in(gpio_in[31:0]),
             .dbus_rdwr_gpio_base(dbus_rdwr_gpio_base),
             .dbus_rd_add_bus(dbus_rdwr_add),
             .dbus_wr_add_bus(dbus_rdwr_add),
             .dbus_rdwr_be_in(),
             .dbus_wr_en(thread_pipe_valid_bus[2] & !pc_set[2] & dbus_wr_en),
             .dbus_wr_data_in(dbus_wr_data),
             .dbus_rd_req(1'b1),
             .dbus_rd_data_out(dbus_rd_data_out_gpio),
             .ca_match(ca_gpio_match),
             .ca_command_in(ca_gpio_command),
             .gpio_event(gpio_event),
             .gpio_event_ack(gpio_event_ack),
             .gpio_command_out(gpio_command_out));                

endmodule 


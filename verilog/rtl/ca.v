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
// Simple calendar (ca) implementation.
// Goal is to have a working calendar first.
// Timing optimizations second.
// C-slow-retiming to enable multithreaded access not implemented yet.
// Calendar time bit width = 23;
//

module ca (clk_const,
           rstn,
           test_overflow,

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
           cubev_ca_wea,
           cubev_ca_addra,
           cubev_ca_dina,
           cubev_ca_douta,
           cubev_ca_addrb,
           cubev_ca_doutb);


parameter CA_COM = 32'h80001000;
parameter CA_ET  = 32'h80001004;
parameter CA_CT  =    19'h01008;

input clk_const;
input rstn;
input test_overflow;

input ca_dbus_valid;
output ca_dbus_ack;
input ca_dbus_com;
input [2:0] ca_dbus_tid;
input [31:0] ca_dbus_data;
output ca_time_valid;
input ca_time_ack;
output [22:0] ca_time_data;
output ca_match_valid;
input ca_match_ack;
output [31:0] ca_command;

output cubev_ca_wea;
output [8:0] cubev_ca_addra;
output [31:0] cubev_ca_dina;
input  [31:0] cubev_ca_douta;
output [8:0] cubev_ca_addrb;
input  [31:0] cubev_ca_doutb;

//wire [32:0] ca_wr_douta;
reg ca_wr_wea;
reg [8:0] ca_wr_add;
reg [8:0] ca_wr_add_start;
reg ca_wr_add_start_marker;
reg [8:0] ca_wr_add_fill;
reg [8:0] ca_wr_add_fill_next;
reg ca_end_of_wr_list;
reg [8:0] ca_wr_add_ptr;
reg [32:0] ca_wr_dina;
//wire [32:0] ca_rd_doutb;
reg [5:0] ca_wr_fsm_state;
reg ca_ready;
reg [22:0] ca_insert_time;
reg [8:0] ca_rd_add;
reg [3:0] ca_rd_fsm_state;
//reg [2:0] ca_rd_delay;
reg ca_update_rd_add;
reg [31:0] ca_command;
reg ca_wr_sync_update;
reg ca_wr_sync_update_done;
reg ca_rd_doutb_31_23; 

///////////////////////////////////////////////////
// handling time counter
// and transfer to user clock
///////////////////////////////////////////////////
//reg [22:0] ca_time;
reg [22:0] ca_time_const;
reg [22:0] ca_time_data;
reg ca_time_valid;
reg hs_ready_meta;
reg hs_valid;


always @ (posedge clk_const or negedge rstn)
if (~rstn) begin
   ca_time_const <= 0;
   ca_time_valid <= 0;
   ca_time_data <= 0;
   hs_valid <= 0;
   hs_ready_meta <= 1;
end else begin
   case (ca_time_valid) 
   0: if (hs_ready_meta) begin
         hs_valid <= 1'b1;
         ca_time_data <= ca_time_const;
         ca_time_valid <= 1'b1;
      end
   1: if (!hs_ready_meta) begin
         ca_time_valid <= 1'b0;
         hs_valid <= 1'b0;
      end
   endcase
   ca_time_const <= ca_time_const + 1;
   hs_ready_meta <= ca_time_ack; 
end

///////////////////////////////////////////////////
// handling write transfer
///////////////////////////////////////////////////

reg [1:0] hs_state_write_const;
reg ca_dbus_valid_meta;
reg ca_dbus_ack;
reg ca_wr_com_const;
reg ca_wr_et_const;
reg [31:0] hs_write_dbus_wr_data_const;
reg [2:0] hs_write_tid_wr0_const;

always @ (posedge clk_const or negedge rstn)
if (~rstn) begin
   hs_state_write_const <= 0;
   ca_wr_com_const <= 0;
   ca_wr_et_const <= 0;
   hs_write_dbus_wr_data_const <= 0;
   hs_write_tid_wr0_const <= 0;
   ca_dbus_ack <= 0;
   ca_dbus_valid_meta <= 0;
end else begin
   ca_wr_com_const <= 0;
   ca_wr_et_const <= 0;
   case (hs_state_write_const) 
   0: if (ca_dbus_valid_meta) begin
         hs_state_write_const <= 1;
      end
   1: hs_state_write_const <= 2;
   2: if (ca_ready) begin
         hs_state_write_const <= 3;
         ca_wr_com_const <= ca_dbus_com;
         ca_wr_et_const <= !ca_dbus_com;
         hs_write_dbus_wr_data_const <= ca_dbus_data;
         hs_write_tid_wr0_const <= ca_dbus_tid; 
         ca_dbus_ack <= 1;
      end
   3: if (!ca_dbus_valid_meta) begin
         hs_state_write_const <= 0; 
         ca_dbus_ack <= 0;
      end
   endcase
   ca_dbus_valid_meta <= ca_dbus_valid;
end

///////////////////////////////////////////////////
// compare time
///////////////////////////////////////////////////

reg ca_insert_lesser_low;
reg ca_insert_lesser_high;
reg ca_insert_equal_high;
reg ca_compare_check;

always @ (posedge clk_const or negedge rstn)
if (~rstn) begin
   ca_insert_lesser_low <= 0;
   ca_insert_lesser_high <= 0;
   ca_insert_equal_high <= 0;
   ca_compare_check <= 0;
end else begin
   if (test_overflow) begin
      ca_insert_lesser_low <= ca_insert_time[5:0] < ca_wr_douta[5:0];
      ca_insert_lesser_high <= ca_insert_time[11:6] < ca_wr_douta[11:6];
      ca_insert_equal_high <= ca_insert_time[11:6] == ca_wr_douta[11:6];
      ca_compare_check <= ca_insert_time[11:10] == ca_wr_douta[11:10];
      if (((ca_wr_douta[11:10] == 2'h0) & (ca_insert_time[11:10] == 2'h3)) |
          ((ca_wr_douta[11:10] == 2'h1) & (ca_insert_time[11:10] == 2'h0)) |
          ((ca_wr_douta[11:10] == 2'h2) & (ca_insert_time[11:10] == 2'h1)) |
          ((ca_wr_douta[11:10] == 2'h3) & (ca_insert_time[11:10] == 2'h2)) ) begin
         ca_insert_lesser_high <= 1'b1;
         ca_compare_check <= 1'b1;
      end
   end else begin
      ca_insert_lesser_low <= ca_insert_time[10:0] < ca_wr_douta[10:0];
      ca_insert_lesser_high <= ca_insert_time[22:11] < ca_wr_douta[22:11];
      ca_insert_equal_high <= ca_insert_time[22:11] == ca_wr_douta[22:11];
      ca_compare_check <= ca_insert_time[22:21] == ca_wr_douta[22:21];
      if (((ca_wr_douta[22:21] == 2'h0) & (ca_insert_time[22:21] == 2'h3)) |
          ((ca_wr_douta[22:21] == 2'h1) & (ca_insert_time[22:21] == 2'h0)) |
          ((ca_wr_douta[22:21] == 2'h2) & (ca_insert_time[22:21] == 2'h1)) |
          ((ca_wr_douta[22:21] == 2'h3) & (ca_insert_time[22:21] == 2'h2)) ) begin
         ca_insert_lesser_high <= 1'b1;
         ca_compare_check <= 1'b1;
      end
   end
end

wire ca_insert = ca_compare_check ?
                    (ca_insert_equal_high ? ca_insert_lesser_low : ca_insert_lesser_high) :
                    1'b0;

always @ (test_overflow or ca_wr_add_fill)
   if ((test_overflow & (ca_wr_add_fill == 9'h02e)) |
       //(!test_overflow & (ca_wr_add_fill == 510))) begin
       (!test_overflow & (ca_wr_add_fill == 62))) begin
      ca_wr_add_fill_next = 9'h010;
   end else begin
      ca_wr_add_fill_next = ca_wr_add_fill + 2;
   end

///////////////////////////////////////////////////
// Central FSM
///////////////////////////////////////////////////
always @ (posedge clk_const or negedge rstn)
if (~rstn) begin
   ca_wr_add <= 0;
   ca_wr_wea <= 0;
   ca_wr_dina <= 0;
   ca_wr_add_start <= 0;
   ca_wr_fsm_state <= 0;
   ca_wr_add_start <= 0;
   ca_wr_add_fill <= 0;  
   ca_wr_add_ptr <= 0;
   ca_ready <= 0; 
   ca_insert_time <= 0;    
   ca_update_rd_add <= 0;  
   ca_wr_add_start_marker <= 0; 
   ca_end_of_wr_list <= 0;
   ca_wr_sync_update_done <= 0;    
end else begin
   ca_wr_wea <= 1'b0;
   case (ca_wr_fsm_state) 
      0: begin /////////////////////////////////////////////////// reset
           ca_wr_wea <= 1'b1;
           ca_wr_add_start <= 8'h010;
           ca_wr_add_fill <= 8'h010;
           //if (ca_wr_add == 511) begin
           if (ca_wr_add == 63) begin
              ca_wr_add <= 8'h010;
              ca_wr_fsm_state <= 1;
              ca_ready <= 1'b1;
           end else
              ca_wr_add <= ca_wr_add + 1;
         end
      1: begin /////////////////////////////////////////////////// wait
            ca_ready <= 1'b1;
            ca_wr_wea <= 1'b0;
            ca_wr_add_start_marker <= 1'b0;
            if (ca_wr_com_const) begin  //////////////////////////////// handle COM write
               ca_wr_add <= {6'h00, hs_write_tid_wr0_const};
               ca_wr_dina <= {1'b0, hs_write_dbus_wr_data_const};
               ca_wr_wea <= 1'b1;
            end else if (ca_wr_et_const & ca_ready) begin // & ////////////////////////////// handle ET write when no match executed
               ca_wr_add <= {6'h00, hs_write_tid_wr0_const}; //////////////////// read thread specific last command entry
               ca_insert_time <= hs_write_dbus_wr_data_const[22:0];
               ca_ready <= 1'b0;
               ca_wr_fsm_state <= 2;
               ca_wr_add_ptr <= ca_wr_add_start;
               ca_wr_add_start_marker <= 1'b1;
            end else if (ca_wr_sync_update) begin //////////////// clear entry and progress start ptr after match
               ca_wr_add <= ca_wr_add_start;
               ca_wr_dina[32:23] <= 0;
               ca_wr_wea <= 1'b1;
               if (ca_rd_doutb_31_23) //////////////////////////// read section points to start add
                  ca_wr_add_start <= ca_rd_doutb[31:23];
               ca_wr_fsm_state <= 19;       
               ca_ready <= 1'b0;
            end 
         end
      2: begin ///////////////////////////////////////////////////
            ca_wr_fsm_state <= 3;
         end
      3: begin ///////////////////////////////////////////////////
            ca_wr_fsm_state <= 4;
            ca_wr_add <= ca_wr_add_start;
         end
      4: begin /////////////////////////////////////////////////// write command at new entry
            ca_wr_fsm_state <= 5;
            ca_wr_add <= ca_wr_add_fill + 1;
            ca_wr_dina <= ca_wr_douta; // command entry
            ca_wr_wea <= 1'b1;
         end
      5: begin ///////////////////////////////////////////////////
            ca_wr_fsm_state <= 6;
            ca_wr_wea <= 1'b0;
            ca_wr_add <= ca_wr_add_start;
         end
      6: begin /////////////////////////////////////////////////// make decision
            if (!ca_wr_douta[32]) begin ////////////////////////// !ca_wr_douta[32]
               ca_wr_add <= ca_wr_add_fill;
               ca_wr_dina <= {10'h200, ca_insert_time};
               ca_wr_wea <= 1'b1;
               if (ca_wr_add_start_marker) begin /////// insert at start
                  ca_wr_add_start <= ca_wr_add_fill;
                  ca_update_rd_add <= 1'b1;
               end
               ca_wr_fsm_state <= 13;
               ca_wr_add_fill <= ca_wr_add_fill_next;
            end else begin
               ca_wr_fsm_state <= 7;
               ca_wr_dina <= {1'b1, ca_wr_add_ptr, ca_wr_douta[22:0]};
               ca_wr_add_ptr <= ca_wr_add;
               ca_wr_add <= ca_wr_douta[31:23];
            end
         end
      7: begin /////////////////////////////////////////////////// check for insertion or appending
            if (ca_end_of_wr_list & !ca_insert) begin
               ca_wr_add <= ca_wr_add_ptr;
               ca_wr_dina[31:23] <= ca_wr_add_fill;
               ca_wr_wea <= 1'b1;
               ca_wr_fsm_state <= 12;
               ca_wr_add_ptr <= 0;
            end else
            if (ca_insert) begin ///////////////////////////////// insert 
               if (ca_wr_add_start_marker) begin /////// insert at start
                  ca_wr_dina <= {1'b1, ca_wr_add_start, ca_insert_time};
                  ca_wr_add <= ca_wr_add_fill;
                  ca_wr_wea <= 1'b1;
                  ca_wr_fsm_state <= 13;
                  ca_wr_add_start <= ca_wr_add_fill;
                  ca_update_rd_add <= 1'b1;
                  ca_wr_add_fill <= ca_wr_add_fill_next;
               end else begin
                  ca_wr_add <= ca_wr_dina[31:23];
                  ca_wr_fsm_state <= 9;
               end
            end else begin /////////////////////////////////////// no insert, read next entry
               ca_wr_fsm_state <= 8;
            end
            ca_wr_add_start_marker <= 1'b0;
         end
      8: begin /////////////////////////////////////////////////// delay due to read next entry
            ca_wr_fsm_state <= 6;
         end
      9: begin /////////////////////////////////////////////////// 
            ca_wr_fsm_state <= 10;
         end
      10: begin /////////////////////////////////////////////////// 
            ca_wr_fsm_state <= 11;
          end  
      11: begin //////////////////////////////////////////////////
            ca_wr_dina <= {1'b1, ca_wr_add_fill, ca_wr_douta[22:0]};
            ca_wr_wea <= 1'b1;
            ca_wr_fsm_state <= 12;
          end
      12: begin ////////////////////////////////////////////////// 
            ca_wr_add <= ca_wr_add_fill;
            ca_wr_dina <= {1'b1, ca_wr_add_ptr, ca_insert_time};
            ca_wr_wea <= 1'b1;
            ca_wr_fsm_state <= 13;
            ca_wr_add_fill <= ca_wr_add_fill_next;
          end
      13: begin ////////////////////////////////////////////////// 
            ca_wr_add <= ca_wr_add_fill;
            ca_wr_fsm_state <= 14;
            ca_wr_wea <= 1'b0;
            ca_update_rd_add <= 1'b0;
          end
      14: begin ////////////////////////////////////////////////// 
            ca_wr_fsm_state <= 15;
          end
      15: begin ////////////////////////////////////////////////// 
            ca_wr_fsm_state <= 16;
          end
      16: if (ca_wr_douta[32]) begin ////////////////////////// ca_wr_douta[32]
             ca_wr_fsm_state <= 13;
             ca_wr_add_fill <= ca_wr_add_fill_next;
          end else begin
             ca_wr_fsm_state <= 1;
             ca_ready <= 1'b1;
          end
      19: begin ////////////////////////////////////////////////// 
             ca_wr_add <= ca_wr_add_start;
            ca_wr_wea <= 1'b0;
            ca_wr_sync_update_done <= 1'b1;
            if (!ca_wr_sync_update) begin
               ca_wr_sync_update_done <= 1'b0; 
               ca_wr_fsm_state <= 1;
               ca_ready <= 1'b1;
            end
          end
      default : ;
   endcase
   ca_end_of_wr_list <= ca_wr_douta[31:23] == 0;
end


///////////////////////////////////////////////////
// memory handling
///////////////////////////////////////////////////
wire [32:0] ca_wr_dina_33 = {1'b0, ca_wr_dina[32], ca_wr_dina[30:0]};
wire [32:0] ca_wr_douta_33;
wire [32:0] ca_rd_doutb_33;

reg [32:0] ca_wr_douta;
reg [32:0] ca_rd_doutb;

always @ (posedge clk_const) begin
   ca_wr_douta <= {ca_wr_douta_33[31], 1'b0, ca_wr_douta_33[30:0]};
   ca_rd_doutb <= {ca_rd_doutb_33[31], 1'b0, ca_rd_doutb_33[30:0]};
end


assign cubev_ca_wea = ~ca_wr_wea;
assign cubev_ca_addra = ca_wr_add;
assign cubev_ca_dina = ca_wr_dina_33;
assign ca_wr_douta_33 = cubev_ca_douta;
assign cubev_ca_addrb = ca_rd_add;
assign ca_rd_doutb_33 = cubev_ca_doutb;


///////////////////////////////////////////////////
// get match
///////////////////////////////////////////////////
// test_overflow:  late-bits: 8
// !test_overflow: late-bits: 12

reg ca_match_check;
reg [22:0] ca_time_diff; 
reg time_dif_neg;    

always @ (posedge clk_const or negedge rstn)
if (~rstn) begin
   ca_match_check <= 0;
   ca_time_diff <= 0;
   time_dif_neg <= 0;
end else
begin
   if (test_overflow) begin 
      time_dif_neg <= ca_time_diff[11:8] == 4'hf;
      if ((ca_time_const[11:8] == 0) &
          (ca_rd_doutb[11:8] == 4'hf)) ///////////////// overflow
         ca_match_check <= 1'b0;
      else
         ca_match_check <= 1'b1;
      ca_time_diff[11:0] <= ca_rd_doutb[11:0] - ca_time_const[11:0];
   end else begin
      time_dif_neg <= ca_time_diff[22:12] == 11'h7ff;
      if ((ca_time_const[22:12] == 0) &
          (ca_rd_doutb[22:12] == 11'h7ff)) ///////////////// overflow
         ca_match_check <= 1'b0;
      else
         ca_match_check <= 1'b1;
      ca_time_diff <= ca_rd_doutb[22:0] - ca_time_const;
   end
end

wire ca_match_int = ca_rd_doutb_32 & 
                    ((ca_match_check) ?
                        ((test_overflow & (ca_time_diff[11:8] == 4'hf)) | 
                        (!test_overflow & (ca_time_diff[22:12] == 11'h7ff))) : 
                        1'b1);

///////////////////////////////////////////////////
// handling memory read
///////////////////////////////////////////////////
reg ca_rd_doutb_32;
reg ca_match_req;
reg ca_end_of_rd_list;  

always @ (posedge clk_const or negedge rstn)
if (~rstn) begin
   ca_rd_add <= 0;
   ca_rd_fsm_state <= 0;
   ca_rd_doutb_32 <= 0;
   ca_match_req <= 0;
   ca_command <= 0;
   ca_end_of_rd_list <= 0;
   ca_wr_sync_update <= 0;
   ca_rd_doutb_31_23 <= 0;
end else begin
   ca_rd_doutb_32 <= ca_rd_doutb[32];
   ca_match_req <= 0;
   ca_rd_doutb_31_23 <= (ca_rd_doutb[31:23] != 0);
   if (ca_update_rd_add) begin /////////////////////////////////// new entry before current one !!!
      ca_rd_add <= ca_wr_add_start;
      ca_rd_fsm_state <= 6;
   end else
   case (ca_rd_fsm_state)
      0: begin /////////////////////////////////////////////////// reset
            ca_rd_add <= 8'h010;
            if (ca_ready) 
               ca_rd_fsm_state <= 1;
         end
      1: begin /////////////////////////////////////////////////// wait
            if (ca_match_int &
               !ca_wr_add_start_marker) begin
               ca_rd_fsm_state <= 2;
               ca_rd_add <= ca_wr_add_start + 1;
            end
         end
      2: begin /////////////////////////////////////////////////// end clean bit
            ca_rd_fsm_state <= 3;
            ca_rd_add <= ca_wr_add_start;
         end
      3: begin
            ca_rd_fsm_state <= 4;
         end
      4: begin
            if (!ca_match_req)
               ca_command <= ca_rd_doutb[31:0];
            ca_match_req <= 1'b1;
            if (ca_match_block_ack)
               ca_rd_fsm_state <= 5;
        end
      5: begin
            ca_wr_sync_update <= 1'b1;
            if (ca_wr_sync_update_done) begin
               ca_rd_fsm_state <= 6;
               ca_rd_add <= ca_wr_add_start;
               ca_wr_sync_update <= 1'b0;
            end
         end
      6: begin
           ca_rd_fsm_state <= 7;
         end
      7: begin  
            ca_rd_fsm_state <= 8;
         end
      8: if (!ca_wr_sync_update_done)
            ca_rd_fsm_state <= 1;
      default : ;
   endcase
end

///////////////////////////////////////////////////
// FSM for async interface
///////////////////////////////////////////////////
reg ca_match_valid; 
reg ca_match_ack_meta;
reg ca_match_block_ack;
reg [1:0] ca_match_hs_state;

always @ (posedge clk_const or negedge rstn)
if (~rstn) begin
   ca_match_hs_state <= 0;
   ca_match_valid <= 0;
   ca_match_block_ack <= 0;
   ca_match_ack_meta <= 0;
end else begin
   ca_match_block_ack <= 0;
   case (ca_match_hs_state) 
   0: if (ca_match_req) begin // <---
         ca_match_valid <= 1'b1;
         ca_match_hs_state <= 1; // <---
         ca_match_block_ack <= 1;
      end
   1: if (ca_match_ack_meta) begin
         ca_match_hs_state <= 2;
         ca_match_valid <= 1'b0;
      end
   2: if (!ca_match_ack_meta) begin // <---
         ca_match_hs_state <= 0; 
      end
   endcase
   ca_match_ack_meta <= ca_match_ack;
end



endmodule

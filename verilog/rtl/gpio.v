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

module gpio (clk,
             rstn,
             gpio_dir_reg,
             gpio_out_reg,
             gpio_in,
             dbus_rdwr_gpio_base,
             dbus_rd_add_bus,
             dbus_wr_add_bus,
             dbus_rdwr_be_in,
             dbus_wr_en,
             dbus_wr_data_in,
             dbus_rd_req,
             dbus_rd_data_out,
             ca_match,
             ca_command_in,
             gpio_event,
             gpio_event_ack,
             gpio_command_out);

//`include "MPSOC_parameters.v" 
parameter GPIO_EVENT_BANKS = 4;
parameter GPIO_OFFSET      = 32'h80030000;
parameter GPIO_BASE        = 16'h8003;
parameter GPIO_STEP        =      12'h100;
parameter GPIO_DIR_CLR     =     16'h0000;
parameter GPIO_DIR_SET     =     16'h0004;
parameter GPIO_OUT_CLR     =     16'h0010;
parameter GPIO_OUT_SET     =     16'h0014;
parameter GPIO_IN          =     16'h0020;
parameter GPIO_LVL0        =     16'h0030;
parameter GPIO_LVL1        =     16'h0034;
parameter GPIO_CAP         =     16'h0040;
parameter GPIO_EVENT_ADD   =     16'h1000;

parameter CORES = 1;
parameter BANKS = 4;
parameter GPIOS = 32;

input clk;
input rstn;
output [GPIOS - 1:0] gpio_dir_reg;
output [GPIOS - 1:0] gpio_out_reg;
input [GPIOS - 1:0] gpio_in;
input [CORES-1:0] dbus_rdwr_gpio_base;
input [31:0] dbus_rd_add_bus;
input [31:0] dbus_wr_add_bus;
input [7:0] dbus_rdwr_be_in;
input [CORES-1:0] dbus_wr_en;
input [31:0] dbus_wr_data_in;
input [CORES-1:0] dbus_rd_req;
output [31:0] dbus_rd_data_out;
input [CORES-1:0] ca_match;
input [31:0] ca_command_in;
output [CORES-1:0] gpio_event;
input [CORES-1:0] gpio_event_ack;
output [31:0] gpio_command_out;

wire [31:0] dbus_rd_add [CORES-1:0];
assign dbus_rd_add[0] = dbus_rd_add_bus[ 31: 0];

wire [31:0] dbus_wr_add [CORES-1:0];
assign dbus_wr_add[0] = dbus_wr_add_bus[ 31: 0];

reg [CORES-1:0] dbus_wr_en_d1;

wire [31:0] dbus_wr_data [CORES-1:0];
reg [31:0] dbus_wr_data_d1 [CORES-1:0];
reg [31:0] dbus_wr_data_d2 [CORES-1:0];
assign dbus_wr_data[0] = dbus_wr_data_in[ 31: 0];

reg [31:0] dbus_rd_data [CORES-1:0];
assign  dbus_rd_data_out = dbus_rd_data[0]; 

always @(posedge clk or negedge rstn)
if (~rstn) begin
   for (l = 0; l < CORES; l = l + 1) begin
     dbus_wr_data_d2[l] <= 0;
     dbus_wr_data_d1[l] <= 0;
     dbus_wr_en_d1[l] <= 1'b0;
   end
end else begin
   for (l = 0; l < CORES; l = l + 1) begin
      dbus_wr_data_d2[l] <= dbus_wr_data_d1[l];
      dbus_wr_data_d1[l] <= dbus_wr_data[l];
      dbus_wr_en_d1[l] <= dbus_wr_en;
   end
end

reg [31:0] ca_command_reg [CORES-1:0];
reg [3:0] ca_match_reg;

always @(posedge clk or negedge rstn)
if (~rstn) begin
   for (l = 0; l < CORES; l = l + 1) begin
      ca_command_reg[l] <= 0;
   end
   ca_match_reg <= 0;
end else begin
   for (l = 0; l < CORES; l = l + 1) begin
      ca_command_reg[l] <= ca_command_in[ 31: 0];
   end
   ca_match_reg <= ca_match;
end

reg [31:0] gpio_command [CORES-1:0];
assign  gpio_command_out = gpio_command[0];

reg [GPIOS - 1:0] gpio_dir_reg;
reg [GPIOS - 1:0] gpio_out_reg;
reg [GPIOS - 1:0] gpio_level_reg;
reg [GPIOS - 1:0] gpio_armed_reg;
reg [GPIO_EVENT_BANKS * 8 - 1:0] gpio_event_reg;
reg [GPIO_EVENT_BANKS * 8 - 1:0] gpio_cap_reg;
reg [1:0] gpio_core_reg [31:0];
reg [GPIOS - 1:0] gpio_in_l1_reg;
reg [GPIOS - 1:0] gpio_in_l2_reg;
reg [GPIOS - 1:0] gpio_in_l3_reg;
reg [GPIOS - 1:0] gpio_in_reg;

integer k, l, m, n;

// CLEAR DIR
reg [14:0] gpio_clr_dir_dbus_reg [CORES-1:0];

always @(posedge clk or negedge rstn)
if (~rstn) begin
   for (l = 0; l < CORES; l = l + 1)
      gpio_clr_dir_dbus_reg[l] <= 0;
end else begin
   for (l = 0; l < CORES; l = l + 1)
      gpio_clr_dir_dbus_reg[l] <= 0;
   for (k = 0; k < BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
         if (dbus_wr_en/* _c3 */[l] & dbus_rdwr_gpio_base/* _c3 */[l] & (dbus_wr_add/* _c3 */[l][15:0] == (k * GPIO_STEP) + GPIO_DIR_CLR))
           gpio_clr_dir_dbus_reg[l][k] <= 1'b1;
      end
   end
end

reg [14:0] gpio_clr_dir_ca_reg [CORES-1:0];

always @(posedge clk or negedge rstn)
if (~rstn) begin
   for (l = 0; l < CORES; l = l + 1)
      gpio_clr_dir_ca_reg[l] <= 0;
end else begin
   for (l = 0; l < CORES; l = l + 1)
      gpio_clr_dir_ca_reg[l] <= 0;
   for (k = 0; k < BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
         if (ca_match_reg[l] & (ca_command_reg[l][/*31:29*/30:28] == 3'b010) & (ca_command_reg[l][11:8] == k))
            gpio_clr_dir_ca_reg[l][k] <= 1'b1;
      end
   end
end

reg [GPIOS - 1:0] gpio_clr_dir_sig;

always @(*) //gpio_clr_dir_dbus_reg or dbus_wr_data_d1/* _c4 */ or gpio_clr_dir_ca_reg or ca_command_reg)
begin
   gpio_clr_dir_sig = 0;                           // overwrite bit-wise
   for (k = 0; k < BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
         if (gpio_clr_dir_dbus_reg[l][k])
            for (m = 0; m < 8; m = m + 1) begin   // go through all bits, bus wide didn't work 
               if (dbus_wr_data_d1/* _c4 */[l][m])
                  gpio_clr_dir_sig[k * 8 + m] = 1'b1;
            end
         if (gpio_clr_dir_ca_reg[l][k])
            for (m = 0; m < 8; m = m + 1) begin   // go through all bits, bus wide didn't work 
               if (ca_command_reg[l][m])
                  gpio_clr_dir_sig[k * 8 + m] = 1'b1;
            end 
      end
   end
end

// SET DIR
reg [14:0] gpio_set_dir_dbus_reg [CORES-1:0];

always @(posedge clk or negedge rstn)
if (~rstn) begin
   for (l = 0; l < CORES; l = l + 1)
      gpio_set_dir_dbus_reg[l] <= 0;
end else begin
   for (l = 0; l < CORES; l = l + 1)
      gpio_set_dir_dbus_reg[l] <= 0;
   for (k = 0; k < BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
         if (dbus_wr_en/* _c3 */[l] & dbus_rdwr_gpio_base/* _c3 */[l] & (dbus_wr_add/* _c3 */[l][15:0] == (k * GPIO_STEP) + GPIO_DIR_SET))
            gpio_set_dir_dbus_reg[l][k] <= 1'b1;
      end
   end
end

reg [14:0] gpio_set_dir_ca_reg [CORES-1:0];

always @(posedge clk or negedge rstn)
if (~rstn) begin
   for (l = 0; l < CORES; l = l + 1)
      gpio_set_dir_ca_reg[l] <= 0;
end else begin
   for (l = 0; l < CORES; l = l + 1)
      gpio_set_dir_ca_reg[l] <= 0;
   for (k = 0; k < BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all 4 cores addressing possibilities
         if (ca_match_reg[l] & (ca_command_reg[l][/*31:29*/30:28] == 3'b011) & (ca_command_reg[l][11:8] == k))
            gpio_set_dir_ca_reg[l][k] <= 1'b1;
      end
   end
end

reg [GPIOS - 1:0] gpio_set_dir_sig;

always @(*)
begin
   gpio_set_dir_sig = 0;                           // overwrite bit-wise
   for (k = 0; k < BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
         if (gpio_set_dir_dbus_reg[l][k])
            for (m = 0; m < 8; m = m + 1) begin   // go through all bits, bus wide didn't work 
               if (dbus_wr_data_d1/* _c4 */[l][m])
                  gpio_set_dir_sig[k * 8 + m] = 1'b1;
            end 
         if (gpio_set_dir_ca_reg[l][k])
            for (m = 0; m < 8; m = m + 1) begin   // go through all bits, bus wide didn't work 
               if (ca_command_reg[l][m])
                  gpio_set_dir_sig[k * 8 + m] = 1'b1;
            end 
      end
   end
end

// DIR
always @(posedge clk or negedge rstn)
if (~rstn) begin
   gpio_dir_reg <= 0;
end else begin
   gpio_dir_reg <= (gpio_dir_reg | gpio_set_dir_sig) & (~gpio_clr_dir_sig);
end


// CLEAR OUT
reg [14:0] gpio_clr_out_dbus_reg [CORES-1:0];
always @(posedge clk or negedge rstn)
if (~rstn) begin
   for (l = 0; l < CORES; l = l + 1)
      gpio_clr_out_dbus_reg[l] <= 0;
end else begin
   for (l = 0; l < CORES; l = l + 1)
      gpio_clr_out_dbus_reg[l] <= 0;
   for (k = 0; k < BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
         if (dbus_wr_en/* _c3 */[l] & dbus_rdwr_gpio_base/* _c3 */[l] & (dbus_wr_add/* _c3 */[l][15:0] == (k * GPIO_STEP) + GPIO_OUT_CLR))
            gpio_clr_out_dbus_reg[l][k] <= 1'b1;
       end
   end
end

reg [14:0] gpio_clr_out_ca_reg [CORES-1:0];
always @(posedge clk or negedge rstn)
if (~rstn) begin
   for (l = 0; l < CORES; l = l + 1)
      gpio_clr_out_ca_reg[l] <= 0;
end else begin
   for (l = 0; l < CORES; l = l + 1)
      gpio_clr_out_ca_reg[l] <= 0;
   for (k = 0; k < BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all 4 cores addressing possibilities
         if (ca_match_reg[l] & (ca_command_reg[l][/*31:29*/30:28] == 3'b000) & (ca_command_reg[l][11:8] == k))
            gpio_clr_out_ca_reg[l][k] <= 1'b1;
       end
   end
end

reg [GPIOS - 1:0] gpio_clr_out_sig;
always @(*)
begin
   gpio_clr_out_sig = 0;                               // overwrite bit-wise
   for (k = 0; k < BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
         if (gpio_clr_out_dbus_reg[l][k])
            for (m = 0; m < 8; m = m + 1) begin   // go through all bits, bus wide didn't work 
               if (dbus_wr_data_d1[l][m])
                  gpio_clr_out_sig[k * 8 + m] = 1'b1;
            end
         if (gpio_clr_out_ca_reg[l][k])
            for (m = 0; m < 8; m = m + 1) begin   // go through all bits, bus wide didn't work 
               if (ca_command_reg[l][m])
                  gpio_clr_out_sig[k * 8 + m] = 1'b1;
            end 
       end
   end
end

// SET OUT
reg [14:0] gpio_set_out_dbus_reg [CORES-1:0];

always @(posedge clk or negedge rstn)
if (~rstn) begin
   for (l = 0; l < CORES; l = l + 1)
      gpio_set_out_dbus_reg[l] <= 0;
end else begin
   for (l = 0; l < CORES; l = l + 1)
      gpio_set_out_dbus_reg[l] <= 0;
   for (k = 0; k < BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
         if (dbus_wr_en/* _c3 */[l] & dbus_rdwr_gpio_base/* _c3 */[l] & (dbus_wr_add/* _c3 */[l][15:0] == (k * GPIO_STEP) + GPIO_OUT_SET))
            gpio_set_out_dbus_reg[l][k] <= 1'b1;
       end
   end
end

reg [14:0] gpio_set_out_ca_reg [CORES-1:0];

always @(posedge clk or negedge rstn)
if (~rstn) begin
   for (l = 0; l < CORES; l = l + 1)
      gpio_set_out_ca_reg[l] <= 0;
end else begin
   for (l = 0; l < CORES; l = l + 1)
      gpio_set_out_ca_reg[l] <= 0;
   for (k = 0; k < BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
         if (ca_match_reg[l] & (ca_command_reg[l][/*31:29*/30:28] == 3'b001) & (ca_command_reg[l][11:8] == k))
            gpio_set_out_ca_reg[l][k] <= 1'b1;
       end
   end
end

reg [GPIOS - 1:0] gpio_set_out_sig;

always @(*)
begin
   gpio_set_out_sig = 0;                               // overwrite bit-wise
   for (k = 0; k < BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
         if (gpio_set_out_dbus_reg[l][k])
            for (m = 0; m < 8; m = m + 1) begin   // go through all bits, bus wide didn't work 
               if (dbus_wr_data_d1[l][m])
                  gpio_set_out_sig[k * 8 + m] = 1'b1;
            end 
         if (gpio_set_out_ca_reg[l][k])
            for (m = 0; m < 8; m = m + 1) begin   // go through all bits, bus wide didn't work 
               if (ca_command_reg[l][m])
                  gpio_set_out_sig[k * 8 + m] = 1'b1;
            end 
       end
   end
end

// OUT
always @(posedge clk or negedge rstn)
if (~rstn) begin
   gpio_out_reg <= 0;
end else begin
   gpio_out_reg <= (gpio_out_reg | gpio_set_out_sig) & (~gpio_clr_out_sig);
end

// Filter IN
always @(posedge clk or negedge rstn)
if (~rstn) begin
   gpio_in_l1_reg <= 0;
   gpio_in_l2_reg <= 0;
   gpio_in_l3_reg <= 0;
   gpio_in_reg <= 0;
end else begin
   gpio_in_reg <= (gpio_in_l3_reg & gpio_in_l2_reg) |
                  (gpio_in_l3_reg & gpio_in_l1_reg) |
                  (gpio_in_l2_reg & gpio_in_l1_reg);
   gpio_in_l3_reg <= gpio_in_l2_reg;
   gpio_in_l2_reg <= gpio_in_l1_reg;
   gpio_in_l1_reg <= gpio_in;
end

// read
reg [14:0] gpio_rd_sel_in_reg [CORES-1:0];
reg [14:0] gpio_rd_sel_cap_reg [CORES-1:0];


always @(dbus_rd_req or dbus_rdwr_gpio_base) begin
   for (l = 0; l < CORES; l = l + 1) begin
      gpio_rd_sel_in_reg[l] <= 0;
      gpio_rd_sel_cap_reg[l] <= 0;
   end
   for (k = 0; k < BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
         if (dbus_rd_req[l] & dbus_rdwr_gpio_base/* _c3 */[l] &
             (dbus_rd_add[l][15:0] == ((k * GPIO_STEP) + GPIO_IN))) begin
            gpio_rd_sel_in_reg[l][k] <= 1'b1;
         end else if (dbus_rd_req[l] & dbus_rdwr_gpio_base[l] &
                      (dbus_rd_add[l][15:0] == ((k * GPIO_STEP) + GPIO_CAP))) begin
             gpio_rd_sel_cap_reg[l][k] <= 1'b1;
         end
      end
   end
end

reg [7:0] gpio_rd_data_in [CORES-1:0][BANKS-1:0];
reg [7:0] gpio_rd_data_cap [CORES-1:0][BANKS-1:0];

always @(*)
begin
   for (k = 0; k < BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
         if (gpio_rd_sel_in_reg[l][k]) begin
            for (m = 0; m < 8; m = m + 1) begin   // go through all bits, bus wide didn't work 
               gpio_rd_data_in[l][k][m] = gpio_in_reg[k * 8 + m];
            end
         end else
            gpio_rd_data_in[l][k] = 0;
         if (gpio_rd_sel_cap_reg[l][k]) begin
            for (m = 0; m < 8; m = m + 1) begin   // go through all bits, bus wide didn't work 
               gpio_rd_data_cap[l][k][m] = gpio_cap_reg[k * 8 + m];
            end
         end else
            gpio_rd_data_cap[l][k] = 0;
      end
   end
end


always @(*)
begin
   for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
      dbus_rd_data[l][7:0] = gpio_rd_data_in[l][0] |
                             gpio_rd_data_in[l][1] |
                             gpio_rd_data_in[l][2] |
                             gpio_rd_data_in[l][3] |
                             gpio_rd_data_cap[l][0] |
                             gpio_rd_data_cap[l][1] |
                             gpio_rd_data_cap[l][2] |
                             gpio_rd_data_cap[l][3];
   end
end


// LEVEL 
reg [CORES-1:0] gpio_event;

always @(*) begin
for (l = 0; l < CORES; l = l + 1) begin             // go through all 4 core 
   gpio_event[l] = !(gpio_prop_p4_fsm[l] == 0) & !gpio_event_ack;
end
end

reg [CORES-1:0] gpio_command_reg;

always @(posedge clk or negedge rstn)
if (~rstn) begin
   gpio_command_reg <= 0;
end else begin
   gpio_command_reg <= 0;
   for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
      if (dbus_wr_en/* _c3 */[l] & dbus_rdwr_gpio_base/* _c3 */[l] & (dbus_wr_add/* _c3 */[l][15:0] == GPIO_EVENT_ADD))
         gpio_command_reg[l] <= 1'b1;
   end
end

reg [1:0] gpio_prop_p4_fsm [CORES-1:0];
reg [1:0] gpio_prop_p4_ack;

always @(posedge clk or negedge rstn)
if (~rstn) begin
   gpio_prop_p4_ack <= 0;
   for (l = 0; l < CORES; l = l + 1) begin
      gpio_prop_p4_fsm[l] <= 0;  
   end
   for (l = 0; l < CORES; l = l + 1) begin
      gpio_command[l] <= 0; 
   end
end else begin   
   gpio_command[0][30] <= 1'b1;
   for (l = 0; l < CORES; l = l + 1)                   // go through all CORES cores addressing possibilities
      if (gpio_command_reg[l])
         gpio_command[l][13:0] <= dbus_wr_data_d1/* _c4 */[l][13:0];
   /////////////////////////////////////
   // event propagation, pipe 4
   /////////////////////////////////////
   gpio_prop_p4_ack <= 0;  
   for (l = 0; l < CORES; l = l + 1) begin             // go through all 4 core 
      if (gpio_prop_p4_fsm[l] == 0) begin          // empty pipe element
         if (gpio_prop_p3_fsm[l * 2 + 0]) begin    // go through nibble group
            gpio_prop_p4_fsm[l] <= 0 + 1;          // state = bit count + 1
            gpio_command[l][19:14] <= {gpio_prop_p3_fsm[l * 2 + 0][1:0] - 1, gpio_prop_p3_tag[l * 2 + 0]};  
            gpio_command[l][20] <= 1'b0;  
            gpio_prop_p4_ack[l * 2 + 0] <= 1'b1;
         end else if (gpio_prop_p3_fsm[l * 2 + 1]) begin
            gpio_prop_p4_fsm[l] <= 1 + 1;
            gpio_command[l][19:14] <= {gpio_prop_p3_fsm[l * 2 + 1][1:0] - 1, gpio_prop_p3_tag[l * 2 + 1]};  
            gpio_command[l][20] <= 1'b1;
            gpio_prop_p4_ack[l * 2 + 1] <= 1'b1;
         end
      end else if (gpio_event_ack[l]) begin 
         case (gpio_prop_p4_fsm[l])                 // synopsys full_case
         1: if (gpio_prop_p3_fsm[l * 2 + 1]) begin
               gpio_prop_p4_fsm[l] <= 1 + 1;
               gpio_command[l][19:14] <= {gpio_prop_p3_fsm[l * 2 + 1][1:0] - 1, gpio_prop_p3_tag[l * 2 + 1]};  
               gpio_command[l][20] <= 1'b1;
               gpio_prop_p4_ack[l * 2 + 1] <= 1'b1;
            end else
               gpio_prop_p4_fsm[l] <= 0;
         2: if (gpio_prop_p3_fsm[l * 2 + 0]) begin
               gpio_prop_p4_fsm[l] <= 0 + 1;
               gpio_command[l][19:14] <= {gpio_prop_p3_fsm[l * 2 + 0][1:0] - 1, gpio_prop_p3_tag[l * 2 + 0]};  
               gpio_command[l][20] <= 1'b0;
               gpio_prop_p4_ack[l * 2 + 0] <= 1'b1;
            end else
               gpio_prop_p4_fsm[l] <= 0;
         default : ;
         endcase
      end
   end
end

reg [2:0] gpio_prop_p3_fsm [1:0];
reg [3:0] gpio_prop_p3_tag [1:0];
reg [7:0] gpio_prop_p3_ack;

always @(posedge clk or negedge rstn)
if (~rstn) begin
   gpio_prop_p3_ack <= 0;  
   for (l = 0; l < 2; l = l + 1) begin
      gpio_prop_p3_fsm[l] <= 0;
      gpio_prop_p3_tag[l] <= 0;
   end
end else begin
   /////////////////////////////////////
   // event propagation, pipe 3
   /////////////////////////////////////
   gpio_prop_p3_ack <= 0;
   for (l = 0; l < CORES; l = l + 1) begin             // go through all 4 core 
      for (k = 0; k < 2; k = k + 1) begin          // go through all nibble groups
         if (gpio_prop_p3_fsm[l * 2 + k] == 0) begin // empty pipe element
            if (gpio_prop_p2_fsm[l * 8 + k * 4 + 0]) begin // go through nibble group
                gpio_prop_p3_fsm[l * 2 + k] <= 0 + 1; // state = bit count + 1
                gpio_prop_p3_tag[l * 2 + k] <= {gpio_prop_p2_fsm[l * 8 + k * 4 + 0] - 1, gpio_prop_p2_tag[l * 8 + k * 4 + 0]};  
                gpio_prop_p3_ack[l * 8 + k * 4 + 0] <= 1'b1;
            end else if (gpio_prop_p2_fsm[l * 8 + k * 4 + 1]) begin
                gpio_prop_p3_fsm[l * 2 + k] <= 1 + 1;
                gpio_prop_p3_tag[l * 2 + k] <= {gpio_prop_p2_fsm[l * 8 + k * 4 + 1] - 1, gpio_prop_p2_tag[l * 8 + k * 4 + 1]};  
                gpio_prop_p3_ack[l * 8 + k * 4 + 1] <= 1'b1;
            end else if (gpio_prop_p2_fsm[l * 8 + k * 4 + 2]) begin
                gpio_prop_p3_fsm[l * 2 + k] <= 2 + 1;
                gpio_prop_p3_tag[l * 2 + k] <= {gpio_prop_p2_fsm[l * 8 + k * 4 + 2] - 1, gpio_prop_p2_tag[l * 8 + k * 4 + 2]};  
                gpio_prop_p3_ack[l * 8 + k * 4 + 2] <= 1'b1;
            end else if (gpio_prop_p2_fsm[l * 8 + k * 4 + 3]) begin
                gpio_prop_p3_fsm[l * 2 + k] <= 3 + 1;
                gpio_prop_p3_tag[l * 2 + k] <= {gpio_prop_p2_fsm[l * 8 + k * 4 + 3] - 1, gpio_prop_p2_tag[l * 8 + k * 4 + 3]};  
                gpio_prop_p3_ack[l * 8 + k * 4 + 3] <= 1'b1;
            end
         end else if (gpio_prop_p4_ack[l * 2 + k]) begin 
         case (gpio_prop_p3_fsm[l * 2 + k])       // synopsys full_case
            1: if (gpio_prop_p2_fsm[l * 8 + k * 4 + 1]) begin
                  gpio_prop_p3_fsm[l * 2 + k] <= 1 + 1;
                  gpio_prop_p3_tag[l * 2 + k] <= {gpio_prop_p2_fsm[l * 8 + k * 4 + 1] - 1, gpio_prop_p2_tag[l * 8 + k * 4 + 1]};  
                  gpio_prop_p3_ack[l * 8 + k * 4 + 1] <= 1'b1;
               end else if (gpio_prop_p2_fsm[l * 8 + k * 4 + 2]) begin
                  gpio_prop_p3_fsm[l * 2 + k] <= 2 + 1;
                  gpio_prop_p3_tag[l * 2 + k] <= {gpio_prop_p2_fsm[l * 8 + k * 4 + 2] - 1, gpio_prop_p2_tag[l * 8 + k * 4 + 2]};  
                  gpio_prop_p3_ack[l * 8 + k * 4 + 2] <= 1'b1;
               end else if (gpio_prop_p2_fsm[l * 8 + k * 4 + 3]) begin
                  gpio_prop_p3_fsm[l * 2 + k] <= 3 + 1;
                  gpio_prop_p3_tag[l * 2 + k] <= {gpio_prop_p2_fsm[l * 8 + k * 4 + 3] - 1, gpio_prop_p2_tag[l * 8 + k * 4 + 3]};  
                  gpio_prop_p3_ack[l * 8 + k * 4 + 3] <= 1'b1;
               end else
                  gpio_prop_p3_fsm[l * 2 + k] <= 0;
            2: if (gpio_prop_p2_fsm[l * 8 + k * 4 + 2]) begin
                  gpio_prop_p3_fsm[l * 2 + k] <= 2 + 1;
                  gpio_prop_p3_tag[l * 2 + k] <= {gpio_prop_p2_fsm[l * 8 + k * 4 + 2] - 1, gpio_prop_p2_tag[l * 8 + k * 4 + 2]};  
                  gpio_prop_p3_ack[l * 8 + k * 4 + 2] <= 1'b1;
               end else if (gpio_prop_p2_fsm[l * 8 + k * 4 + 3]) begin
                  gpio_prop_p3_fsm[l * 2 + k] <= 3 + 1;
                  gpio_prop_p3_tag[l * 2 + k] <= {gpio_prop_p2_fsm[l * 8 + k * 4 + 3] - 1, gpio_prop_p2_tag[l * 8 + k * 4 + 3]};  
                  gpio_prop_p3_ack[l * 8 + k * 4 + 3] <= 1'b1;
               end else if (gpio_prop_p2_fsm[l * 8 + k * 4 + 0]) begin
                  gpio_prop_p3_fsm[l * 2 + k] <= 0 + 1;
                  gpio_prop_p3_tag[l * 2 + k] <= {gpio_prop_p2_fsm[l * 8 + k * 4 + 0] - 1, gpio_prop_p2_tag[l * 8 + k * 4 + 0]};  
                  gpio_prop_p3_ack[l * 8 + k * 4 + 0] <= 1'b1;
               end else
                  gpio_prop_p3_fsm[l * 2 + k] <= 0;
            3: if (gpio_prop_p2_fsm[l * 8 + k * 4 + 3]) begin
                  gpio_prop_p3_fsm[l * 2 + k] <= 3 + 1;
                  gpio_prop_p3_tag[l * 2 + k] <= {gpio_prop_p2_fsm[l * 8 + k * 4 + 3] - 1, gpio_prop_p2_tag[l * 8 + k * 4 + 3]};  
                  gpio_prop_p3_ack[l * 8 + k * 4 + 3] <= 1'b1;
               end else if (gpio_prop_p2_fsm[l * 8 + k * 4 + 0]) begin
                  gpio_prop_p3_fsm[l * 2 + k] <= 0 + 1;
                  gpio_prop_p3_tag[l * 2 + k] <= {gpio_prop_p2_fsm[l * 8 + k * 4 + 0] - 1, gpio_prop_p2_tag[l * 8 + k * 4 + 0]};  
                  gpio_prop_p3_ack[l * 8 + k * 4 + 0] <= 1'b1;
               end else if (gpio_prop_p2_fsm[l * 8 + k * 4 + 1]) begin
                  gpio_prop_p3_fsm[l * 2 + k] <= 1 + 1;
                  gpio_prop_p3_tag[l * 2 + k] <= {gpio_prop_p2_fsm[l * 8 + k * 4 + 1] - 1, gpio_prop_p2_tag[l * 8 + k * 4 + 1]};  
                  gpio_prop_p3_ack[l * 8 + k * 4 + 1] <= 1'b1;
               end else
                  gpio_prop_p3_fsm[l * 2 + k] <= 0;
            4: if (gpio_prop_p2_fsm[l * 8 + k * 4 + 0]) begin
                  gpio_prop_p3_fsm[l * 2 + k] <= 0 + 1;
                  gpio_prop_p3_tag[l * 2 + k] <= {gpio_prop_p2_fsm[l * 8 + k * 4 + 0] - 1, gpio_prop_p2_tag[l * 8 + k * 4 + 0]};  
                  gpio_prop_p3_ack[l * 8 + k * 4 + 0] <= 1'b1;
               end else if (gpio_prop_p2_fsm[l * 8 + k * 4 + 1]) begin
                  gpio_prop_p3_fsm[l * 2 + k] <= 1 + 1;
                  gpio_prop_p3_tag[l * 2 + k] <= {gpio_prop_p2_fsm[l * 8 + k * 4 + 1] - 1, gpio_prop_p2_tag[l * 8 + k * 4 + 1]};  
                  gpio_prop_p3_ack[l * 8 + k * 4 + 1] <= 1'b1;
               end else if (gpio_prop_p2_fsm[l * 8 + k * 4 + 2]) begin
                  gpio_prop_p3_fsm[l * 2 + k] <= 2 + 1;
                  gpio_prop_p3_tag[l * 2 + k] <= {gpio_prop_p2_fsm[l * 8 + k * 4 + 2] - 1, gpio_prop_p2_tag[l * 8 + k * 4 + 2]};  
                  gpio_prop_p3_ack[l * 8 + k * 4 + 2] <= 1'b1;
               end else
                  gpio_prop_p3_fsm[l * 2 + k] <= 0;
            default : ;
            endcase
         end
      end
   end
end

reg [2:0] gpio_prop_p2_fsm [7:0];
reg [1:0] gpio_prop_p2_tag [7:0];
reg [31:0] gpio_prop_p2_ack;

always @(posedge clk or negedge rstn)
if (~rstn) begin
   gpio_prop_p2_ack <= 0;  
   for (l = 0; l < 8; l = l + 1) begin
      gpio_prop_p2_fsm[l] <= 0;
      gpio_prop_p2_tag[l] <= 0;
   end
end else begin
   /////////////////////////////////////
   // event propagation, pipe 2
   /////////////////////////////////////
   gpio_prop_p2_ack <= 0;  
   for (l = 0; l < CORES; l = l + 1) begin             // go through all 4 core 
      for (k = 0; k < 8; k = k + 1) begin          // go through all nibble groups
         if (gpio_prop_p2_fsm[l * 8 + k] == 0) begin // empty pipe element
            if (gpio_prop_p1_fsm[l * 32 + k * 4 + 0]) begin // go through nibble group
                gpio_prop_p2_fsm[l * 8 + k] <= 0 + 1; // state = bit count + 1
                gpio_prop_p2_tag[l * 8 + k] <= {gpio_prop_p1_fsm[l * 32 + k * 4 + 0] - 1, gpio_prop_p1_tag[l * 32 + k * 4 + 0][0]};  
                gpio_prop_p2_ack[l * 32 + k * 4 + 0] <= 1'b1;
            end else if (gpio_prop_p1_fsm[l * 32 + k * 4 + 1]) begin
                gpio_prop_p2_fsm[l * 8 + k] <= 1 + 1;
                //gpio_prop_p2_tag[l * 8 + k] <= 0;  
                gpio_prop_p2_tag[l * 8 + k] <= {gpio_prop_p1_fsm[l * 32 + k * 4 + 1] - 1, gpio_prop_p1_tag[l * 32 + k * 4 + 1][0]};  
                gpio_prop_p2_ack[l * 32 + k * 4 + 1] <= 1'b1;
            end else if (gpio_prop_p1_fsm[l * 32 + k * 4 + 2]) begin
                gpio_prop_p2_fsm[l * 8 + k] <= 2 + 1;
                gpio_prop_p2_tag[l * 8 + k] <= {gpio_prop_p1_fsm[l * 32 + k * 4 + 2] - 1, gpio_prop_p1_tag[l * 32 + k * 4 + 2][0]};  
                gpio_prop_p2_ack[l * 32 + k * 4 + 2] <= 1'b1;
            end else if (gpio_prop_p1_fsm[l * 32 + k * 4 + 3]) begin
                gpio_prop_p2_fsm[l * 8 + k] <= 3 + 1;
                gpio_prop_p2_tag[l * 8 + k] <= {gpio_prop_p1_fsm[l * 32 + k * 4 + 3] - 1, gpio_prop_p1_tag[l * 32 + k * 4 + 3][0]};  
                gpio_prop_p2_ack[l * 32 + k * 4 + 3] <= 1'b1;
            end
         end else if (gpio_prop_p3_ack[l * 8 + k]) begin 
            case (gpio_prop_p2_fsm[l * 8 + k])       // round robin
            1: if (gpio_prop_p1_fsm[l * 32 + k * 4 + 1]) begin
                  gpio_prop_p2_fsm[l * 8 + k] <= 1 + 1;
                  gpio_prop_p2_tag[l * 8 + k] <= {gpio_prop_p1_fsm[l * 32 + k * 4 + 1] - 1, gpio_prop_p1_tag[l * 32 + k * 4 + 1][0]};  
                  gpio_prop_p2_ack[l * 32 + k * 4 + 1] <= 1'b1;
               end else if (gpio_prop_p1_fsm[l * 32 + k * 4 + 2]) begin
                  gpio_prop_p2_fsm[l * 8 + k] <= 2 + 1;
                  gpio_prop_p2_tag[l * 8 + k] <= {gpio_prop_p1_fsm[l * 32 + k * 4 + 2] - 1, gpio_prop_p1_tag[l * 32 + k * 4 + 2][0]};  
                  gpio_prop_p2_ack[l * 32 + k * 4 + 2] <= 1'b1;
               end else if (gpio_prop_p1_fsm[l * 32 + k * 4 + 3]) begin
                  gpio_prop_p2_fsm[l * 8 + k] <= 3 + 1;
                  gpio_prop_p2_tag[l * 8 + k] <= {gpio_prop_p1_fsm[l * 32 + k * 4 + 3] - 1, gpio_prop_p1_tag[l * 32 + k * 4 + 3][0]};  
                  gpio_prop_p2_ack[l * 32 + k * 4 + 3] <= 1'b1;
               end else
                  gpio_prop_p2_fsm[l * 8 + k] <= 0;
            2: if (gpio_prop_p1_fsm[l * 32 + k * 4 + 2]) begin
                  gpio_prop_p2_fsm[l * 8 + k] <= 2 + 1;
                  gpio_prop_p2_tag[l * 8 + k] <= {gpio_prop_p1_fsm[l * 32 + k * 4 + 2] - 1, gpio_prop_p1_tag[l * 32 + k * 4 + 2][0]};  
                  gpio_prop_p2_ack[l * 32 + k * 4 + 2] <= 1'b1;
               end else if (gpio_prop_p1_fsm[l * 32 + k * 4 + 3]) begin
                  gpio_prop_p2_fsm[l * 8 + k] <= 3 + 1;
                  gpio_prop_p2_tag[l * 8 + k] <= {gpio_prop_p1_fsm[l * 32 + k * 4 + 3] - 1, gpio_prop_p1_tag[l * 32 + k * 4 + 3][0]};  
                  gpio_prop_p2_ack[l * 32 + k * 4 + 3] <= 1'b1;
               end else if (gpio_prop_p1_fsm[l * 32 + k * 4 + 0]) begin
                  gpio_prop_p2_fsm[l * 8 + k] <= 0 + 1;
                  gpio_prop_p2_tag[l * 8 + k] <= {gpio_prop_p1_fsm[l * 32 + k * 4 + 0] - 1, gpio_prop_p1_tag[l * 32 + k * 4 + 0][0]};  
                  gpio_prop_p2_ack[l * 32 + k * 4 + 0] <= 1'b1;
               end else
                  gpio_prop_p2_fsm[l * 8 + k] <= 0;
            3: if (gpio_prop_p1_fsm[l * 32 + k * 4 + 3]) begin
                  gpio_prop_p2_fsm[l * 8 + k] <= 3 + 1;
                  gpio_prop_p2_tag[l * 8 + k] <= {gpio_prop_p1_fsm[l * 32 + k * 4 + 3] - 1, gpio_prop_p1_tag[l * 32 + k * 4 + 3][0]};  
                  gpio_prop_p2_ack[l * 32 + k * 4 + 3] <= 1'b1;
               end else if (gpio_prop_p1_fsm[l * 32 + k * 4 + 0]) begin
                  gpio_prop_p2_fsm[l * 8 + k] <= 0 + 1;
                  gpio_prop_p2_tag[l * 8 + k] <= {gpio_prop_p1_fsm[l * 32 + k * 4 + 0] - 1, gpio_prop_p1_tag[l * 32 + k * 4 + 0][0]};  
                  gpio_prop_p2_ack[l * 32 + k * 4 + 0] <= 1'b1;
               end else if (gpio_prop_p1_fsm[l * 32 + k * 4 + 1]) begin
                  gpio_prop_p2_fsm[l * 8 + k] <= 1 + 1;
                  gpio_prop_p2_tag[l * 8 + k] <= {gpio_prop_p1_fsm[l * 32 + k * 4 + 1] - 1, gpio_prop_p1_tag[l * 32 + k * 4 + 1][0]};  
                  gpio_prop_p2_ack[l * 32 + k * 4 + 1] <= 1'b1;
               end else
                  gpio_prop_p2_fsm[l * 8 + k] <= 0;
            4: if (gpio_prop_p1_fsm[l * 32 + k * 4 + 0]) begin
                  gpio_prop_p2_fsm[l * 8 + k] <= 0 + 1;
                  gpio_prop_p2_tag[l * 8 + k] <= {gpio_prop_p1_fsm[l * 32 + k * 4 + 0] - 1, gpio_prop_p1_tag[l * 32 + k * 4 + 0][0]};  
                  gpio_prop_p2_ack[l * 32 + k * 4 + 0] <= 1'b1;
               end else if (gpio_prop_p1_fsm[l * 32 + k * 4 + 1]) begin
                  gpio_prop_p2_fsm[l * 8 + k] <= 1 + 1;
                  gpio_prop_p2_tag[l * 8 + k] <= {gpio_prop_p1_fsm[l * 32 + k * 4 + 1] - 1, gpio_prop_p1_tag[l * 32 + k * 4 + 1][0]};  
                  gpio_prop_p2_ack[l * 32 + k * 4 + 1] <= 1'b1;
               end else if (gpio_prop_p1_fsm[l * 32 + k * 4 + 2]) begin
                  gpio_prop_p2_fsm[l * 8 + k] <= 2 + 1;
                  gpio_prop_p2_tag[l * 8 + k] <= {gpio_prop_p1_fsm[l * 32 + k * 4 + 2] - 1, gpio_prop_p1_tag[l * 32 + k * 4 + 2][0]};  
                  gpio_prop_p2_ack[l * 32 + k * 4 + 2] <= 1'b1;
               end else
                  gpio_prop_p2_fsm[l * 8 + k] <= 0;
            default : ;
            endcase
         end
      end
   end
end


reg [1:0] gpio_prop_p1_fsm [31:0];
reg [1:0] gpio_prop_p1_tag [31:0];
reg [63:0] gpio_prop_p1_ack;

always @(posedge clk or negedge rstn)
if (~rstn) begin
   gpio_prop_p1_ack <= 0;  
   for (l = 0; l < 32; l = l + 1) begin
      gpio_prop_p1_fsm[l] <= 0;
      gpio_prop_p1_tag[l] <= 0;
   end
end else begin
   /////////////////////////////////////
   // event propagation, pipe 1
   /////////////////////////////////////
   gpio_prop_p1_ack <= 0;  
   for (l = 0; l < CORES; l = l + 1) begin             // go through all CORES cores
      for (k = 0; k < GPIO_EVENT_BANKS; k = k + 1) begin          // go through all nibble groups
         for (n = 0; n < 2; n = n + 1) begin       // go through all 2 nibbles
            if (gpio_prop_p1_fsm[l * 32 + k * 2 + n] == 0) begin // empty pipe element
               if (gpio_prop_p0_fsm[l * 64 + k * 4 + n * 2 + 0]) begin // go through nibble group
                   gpio_prop_p1_fsm[l * 32 + k * 2 + n] <= 0 + 1; // state = bit count + 1
                   gpio_prop_p1_tag[l * 32 + k * 2 + n] <= gpio_prop_p0_fsm[l * 64 + k * 4 + n * 2 + 0] - 1;  
                   gpio_prop_p1_ack[l * 64 + k * 4 + n * 2 + 0] <= 1'b1;
               end else if (gpio_prop_p0_fsm[l * 64 + k * 4 + n * 2 + 1]) begin
                   gpio_prop_p1_fsm[l * 32 + k * 2 + n] <= 1 + 1;
                   gpio_prop_p1_tag[l * 32 + k * 2 + n] <= gpio_prop_p0_fsm[l * 64 + k * 4 + n * 2 + 1] - 1;  
                   gpio_prop_p1_ack[l * 64 + k * 4 + n * 2 + 1] <= 1'b1;
               end
            end else if (gpio_prop_p2_ack[l * 32 + k * 2 + n]) begin 
               case (gpio_prop_p1_fsm[l * 32 + k * 2 + n])       // synopsys full_case
               1: if (gpio_prop_p0_fsm[l * 64 + k * 4 + n * 2 + 1]) begin
                     gpio_prop_p1_fsm[l * 32 + k * 2 + n] <= 1 + 1;
                     gpio_prop_p1_tag[l * 32 + k * 2 + n] <= gpio_prop_p0_fsm[l * 64 + k * 4 + n * 2 + 1] - 1;  
                     gpio_prop_p1_ack[l * 64 + k * 4 + n * 2 + 1] <= 1'b1;
                  end else
                     gpio_prop_p1_fsm[l * 32 + k * 2 + n] <= 0;
               2: if (gpio_prop_p0_fsm[l * 64 + k * 4 + n * 2 + 0]) begin
                     gpio_prop_p1_fsm[l * 32 + k * 2 + n] <= 0 + 1;
                     gpio_prop_p1_tag[l * 32 + k * 2 + n] <= gpio_prop_p0_fsm[l * 64 + k * 4 + n * 2 + 0] - 1;  
                     gpio_prop_p1_ack[l * 64 + k * 4 + n * 2 + 0] <= 1'b1;
                  end else
                     gpio_prop_p1_fsm[l * 32 + k * 2 + n] <= 0;
               default : ;
               endcase
            end
         end
      end
   end
end

reg [GPIO_EVENT_BANKS-1:0] gpio_sel_lvl0_reg [CORES-1:0];
reg [GPIO_EVENT_BANKS-1:0] gpio_sel_lvl1_reg [CORES-1:0];

always @(posedge clk or negedge rstn)
if (~rstn) begin
   for (l = 0; l < CORES; l = l + 1) begin
      gpio_sel_lvl0_reg[l] <= 0;
      gpio_sel_lvl1_reg[l] <= 0;
   end
end else begin
   for (l = 0; l < CORES; l = l + 1) begin
      gpio_sel_lvl0_reg[l] <= 0;
      gpio_sel_lvl1_reg[l] <= 0;
   end
   for (k = 0; k < GPIO_EVENT_BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
         if ((dbus_wr_add/* _c2 */[l][15:0] == (k * GPIO_STEP) + GPIO_LVL0) & dbus_rdwr_gpio_base/* _c3 */[l])
            gpio_sel_lvl0_reg[l][k] <= 1'b1;
         if ((dbus_wr_add/* _c2 */[l][15:0] == (k * GPIO_STEP) + GPIO_LVL1) & dbus_rdwr_gpio_base/* _c3 */[l])
            gpio_sel_lvl1_reg[l][k] <= 1'b1;
      end
   end
end

reg [GPIO_EVENT_BANKS-1:0] gpio_lvl0_reg [CORES-1:0];
reg [GPIO_EVENT_BANKS-1:0] gpio_lvl1_reg [CORES-1:0];

always @(posedge clk or negedge rstn)
if (~rstn) begin
   for (l = 0; l < CORES; l = l + 1) begin
      gpio_lvl0_reg[l] <= 0;
      gpio_lvl1_reg[l] <= 0;
   end
end else begin
   for (l = 0; l < CORES; l = l + 1) begin
      gpio_lvl0_reg[l] <= 0;
      gpio_lvl1_reg[l] <= 0;
   end
   for (k = 0; k < GPIO_EVENT_BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
         if (dbus_wr_en_d1/* _c3 */[l] & gpio_sel_lvl0_reg[l][k])
            gpio_lvl0_reg[l][k] <= 1'b1;
         if (dbus_wr_en_d1/* _c3 */[l] & gpio_sel_lvl1_reg[l][k])
            gpio_lvl1_reg[l][k] <= 1'b1;
      end
   end
end

reg [1:0] gpio_prop_p0_fsm [63:0];

always @(posedge clk or negedge rstn)
if (~rstn) begin
   gpio_level_reg <= 0;
   gpio_armed_reg <= 0;
   for (l = 0; l < 32; l = l + 1) begin
       gpio_core_reg[l] <= 0;
   end
   gpio_event_reg <= 0;
   for (l = 0; l < 64; l = l + 1) begin
      gpio_prop_p0_fsm[l] <= 0;  
   end
   gpio_cap_reg <= 0;
end else begin
   /////////////////////////////////////
   // event propagation, pipe 0 
   /////////////////////////////////////
   for (l = 0; l < CORES; l = l + 1) begin             // go through all CORES core sources
      for (k = 0; k < GPIO_EVENT_BANKS; k = k + 1) begin         // go through all banks
         for (n = 0; n < 4; n = n + 1) begin       // go through all 2 nibbles
            if (gpio_prop_p0_fsm[l * 64 + k * 4 + n] == 0) begin // empty pipe element
               if (gpio_event_reg[k * 8 + n * 2 + 0] & (gpio_core_reg[k * 8 + n * 2 + 0] == l)) begin
                  gpio_prop_p0_fsm[l * 64 + k * 4 + n] <= 1; // state = nibble count + 1
                  gpio_event_reg[k * 8 + n * 2 + 0] <= 1'b0;
               end else if (gpio_event_reg[k * 8 + n * 2 + 1] & (gpio_core_reg[k * 8 + n * 2 + 1] == l)) begin
                  gpio_prop_p0_fsm[l * 64 + k * 4 + n] <= 2; // state = nibble count + 1
                  gpio_event_reg[k * 8 + n * 2 + 1] <= 1'b0;
               end
            end else if (gpio_prop_p1_ack[l * 64 + k * 4 + n]) begin 
               case (gpio_prop_p0_fsm[l * 64 + k * 4 + n])       // round robin
               1: if ((gpio_event_reg[k * 8 + n * 2 + 1]) & (gpio_core_reg[k * 8 + n * 2 + 1] == l)) begin
                     gpio_prop_p0_fsm[l * 64 + k * 4 + n] <= 2;
                     gpio_event_reg[k * 8 + n * 2 + 1] <= 1'b0;
                  end else
                     gpio_prop_p0_fsm[l * 64 + k * 4 + n] <= 0;
               2: if ((gpio_event_reg[k * 8 + n * 2 + 0]) & (gpio_core_reg[k * 8 + n * 2 + 0] == l)) begin
                     gpio_prop_p0_fsm[l * 64 + k * 4 + n] <= 1;
                     gpio_event_reg[k * 8 + n * 2 + 0] <= 1'b0;
                  end else
                     gpio_prop_p0_fsm[l * 64 + k * 4 + n] <= 0;
               default : ;
               endcase
            end
         end
      end
   end
   /////////////////////////////////////
   // detect event, unarm
   /////////////////////////////////////
   for (k = 0; k < GPIO_EVENT_BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (m = 0; m < 8; m = m + 1) begin          // go through all bits
         if (!gpio_event_reg[k * 8 + m])
            if (gpio_armed_reg[k * 8 + m])
               if (gpio_level_reg[k * 8 + m] == gpio_in_reg[k * 8 + m]) begin
                  gpio_event_reg[k * 8 + m] <= 1'b1;
                  gpio_armed_reg[k * 8 + m] <= 1'b0;
                  if (m < 7)
                     gpio_cap_reg[k * 8 + m + 1] <= gpio_in_reg[k * 8 + m + 1];
                  else
                     gpio_cap_reg[k * 8 + m - 7] <= gpio_in_reg[k * 8 + m - 7];
               end
      end
   end
   /////////////////////////////////////
   // write data bus:
   //      save level and core
   //      set armed flag
   /////////////////////////////////////
   for (k = 0; k < GPIO_EVENT_BANKS; k = k + 1) begin            // go through all 8 bit wide banks
      for (l = 0; l < CORES; l = l + 1) begin         // go through all CORES cores addressing possibilities
         if (gpio_lvl0_reg[l][k])
            for (m = 0; m < 8; m = m + 1) begin   // go through all bits
               if (dbus_wr_data_d2/* _c4 */[l][m]) begin
                  gpio_level_reg[k * 8 + m] <= 1'b0;
                  gpio_armed_reg[k * 8 + m] <= 1'b1;
                  gpio_core_reg[k * 8 + m] <= l;
               end
            end
         if (gpio_lvl1_reg[l][k])
            for (m = 0; m < 8; m = m + 1) begin   // go through all bits, bus wide didn't work 
               if (dbus_wr_data_d2/* _c4 */[l][m]) begin
                  gpio_level_reg[k * 8 + m] <= 1'b1;
                  gpio_armed_reg[k * 8 + m] <= 1'b1;
                  gpio_core_reg[k * 8 + m] <= l;
               end
            end
      end
   end
   /////////////////////////////////////
   // remove unconnected and ARTY LED related banks
   /////////////////////////////////////
   for (k = GPIO_EVENT_BANKS; k < BANKS; k = k + 1) begin    // go through all 8 bit wide banks
      for (m = 0; m < 8; m = m + 1) begin   // go through all bits
         gpio_level_reg[k * 8 + m] <= 1'b0;
         gpio_armed_reg[k * 8 + m] <= 1'b0;
         gpio_core_reg[k * 8 + m] <= 0;
      end
   end
end


endmodule

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
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
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

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [37:0] io_in,
    output [37:0] io_out,
    output [37:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [28:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

wire rstn_reg;

//////////////////////////////////////
// CA memory
//////////////////////////////////////
//wire cubev_ca_rstn;
wire cubev_ca_clk0;
wire cubev_ca_csb0;
wire cubev_ca_web0;
wire [3:0] cubev_ca_wmask0;
wire [7:0] cubev_ca_addr0;
wire [31:0] cubev_ca_din0;
wire [31:0] cubev_ca_dout0;
wire cubev_ca_clk1;
wire cubev_ca_csb1;
wire [7:0] cubev_ca_addr1;
wire [31:0] cubev_ca_dout1;

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

//////////////////////////////////////
// Program low memory
//////////////////////////////////////
wire cubev_pli_rstn;
wire cubev_pli_clk0;
wire cubev_pli_csb0;
wire cubev_pli_web0;
wire [3:0] cubev_pli_wmask0;
wire [7:0] cubev_pli_addr0;
wire [31:0] cubev_pli_din0;
wire [31:0] cubev_pli_dout0;
wire cubev_pli_clk1;
wire cubev_pli_csb1;
wire [7:0] cubev_pli_addr1;
wire [31:0] cubev_pli_dout1;
wire [31:0] cubev_pli_dout1_reg;

//////////////////////////////////////
// Program high memory
//////////////////////////////////////
wire cubev_phi_rstn;
wire cubev_phi_clk0;
wire cubev_phi_csb0;
wire cubev_phi_web0;
wire [3:0] cubev_phi_wmask0;
wire [7:0] cubev_phi_addr0;
wire [31:0] cubev_phi_din0;
wire [31:0] cubev_phi_dout0;
wire cubev_phi_clk1;
wire cubev_phi_csb1;
wire [7:0] cubev_phi_addr1;
wire [31:0] cubev_phi_dout1;
wire [31:0] cubev_phi_dout1_reg;

//////////////////////////////////////
// Data low memory
//////////////////////////////////////
wire cubev_dli_rstn;
wire cubev_dli_clk0;
wire cubev_dli_csb0;
wire cubev_dli_web0;
wire [3:0] cubev_dli_wmask0;
wire [7:0] cubev_dli_addr0;
wire [31:0] cubev_dli_din0;
wire [31:0] cubev_dli_dout0;
wire cubev_dli_clk1;
wire cubev_dli_csb1;
wire [7:0] cubev_dli_addr1;
wire [31:0] cubev_dli_dout1;
wire [31:0] cubev_dli_dout1_reg;

//////////////////////////////////////
// Data high memory
//////////////////////////////////////
wire cubev_dhi_rstn;
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
wire [31:0] cubev_dhi_dout1_reg;

///////////////////////////////////////////////////
// RF1
///////////////////////////////////////////////////
wire cubev_rf1_rstn;
wire cubev_rf1_clk0;
wire cubev_rf1_csb0;
wire cubev_rf1_web0;
wire [3:0] cubev_rf1_wmask0;
wire [7:0] cubev_rf1_addr0;
wire [31:0] cubev_rf1_din0;
wire [31:0] cubev_rf1_dout0;
wire cubev_rf1_clk1;
wire cubev_rf1_csb1;
wire [7:0] cubev_rf1_addr1;
wire [31:0] cubev_rf1_dout1;
wire [31:0] cubev_rf1_dout1_reg;

///////////////////////////////////////////////////
// RF2
///////////////////////////////////////////////////
wire cubev_rf2_rstn;
wire cubev_rf2_clk0;
wire cubev_rf2_csb0;
wire cubev_rf2_web0;
wire [3:0] cubev_rf2_wmask0;
wire [7:0] cubev_rf2_addr0;
wire [31:0] cubev_rf2_din0;
wire [31:0] cubev_rf2_dout0;
wire cubev_rf2_clk1;
wire cubev_rf2_csb1;
wire [7:0] cubev_rf2_addr1;
wire [31:0] cubev_rf2_dout1;
wire [31:0] cubev_rf2_dout1_reg;

///////////////////////////////////////////////////
// REG 0
///////////////////////////////////////////////////
wire cubev_reg_0_rstn;
wire cubev_reg_0_clk0;
wire cubev_reg_0_csb0;
wire cubev_reg_0_web0;
wire [3:0] cubev_reg_0_wmask0;
wire [7:0] cubev_reg_0_addr0;
wire [31:0] cubev_reg_0_din0;
wire [31:0] cubev_reg_0_dout0;
wire cubev_reg_0_clk1;
wire cubev_reg_0_csb1;
wire [7:0] cubev_reg_0_addr1;
wire [31:0] cubev_reg_0_dout1;
wire [31:0] cubev_reg_0_dout1_reg;

///////////////////////////////////////////////////
// REG 1
///////////////////////////////////////////////////
wire cubev_reg_1_rstn;
wire cubev_reg_1_clk0;
wire cubev_reg_1_csb0;
wire cubev_reg_1_web0;
wire [3:0] cubev_reg_1_wmask0;
wire [7:0] cubev_reg_1_addr0;
wire [31:0] cubev_reg_1_din0;
wire [31:0] cubev_reg_1_dout0;
wire cubev_reg_1_clk1;
wire cubev_reg_1_csb1;
wire [7:0] cubev_reg_1_addr1;
wire [31:0] cubev_reg_1_dout1;
wire [31:0] cubev_reg_1_dout1_reg;

///////////////////////////////////////////////////
// REG 2
///////////////////////////////////////////////////
wire cubev_reg_2_rstn;
wire cubev_reg_2_clk0;
wire cubev_reg_2_csb0;
wire cubev_reg_2_web0;
wire [3:0] cubev_reg_2_wmask0;
wire [7:0] cubev_reg_2_addr0;
wire [31:0] cubev_reg_2_din0;
wire [31:0] cubev_reg_2_dout0;
wire cubev_reg_2_clk1;
wire cubev_reg_2_csb1;
wire [7:0] cubev_reg_2_addr1;
wire [31:0] cubev_reg_2_dout1;
wire [31:0] cubev_reg_2_dout1_reg;

///////////////////////////////////////////////////
// REG 3
///////////////////////////////////////////////////
wire cubev_reg_3_rstn;
wire cubev_reg_3_clk0;
wire cubev_reg_3_csb0;
wire cubev_reg_3_web0;
wire [3:0] cubev_reg_3_wmask0;
wire [7:0] cubev_reg_3_addr0;
wire [31:0] cubev_reg_3_din0;
wire [31:0] cubev_reg_3_dout0;
wire cubev_reg_3_clk1;
wire cubev_reg_3_csb1;
wire [7:0] cubev_reg_3_addr1;
wire [31:0] cubev_reg_3_dout1;
wire [31:0] cubev_reg_3_dout1_reg;

///////////////////////////////////////////////////
// REG 4
///////////////////////////////////////////////////
wire cubev_reg_4_rstn;
wire cubev_reg_4_clk0;
wire cubev_reg_4_csb0;
wire cubev_reg_4_web0;
wire [3:0] cubev_reg_4_wmask0;
wire [7:0] cubev_reg_4_addr0;
wire [31:0] cubev_reg_4_din0;
wire [31:0] cubev_reg_4_dout0;
wire cubev_reg_4_clk1;
wire cubev_reg_4_csb1;
wire [7:0] cubev_reg_4_addr1;
wire [31:0] cubev_reg_4_dout1;
wire [31:0] cubev_reg_4_dout1_reg;

///////////////////////////////////////////////////
// REG 5
///////////////////////////////////////////////////
wire cubev_reg_5_rstn;
wire cubev_reg_5_clk0;
wire cubev_reg_5_csb0;
wire cubev_reg_5_web0;
wire [3:0] cubev_reg_5_wmask0;
wire [7:0] cubev_reg_5_addr0;
wire [31:0] cubev_reg_5_din0;
wire [31:0] cubev_reg_5_dout0;
wire cubev_reg_5_clk1;
wire cubev_reg_5_csb1;
wire [7:0] cubev_reg_5_addr1;
wire [31:0] cubev_reg_5_dout1;
wire [31:0] cubev_reg_5_dout1_reg;


cawb cai (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .wb_clk_i(wb_clk_i),
   .wb_rst_i(wb_rst_i),

   // MGMT SoC Wishbone Slave

   .wbs_cyc_i(wbs_cyc_i),
   .wbs_stb_i(wbs_stb_i),
   .wbs_we_i(wbs_we_i),
   .wbs_sel_i(wbs_sel_i),
   .wbs_adr_i(wbs_adr_i),
   .wbs_dat_i(wbs_dat_i),
   .wbs_ack_o(wbs_ack_o),
   .wbs_dat_o(wbs_dat_o),

   // Logic Analyzer

   .la_data_in(la_data_in),
   .la_data_out(la_data_out),
   .la_oenb (la_oenb),
   
   // IRQ
   .irq(user_irq),
        
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
   
/*--------------------------------------*/
/* User project is instantiated  here   */
/*--------------------------------------*/

minisoc mprj (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif

   // IO Pads

   .io_in (io_in),
   .io_out(io_out),
   .io_oeb(io_oeb),

   .rstn_reg(rstn_reg),
   
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

   .cubev_pli_rstn(cubev_pli_rstn),
   .cubev_pli_clk1(cubev_pli_clk1),
   .cubev_pli_csb1(cubev_pli_csb1),
   .cubev_pli_addr1(cubev_pli_addr1),
   .cubev_pli_dout1(cubev_pli_dout1_reg),
               
   .cubev_phi_rstn(cubev_phi_rstn),
   .cubev_phi_clk1(cubev_phi_clk1),
   .cubev_phi_csb1(cubev_phi_csb1),
   .cubev_phi_addr1(cubev_phi_addr1),
   .cubev_phi_dout1(cubev_phi_dout1_reg),
               
   .cubev_dli_rstn(cubev_dli_rstn),
   .cubev_dli_clk0(cubev_dli_clk0),
   .cubev_dli_csb0(cubev_dli_csb0),
   .cubev_dli_web0(cubev_dli_web0),
   .cubev_dli_wmask0(cubev_dli_wmask0),
   .cubev_dli_addr0(cubev_dli_addr0),
   .cubev_dli_din0(cubev_dli_din0),
   .cubev_dli_dout0(cubev_dli_dout0),
   .cubev_dli_clk1(cubev_dli_clk1),
   .cubev_dli_csb1(cubev_dli_csb1),
   .cubev_dli_addr1(cubev_dli_addr1),
   .cubev_dli_dout1(cubev_dli_dout1_reg),
               
   .cubev_dhi_rstn(cubev_dhi_rstn),
   .cubev_dhi_clk0(cubev_dhi_clk0),
   .cubev_dhi_csb0(cubev_dhi_csb0),
   .cubev_dhi_web0(cubev_dhi_web0),
   .cubev_dhi_wmask0(cubev_dhi_wmask0),
   .cubev_dhi_addr0(cubev_dhi_addr0),
   .cubev_dhi_din0(cubev_dhi_din0),
   .cubev_dhi_dout0(cubev_dhi_dout0),
   .cubev_dhi_clk1(cubev_dhi_clk1),
   .cubev_dhi_csb1(cubev_dhi_csb1),
   .cubev_dhi_addr1(cubev_dhi_addr1),
   .cubev_dhi_dout1(cubev_dhi_dout1_reg),
               
   .cubev_rf1_rstn(cubev_rf1_rstn),
   .cubev_rf1_clk0(cubev_rf1_clk0),
   .cubev_rf1_csb0(cubev_rf1_csb0),
   .cubev_rf1_web0(cubev_rf1_web0),
   .cubev_rf1_wmask0(cubev_rf1_wmask0),
   .cubev_rf1_addr0(cubev_rf1_addr0),
   .cubev_rf1_din0(cubev_rf1_din0),
   .cubev_rf1_dout0(cubev_rf1_dout0),
   .cubev_rf1_clk1(cubev_rf1_clk1),
   .cubev_rf1_csb1(cubev_rf1_csb1),
   .cubev_rf1_addr1(cubev_rf1_addr1),
   .cubev_rf1_dout1(cubev_rf1_dout1_reg),
               
   .cubev_rf2_rstn(cubev_rf2_rstn),
   .cubev_rf2_clk0(cubev_rf2_clk0),
   .cubev_rf2_csb0(cubev_rf2_csb0),
   .cubev_rf2_web0(cubev_rf2_web0),
   .cubev_rf2_wmask0(cubev_rf2_wmask0),
   .cubev_rf2_addr0(cubev_rf2_addr0),
   .cubev_rf2_din0(cubev_rf2_din0),
   .cubev_rf2_dout0(cubev_rf2_dout0),
   .cubev_rf2_clk1(cubev_rf2_clk1),
   .cubev_rf2_csb1(cubev_rf2_csb1),
   .cubev_rf2_addr1(cubev_rf2_addr1),
   .cubev_rf2_dout1(cubev_rf2_dout1_reg),
               
   .cubev_reg_0_rstn(cubev_reg_0_rstn),
   .cubev_reg_0_clk0(cubev_reg_0_clk0),
   .cubev_reg_0_csb0(cubev_reg_0_csb0),
   .cubev_reg_0_web0(cubev_reg_0_web0),
   .cubev_reg_0_wmask0(cubev_reg_0_wmask0),
   .cubev_reg_0_addr0(cubev_reg_0_addr0),
   .cubev_reg_0_din0(cubev_reg_0_din0),
   .cubev_reg_0_dout0(cubev_reg_0_dout0),
   .cubev_reg_0_clk1(cubev_reg_0_clk1),
   .cubev_reg_0_csb1(cubev_reg_0_csb1),
   .cubev_reg_0_addr1(cubev_reg_0_addr1),
   .cubev_reg_0_dout1(cubev_reg_0_dout1_reg),
               
   .cubev_reg_1_rstn(cubev_reg_1_rstn),
   .cubev_reg_1_clk0(cubev_reg_1_clk0),
   .cubev_reg_1_csb0(cubev_reg_1_csb0),
   .cubev_reg_1_web0(cubev_reg_1_web0),
   .cubev_reg_1_wmask0(cubev_reg_1_wmask0),
   .cubev_reg_1_addr0(cubev_reg_1_addr0),
   .cubev_reg_1_din0(cubev_reg_1_din0),
   .cubev_reg_1_dout0(cubev_reg_1_dout0),
   .cubev_reg_1_clk1(cubev_reg_1_clk1),
   .cubev_reg_1_csb1(cubev_reg_1_csb1),
   .cubev_reg_1_addr1(cubev_reg_1_addr1),
   .cubev_reg_1_dout1(cubev_reg_1_dout1_reg),
               
   .cubev_reg_2_rstn(cubev_reg_2_rstn),
   .cubev_reg_2_clk0(cubev_reg_2_clk0),
   .cubev_reg_2_csb0(cubev_reg_2_csb0),
   .cubev_reg_2_web0(cubev_reg_2_web0),
   .cubev_reg_2_wmask0(cubev_reg_2_wmask0),
   .cubev_reg_2_addr0(cubev_reg_2_addr0),
   .cubev_reg_2_din0(cubev_reg_2_din0),
   .cubev_reg_2_dout0(cubev_reg_2_dout0),
   .cubev_reg_2_clk1(cubev_reg_2_clk1),
   .cubev_reg_2_csb1(cubev_reg_2_csb1),
   .cubev_reg_2_addr1(cubev_reg_2_addr1),
   .cubev_reg_2_dout1(cubev_reg_2_dout1_reg),
               
   .cubev_reg_3_rstn(cubev_reg_3_rstn),
   .cubev_reg_3_clk0(cubev_reg_3_clk0),
   .cubev_reg_3_csb0(cubev_reg_3_csb0),
   .cubev_reg_3_web0(cubev_reg_3_web0),
   .cubev_reg_3_wmask0(cubev_reg_3_wmask0),
   .cubev_reg_3_addr0(cubev_reg_3_addr0),
   .cubev_reg_3_din0(cubev_reg_3_din0),
   .cubev_reg_3_dout0(cubev_reg_3_dout0),
   .cubev_reg_3_clk1(cubev_reg_3_clk1),
   .cubev_reg_3_csb1(cubev_reg_3_csb1),
   .cubev_reg_3_addr1(cubev_reg_3_addr1),
   .cubev_reg_3_dout1(cubev_reg_3_dout1_reg),
               
   .cubev_reg_4_rstn(cubev_reg_4_rstn),
   .cubev_reg_4_clk0(cubev_reg_4_clk0),
   .cubev_reg_4_csb0(cubev_reg_4_csb0),
   .cubev_reg_4_web0(cubev_reg_4_web0),
   .cubev_reg_4_wmask0(cubev_reg_4_wmask0),
   .cubev_reg_4_addr0(cubev_reg_4_addr0),
   .cubev_reg_4_din0(cubev_reg_4_din0),
   .cubev_reg_4_dout0(cubev_reg_4_dout0),
   .cubev_reg_4_clk1(cubev_reg_4_clk1),
   .cubev_reg_4_csb1(cubev_reg_4_csb1),
   .cubev_reg_4_addr1(cubev_reg_4_addr1),
   .cubev_reg_4_dout1(cubev_reg_4_dout1_reg),
               
   .cubev_reg_5_rstn(cubev_reg_5_rstn),
   .cubev_reg_5_clk0(cubev_reg_5_clk0),
   .cubev_reg_5_csb0(cubev_reg_5_csb0),
   .cubev_reg_5_web0(cubev_reg_5_web0),
   .cubev_reg_5_wmask0(cubev_reg_5_wmask0),
   .cubev_reg_5_addr0(cubev_reg_5_addr0),
   .cubev_reg_5_din0(cubev_reg_5_din0),
   .cubev_reg_5_dout0(cubev_reg_5_dout0),
   .cubev_reg_5_clk1(cubev_reg_5_clk1),
   .cubev_reg_5_csb1(cubev_reg_5_csb1),
   .cubev_reg_5_addr1(cubev_reg_5_addr1),
   .cubev_reg_5_dout1(cubev_reg_5_dout1_reg));

///////////////////////////////////////////////////
// CA RAM
///////////////////////////////////////////////////
  
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_cai (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk0(cubev_ca_clk0),
   .csb0(cubev_ca_csb0),
   .web0(cubev_ca_web0),
   .wmask0(cubev_ca_wmask0),
   .addr0(cubev_ca_addr0),
   .din0(cubev_ca_din0),
   .dout0(cubev_ca_dout0),
   .clk1(cubev_ca_clk1),
   .csb1(cubev_ca_csb1),
   .addr1(cubev_ca_addr1),
   .dout1(cubev_ca_dout1));

///////////////////////////////////////////////////
// CUBE-V Prog L
///////////////////////////////////////////////////
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_pli (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk0   (cubev_pli_clk0),
   .csb0   (cubev_pli_csb0),
   .web0   (cubev_pli_web0),
   .wmask0 (cubev_pli_wmask0),
   .addr0  (cubev_pli_addr0),
   .din0   (cubev_pli_din0),
   .dout0  (cubev_pli_dout0),
   .clk1   (cubev_pli_clk1),
   .csb1   (cubev_pli_csb1),
   .addr1  (cubev_pli_addr1),
   .dout1  (cubev_pli_dout1));

//always @ (posedge cubev_pli_clk)
//   cubev_pli_instrl_reg <= instrl;

rb cubev_pli_rb (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk    (cubev_pli_clk1),
   .rstn   (cubev_pli_rstn),
   .dati   (cubev_pli_dout1),
   .dato   (cubev_pli_dout1_reg));
   
///////////////////////////////////////////////////
// CUBE-V Prog H
///////////////////////////////////////////////////

sky130_sram_1kbyte_1rw1r_32x256_8 cubev_phi (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk0   (cubev_phi_clk0),
   .csb0   (cubev_phi_csb0),
   .web0   (cubev_phi_web0),
   .wmask0 (cubev_phi_wmask0),
   .addr0  (cubev_phi_addr0),
   .din0   (cubev_phi_din0),
   .dout0  (cubev_phi_dout0),
   .clk1   (cubev_phi_clk1),
   .csb1   (cubev_phi_csb1),
   .addr1  (cubev_phi_addr1),
   .dout1  (cubev_phi_dout1));

//always @ (posedge cubev_phi_clk)
//   cubev_phi_instrh_reg <= instrh;

rb cubev_phi_rb (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk    (cubev_phi_clk1),
   .rstn   (cubev_phi_rstn),
   .dati   (cubev_phi_dout1),
   .dato   (cubev_phi_dout1_reg));
   
///////////////////////////////////////////////////
// CUBE-V Dat L
///////////////////////////////////////////////////

sky130_sram_1kbyte_1rw1r_32x256_8 cubev_dli (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk0   (cubev_dli_clk0),
   .csb0   (cubev_dli_csb0),
   .web0   (cubev_dli_web0),
   .wmask0 (cubev_dli_wmask0),
   .addr0  (cubev_dli_addr0),
   .din0   (cubev_dli_din0),
   .dout0  (cubev_dli_dout0),
   .clk1   (cubev_dli_clk1),
   .csb1   (cubev_dli_csb1),
   .addr1  (cubev_dli_addr1),
   .dout1  (cubev_dli_dout1));

//always @ (posedge cubev_dli_clk)
//   cubev_dli_dout1 <= cubev_dli_dout1_int;

rb cubev_dli_rb (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk    (cubev_dli_clk1),
   .rstn   (cubev_dli_rstn),
   .dati   (cubev_dli_dout1),
   .dato   (cubev_dli_dout1_reg));
   
///////////////////////////////////////////////////
// CUBE-V Dat H
///////////////////////////////////////////////////

//wire [31:0] cubev_dhi_dout1_int;

sky130_sram_1kbyte_1rw1r_32x256_8 cubev_dhi (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk0   (cubev_dhi_clk0),
   .csb0   (cubev_dhi_csb0),
   .web0   (cubev_dhi_web0),
   .wmask0 (cubev_dhi_wmask0),
   .addr0  (cubev_dhi_addr0),
   .din0   (cubev_dhi_din0),
   .dout0  (cubev_dhi_dout0),
   .clk1   (cubev_dhi_clk1),
   .csb1   (cubev_dhi_csb1),
   .addr1  (cubev_dhi_addr1),
   .dout1  (cubev_dhi_dout1));
      
//always @ (posedge cubev_dhi_clk)
//   cubev_dhi_dout1 <= cubev_dhi_dout1_int;

rb cubev_dhi_rb (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk    (cubev_dhi_clk1),
   .rstn   (cubev_dhi_rstn),
   .dati   (cubev_dhi_dout1),
   .dato   (cubev_dhi_dout1_reg));
   
///////////////////////////////////////////////////
// RF1
///////////////////////////////////////////////////

sky130_sram_1kbyte_1rw1r_32x256_8 cubev_rf1i (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk0   (cubev_rf1_clk0),
   .csb0   (cubev_rf1_csb0),
   .web0   (cubev_rf1_web0),
   .wmask0 (cubev_rf1_wmask0),
   .addr0  (cubev_rf1_addr0),
   .din0   (cubev_rf1_din0),
   .dout0  (cubev_rf1_dout0),
   .clk1   (cubev_rf1_clk1),
   .csb1   (cubev_rf1_csb1),
   .addr1  (cubev_rf1_addr1),
   .dout1  (cubev_rf1_dout1));

//always @ (posedge cubev_rf1_clk)
//   cubev_rf1_dout_reg <= cubev_rf1_dout;

rb cubev_rf1i_rb (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk    (cubev_rf1_clk1),
   .rstn   (cubev_rf1_rstn),
   .dati   (cubev_rf1_dout1),
   .dato   (cubev_rf1_dout1_reg));
   
///////////////////////////////////////////////////
// RF2
///////////////////////////////////////////////////

sky130_sram_1kbyte_1rw1r_32x256_8 cubev_rf2i (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk0   (cubev_rf2_clk0),
   .csb0   (cubev_rf2_csb0),
   .web0   (cubev_rf2_web0),
   .wmask0 (cubev_rf2_wmask0),
   .addr0  (cubev_rf2_addr0),
   .din0   (cubev_rf2_din0),
   .dout0  (cubev_rf2_dout0),
   .clk1   (cubev_rf2_clk1),
   .csb1   (cubev_rf2_csb1),
   .addr1  (cubev_rf2_addr1),
   .dout1  (cubev_rf2_dout1));

//always @ (posedge cubev_rf2_clk)
//   cubev_rf2_dout_reg <= cubev_rf2_dout;

rb cubev_rf2i_rb (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk    (cubev_rf2_clk1),
   .rstn   (cubev_rf2_rstn),
   .dati   (cubev_rf2_dout1),
   .dato   (cubev_rf2_dout1_reg));
   
///////////////////////////////////////////////////
// Regs
///////////////////////////////////////////////////

sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_0 (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk0   (cubev_reg_0_clk0),
   .csb0   (cubev_reg_0_csb0),
   .web0   (cubev_reg_0_web0),
   .wmask0 (cubev_reg_0_wmask0),
   .addr0  (cubev_reg_0_addr0),
   .din0   (cubev_reg_0_din0),
   .dout0  (cubev_reg_0_dout0),
   .clk1   (cubev_reg_0_clk1),
   .csb1   (cubev_reg_0_csb1),
   .addr1  (cubev_reg_0_addr1),
   .dout1  (cubev_reg_0_dout1));

//always @ (posedge cubev_reg_0_clk)
//   cubev_reg_0_dout_reg <= cubev_reg_0_dout;

rb cubev_reg_0_rb (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk    (cubev_reg_0_clk1),
   .rstn   (cubev_reg_0_rstn),
   .dati   (cubev_reg_0_dout1),
   .dato   (cubev_reg_0_dout1_reg));
   
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_1 (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk0   (cubev_reg_1_clk0),
   .csb0   (cubev_reg_1_csb0),
   .web0   (cubev_reg_1_web0),
   .wmask0 (cubev_reg_1_wmask0),
   .addr0  (cubev_reg_1_addr0),
   .din0   (cubev_reg_1_din0),
   .dout0  (cubev_reg_1_dout0),
   .clk1   (cubev_reg_1_clk1),
   .csb1   (cubev_reg_1_csb1),
   .addr1  (cubev_reg_1_addr1),
   .dout1  (cubev_reg_1_dout1));
  
rb cubev_reg_1_rb (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk    (cubev_reg_1_clk1),
   .rstn   (cubev_reg_1_rstn),
   .dati   (cubev_reg_1_dout1),
   .dato   (cubev_reg_1_dout1_reg));
   
//always @ (posedge cubev_reg_1_clk)
//   cubev_reg_1_dout_reg <= cubev_reg_1_dout;

sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_2 (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk0   (cubev_reg_2_clk0),
   .csb0   (cubev_reg_2_csb0),
   .web0   (cubev_reg_2_web0),
   .wmask0 (cubev_reg_2_wmask0),
   .addr0  (cubev_reg_2_addr0),
   .din0   (cubev_reg_2_din0),
   .dout0  (cubev_reg_2_dout0),
   .clk1   (cubev_reg_2_clk1),
   .csb1   (cubev_reg_2_csb1),
   .addr1  (cubev_reg_2_addr1),
   .dout1  (cubev_reg_2_dout1));
  
//always @ (posedge cubev_reg_2_clk)
//   cubev_reg_2_dout_reg <= cubev_reg_2_dout;

rb cubev_reg_2_rb (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk    (cubev_reg_2_clk1),
   .rstn   (cubev_reg_2_rstn),
   .dati   (cubev_reg_2_dout1),
   .dato   (cubev_reg_2_dout1_reg));
   
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_3 (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk0   (cubev_reg_3_clk0),
   .csb0   (cubev_reg_3_csb0),
   .web0   (cubev_reg_3_web0),
   .wmask0 (cubev_reg_3_wmask0),
   .addr0  (cubev_reg_3_addr0),
   .din0   (cubev_reg_3_din0),
   .dout0  (cubev_reg_3_dout0),
   .clk1   (cubev_reg_3_clk1),
   .csb1   (cubev_reg_3_csb1),
   .addr1  (cubev_reg_3_addr1),
   .dout1  (cubev_reg_3_dout1));

//always @ (posedge cubev_reg_3_clk)
//   cubev_reg_3_dout_reg <= cubev_reg_3_dout;

rb cubev_reg_3_rb (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk    (cubev_reg_3_clk1),
   .rstn   (cubev_reg_3_rstn),
   .dati   (cubev_reg_3_dout1),
   .dato   (cubev_reg_3_dout1_reg));
   
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_4 (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk0   (cubev_reg_4_clk0),
   .csb0   (cubev_reg_4_csb0),
   .web0   (cubev_reg_4_web0),
   .wmask0 (cubev_reg_4_wmask0),
   .addr0  (cubev_reg_4_addr0),
   .din0   (cubev_reg_4_din0),
   .dout0  (cubev_reg_4_dout0),
   .clk1   (cubev_reg_4_clk1),
   .csb1   (cubev_reg_4_csb1),
   .addr1  (cubev_reg_4_addr1),
   .dout1  (cubev_reg_4_dout1));
  
//always @ (posedge cubev_reg_4_clk)
//   cubev_reg_4_dout_reg <= cubev_reg_4_dout;

rb cubev_reg_4_rb (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk    (cubev_reg_4_clk1),
   .rstn   (cubev_reg_4_rstn),
   .dati   (cubev_reg_4_dout1),
   .dato   (cubev_reg_4_dout1_reg));
   
sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_5 (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk0   (cubev_reg_5_clk0),
   .csb0   (cubev_reg_5_csb0),
   .web0   (cubev_reg_5_web0),
   .wmask0 (cubev_reg_5_wmask0),
   .addr0  (cubev_reg_5_addr0),
   .din0   (cubev_reg_5_din0),
   .dout0  (cubev_reg_5_dout0),
   .clk1   (cubev_reg_5_clk1),
   .csb1   (cubev_reg_5_csb1),
   .addr1  (cubev_reg_5_addr1),
   .dout1  (cubev_reg_5_dout1));
                       
                       
//always @ (posedge cubev_reg_5_clk)
//   cubev_reg_5_dout_reg <= cubev_reg_5_dout;

rb cubev_reg_5_rb (
`ifdef USE_POWER_PINS
   .vccd1(vccd1),	// User area 1 1.8V power
   .vssd1(vssd1),	// User area 1 digital ground
`endif
   .clk    (cubev_reg_5_clk1),
   .rstn   (cubev_reg_5_rstn),
   .dati   (cubev_reg_5_dout1),
   .dato   (cubev_reg_5_dout1_reg));
   

endmodule	// user_project_wrapper

//`default_nettype wire

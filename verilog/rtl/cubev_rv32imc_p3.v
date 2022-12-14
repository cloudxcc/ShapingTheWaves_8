///
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

module cubev_rv32imc_p3      (pc_s2_next,
                              instr,
                              pc_set_int,
                              pc_set_data_int,
                              dbus_rd_add,
                              dbus_wr_add,
                              dbus_rdwr_width,
                              dbus_rd_i_req,
                              dbus_rd_i_data,
                              dbus_wr_en,
                              dbus_wr_data,
                              cubev_rf1_we,
                              cubev_rf1_wr_add,
                              cubev_rf1_din,
                              cubev_rf1_rd_add,
                              cubev_rf1_dout,
                              cubev_rf2_we,
                              cubev_rf2_wr_add,
                              cubev_rf2_din,
                              cubev_rf2_rd_add,
                              cubev_rf2_dout,
                              cubev_reg_din0,
                              cubev_reg_din0_valid,
                              cubev_reg_din1,
                              cubev_reg_din2,
                              cubev_reg_din2_valid,
                              cubev_reg_din3,
                              cubev_reg_din4,
                              cubev_reg_din5,
                              cubev_reg_dout0,
                              cubev_reg_dout1,
                              cubev_reg_dout2,
                              cubev_reg_dout3,
                              cubev_reg_dout4,
                              cubev_reg_dout5,
                              cubev_reg_dout0_late,
                              cubev_reg_dout1_late,
                              cubev_reg_dout2_late,
                              cubev_reg_dout3_late,
                              cubev_reg_dout4_late,
                              cubev_reg_dout5_late);


output [31:0] pc_s2_next;
input [31:0] instr;
input pc_set_int;
input [29:0] pc_set_data_int;
output [31:0] dbus_rd_add;
output [31:0] dbus_wr_add;
output [1:0] dbus_rdwr_width;
output dbus_rd_i_req;
input [31:0] dbus_rd_i_data;
output dbus_wr_en;
output [31:0] dbus_wr_data;

output cubev_rf1_we;
output [4:0] cubev_rf1_wr_add;
output [31:0] cubev_rf1_din;
output [4:0] cubev_rf1_rd_add;
input  [31:0] cubev_rf1_dout;
output cubev_rf2_we;
output [4:0] cubev_rf2_wr_add;
output [31:0] cubev_rf2_din;
output [4:0] cubev_rf2_rd_add;
input  [31:0] cubev_rf2_dout;
output [31:0] cubev_reg_din0;
output cubev_reg_din0_valid;
output [31:0] cubev_reg_din1;
output [31:0] cubev_reg_din2;
output cubev_reg_din2_valid;
output [31:0] cubev_reg_din3;
output [31:0] cubev_reg_din4;
output [31:0] cubev_reg_din5;
input [31:0] cubev_reg_dout0;
input [31:0] cubev_reg_dout1;
input [31:0] cubev_reg_dout2;
input [31:0] cubev_reg_dout3;
input [31:0] cubev_reg_dout4;
input [31:0] cubev_reg_dout5;
input [31:0] cubev_reg_dout0_late;
input [31:0] cubev_reg_dout1_late;
input [31:0] cubev_reg_dout2_late;
input [31:0] cubev_reg_dout3_late;
input [31:0] cubev_reg_dout4_late;
input [31:0] cubev_reg_dout5_late;

wire [31:0] pc = pc_s2;

wire [31:0] pc_s2;
wire [31:0] instr_s1;
wire [31:0] instr_s2;
wire [31:0] dp_rs1_s2, dp_rs2_s2;
wire [1:0] pvalid;
wire stalled;
wire [5:0] state_s2; 
wire sign_s2;
wire instr_i_load_s2;
wire instr_c_lw_s2;
wire instr_c_lwsp_s2;
wire instr_i_store_s2;
wire instr_c_sw_s2;
wire instr_c_swsp_s2;
wire divrem_access_0_d1;
wire [1:0] mul_carry_s2;
wire [1:0] mul_carry_s2_next;

////////////////////////////////////////////////////////////
//
//	Init phase, set stages invalid, stall, RF write-through
//
////////////////////////////////////////////////////////////
wire [1:0] pvalid_next_late = (pvalid_late < 2) ? pvalid_late + 1 : jump_or_branch_s2 ? 0 : pvalid_late;
wire [1:0] pvalid_next = (pvalid_c3 < 2) ? pvalid_c3 + 1 : jump_or_branch_s2 ? 0 : pvalid_c3;

wire instr_m_s1 = instr_m_mul_s1_c1_next | instr_m_mulh_s1_c1_next | instr_m_mulhsu_s1_c1_next |
                  instr_m_div_s1_c1_next | instr_m_rem_s1_c1_next;

wire instr_m_mulhx_s2 = instr_m_mulh_s2_c1_next | instr_m_mulhsu_s2_c1_next | instr_m_mulhu_s2_c1_next;

wire instr_m_mulx_s2 = instr_m_mul_s2_c1_next | instr_m_mulhx_s2; 

wire rd_valid_s2 = (((instr_i_beq_s2_c1 | instr_i_bne_s2_c1 | instr_i_blt_s2_c1 | instr_i_bge_s2_c1 | instr_i_bltu_s2_c1 | instr_i_bgeu_s2_c1) & opcode_i_s2_eq63_c1) |
                    instr_i_store_s2_c1 |
                    instr_c_j_s2_c1 | (instr_c_jr_s2_c1 & rs2_c_s2_eq0_c1) | instr_c_beqz_s2_c1 | instr_c_bnez_s2_c1 |
                    instr_c_swsp_s2_c1 | instr_c_sw_s2_c1) ? 1'b0 : 1'b1;

wire rs1_valid_s1 = (instr_i_lui_s1_c1 | instr_i_auipc_s1_c1 | instr_i_jal_s1_c1 |
                     instr_c_j_s1_c1 | instr_c_jal_s1_c1 | instr_c_li_s1_c1 |
                     (instr_c_lui_s1_c1 & !instr_s1_11_7_eq_02_c1)) ? 1'b0 : 1'b1;

wire rs1_wth_s1 = ((pvalid_c2 == 2) &
                   (rs1_s1_c2 == rd_s2_c2) &
                   rs1_valid_s1_c2 &
                   rd_valid_s2_c2 &
                   !instr_m_s1_c2 &
                   !(instr_m_mulhx_s2_c2 & state_eq1_s2_c2)) ? 1'b1 : 1'b0;

wire [31:0] dp_rs1_s2_next_stalled = stalled_next_c3 ? cubev_reg_dout2 : 0; //dp_rs1_s2_c3 : 0;

wire [31:0] dp_rs1_s2_next_div = (!stalled_next & (instr_m_div_s2_c2 | instr_m_divu_s2_c2) & (state_eq31_s2)) ? dp_divrem_rfin_s2 : 
                                 (!stalled_next & instr_m_divrem_s2_c2 & !state_eq32_s2_c2) ? dp_div_remainder_result_s2 : 0;

wire [31:0] dp_rs1_s2_next_mul2 = dp_mul_alhblh_s2_c3;

wire dp_rs1_s2_next_mul_sel = (!stalled_next &
                               (instr_m_mul_s1_c2 |
                                instr_m_mulh_s1_c2 | instr_m_mulhsu_s1_c2 |
                                instr_m_div_s1_c2 | instr_m_rem_s1_c2 |
                                ((instr_m_mulh_s2_c2 | instr_m_mulhsu_s2_c2) & state_eq1_s2_c2)));

wire [31:0] dp_rs1_s2_next_mul = dp_rs1_s2_next_mul_sel_c3 ? dp_rs1_abs_s1 : 0;

wire [31:0] dp_rs1_s2_next_rf_dp_out = (!stalled_next_c3 & rs1_wth_s1_c3 & dp_wr_s2) ? dp_out_s2 : 0;

wire [31:0] dp_rs1_s2_next_rf_dp_load = (!stalled_next_c3 & rs1_wth_s1_c3 & !dp_wr_s2 & !(stalled_next_c3 | dp_rs1_s2_next_sel1_c3)) ? dp_load_s2 : 0;

wire dp_rs1_s2_next_def_sel = (!stalled_next &(!(rs1_wth_s1 | dp_rs1_s2_next_mul_sel)));

wire [31:0] dp_rs1_s2_next_def = dp_rs1_s2_next_def_sel_c3 ? dp_rs1_s1_c3 : 0;

wire dp_rs1_s2_next_sel1 = ((instr_m_div_s2_c2 | instr_m_divu_s2_c2) & state_eq31_s2) |
                             (instr_m_divrem_s2_c2 & !state_eq32_s2_c2) |
                             (instr_m_mulx_s2_c2 & state_eq0_s2_c2) |
                             (instr_m_mulhx_s2_c2 & state_eq2_s2);

/*
wire [31:0] dp_rs1_s2_next = dp_rs1_s2_next_rf_dp_load |
                             dp_rs1_s2_next_stalled |
                             ((dp_rs1_s2_next_sel1_c3) ? // priority
                                 (dp_rs1_s2_next_div_c3 | dp_rs1_s2_next_mul2) :
                                 (dp_rs1_s2_next_mul | dp_rs1_s2_next_rf_dp_out | dp_rs1_s2_next_def));           
*/

wire [31:0] dp_rs1_s2_next = dp_rs1_s2_next_rf_dp_load |
                             //dp_rs1_s2_next_stalled |
                             ((dp_rs1_s2_next_sel1_c3) ? // priority
                                 (dp_rs1_s2_next_div_c3 | dp_rs1_s2_next_mul2) :
                                 (dp_rs1_s2_next_mul | dp_rs1_s2_next_rf_dp_out | dp_rs1_s2_next_def));           

wire [31:0] dp_rs1_s2_next_int = dp_rs1_s2_next_rf_dp_load |
                             dp_rs1_s2_next_stalled |
                             ((dp_rs1_s2_next_sel1_c3) ? // priority
                                 (dp_rs1_s2_next_div_c3 | dp_rs1_s2_next_mul2) :
                                 (dp_rs1_s2_next_mul | dp_rs1_s2_next_rf_dp_out | dp_rs1_s2_next_def));           

assign cubev_reg_din2_valid = !stalled_next_c3;

wire rs2_wth_s1 = ((pvalid_c2 == 2) & 
                   (rs2_s1_c2 == rd_s2_c2) & 
                   rs2_valid_s1_c2 & 
                   rd_valid_s2_c2 & !instr_m_s1_c2 & 
                   !(instr_m_mulhx_s2_c2 & state_eq1_s2_c2)) ? 1'b1 : 1'b0;

wire rs2_valid_s1 = opcode_i_s1_13_shamt_c1 |
                    opcode_i_s1_23_c1 |
                    opcode_i_s1_33_c1 |
                    opcode_i_s1_63_c1 |
                    instr_c_swsp_s1_c1 |
                    instr_c_sw_s1_c1 |
                    (instr_c_mv_s1_c1 & !rs2_c_s1_eq0_c1) |
                    (instr_c_add_s1_c1 & !rs2_c_s1_eq0_c1) |
                    funct6_c_s1_23_opcode_2_c1;

wire [31:0] dbus_rdwr_offset_load_s1 = instr_i_load_s1_c2 ? {{20{imm_11_0_s1[11]}}, imm_11_0_s1} : 0;

wire [31:0] dbus_rdwr_offset_c_lw_s1 = instr_c_lw_s1_c2 ? {24'h000000, imm_6_5_3_2_s1, 2'b00} : 0;

wire [31:0] dbus_rdwr_offset_c_lwsp_s1 = instr_c_lwsp_s1_c2 ? {25'h0000000, offset_7_6_5_4_2_s1, 2'b00} : 0;                         

wire [31:0] dp_rs2_s2_next_offset = dbus_rdwr_offset_load_s1 |
                                    dbus_rdwr_offset_c_lw_s1 |
                                    dbus_rdwr_offset_c_lwsp_s1;

wire [31:0] dp_rs2_s2_next_stalled = stalled_next ? cubev_reg_dout3 : 0; //dp_rs2_s2_c2 : 0;

wire [30:0] dp_rs2_s2_31_1 = cubev_reg_dout3 >> 1; //dp_rs2_s2_c3 >> 1;

wire dp_rs2_s2_next_div_sel = !stalled_next & instr_m_divrem_s2_c2 & !state_eq32_s2_c2;
wire [31:0] dp_rs2_s2_next_div = dp_rs2_s2_next_div_sel_c3 ? {/*dp_rs2_s2_c3*/cubev_reg_dout3[0], dp_rs2_s2_31_1} : 0;

wire dp_rs2_s2_next_mul2_sel1 = !stalled_next & instr_m_mulx_s2_c2 & state_eq0_s2_c2;
wire dp_rs2_s2_next_mul2_sel2 = !stalled_next & instr_m_mulhx_s2_c2 & state_eq2_s2;
wire [31:0] dp_rs2_s2_next_mul2 = dp_rs2_s2_next_mul2_sel1_c3 ? {dp_mul_ahbl_s2_c3[15:0], dp_mul_albh_s2_c3[15:0]} :
                                  dp_rs2_s2_next_mul2_sel2_c3 ? {dp_mul_ahbl_s2_c3[31:16], dp_mul_albh_s2_c3[31:16]} : 0;

wire dp_rs2_s2_next_mul_sel = (!stalled_next & 
                               (instr_m_mul_s1_c2 |
                                instr_m_mulh_s1_c2 |
                                instr_m_div_s1_c2 | instr_m_rem_s1_c2 |
                                (instr_m_mulh_s2_c2 & state_eq1_s2_c2)));
wire [31:0] dp_rs2_s2_next_mul = dp_rs2_s2_next_mul_sel_c3 ? dp_rs2_abs_s1 : 0;

wire dp_rs2_s2_next_sh_sel = (!stalled_next &
                              (instr_i_srli_s1_c2 | instr_c_srli_s1_c2 |
                               instr_i_srai_s1_c2 | instr_c_srai_s1_c2 |
                               instr_i_slli_s1_c2 | instr_c_slli_s1_c2));

wire [31:0] dp_rs2_s2_next_sh = dp_rs2_s2_next_sh_sel_c3 ? {27'hxxxxxxx, dp_shmul_a_s1_c3} : 0;

wire [31:0] dp_rs2_s2_next_rf_dp_out = (!stalled_next_c3 & rs2_wth_s1_c3 & dp_wr_s2) ? dp_out_s2 : 0;

wire dp_rs2_s2_next_rf_dp_load_sel = !stalled_next & dbus_rd_i_req_c2 & rs2_wth_s1;
wire [31:0] dp_rs2_s2_next_rf_dp_load = (dp_rs2_s2_next_rf_dp_load_sel_c3 & !dp_wr_s2) ? dp_load_s2 : 0;

wire dp_rs2_s2_next_def_sel = !(stalled_next |
                                rs2_wth_s1 |   
                                instr_i_load_s1_c2 |
                                instr_c_lw_s1_c2 |
                                instr_c_lwsp_s1_c2 |
                                instr_m_mul_s1_c2 | 
                                instr_m_mulh_s1_c2 | 
                                instr_m_div_s1_c2 | instr_m_rem_s1_c2 |
                                (instr_m_mulh_s2_c2 & state_eq1_s2_c2));

wire [31:0] dp_rs2_s2_next_def = dp_rs2_s2_next_def_sel_c3 ? dp_rs2_s1_c3 : 0;

wire dp_rs2_s2_next_sel = (instr_m_divrem_s2_c2 & !state_eq32_s2_c2) |
                          (instr_m_mulx_s2_c2 & state_eq0_s2_c2) |
                          (instr_m_mulhx_s2_c2 & state_eq2_s2);

/*
wire [31:0] dp_rs2_s2_next = dp_rs2_s2_next_rf_dp_load |
                             dp_rs2_s2_next_stalled_c3 | 
                             (dp_rs2_s2_next_sel_c3 ? // priority
                                 (dp_rs2_s2_next_div | dp_rs2_s2_next_mul2) :
                                 (dp_rs2_s2_next_mul | dp_rs2_s2_next_sh | dp_rs2_s2_next_rf_dp_out | dp_rs2_s2_next_def | dp_rs2_s2_next_offset_c3));
*/
wire [31:0] dp_rs2_s2_next = dp_rs2_s2_next_rf_dp_load |
                             //dp_rs2_s2_next_stalled_c3 | 
                             (dp_rs2_s2_next_sel_c3 ? // priority
                                 (dp_rs2_s2_next_div | dp_rs2_s2_next_mul2) :
                                 (dp_rs2_s2_next_mul | dp_rs2_s2_next_sh | dp_rs2_s2_next_rf_dp_out | dp_rs2_s2_next_def | dp_rs2_s2_next_offset_c3));

wire [31:0] instr_s1_next = (jump_or_branch_s2) ? 32'h00000013 : 
                            (stalled_next_c3 | 
                             (instr_m_divrem_s2_c3 & !state_eq32_s2_c3) | 
                             (instr_m_mul_s2_c3 & state_eq0_s2_c3) | 
                             (instr_m_mulhx_s2_c3 & state_lt3_s2_c3)) ? cubev_reg_dout0 //instr_s1_c3 
                                                                        : instr_c3;
//wire [31:0] instr_s1_next = (jump_or_branch_s2) ? 32'h00000013 : instr_c3;
//assign cubev_reg_din0_valid = 1'b1;

assign cubev_reg_din0_valid = pc_set_int |
                              jump_or_branch_s2 |
                              (!(stalled_next_c3 | 
                                (instr_m_divrem_s2_c3 & !state_eq32_s2_c3) | 
                                (instr_m_mul_s2_c3 & state_eq0_s2_c3) | 
                                (instr_m_mulhx_s2_c3 & state_lt3_s2_c3)));

wire [31:0] instr_s2_next = (jump_or_branch_s2) ? 32'h00000013 :
                            /*
                            (stalled_next_c3 | 
                             (instr_m_divrem_s2_c3 & !state_eq32_s2_c3) | 
                             (instr_m_mul_s2_c3 & state_eq0_s2_c3) | 
                             (instr_m_mulhx_s2_c3 & state_lt3_s2_c3)) ? cubev_reg_dout1 : //instr_s2_c3 :
                            */
                            instr_i_sra_s1_c3 ? //{instr_s1_c3[31:25], dp_rs2_s1_c3[4:0], instr_s1_c3[19:0]} : 
                            {cubev_reg_dout0[31:25], dp_rs2_s1_c3[4:0], cubev_reg_dout0[19:0]} :
                            cubev_reg_dout0; //instr_s1_c3;

wire [31:0] instr_s2_next_int = (jump_or_branch_s2) ? 32'h00000013 :
                            (stalled_next_c3 | 
                             (instr_m_divrem_s2_c3 & !state_eq32_s2_c3) | 
                             (instr_m_mul_s2_c3 & state_eq0_s2_c3) | 
                             (instr_m_mulhx_s2_c3 & state_lt3_s2_c3)) ? cubev_reg_dout1 : //instr_s2_c3 :
                            instr_i_sra_s1_c3 ? //{instr_s1_c3[31:25], dp_rs2_s1_c3[4:0], instr_s1_c3[19:0]} : 
                            {cubev_reg_dout0[31:25], dp_rs2_s1_c3[4:0], cubev_reg_dout0[19:0]} :
                            cubev_reg_dout0; //instr_s1_c3;

wire stalled_next_sel1 = (stalled_c1 | (rd_s2 == 0) | !rd_valid_s2 | 
                          (instr_m_divrem_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1 & !state_eq32_s2_c1) | 
                          (instr_m_mul_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1 & state_eq0_s2_c1) | 
                          (instr_m_mulhx_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1 & (state_eq0_s2_c1 | state_eq1_s2_c1 | (state_s2_c1 == 2)))) ? 1'b1 : 0;

wire stalled_next_sel2 = (((rs1_s1 == rd_s2) & instr_m_s1_c1 & opcode_i_s1_33_c1 & funct7_i_s1_eq1) | 
                          ((rs2_s1 == rd_s2) & instr_m_s1_c1 & opcode_i_s1_33_c1 & funct7_i_s1_eq1) /* |
                          (instr_load_s2)*/) ? 1'b1 : 0; 

wire stalled_next = stalled_next_sel1_c2 ? 0 :
                    stalled_next_sel2_c2 ? 1'b1 : 0;

wire pcadv1 = (instr_s1[1:0] == 2'b11) ? 1 : 0;
wire pcadv2 = (instr_s2[1:0] == 2'b11) ? 1 : 0;

wire state_eq0_s2 = state_s2 == 0;
wire state_eq1_s2 = state_s2 == 1;
wire state_eq2_s2 = state_s2_c2 == 2;
wire state_eq3_s2 = state_s2_c1 == 3;
wire state_lt3_s2 = (state_eq0_s2_c2 | state_eq1_s2_c2 | state_eq2_s2);
wire state_eq31_s2 = state_s2_c2 == 31;
wire state_eq32_s2 = state_s2 == 32;

wire state_s2_next_sel1 = (stalled_next & state_eq32_s2_c2 & instr_m_divrem_s2_c2) |
                          (stalled_next & state_eq1_s2_c2 & instr_m_mul_s2_c2) |
                          (stalled_next & state_eq3_s2_c2 & instr_m_mulhx_s2_c2);

wire state_s2_next_sel2 = (state_eq32_s2_c2 |
                          (instr_m_mul_s2_c2 & state_eq1_s2_c2) |
                          (instr_m_mulhx_s2_c2 & state_eq3_s2_c2) |
                          (!(pvalid_c2 == 2)));

wire [5:0] state_s2_next = state_s2_next_sel1_c3 ? cubev_reg_dout5[8:3] : //state_s2_c3 :
                           state_s2_next_sel2_c3 ? 0 :
                           (instr_m_divrem_s2_c3 | instr_m_mulx_s2_c3) ? state_s2_c3 + 1 : 0; //221006 cubev_reg_dout5[8:3]; //state_s2_c3;

////////////////////////////////////////////////////////////
//
//	Stage 0
//
////////////////////////////////////////////////////////////
wire [31:0] instr_s0_clear = jump_or_branch_s2 ? 32'h00000013 : 
                             (stalled_next_c3 | 
                              (instr_m_divrem_s2_c3 & !state_eq32_s2_c3) | 
                              (instr_m_mul_s2_c3 & state_eq0_s2_c3) | 
                              (instr_m_mulhx_s2_c3 & state_lt3_s2_c3)) ? instr_s1_c3 : instr;

//wire [2:0] funct3_i_s2 = instr_s2[14:12];
wire [2:0] funct3_i_s2_next = instr_s2_next_int[14:12];
//wire instr_m_mulh_s2_next = funct3_i_s2 == 3'b001;
wire instr_m_mulh_s1_next = funct3_i_s2_next == 3'b001;
wire instr_m_mulhsu_s1_next = funct3_i_s2_next == 3'b010;
wire instr_m_mulhu_s1_next = funct3_i_s2_next == 3'b011;
//wire funct7_i_s2_eq1 = funct7_i_s2 == 7'b0000001;
wire funct7_i_s2_eq1_next = instr_s2_next_int[31:25] == 7'b0000001;
//wire opcode_i_s2_eq33 = instr_s2[6:0] == 7'h33;
wire opcode_i_s1_eq33 = instr_s2_next_int[6:0] == 7'h33;
wire state_eq1_s1 = state_s2_next == 1;
//wire instr_m_mulhx_s2 = instr_m_mulh_s2_c1_next | instr_m_mulhsu_s2_c1_next | instr_m_mulhu_s2_c1_next;
wire instr_m_mulhx_s1 = instr_m_mulh_s1_next | instr_m_mulhsu_s1_next | instr_m_mulhu_s1_next;
wire mulh_access_0_s0 = //instr_m_mulhx_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1 & state_eq1_s2_c1;
                        instr_m_mulhx_s1 & opcode_i_s1_eq33 & funct7_i_s2_eq1_next & state_eq1_s1;
//
//   rs1
//
wire rs1_def_sel_s0 = instr_s0_clear[1:0] == 2'b11;
wire [4:0] rs1_i_s0 = instr_s0_clear[19:15];
wire [4:0] rs1_def_s0 = rs1_def_sel_s0 ? rs1_i_s0 : 0;
wire rs2_c_s0_eq0 = instr_s0_clear[6:2] == 0;  
wire rs1_c_add_sel_s0 = instr_c_add_s0 & !rs2_c_s0_eq0;
wire [4:0] rs2_c_s0 = instr_s0_clear[6:2]; 
wire [4:0] rs1_c_add_s0 = rs1_c_add_sel_s0 ? rs2_c_s0 : 0;

wire [1:0] opcode_c_s0 = instr_s0_clear[1:0];
wire [2:0] funct3_c_s0 = instr_s0_clear[15:13];
wire instr_c_addi4spn_s0 = opcode_c_s0 == 2'b00 & funct3_c_s0 == 3'b000;
wire instr_c_swsp_s0 = opcode_c_s0 == 2'b10 & funct3_c_s0 == 3'b110;
wire instr_c_lwsp_s0 = opcode_c_s0 == 2'b10 & funct3_c_s0 == 3'b010;
wire rs1_c_sp_sel_s0 = instr_c_addi4spn_s0 | instr_c_swsp_s0 | instr_c_lwsp_s0;
wire [4:0] rs1_c_sp_s0 = rs1_c_sp_sel_s0 ? 2 : 0;
wire instr_c_addi_s0 = opcode_c_s0 == 2'b01 & funct3_c_s0 == 3'b000;
wire instr_c_addi16sp_s0 = opcode_c_s0 == 2'b01 & funct3_c_s0 == 3'b011;
wire instr_s0_11_7_eq_02 = instr_s0_clear[11:7] == 5'b00010;
wire instr_c_slli_s0 = opcode_c_s0 == 2'b10 & funct3_c_s0 == 3'b000;
wire instr_c_jr_s0 = opcode_c_s0 == 2'b10 & funct3_c_s0 == 3'b100 & instr_s0_clear[12] == 1'b0;
wire instr_c_jalr_s0 = opcode_c_s0 == 2'b10 & funct3_c_s0 == 3'b100 & instr_s0_clear[12] == 1'b1;
wire rs1_c_def_sel_s0 = (instr_c_addi_s0 |
                         (instr_c_addi16sp_s0 & instr_s0_11_7_eq_02) |
                          instr_c_slli_s0 |
                          (instr_c_jr_s0 & rs2_c_s0_eq0) |
                          (instr_c_jalr_s0 & rs2_c_s0_eq0));
wire [2:0] rs1s_c_s0 = instr_s0_clear[9:7];
wire [4:0] rs1_c_1_s0 = !(rs1_def_sel_s0 | rs1_c_add_sel_s0 | rs1_c_sp_sel_s0 | rs1_c_def_sel_s0) ? {2'b01, rs1s_c_s0} : 0;
wire [4:0] rs1_c_s0 = instr_s0_clear[11:7];
wire [4:0] rs1_c_def_s0 = rs1_c_def_sel_s0 ? rs1_c_s0 : 0;
wire [4:0] rs1_s0 = rs1_def_s0 | rs1_c_add_s0 | rs1_c_sp_s0 | rs1_c_1_s0 | rs1_c_def_s0;

wire [4:0] rf1_addrb_s0 = /* mulh_access_0 ? instr_s2_c1[19:15] : */ 
                         mulh_access_0_s0 ? instr_s2_next_int[19:15] : rs1_s0;
//
//   rs2
// 
wire rs2_def_sel_s0 = (instr_s0_clear[1:0] == 2'b11) & !(instr_s0_clear[6:2] == 5'h04);
wire [4:0] rs2_i_s0 = instr_s0_clear[24:20];
wire [4:0] rs2_def_s0 = rs2_def_sel_s0 ? rs2_i_s0 : 0;

wire instr_c_add_s0 = opcode_c_s0 == 2'b10 & funct3_c_s0 == 4'b100 & instr_s0_clear[12] == 1'b1 & instr_s0_clear[6:2] != 0 & instr_s0_clear[11:7] != 0;
wire [4:0] rd_c_s0 = instr_s0_clear[11:7];
wire [4:0] rs2_c_add_s0 = instr_c_add_s0 & !rs2_c_s0_eq0 ? rd_c_s0 : 0;
wire instr_c_mv_s0 = opcode_c_s0 == 2'b10 & funct3_c_s0 == 3'b100 & instr_s0_clear[12] == 1'b0 & instr_s0_clear[11:7] != 0;
wire [4:0] rs2_c_mv_s0 = ((instr_c_mv_s0 & !rs2_c_s0_eq0) | instr_c_swsp_s0) ? rs2_c_s0 : 0;

wire instr_c_sw_s0 = opcode_c_s0 == 2'b00 & funct3_c_s0 == 3'b110;
wire [5:0] funct6_c_s0 = instr_s0_clear[15:10];
wire funct6_c_s0_23_opcode_2 = (opcode_c_s0 == 2'b01) & (funct6_c_s0 == 6'b100011);
wire [2:0] rs2s_c_s0 = instr_s0_clear[4:2];
wire [4:0] rs2_c_sw_s0 = (instr_c_sw_s0 | funct6_c_s0_23_opcode_2) ? {2'b01, rs2s_c_s0} : 0;

wire [4:0] rs2_s0 = rs2_c_add_s0 | rs2_c_mv_s0 | rs2_c_sw_s0 | rs2_def_s0;

wire [4:0] rf2_addrb_s0 = /* divrem_access_0_d1 ? 0 : 
                          mulh_access_0 ? instr_s2_c1[24:20] : */ 
                          divrem_access_0_d1_next ? 0 :
                          mulh_access_0_s0 ? instr_s2_next_int[24:20] : rs2_s0;

////////////////////////////////////////////////////////////
//
//	Stage 1
//
////////////////////////////////////////////////////////////
wire [7:0] funct7_i_s1 = instr_s1[31:25];
wire [7:0] funct7_i_s1_c1 = instr_s1_c1[31:25];
wire funct7_i_s1_eq0 = funct7_i_s1_c1 == 7'b0000000;
wire funct7_i_s1_eq20 = funct7_i_s1_c1 == 7'b0100000;
wire funct7_i_s1_eq1 = funct7_i_s1_c1 == 7'b0000001;
wire [2:0] funct3_i_s1 = instr_s1[14:12];
wire [4:0] shamt_i_s1 = instr_s1_c2[24:20];
wire [4:0] rs2_i_s1 = instr_s1_c1[24:20];
wire [4:0] rs1_i_s1 = instr_s1_c1[19:15];
wire [6:0] opcode_i_s1 = instr_s1[6:0];
wire opcode_i_s1_13_shamt = (instr_s1[6:0] == 7'h13) & ((instr_s1[14:12] == 3'h1) | (instr_s1[14:12] == 3'h5));
wire opcode_i_s1_13 = instr_s1[6:0] == 7'h13;
wire opcode_i_s1_23 = instr_s1[6:0] == 7'h23;
wire opcode_i_s1_33 = instr_s1[6:0] == 7'h33;
wire opcode_i_s1_63 = instr_s1[6:0] == 7'h63;
wire [11:0] imm_11_0_s1 = instr_s1_c2[31:20];

wire instr_i_lui_s1_c1_next = opcode_i_s1 == 7'b0110111;
wire instr_i_auipc_s1_c1_next = opcode_i_s1 == 7'b0010111;
wire instr_i_jal_s1_c1_next = opcode_i_s1 == 7'b1101111;
wire instr_i_load_s1_c1_next = opcode_i_s1 == 7'b0000011;
wire instr_i_store_s1_c1_next = opcode_i_s1 == 7'b0100011;
wire instr_i_slli_s1_c1_next = /* opcode_i_s1 == 7'b0010011 & */ funct3_i_s1 == 3'b001; // & funct7_i_s1 == 7'b0000000;
wire instr_i_srli_s1_c1_next = /* opcode_i_s1 == 7'b0010011 & */ funct3_i_s1 == 3'b101; // & funct7_i_s1 == 7'b0000000;
wire instr_i_srai_s1_c1_next = /* opcode_i_s1 == 7'b0010011 & */ funct3_i_s1 == 3'b101; // & funct7_i_s1 == 7'b0100000;
wire instr_i_sll_s1_c1_next = /* opcode_i_s1 == 7'b0110011 & */ funct3_i_s1 == 3'b001; // & funct7_i_s1 == 7'b0000000;
wire instr_i_srl_s1_c1_next = /* opcode_i_s1 == 7'b0110011 & */ funct3_i_s1 == 3'b101; // & funct7_i_s1 == 7'b0000000;
wire instr_i_sra_s1_c1_next = /* opcode_i_s1 == 7'b0110011 & */ funct3_i_s1 == 3'b101; // & funct7_i_s1 == 7'b0100000;

wire instr_m_mul_s1_c1_next = /* opcode_i_s1 == 7'b0110011 & */ funct3_i_s1 == 3'b000; // & funct7_i_s1 == 7'b0000001;
wire instr_m_mulh_s1_c1_next = /* opcode_i_s1 == 7'b0110011 & */ funct3_i_s1 == 3'b001; // & funct7_i_s1 == 7'b0000001;
wire instr_m_mulhsu_s1_c1_next = /* opcode_i_s1 == 7'b0110011 & */ funct3_i_s1 == 3'b010; // & funct7_i_s1 == 7'b0000001;
wire instr_m_div_s1_c1_next = /* opcode_i_s1 == 7'b0110011 & */ funct3_i_s1 == 3'b100; // & funct7_i_s1 == 7'b0000001;
wire instr_m_rem_s1_c1_next = /* opcode_i_s1 == 7'b0110011 & */ funct3_i_s1 == 3'b110; // & funct7_i_s1 == 7'b0000001;

wire [1:0] opcode_c_s1 = instr_s1[1:0];
wire [1:0] funct_c_s1 = instr_s1[6:5];
wire [1:0] funct2_c_s1 = instr_s1[11:10];
wire [2:0] funct3_c_s1 = instr_s1[15:13];
wire [5:0] funct6_c_s1 = instr_s1[15:10];
wire [4:0] imm_6_5_3_2_s1 = {instr_s1_c2[5], instr_s1_c2[12:10], instr_s1_c2[6]};
wire [5:0] offset_7_6_5_4_2_s1 = {instr_s1_c2[3:2], instr_s1_c2[12], instr_s1_c2[6:4]};
wire [5:0] shamt_5_4_0_s1 = {instr_s1_c2[12], instr_s1_c2[6:2]};
wire [4:0] rs1_c_s1 = instr_s1_c1[11:7];
wire [2:0] rs1s_c_s1 = instr_s1_c1[9:7];
wire [4:0] rs2_c_s1 = instr_s1_c1[6:2]; 
wire rs2_c_s1_eq0 = instr_s1[6:2] == 0;  
wire [2:0] rs2s_c_s1 = instr_s1_c1[4:2];
wire [4:0] rd_c_s1 = instr_s1_c1[11:7];
wire instr_s1_11_7_eq_02 = instr_s1[11:7] == 5'b00010;

wire instr_c_lwsp_s1_c1_next = opcode_c_s1 == 2'b10 & funct3_c_s1 == 3'b010;
wire instr_c_swsp_s1_c1_next = opcode_c_s1 == 2'b10 & funct3_c_s1 == 3'b110;
wire instr_c_lw_s1_c1_next = opcode_c_s1 == 2'b00 & funct3_c_s1 == 3'b010;
wire instr_c_sw_s1_c1_next = opcode_c_s1 == 2'b00 & funct3_c_s1 == 3'b110;
wire instr_c_j_s1_c1_next = opcode_c_s1 == 2'b01 & funct3_c_s1 == 3'b101;
wire instr_c_jal_s1_c1_next = opcode_c_s1 == 2'b01 & funct3_c_s1 == 3'b001;
wire instr_c_jr_s1_c1_next = opcode_c_s1 == 2'b10 & funct3_c_s1 == 3'b100 & instr_s1[12] == 1'b0; // & instr_s1[6:2] == 0; //{instr_s1[12], instr_s1[6:2]} == 6'b000000;
wire instr_c_jalr_s1_c1_next = opcode_c_s1 == 2'b10 & funct3_c_s1 == 3'b100 & instr_s1[12] == 1'b1; // & instr_s1[6:2] == 0; //{instr_s1[12], instr_s1[6:2]} == 6'b100000;     
wire instr_c_li_s1_c1_next = opcode_c_s1 == 2'b01 & funct3_c_s1 == 3'b010;
wire instr_c_lui_s1_c1_next = opcode_c_s1 == 2'b01 & funct3_c_s1 == 3'b011; // & instr_s1[11:7] != 5'b00010;
wire instr_c_beqz_s1_c1_next = opcode_c_s1 == 2'b01 & funct3_c_s1 == 3'b110;
wire instr_c_bnez_s1_c1_next = opcode_c_s1 == 2'b01 & funct3_c_s1 == 3'b111;
wire instr_c_addi_s1_c1_next = opcode_c_s1 == 2'b01 & funct3_c_s1 == 3'b000;
wire instr_c_addi16sp_s1_c1_next = opcode_c_s1 == 2'b01 & funct3_c_s1 == 3'b011; // & instr_s1[11:7] == 5'b00010;
wire instr_c_addi4spn_s1_c1_next = opcode_c_s1 == 2'b00 & funct3_c_s1 == 3'b000;
wire instr_c_slli_s1_c1_next = opcode_c_s1 == 2'b10 & funct3_c_s1 == 3'b000;
wire instr_c_srli_s1_c1_next = opcode_c_s1 == 2'b01 & funct2_c_s1 == 2'b00 & funct3_c_s1 == 3'b100;
wire instr_c_srai_s1_c1_next = opcode_c_s1 == 2'b01 & funct2_c_s1 == 2'b01 & funct3_c_s1 == 3'b100;
wire instr_c_andi_s1_c1_next = opcode_c_s1 == 2'b01 & funct3_c_s1 == 3'b100 & funct2_c_s1 == 2'b10;
wire instr_c_mv_s1_c1_next = opcode_c_s1 == 2'b10 & funct3_c_s1 == 3'b100 & instr_s1[12] == 1'b0 /* & instr_s1[6:2] != 0 */ & instr_s1[11:7] != 0; // & imm_5_4_0[4:0] != 5'b00000;
wire instr_c_add_s1_c1_next = opcode_c_s1 == 2'b10 & funct3_c_s1 == 4'b100 & instr_s1[12] == 1'b1 & instr_s1[6:2] != 0 & instr_s1[11:7] != 0; // & imm_5_4_0[4:0] != 5'b00000;

// SLLI
wire [4:0] dp_shamt_i_slli_s1 = instr_i_slli_s1_c2 ? shamt_i_s1 : 0;

// SLLI16
wire [4:0] dp_shamt_i_slli16_s1 = instr_c_slli_s1_c2 ? shamt_5_4_0_s1 : 0;

// SRLI
wire [4:0] dp_shamt_i_srli_s1 = instr_i_srli_s1_c2 ? shamt_i_s1 : 0;

// SRLI16
wire [4:0] dp_shamt_i_srli16_s1 = instr_c_srli_s1_c2 ? shamt_5_4_0_s1 : 0;

// SRAI
wire [4:0] dp_shamt_i_srai_s1 = instr_i_srai_s1_c2 ? shamt_i_s1 : 0;

// SRAI16
wire [4:0] dp_shamt_i_srai16_s1 = instr_c_srai_s1_c2 ? shamt_5_4_0_s1 : 0;

// SRL
wire [4:0] dp_shamt_i_srl_s1 = instr_i_srl_s1_c2 ? dp_rs2_s1[4:0] : 0;
   
// SRA
wire [4:0] dp_shamt_i_sra_s1 = instr_i_sra_s1_c2 ? dp_rs2_s1[4:0] : 0;
   
// SLL
wire [4:0]  dp_shamt_sll_s1 = instr_i_sll_s1_c2 ? dp_rs2_s1[4:0] : 0;

wire [4:0] dp_shmul_a_s1 = dp_shamt_i_slli_s1 | dp_shamt_sll_s1 | dp_shamt_i_slli16_s1 |
                           dp_shamt_i_srli_s1 | dp_shamt_i_srai_s1 | dp_shamt_i_srl_s1 |
                           dp_shamt_i_sra_s1 | dp_shamt_i_srli16_s1 | dp_shamt_i_srai16_s1;

////////////////////////////////////////////////////////////
//
//	Stage 2
//
////////////////////////////////////////////////////////////
wire [7:0] funct7_i_s2 = instr_s2[31:25];
wire funct7_i_s2_eq0 = funct7_i_s2 == 7'b0000000;
wire funct7_i_s2_eq20 = funct7_i_s2 == 7'b0100000;
wire funct7_i_s2_eq1 = funct7_i_s2 == 7'b0000001;
wire [2:0] funct3_i_s2 = instr_s2[14:12];
wire [4:0] shamt_i_s2_c1 = instr_s2_c1[24:20];
wire [4:0] rd_i_s2_c1 = instr_s2_c1[11:7];
wire [6:0] opcode_i_s2 = instr_s2[6:0];
wire opcode_i_s2_eq13 = instr_s2[6:0] == 7'h13;
wire opcode_i_s2_eq33 = instr_s2[6:0] == 7'h33;
wire opcode_i_s2_eq63 = instr_s2[6:0] == 7'h63;
wire [11:0] imm_11_0_s2 = instr_s2[31:20];
wire [11:0] imm_11_0_s2_c1 = instr_s2_c1[31:20];
wire [11:0] imm_11_0_s2_c2 = instr_s2_c2[31:20];
wire [11:0] imm_11_5_4_0_s2_c0 = {instr_s2[31:25], instr_s2[11:7]};
wire [11:0] imm_12_1_s2_c1 = {instr_s2_c1[31], instr_s2_c1[7], instr_s2_c1[30:25], instr_s2_c1[11:8]};
wire [19:0] imm_31_12_s2_c1 = instr_s2_c1[31:12];
wire [19:0] imm_20_1_s2_c1 = {instr_s2_c1[31], instr_s2_c1[19:12], instr_s2_c1[20], instr_s2_c1[30:21]};   

wire instr_i_lui_s2_c1_next = opcode_i_s2 == 7'b0110111;
wire instr_i_auipc_s2_c1_next = opcode_i_s2 == 7'b0010111;
wire instr_i_jal_s2_c1_next = opcode_i_s2 == 7'b1101111;
wire instr_i_jalr_s2_c1_next = opcode_i_s2 == 7'b1100111;
wire instr_i_beq_s2_c1_next = /* opcode_i_s2 == 7'b1100011 & */ funct3_i_s2 == 3'b000;
wire instr_i_bne_s2_c1_next = /* opcode_i_s2 == 7'b1100011 & */ funct3_i_s2 == 3'b001;
wire instr_i_blt_s2_c1_next = /* opcode_i_s2 == 7'b1100011 & */ funct3_i_s2 == 3'b100;
wire instr_i_bge_s2_c1_next = /* opcode_i_s2 == 7'b1100011 & */ funct3_i_s2 == 3'b101;
wire instr_i_bltu_s2_c1_next = /* opcode_i_s2 == 7'b1100011 & */ funct3_i_s2 == 3'b110;
wire instr_i_bgeu_s2_c1_next = /* opcode_i_s2 == 7'b1100011 & */ funct3_i_s2 == 3'b111;
wire instr_i_addi_s2_c1_next = /* opcode_i_s2 == 7'b0010011 & */ funct3_i_s2 == 3'b000;
wire instr_i_slti_s2_c1_next = /* opcode_i_s2 == 7'b0010011 & */ funct3_i_s2 == 3'b010;
wire instr_i_sltiu_s2_c1_next = /* opcode_i_s2 == 7'b0010011 & */ funct3_i_s2 == 3'b011;
wire instr_i_xori_s2_c1_next = /* opcode_i_s2 == 7'b0010011 & */ funct3_i_s2 == 3'b100;
wire instr_i_ori_s2_c1_next = /* opcode_i_s2 == 7'b0010011 & */ funct3_i_s2 == 3'b110;
wire instr_i_andi_s2_c1_next = /* opcode_i_s2 == 7'b0010011 & */ funct3_i_s2 == 3'b111;
wire instr_i_slli_s2_c1_next = /* opcode_i_s2 == 7'b0010011 & */ funct3_i_s2 == 3'b001; // & funct7_i_s2 == 7'b0000000;
wire instr_i_srli_s2_c1_next = /* opcode_i_s2 == 7'b0010011 & */ funct3_i_s2 == 3'b101; // & funct7_i_s2 == 7'b0000000;
wire instr_i_srai_s2_c1_next = /* opcode_i_s2 == 7'b0010011 & */ funct3_i_s2 == 3'b101; // & funct7_i_s2 == 7'b0100000;
wire instr_i_add_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b000; // & funct7_i_s2 == 7'b0000000;
wire instr_i_sub_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b000; // & funct7_i_s2 == 7'b0100000;
wire instr_i_sll_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b001; // & funct7_i_s2 == 7'b0000000;
wire instr_i_slt_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b010; // & funct7_i_s2 == 7'b0000000;
wire instr_i_sltu_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b011; // & funct7_i_s2 == 7'b0000000;
wire instr_i_xor_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b100; // & funct7_i_s2 == 7'b0000000;
wire instr_i_srl_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b101; // & funct7_i_s2 == 7'b0000000;
wire instr_i_sra_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b101; // & funct7_i_s2 == 7'b0100000;
wire instr_i_or_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b110; // & funct7_i_s2 == 7'b0000000;
wire instr_i_and_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b111; // & funct7_i_s2 == 7'b0000000;
wire instr_m_mul_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b000; // & funct7_i_s2 == 7'b0000001;
wire instr_m_mulh_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b001; // & funct7_i_s2 == 7'b0000001;
wire instr_m_mulhsu_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b010; // & funct7_i_s2 == 7'b0000001;
wire instr_m_mulhu_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b011; // & funct7_i_s2 == 7'b0000001;
wire instr_m_div_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b100; // & funct7_i_s2 == 7'b0000001;
wire instr_m_divu_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b101; // & funct7_i_s2 == 7'b0000001;
wire instr_m_rem_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b110; // & funct7_i_s2 == 7'b0000001;
wire instr_m_remu_s2_c1_next = /* opcode_i_s2 == 7'b0110011 & */ funct3_i_s2 == 3'b111; // & funct7_i_s2 == 7'b0000001;  

wire [1:0] opcode_c_s2 = instr_s2[1:0];
wire [1:0] funct_c_s2 = instr_s2[6:5];
wire [1:0] funct2_c_s2 = instr_s2[11:10];
wire [2:0] funct3_c_s2 = instr_s2[15:13];
wire [5:0] funct6_c_s2 = instr_s2[15:10];
wire [5:0] imm_5_4_0_s2_c1 = {instr_s2_c1[12], instr_s2_c1[6:2]};
wire [4:0] imm_6_5_3_2_s2_c0 = {instr_s2[5], instr_s2[12:10], instr_s2[6]};
wire [7:0] imm_8_7_6_5_4_3_2_1_s2_c1 = {instr_s2_c1[12], instr_s2_c1[6:5], instr_s2_c1[2], instr_s2_c1[11:10], instr_s2_c1[4:3]};
wire [7:0] imm_9_6_5_4_3_2_s2_c1 = {instr_s2_c1[10:7], instr_s2_c1[12:11], instr_s2_c1[5], instr_s2_c1[6]};
wire [10:0] imm_11_10_9_8_7_6_5_4_3_1_s2_c1 = {instr_s2_c1[12], instr_s2_c1[8], instr_s2_c1[10:9], instr_s2_c1[6], instr_s2_c1[7], instr_s2_c1[2], instr_s2_c1[11], instr_s2_c1[5:3]};
wire [9:0] nzimm_9_8_7_6_5_4_s2_c1 = {instr_s2_c1[12], instr_s2_c1[4:3], instr_s2_c1[5], instr_s2_c1[2], instr_s2_c1[6], 4'h0};
wire [5:0] offset_7_6_5_2_s2_c0 = {instr_s2[8:7], instr_s2[12:9]};
wire [5:0] offset_7_6_5_4_2_s2_c0 = {instr_s2[3:2], instr_s2[12], instr_s2[6:4]};
wire [5:0] shamt_5_4_0_s2_c1 = {instr_s2_c1[12], instr_s2_c1[6:2]};
wire rs2_c_s2_eq0 = instr_s2[6:2] == 0;
wire [4:0] rd_c_s2_c1 = instr_s2_c1[11:7];
wire [2:0] rds97_c_s2_c1 = instr_s2_c1[9:7];
wire [2:0] rds42_c_s2_c1 = instr_s2_c1[4:2];
wire instr_s2_11_7_eq_02 = instr_s2[11:7] == 5'b00010;

wire instr_c_j_s2_c1_next = opcode_c_s2 == 2'b01 & funct3_c_s2 == 3'b101;
wire instr_c_jal_s2_c1_next = opcode_c_s2 == 2'b01 & funct3_c_s2 == 3'b001;
wire instr_c_jr_s2_c1_next = opcode_c_s2 == 2'b10 & funct3_c_s2 == 3'b100 & instr_s2[12] == 1'b0; // & instr_s2[6:2] == 0; //{instr_s2[12], instr_s2[6:2]} == 6'b000000;
wire instr_c_jalr_s2_c1_next = opcode_c_s2 == 2'b10 & funct3_c_s2 == 3'b100 & instr_s2[12] == 1'b1; // & instr_s2[6:2] == 0; //{instr_s2[12], instr_s2[6:2]} == 6'b100000;     
wire instr_c_li_s2_c1_next = opcode_c_s2 == 2'b01 & funct3_c_s2 == 3'b010;
wire instr_c_lui_s2_c1_next = opcode_c_s2 == 2'b01 & funct3_c_s2 == 3'b011; // & instr_s2[11:7] != 5'b00010;
wire instr_c_beqz_s2_c1_next = opcode_c_s2 == 2'b01 & funct3_c_s2 == 3'b110;
wire instr_c_bnez_s2_c1_next = opcode_c_s2 == 2'b01 & funct3_c_s2 == 3'b111;
wire instr_c_addi_s2_c1_next = opcode_c_s2 == 2'b01 & funct3_c_s2 == 3'b000;
wire instr_c_addi16sp_s2_c1_next = opcode_c_s2 == 2'b01 & funct3_c_s2 == 3'b011; // & instr_s2[11:7] == 5'b00010;
wire instr_c_addi4spn_s2_c1_next = opcode_c_s2 == 2'b00 & funct3_c_s2 == 3'b000;
wire instr_c_slli_s2_c1_next = opcode_c_s2 == 2'b10 & funct3_c_s2 == 3'b000;
wire instr_c_srli_s2_c1_next = opcode_c_s2 == 2'b01 & funct2_c_s2 == 2'b00 & funct3_c_s2 == 3'b100;
wire instr_c_srai_s2_c1_next = opcode_c_s2 == 2'b01 & funct2_c_s2 == 2'b01 & funct3_c_s2 == 3'b100;
wire instr_c_andi_s2_c1_next = opcode_c_s2 == 2'b01 & funct3_c_s2 == 3'b100 & funct2_c_s2 == 2'b10;
wire instr_c_mv_s2_c1_next = opcode_c_s2 == 2'b10 & funct3_c_s2 == 3'b100 & instr_s2[12] == 1'b0 /* & instr_s2[6:2] != 0 */ & instr_s2[11:7] != 0; // & imm_5_4_0[4:0] != 5'b00000;
wire instr_c_add_s2_c1_next = opcode_c_s2 == 2'b10 & funct3_c_s2 == 4'b100 & instr_s2[12] == 1'b1 /* & instr_s2[6:2] != 0 */ & instr_s2[11:7] != 0; // & imm_5_4_0[4:0] != 5'b00000;
wire instr_c_and_s2_c1_next = /* opcode_c_s2 == 2'b01 & funct6_c_s2 == 6'b100011 & */ funct_c_s2 == 2'b11;
wire instr_c_or_s2_c1_next = /* opcode_c_s2 == 2'b01 & funct6_c_s2 == 6'b100011 & */ funct_c_s2 == 2'b10;
wire instr_c_xor_s2_c1_next = /* opcode_c_s2 == 2'b01 & funct6_c_s2 == 6'b100011 & */ funct_c_s2 == 2'b01;
wire instr_c_sub_s2_c1_next = /* opcode_c_s2 == 2'b01 & funct6_c_s2 == 6'b100011 & */ funct_c_s2 == 2'b00;

wire instr_load_s2 = 0; //instr_i_load_s2_c3 | instr_c_lw_s2_c3 | instr_c_lwsp_s2_c3;

////////////////////////////////////////////////////////////
//
//	Datapath
//
////////////////////////////////////////////////////////////
// LUI32
wire [31:0] dp_lui_s2 = instr_i_lui_s2_c1 ? {imm_31_12_s2_c1, 12'h000} : 0;

// AUIPC32
wire [31:0] dp_pc_auipc_s2 = instr_i_auipc_s2_c1 ? pc_cleared_s2 : 0;
wire [31:0] dp_imm_auipc_s2 = instr_i_auipc_s2_c1 ? {imm_31_12_s2_c1, 12'h000} : 0;

// LI16
wire [31:0] dp_li16_s2 = instr_c_li_s2_c1 ? {{26{imm_5_4_0_s2_c1[5]}}, imm_5_4_0_s2_c1} : 0;

// LUI16
wire [31:0] dp_lui16_s2 = instr_c_lui_s2_c1 & !instr_s2_11_7_eq_02_c1 ? {{14{imm_5_4_0_s2_c1[5]}}, imm_5_4_0_s2_c1, 12'h000} : 0;

// JAL32
wire [31:0] dp_pc_jal32_s2 = instr_i_jal_s2_c1 ? pc_cleared_s2 : 0;
wire [31:0] dp_p4_jal32_s2 = instr_i_jal_s2_c1 ? 4 : 0;

// JAL16
wire [31:0] dp_pc_jal16_s2 = instr_c_jal_s2_c1 ? pc_cleared_s2 : 0;
wire [31:0] dp_p2_jal16_s2 = instr_c_jal_s2_c1 ? 2 : 0;

// JALR32
wire [31:0] dp_pc_jalr32_s2 = instr_i_jalr_s2_c1 ? pc_cleared_s2 : 0;
wire [31:0] dp_p4_jalr32_s2 = instr_i_jalr_s2_c1 ? 4 : 0;
wire [31:0] dp_rs1_jalr32_s2 = instr_i_jalr_s2_c1 ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_imm_jalr32_s2 = instr_i_jalr_s2_c2 ? {{20{imm_11_0_s2_c2[11]}}, imm_11_0_s2_c2} : 0;

// JALR16
wire [31:0] dp_pc_jalr16_s2 = instr_c_jalr_s2_c1 & rs2_c_s2_eq0_c1 ? pc_cleared_s2 : 0;
wire [31:0] dp_p2_jalr16_s2 = instr_c_jalr_s2_c1 & rs2_c_s2_eq0_c1 ? 2 : 0;

// ADDI32
wire [31:0] dp_rs1_addi32_s2 = instr_i_addi_s2_c1 & opcode_i_s2_eq13_c1 ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_imm_addi32_s2 = instr_i_addi_s2_c1 & opcode_i_s2_eq13_c1 ? {{20{imm_11_0_s2_c1[11]}}, imm_11_0_s2_c1} : 0;

// ADDI16
wire [31:0] dp_rs1_addi16_s2 = instr_c_addi_s2_c1 ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_imm_addi16_s2 = instr_c_addi_s2_c1 ? {{26{imm_5_4_0_s2_c1[5]}}, imm_5_4_0_s2_c1} : 0;

// ADDI16SP
wire [31:0] dp_rs1_addi16sp_s2 = instr_c_addi16sp_s2_c1 & instr_s2_11_7_eq_02_c1 ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_imm_addi16sp_s2 = instr_c_addi16sp_s2_c1 & instr_s2_11_7_eq_02_c1 ? {{22{nzimm_9_8_7_6_5_4_s2_c1[9]}}, nzimm_9_8_7_6_5_4_s2_c1} : 0; //{{26{imm_5_4_0[5]}}, imm_5_4_0} : 0;

// ADDI4SPN
wire [31:0] dp_rs1_addi4spn_s2 = instr_c_addi4spn_s2_c1 ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_imm_addi4spn_s2 = instr_c_addi4spn_s2_c1 ? {{22{1'b0}}, imm_9_6_5_4_3_2_s2_c1, 2'b00} : 0;

// MV16
wire [31:0] dp_mv16_s2 = instr_c_mv_s2_c1 & !rs2_c_s2_eq0_c1 ? dp_rs2_s2_c1 : 0;

// ADD16
wire [31:0] dp_rs1_add16_s2 = instr_c_add_s2_c1 & !rs2_c_s2_eq0_c1 ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_rd_add16_s2 = instr_c_add_s2_c1 & !rs2_c_s2_eq0_c1 ? dp_rs2_s2_c1 : 0;

// XORI
wire [31:0] dp_rs1_xori_s2 = instr_i_xori_s2_c1 & opcode_i_s2_eq13_c1 ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_imm_xori_s2 = instr_i_xori_s2_c1 & opcode_i_s2_eq13_c1 ? {{20{imm_11_0_s2_c1[11]}}, imm_11_0_s2_c1} : 0;
wire [31:0] dp_xori_s2 = dp_rs1_xori_s2 ^ dp_imm_xori_s2;

// ORI
wire [31:0] dp_rs1_ori_s2 = instr_i_ori_s2_c1 & opcode_i_s2_eq13_c1 ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_imm_ori_s2 = instr_i_ori_s2_c1 & opcode_i_s2_eq13_c1 ? {{20{imm_11_0_s2_c1[11]}}, imm_11_0_s2_c1} : 0;
wire [31:0] dp_ori_s2 = dp_rs1_ori_s2 | dp_imm_ori_s2;

// ANDI
wire [31:0] dp_rs1_andi_s2 = instr_i_andi_s2_c1 & opcode_i_s2_eq13_c1 ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_imm_andi_s2 = instr_i_andi_s2_c1 & opcode_i_s2_eq13_c1 ? {{20{imm_11_0_s2_c1[11]}}, imm_11_0_s2_c1} : 0;
wire [31:0] dp_andi_s2 = dp_rs1_andi_s2 & dp_imm_andi_s2;

// ANDI16
wire [31:0] dp_rs1_andi16_s2 = instr_c_andi_s2_c1 ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_imm_andi16_s2 = instr_c_andi_s2_c1 ? {{26{imm_5_4_0_s2_c1[5]}}, imm_5_4_0_s2_c1} : 0;
wire [31:0] dp_andi16_s2 = dp_rs1_andi16_s2 & dp_imm_andi16_s2;

// AND16
wire [31:0] dp_rs1_and16_s2 = (funct6_c_s2_23_opcode_2_c1 & instr_c_and_s2_c1) ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_rs2_and16_s2 = (funct6_c_s2_23_opcode_2_c1 & instr_c_and_s2_c1) ? dp_rs2_s2_c1 : 0;
wire [31:0] dp_and16_s2 = dp_rs1_and16_s2 & dp_rs2_and16_s2;

// SRLI
wire [4:0] dp_shamt_i_srli_s2 = instr_i_srli_s2_c1 & opcode_i_s2_eq13_c1 & funct7_i_s2_eq0_c1 ? shamt_i_s2_c1 : 0;

// SRLI16
wire [4:0] dp_shamt_i_srli16_s2 = instr_c_srli_s2_c1 ? shamt_5_4_0_s2_c1 : 0;

// SRAI
wire [4:0] dp_shamt_i_srai_s2 = instr_i_srai_s2_c1 & opcode_i_s2_eq13_c1 & funct7_i_s2_eq20_c1 ? shamt_i_s2_c1 : 0;

// SRAI16
wire [4:0] dp_shamt_i_srai16_s2 = instr_c_srai_s2_c1 ? shamt_5_4_0_s2_c1 : 0;

// ADD
wire [31:0] dp_rs1_add_s2 = instr_i_add_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq0_c1 ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_rs2_add_s2 = instr_i_add_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq0_c1 ? dp_rs2_s2_c1 : 0;

// XOR
wire [31:0] dp_rs1_xor_s2 = instr_i_xor_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq0_c1 ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_rs2_xor_s2 = instr_i_xor_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq0_c1 ? dp_rs2_s2_c1 : 0;
wire [31:0] dp_xor_s2 = dp_rs1_xor_s2 ^ dp_rs2_xor_s2;

// XOR16
wire [31:0] dp_rs1_xor16_s2 = (funct6_c_s2_23_opcode_2_c1 & instr_c_xor_s2_c1) ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_rs2_xor16_s2 = (funct6_c_s2_23_opcode_2_c1 & instr_c_xor_s2_c1) ? dp_rs2_s2_c1 : 0;
wire [31:0] dp_xor16_s2 = dp_rs1_xor16_s2 ^ dp_rs2_xor16_s2;

// SRL
wire [4:0] dp_shamt_i_srl_s2 = instr_i_srl_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq0_c1 ? dp_rs2_s2_c1[4:0] : 0;

// SRA
wire [4:0] dp_shamt_i_sra_s2 = instr_i_sra_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq20_c1 ? dp_rs2_s2_c1[4:0] : 0;

// OR
wire [31:0] dp_rs1_or_s2 = instr_i_or_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq0_c1 ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_rs2_or_s2 = instr_i_or_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq0_c1 ? dp_rs2_s2_c1 : 0;
wire [31:0] dp_or_s2 = dp_rs1_or_s2 | dp_rs2_or_s2;

// OR16
wire [31:0] dp_rs1_or16_s2 = (funct6_c_s2_23_opcode_2_c1 & instr_c_or_s2_c1) ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_rs2_or16_s2 = (funct6_c_s2_23_opcode_2_c1 & instr_c_or_s2_c1) ? dp_rs2_s2_c1 : 0;
wire [31:0] dp_or16_s2 = dp_rs1_or16_s2 | dp_rs2_or16_s2;

// AND
wire [31:0] dp_rs1_and_s2 = instr_i_and_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq0_c1 ? dp_rs1_s2_c1 : 0;
wire [31:0] dp_rs2_and_s2 = instr_i_and_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq0_c1 ? dp_rs2_s2_c1 : 0;
wire [31:0] dp_and_s2 = dp_rs1_and_s2 & dp_rs2_and_s2;

//
// DIV and REM:  divident / divisor
//
// divident: state 0: rf1[rs1_i]
//           state > 0: rf1[0] (formally remainder)
//
// divisor: always rf2[rs2_i]
//
// remainder = divident - divisor (shifted)
//
// state: 0 => load registers
//
wire instr_m_divrem_s2 = instr_m_div_s2_c1_next | instr_m_divu_s2_c1_next | instr_m_rem_s2_c1_next | instr_m_remu_s2_c1_next; 

wire sign_s2_next = (stalled_next_c3 & state_eq32_s2_c3) |
                     (instr_m_mul_s2_c3 & state_eq0_s2_c3) |
                     (instr_m_mulhx_s2_c3 & state_lt3_s2_c3) |
                    ((instr_m_div_s2_c3 | instr_m_rem_s2_c3) & !state_eq32_s2_c3) ? sign_s2_late :
                    ((instr_m_div_s1_c3 & (dp_rs1_s1_c3[31] != dp_rs2_s1_c3[31])) |
                     (instr_m_rem_s1_c3 & dp_rs1_s1_c3[31]) |
                     (instr_m_mul_s1_c3    & (dp_rs1_s1_c3[31] != dp_rs2_s1_c3[31])) |
                     (instr_m_mulh_s1_c3   & (dp_rs1_s1_c3[31] != dp_rs2_s1_c3[31])) |
                     (instr_m_mulhsu_s1_c3 & dp_rs1_s1_c3[31])) ? 1'b1 : 0;

// get divisor at the right place
wire [63:0] dp_div_divisor_s2 = {1'b0, dp_rs2_s2, dp_rs2_s2[31:1]} &
                                (64'h7fffffff80000000 >> state_s2);

// compare
wire dp_div_greater_s2 = (instr_m_divrem_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1) ? {32'h00000000, dp_rs1_s2_c1} >= dp_div_divisor_s2_c1 : 0;  

// substract
wire [31:0] dp_div_remainder_s2 = dp_rs1_s2_c1[31:0] - dp_div_divisor_s2_c1[31:0];  

wire [31:0] dp_div_remainder_result_s2 = dp_div_greater_s2_c2 & !state_eq32_s2_c2 ? dp_div_remainder_s2_c2 : dp_rs1_s2_c2;

// div and rem rfin
wire [31:0] dp_divrem_rfin_s2 = (instr_m_div_s2_c2 | instr_m_divu_s2_c2) ? {dp_divrem_rfout_s2, dp_div_greater_s2_c2} : dp_divrem_rfout_s2;

// div rfout control
wire [31:0] dp_divrem_rfout_s2 = rf2_doutb_s1;

// div and rem or-ed
wire [31:0] dp_divrem_s2 = (instr_m_divrem_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1) ? (sign_s2_c1 ? dp_neg_s2[31:0] : dp_rs1_s2_c1) : 0;

// not checked: reuse of adder might be beneficial
wire [32:0] dp_add_a_s2 = (dp_pc_auipc_s2 | dp_pc_jal32_s2   | dp_pc_jal16_s2   | dp_pc_jalr32_s2    | dp_pc_jalr16_s2    |
                           dp_rs1_addi32_s2 | dp_rs1_addi16_s2 | dp_rs1_addi16sp_s2 | dp_rs1_addi4spn_s2 | dp_rs1_add_s2 | dp_rs1_add16_s2);

wire [32:0] dp_add_b_s2 = (dp_imm_auipc_s2 | dp_p4_jal32_s2   | dp_p2_jal16_s2   | dp_p4_jalr32_s2    | dp_p2_jalr16_s2    |
                           dp_imm_addi32_s2 | dp_imm_addi16_s2 | dp_imm_addi16sp_s2 | dp_imm_addi4spn_s2 | dp_rs2_add_s2 | dp_rd_add16_s2);

wire [33:0] dp_add_s2 = (dp_add_a_s2_c2 | dp_mul_add_s2_ab_used_c2 | dp_mul_add_s2_ab_neg_used_c2) + 
                        (dp_add_b_s2_c2 | dp_mul_add_s2_cd_used_c2 | dp_mul_add_s2_cd_sub_used_c2 | dp_mul_add_s2_cd_neg_used_c2);

wire [31:0] dp_slt_s2_a = dp_rs1_s2_c1;
wire [31:0] dp_slt_s2_b = (instr_s2_c1[5] == 1'b0) ? {{20{imm_11_0_s2_c1[11]}}, imm_11_0_s2_c1} : dp_rs2_s2_c1;

wire dp_slt_s2_lt_0 = dp_slt_s2_a[ 3: 0] < dp_slt_s2_b[ 3: 0];
wire dp_slt_s2_lt_1 = dp_slt_s2_a[ 7: 4] < dp_slt_s2_b[ 7: 4];
wire dp_slt_s2_lt_2 = dp_slt_s2_a[11: 8] < dp_slt_s2_b[11: 8];
wire dp_slt_s2_lt_3 = dp_slt_s2_a[15:12] < dp_slt_s2_b[15:12];
wire dp_slt_s2_lt_4 = dp_slt_s2_a[19:16] < dp_slt_s2_b[19:16];
wire dp_slt_s2_lt_5 = dp_slt_s2_a[23:20] < dp_slt_s2_b[23:20];
wire dp_slt_s2_lt_6 = dp_slt_s2_a[27:24] < dp_slt_s2_b[27:24];
wire dp_slt_s2_lt_7 = dp_slt_s2_a[31:28] < dp_slt_s2_b[31:28];

wire dp_slt_s2_eq_0 = dp_slt_s2_a[ 3: 0] == dp_slt_s2_b[ 3: 0];
wire dp_slt_s2_eq_1 = dp_slt_s2_a[ 7: 4] == dp_slt_s2_b[ 7: 4];
wire dp_slt_s2_eq_2 = dp_slt_s2_a[11: 8] == dp_slt_s2_b[11: 8];
wire dp_slt_s2_eq_3 = dp_slt_s2_a[15:12] == dp_slt_s2_b[15:12];
wire dp_slt_s2_eq_4 = dp_slt_s2_a[19:16] == dp_slt_s2_b[19:16];
wire dp_slt_s2_eq_5 = dp_slt_s2_a[23:20] == dp_slt_s2_b[23:20];
wire dp_slt_s2_eq_6 = dp_slt_s2_a[27:24] == dp_slt_s2_b[27:24];
wire dp_slt_s2_eq_7 = dp_slt_s2_a[31:28] == dp_slt_s2_b[31:28];

wire dp_slt_sel_s2 = ((instr_i_slti_s2_c1 & opcode_i_s2_eq13_c1) | 
                      (instr_i_slt_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq0_c1) |
                      (instr_i_sltu_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq0_c1) |
                      (instr_i_sltiu_s2_c1 & opcode_i_s2_eq13_c1));
                      
wire dp_slt_inv_s2 = ((instr_i_slti_s2_c1 & opcode_i_s2_eq13_c1 & !(dp_rs1_s2_c1[31] == imm_11_0_s2_c1[11])) | 
                      (instr_i_slt_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq0_c1 & !(dp_rs1_s2_c1[31] == dp_rs2_s2_c1[11])));

wire dp_slt_s2_tmp = (dp_slt_s2_lt_7_c2 |
                      (dp_slt_s2_eq_7_c2 & dp_slt_s2_lt_6_c2) |
                      (dp_slt_s2_eq_7_c2 & dp_slt_s2_eq_6_c2 & dp_slt_s2_lt_5_c2) |
                      (dp_slt_s2_eq_7_c2 & dp_slt_s2_eq_6_c2 & dp_slt_s2_eq_5_c2 & dp_slt_s2_lt_4_c2) |
                      (dp_slt_s2_eq_7_c2 & dp_slt_s2_eq_6_c2 & dp_slt_s2_eq_5_c2 & dp_slt_s2_eq_4_c2 & dp_slt_s2_lt_3_c2) |
                      (dp_slt_s2_eq_7_c2 & dp_slt_s2_eq_6_c2 & dp_slt_s2_eq_5_c2 & dp_slt_s2_eq_4_c2 & dp_slt_s2_eq_3_c2 & dp_slt_s2_lt_2_c2) |
                      (dp_slt_s2_eq_7_c2 & dp_slt_s2_eq_6_c2 & dp_slt_s2_eq_5_c2 & dp_slt_s2_eq_4_c2 & dp_slt_s2_eq_3_c2 & dp_slt_s2_eq_2_c2 & dp_slt_s2_lt_1_c2) |
                      (dp_slt_s2_eq_7_c2 & dp_slt_s2_eq_6_c2 & dp_slt_s2_eq_5_c2 & dp_slt_s2_eq_4_c2 & dp_slt_s2_eq_3_c2 & dp_slt_s2_eq_2_c2 & dp_slt_s2_eq_1_c2 & dp_slt_s2_lt_0_c2));
wire dp_slt_s2 = dp_slt_sel_s2_c2 ? (dp_slt_inv_s2_c2 ? ~dp_slt_s2_tmp : dp_slt_s2_tmp) : 0;

wire [ 4:0] dp_shmul_a_in_s2 = dp_shamt_i_srli_s2 | dp_shamt_i_srai_s2 | dp_shamt_i_srl_s2 |
                               dp_shamt_i_sra_s2 |
                               dp_shamt_i_srli16_s2 | dp_shamt_i_srai16_s2;
wire [ 4:0] dp_shmul_32a_in_s2 = 32 - dp_shmul_a_in_s2; 
wire [31:0] dp_shmul_arith_s2 = 32'hffffffff << dp_shmul_32a_in_s2_c2;

wire [4:0] dp_shmul_a_s2 = ((instr_i_slli_s2_c1 & opcode_i_s2_eq13_c1 & funct7_i_s2_eq0_c1) |
                            (instr_i_sll_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq0_c1) |
                            instr_c_slli_s2_c1) ?
                                     dp_rs2_s2_c1[4:0] :
                                     (32 - dp_rs2_s2_c1[4:0]);

wire [31:0] dp_shmul_b_s2 = dp_rs1_s2_c2;

wire [63:0] dp_shmul_out_s2 = dp_shmul_b_s2 << dp_shmul_a_s2_c2[4:0];

wire noshift_s2 = ((instr_i_srli_s2_c1 & opcode_i_s2_eq13_c1 & funct7_i_s2_eq0_c1) | 
                   (instr_i_srai_s2_c1 & opcode_i_s2_eq13_c1 & funct7_i_s2_eq20_c1) | 
                   (instr_i_srl_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq0_c1) | 
                   (instr_i_sra_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq20_c1) | instr_c_srli_s2_c1 | instr_c_srai_s2_c1) &
                   (dp_shmul_a_s2 == 0); 

wire [31:0] dp_shmul_s2_srl = instr_i_srli_s2_c2 | instr_i_srl_s2_c2 | instr_c_srli_s2_c2 ? dp_shmul_out_s2[63:32] : 0;
wire [31:0] dp_shmul_s2_i_srai = instr_i_srai_s2_c2 ? (dp_shmul_b_s2[31] ? (dp_shmul_out_s2[63:32] | dp_shmul_arith_s2) : dp_shmul_out_s2[63:32]) : 0;
wire [31:0] dp_shmul_s2_sra = instr_i_sra_s2_c2 ? (dp_shmul_b_s2[31] ? (dp_shmul_out_s2[63:32] | dp_shmul_arith_s2) : dp_shmul_out_s2[63:32]) : 0;
wire [31:0] dp_shmul_s2_c_srai = instr_c_srai_s2_c2 ? (dp_shmul_b_s2[31] ? (dp_shmul_out_s2[63:32] | dp_shmul_arith_s2) : dp_shmul_out_s2[63:32]) : 0;
wire [31:0] dp_shmul_s2_sll = instr_i_slli_s2_c2 | instr_i_sll_s2_c2 | instr_c_slli_s2_c2 ? dp_shmul_out_s2[31: 0] : 0;
wire [31:0] dp_shmul_s2 = noshift_s2_c2 ? dp_shmul_out_s2[31: 0] : 
                          (dp_shmul_s2_srl | dp_shmul_s2_i_srai | dp_shmul_s2_sra | dp_shmul_s2_c_srai | dp_shmul_s2_sll);

wire [31:0] dp_mul_a_s2_c1;
wire [31:0] dp_mul_b_s2_c1;

//always @ (posedge clk_c1) begin
assign dp_mul_a_s2_c1 = dp_rs1_s2;
assign dp_mul_b_s2_c1 = dp_rs2_s2;
//end

wire [31:0] dp_mul_ahbh_s2_c2;
wire [31:0] dp_mul_ahbl_s2_c2;
wire [31:0] dp_mul_albh_s2_c2;
wire [31:0] dp_mul_albl_s2_c2;

//always @ (posedge clk_c2) begin
assign dp_mul_ahbh_s2_c2 = dp_mul_a_s2_c1[31:16] * dp_mul_b_s2_c1[31:16];
assign dp_mul_ahbl_s2_c2 = dp_mul_a_s2_c1[31:16] * dp_mul_b_s2_c1[15: 0];
assign dp_mul_albh_s2_c2 = dp_mul_a_s2_c1[15: 0] * dp_mul_b_s2_c1[31:16];
assign dp_mul_albl_s2_c2 = dp_mul_a_s2_c1[15: 0] * dp_mul_b_s2_c1[15: 0];
//end

wire [31:0] dp_mul_alhblh_s2_c3;
wire [31:0] dp_mul_ahbh_s2_c3;
wire [31:0] dp_mul_ahbl_s2_c3;
wire [31:0] dp_mul_albh_s2_c3;
wire [31:0] dp_mul_albl_s2_c3;

//always @ (posedge clk_c3) begin
assign dp_mul_alhblh_s2_c3 = (!stalled_next & instr_m_mulx_s2_c2 & state_eq0_s2_c2) ? dp_mul_albl_s2_c2 :
                          (!stalled_next & instr_m_mulhx_s2_c2 & state_eq2_s2) ? dp_mul_ahbh_s2_c2 : 0;
assign dp_mul_ahbh_s2_c3 = dp_mul_ahbh_s2_c2;
assign dp_mul_ahbl_s2_c3 = dp_mul_ahbl_s2_c2;
assign dp_mul_albh_s2_c3 = dp_mul_albh_s2_c2;
assign dp_mul_albl_s2_c3 = dp_mul_albl_s2_c2;
//end

wire [16:0] dp_mul_add_s2_ab_def_p1 = dp_rs1_s2[15:0] + 1;
wire [16:0] dp_mul_add_s2_ab_def_p2 = dp_rs1_s2[15:0] + 2;
wire [16:0] dp_mul_add_s2_ab_def_hw_p1 = dp_rs1_s2[31:16] + 1;
wire [32:0] dp_mul_add_s2_ab = ((instr_m_mul_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1) | (mul_carry_s2_c1 == 0)) ? dp_rs1_s2_c1 : 
                                        ((mul_carry_s2_c1 == 1) ? 
                                            (dp_mul_add_s2_ab_def_p1_c1[16] ? 
                                               {dp_mul_add_s2_ab_def_hw_p1_c1, dp_mul_add_s2_ab_def_p1_c1[15:0]} :
                                               {1'b0, dp_rs1_s2_c1[31:16], dp_mul_add_s2_ab_def_p1_c1[15:0]}) :
                                            (dp_mul_add_s2_ab_def_p2_c1[16] ? 
                                               {dp_mul_add_s2_ab_def_hw_p1_c1, dp_mul_add_s2_ab_def_p2_c1[15:0]} :
                                               {1'b0, dp_rs1_s2_c1[31:16], dp_mul_add_s2_ab_def_p2_c1[15:0]}));
wire [16:0] dp_mul_add_s2_ab_neg_low = ~dp_mul_add_s2_ab[15:0] + 1;
wire [16:0] dp_mul_add_s2_ab_neg_high = ~dp_mul_add_s2_ab[32:16] + 1;
wire [32:0] dp_mul_add_s2_ab_neg = (dp_mul_add_s2_ab[15:0] == 16'h0000) ?
                                        {dp_mul_add_s2_ab_neg_high, dp_mul_add_s2_ab_neg_low[15:0]} :
                                        {~dp_mul_add_s2_ab[32:16], dp_mul_add_s2_ab_neg_low[15:0]};
wire [32:0] dp_mul_add_s2_ab_used = ((instr_m_mulx_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1 & !sign_s2_c1) |
                                     (instr_i_sub_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq20_c1) | 
                                     (funct6_c_s2_23_opcode_2_c1 & instr_c_sub_s2_c1)) ? dp_mul_add_s2_ab : 0;
wire [32:0] dp_mul_add_s2_ab_neg_used = (instr_m_mulx_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1 & sign_s2_c1) ? dp_mul_add_s2_ab_neg : 0;

wire [16:0] dp_mul_add_s2_cd_def = dp_rs2_s2[15: 0] + dp_rs2_s2[31:16];
wire [32:0] dp_mul_add_s2_cd = state_eq1_s2_c1 ? {dp_mul_add_s2_cd_def_c1, 16'h00000000} :
                                                 {16'h00000000, dp_mul_add_s2_cd_def_c1};

wire [16:0] dp_mul_add_s2_cd_def_neg = ~dp_mul_add_s2_cd_def_c1 + 1;
wire [32:0] dp_mul_add_s2_cd_neg = state_eq1_s2_c1 ? {dp_mul_add_s2_cd_def_neg, 16'h00000000} :
                                                     {{15{dp_mul_add_s2_cd_def_neg[16]}}, dp_mul_add_s2_cd_def_neg};

wire [32:0] dp_mul_add_s2_cd_used = (instr_m_mulx_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1 & !sign_s2_c1) ? dp_mul_add_s2_cd : 0;
wire [32:0] dp_mul_add_s2_cd_sub_used = ((instr_i_sub_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq20_c1) | 
                                         (funct6_c_s2_23_opcode_2_c1 & instr_c_sub_s2_c1)) ? 
                                         dp_rs2_2c_s2 : 0; 
wire [32:0] dp_mul_add_s2_cd_neg_used = ((instr_m_mul_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1    & sign_s2_c1) |
                                         (instr_m_mulh_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1   & sign_s2_c1) |
                                         (instr_m_mulhsu_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1 & sign_s2_c1)) ? 
                                         dp_mul_add_s2_cd_neg : 0;

assign mul_carry_s2_next = (instr_m_mulhx_s2_c3 & state_eq1_s2_c3) ? 
                              ((dp_add_s2_c3[33:32] < 3) ? dp_add_s2_c3[33:32] : {1'b0, dp_add_s2_c3[32]}) :
                              mul_carry_s2_c3; 

wire [3:0] dp_rs1_2c_0_s2 = ~dp_rs1_s2_c1[ 3: 0] + 1;
wire [3:0] dp_rs1_2c_1_s2 = ~dp_rs1_s2_c1[ 7: 4] + 1;
wire [3:0] dp_rs1_2c_2_s2 = ~dp_rs1_s2_c1[11: 8] + 1;
wire [3:0] dp_rs1_2c_3_s2 = ~dp_rs1_s2_c1[15:12] + 1;
wire [3:0] dp_rs1_2c_4_s2 = ~dp_rs1_s2_c1[19:16] + 1;
wire [3:0] dp_rs1_2c_5_s2 = ~dp_rs1_s2_c1[23:20] + 1;
wire [3:0] dp_rs1_2c_6_s2 = ~dp_rs1_s2_c1[27:24] + 1;
wire [3:0] dp_rs1_2c_7_s2 = ~dp_rs1_s2_c1[31:28] + 1;
wire [3:0] dp_rs2_2c_0_s2 = ~dp_rs2_s2_c1[ 3: 0] + 1;
wire [3:0] dp_rs2_2c_1_s2 = ~dp_rs2_s2_c1[ 7: 4] + 1;
wire [3:0] dp_rs2_2c_2_s2 = ~dp_rs2_s2_c1[11: 8] + 1;
wire [3:0] dp_rs2_2c_3_s2 = ~dp_rs2_s2_c1[15:12] + 1;
wire [3:0] dp_rs2_2c_4_s2 = ~dp_rs2_s2_c1[19:16] + 1;
wire [3:0] dp_rs2_2c_5_s2 = ~dp_rs2_s2_c1[23:20] + 1;
wire [3:0] dp_rs2_2c_6_s2 = ~dp_rs2_s2_c1[27:24] + 1;
wire [4:0] dp_rs2_2c_7_s2 = ~dp_rs2_s2_c1[31:28] + 1;

wire dp_rs1_0_0_s2;
wire dp_rs1_1_0_s2;
wire dp_rs1_2_0_s2;
wire dp_rs1_3_0_s2;
wire dp_rs1_4_0_s2;
wire dp_rs1_5_0_s2;
wire dp_rs1_6_0_s2;
wire dp_rs2_0_0_s2;
wire dp_rs2_1_0_s2;
wire dp_rs2_2_0_s2;
wire dp_rs2_3_0_s2;
wire dp_rs2_4_0_s2;
wire dp_rs2_5_0_s2;
wire dp_rs2_6_0_s2;

//always @ (posedge clk_c1) begin
assign dp_rs1_0_0_s2 = dp_rs1_s2[ 3: 0] == 0;
assign dp_rs1_1_0_s2 = dp_rs1_s2[ 7: 4] == 0;
assign dp_rs1_2_0_s2 = dp_rs1_s2[11: 8] == 0;
assign dp_rs1_3_0_s2 = dp_rs1_s2[15:12] == 0;
assign dp_rs1_4_0_s2 = dp_rs1_s2[19:16] == 0;
assign dp_rs1_5_0_s2 = dp_rs1_s2[23:20] == 0;
assign dp_rs1_6_0_s2 = dp_rs1_s2[27:24] == 0;
assign dp_rs2_0_0_s2 = dp_rs2_s2[ 3: 0] == 0;
assign dp_rs2_1_0_s2 = dp_rs2_s2[ 7: 4] == 0;
assign dp_rs2_2_0_s2 = dp_rs2_s2[11: 8] == 0;
assign dp_rs2_3_0_s2 = dp_rs2_s2[15:12] == 0;
assign dp_rs2_4_0_s2 = dp_rs2_s2[19:16] == 0;
assign dp_rs2_5_0_s2 = dp_rs2_s2[23:20] == 0;
assign dp_rs2_6_0_s2 = dp_rs2_s2[27:24] == 0;
//end

wire [31:0] dp_rs1_2c_s2;
wire [31:0] dp_rs12_2c_s2;
wire [32:0] dp_rs2_2c_s2;

assign dp_rs1_2c_s2[ 3: 0] = dp_rs1_2c_0_s2;
assign dp_rs1_2c_s2[ 7: 4] = dp_rs1_0_0_s2 ? dp_rs1_2c_1_s2 : ~dp_rs1_s2_c1[ 7: 4];
assign dp_rs1_2c_s2[11: 8] = dp_rs1_0_0_s2 & dp_rs1_1_0_s2 ? dp_rs1_2c_2_s2 : ~dp_rs1_s2_c1[11: 8];
assign dp_rs1_2c_s2[15:12] = dp_rs1_0_0_s2 & dp_rs1_1_0_s2 & dp_rs1_2_0_s2 ? dp_rs1_2c_3_s2 : ~dp_rs1_s2_c1[15:12];
assign dp_rs1_2c_s2[19:16] = dp_rs1_0_0_s2 & dp_rs1_1_0_s2 & dp_rs1_2_0_s2 & dp_rs1_3_0_s2 ? dp_rs1_2c_4_s2 : ~dp_rs1_s2_c1[19:16];
assign dp_rs1_2c_s2[23:20] = dp_rs1_0_0_s2 & dp_rs1_1_0_s2 & dp_rs1_2_0_s2 & dp_rs1_3_0_s2 & dp_rs1_4_0_s2 ? dp_rs1_2c_5_s2 : ~dp_rs1_s2_c1[23:20];
assign dp_rs1_2c_s2[27:24] = dp_rs1_0_0_s2 & dp_rs1_1_0_s2 & dp_rs1_2_0_s2 & dp_rs1_3_0_s2 & dp_rs1_4_0_s2 & dp_rs1_5_0_s2 ? dp_rs1_2c_6_s2 : ~dp_rs1_s2_c1[27:24];
assign dp_rs1_2c_s2[31:28] = dp_rs1_0_0_s2 & dp_rs1_1_0_s2 & dp_rs1_2_0_s2 & dp_rs1_3_0_s2 & dp_rs1_4_0_s2 & dp_rs1_5_0_s2 & dp_rs1_6_0_s2 ? dp_rs1_2c_7_s2 : ~dp_rs1_s2_c1[31:28];

assign dp_rs2_2c_s2[ 3: 0] = dp_rs2_2c_0_s2;
assign dp_rs2_2c_s2[ 7: 4] = dp_rs2_0_0_s2 ? dp_rs2_2c_1_s2 : ~dp_rs2_s2_c1[ 7: 4];
assign dp_rs2_2c_s2[11: 8] = dp_rs2_0_0_s2 & dp_rs2_1_0_s2 ? dp_rs2_2c_2_s2 : ~dp_rs2_s2_c1[11: 8];
assign dp_rs2_2c_s2[15:12] = dp_rs2_0_0_s2 & dp_rs2_1_0_s2 & dp_rs2_2_0_s2 ? dp_rs2_2c_3_s2 : ~dp_rs2_s2_c1[15:12];
assign dp_rs2_2c_s2[19:16] = dp_rs2_0_0_s2 & dp_rs2_1_0_s2 & dp_rs2_2_0_s2 & dp_rs2_3_0_s2 ? dp_rs2_2c_4_s2 : ~dp_rs2_s2_c1[19:16];
assign dp_rs2_2c_s2[23:20] = dp_rs2_0_0_s2 & dp_rs2_1_0_s2 & dp_rs2_2_0_s2 & dp_rs2_3_0_s2 & dp_rs2_4_0_s2 ? dp_rs2_2c_5_s2 : ~dp_rs2_s2_c1[23:20];
assign dp_rs2_2c_s2[27:24] = dp_rs2_0_0_s2 & dp_rs2_1_0_s2 & dp_rs2_2_0_s2 & dp_rs2_3_0_s2 & dp_rs2_4_0_s2 & dp_rs2_5_0_s2 ? dp_rs2_2c_6_s2 : ~dp_rs2_s2_c1[27:24];
assign dp_rs2_2c_s2[32:28] = dp_rs2_0_0_s2 & dp_rs2_1_0_s2 & dp_rs2_2_0_s2 & dp_rs2_3_0_s2 & dp_rs2_4_0_s2 & dp_rs2_5_0_s2 & dp_rs2_6_0_s2 ? dp_rs2_2c_7_s2 : {1'b1, ~dp_rs2_s2_c1[31:28]};

wire [31:0] dp_neg_s2 = dp_rs1_2c_s2;

wire [31:0] dp_comb_s2 = dp_li16_s2 | dp_lui16_s2 | dp_mv16_s2 | dp_and16_s2 | dp_or16_s2 | dp_xor16_s2 | dp_andi16_s2 |
                         dp_lui_s2 | dp_xori_s2 | dp_ori_s2 | dp_andi_s2 | dp_xor_s2 |
                         dp_or_s2 | dp_and_s2;

wire [31:0] dp_out_s2_early = dp_comb_s2_c2 | {31'h00000000, dp_slt_s2} | dp_divrem_s2_c2;
wire [31:0] dp_out_s2 = dp_out_s2_early_c3 | dp_add_s2_c3[31:0] | dp_shmul_s2_c3;

wire dp_wr_s2_a = instr_i_lui_s2_c1 | instr_i_auipc_s2_c1 | instr_i_jal_s2_c1 | instr_i_jalr_s2_c1 |
                   opcode_i_s2_eq13_c1 |
                   (opcode_i_s2_eq33_c1 & (funct7_i_s2_eq0_c1 | funct7_i_s2_eq20_c1)) |
                   instr_c_jal_s2_c1 | (instr_c_jalr_s2_c1 & rs2_c_s2_eq0_c1) | instr_c_li_s2_c1 | 
                   (instr_c_lui_s2_c1 & !instr_s2_11_7_eq_02_c1) |
                   instr_c_addi_s2_c1 | 
                   (instr_c_addi16sp_s2_c1 & instr_s2_11_7_eq_02_c1) | instr_c_addi4spn_s2_c1 | (instr_c_mv_s2_c1 & !rs2_c_s2_eq0_c1) |
                   (instr_c_add_s2_c1 & !rs2_c_s2_eq0_c1) | instr_c_andi_s2_c1 |
                   (funct6_c_s2_23_opcode_2_c1 /* & (instr_c_and_s2_c1 | instr_c_or_s2_c1 | instr_c_xor_s2_c1 | instr_c_sub_s2_c1) */) |
                   instr_c_slli_s2_c1 | instr_c_srli_s2_c1 | instr_c_srai_s2_c1;
wire dp_wr_s2_b = dp_wr_s2_a_c2 |
                  instr_m_mul_s2_c2 |
                  (instr_m_mulhx_s2_c2 & state_eq3_s2_c2) |
                  (instr_m_divrem_s2_c2 & state_eq32_s2_c2);
wire dp_wr_s2 = dp_wr_s2_b_c3;

////////////////////////////////////////////////////////////
//
//   RegFile
//
////////////////////////////////////////////////////////////
//
//   rs1
//
wire rs1_def_sel_s1 = instr_s1_c1[1:0] == 2'b11;
wire [4:0] rs1_def_s1 = rs1_def_sel_s1 ? rs1_i_s1 : 0;
wire rs1_c_add_sel_s1 = instr_c_add_s1_c1 & !rs2_c_s1_eq0_c1;
wire [4:0] rs1_c_add_s1 = rs1_c_add_sel_s1 ? rs2_c_s1 : 0;
wire rs1_c_sp_sel_s1 = instr_c_addi4spn_s1_c1 | instr_c_swsp_s1_c1 | instr_c_lwsp_s1_c1;
wire [4:0] rs1_c_sp_s1 = rs1_c_sp_sel_s1 ? 2 : 0;
wire [4:0] rs1_c_1_s1 = !(rs1_def_sel_s1 | rs1_c_add_sel_s1 | rs1_c_sp_sel_s1 | rs1_c_def_sel_s1) ? {2'b01, rs1s_c_s1} : 0;
wire rs1_c_def_sel_s1 = (instr_c_addi_s1_c1 |
                           (instr_c_addi16sp_s1_c1 & instr_s1_11_7_eq_02_c1) |
                            instr_c_slli_s1_c1 |
                            (instr_c_jr_s1_c1 & rs2_c_s1_eq0_c1) |
                            (instr_c_jalr_s1_c1 & rs2_c_s1_eq0_c1));
wire [4:0] rs1_c_def_s1 = rs1_c_def_sel_s1 ? rs1_c_s1 : 0;
wire [4:0] rs1_s1 = rs1_def_s1 | rs1_c_add_s1 | rs1_c_sp_s1 | rs1_c_1_s1 | rs1_c_def_s1;

//
//   rs2
// 
wire rs2_def_sel_s1 = (instr_s1[1:0] == 2'b11) & !(instr_s1[6:2] == 5'h04);
wire [4:0] rs2_def_s1 = rs2_def_sel_s1_c1 ? rs2_i_s1 : 0;

wire [4:0] rs2_c_add_s1 = instr_c_add_s1_c1 & !rs2_c_s1_eq0_c1 ? rd_c_s1 : 0;
wire [4:0] rs2_c_mv_s1 = ((instr_c_mv_s1_c1 & !rs2_c_s1_eq0_c1) | instr_c_swsp_s1_c1) ? rs2_c_s1 : 0;
wire [4:0] rs2_c_sw_s1 = (instr_c_sw_s1_c1 | funct6_c_s1_23_opcode_2_c1) ? {2'b01, rs2s_c_s1} : 0;
wire [4:0] rs2_s1 = rs2_c_add_s1 | rs2_c_mv_s1 | rs2_c_sw_s1 | rs2_def_s1;

wire [4:0] rd_s2_i = instr_s2_c1[1:0] == 2'b11 ? rd_i_s2_c1 : 0;
wire [4:0] rd_s2_j = instr_c_jal_s2_c1 | (instr_c_jalr_s2_c1 & rs2_c_s2_eq0_c1) ? 1 : 0;
wire [4:0] rd_s2_c_1 = instr_c_lw_s2_c1 | instr_c_addi4spn_s2_c1 ? {2'b01, rds42_c_s2_c1} : 0;
wire [4:0] rd_s2_c_2 = instr_c_srli_s2_c1 | instr_c_srai_s2_c1 | instr_c_andi_s2_c1 | 
                       funct6_c_s2_23_opcode_2_c1 ? {2'b01, rds97_c_s2_c1} : 0;
wire [4:0] rd_s2 = !((instr_s2_c1[1:0] == 2'b11) |
                     (instr_c_jal_s2_c1 | (instr_c_jalr_s2_c1 & rs2_c_s2_eq0_c1)) |
                     (instr_c_lw_s2_c1 | instr_c_addi4spn_s2_c1) |
                     (instr_c_srli_s2_c1 | instr_c_srai_s2_c1 | instr_c_andi_s2_c1 |
                     funct6_c_s2_23_opcode_2_c1)) ? rd_c_s2_c1 :
                   (rd_s2_i | rd_s2_j | rd_s2_c_1 | rd_s2_c_2);



wire rs2_c_s2_eq0_c3 = (cubev_reg_dout1[6:2] == 0);
wire funct6_c_s2_23_opcode_2_c3 = //(opcode_c_s2 == 2'b01) & (funct6_c_s2 == 6'b100011);
                                  (cubev_reg_dout1[1:0] == 2'b01) & (cubev_reg_dout1[15:10] == 6'b100011);
wire [4:0] rd_c_s2_c3 = cubev_reg_dout1[11:7];
wire [4:0] rd_i_s2_c3 = cubev_reg_dout1[11:7];
wire [4:0] rd_s2_i_c3 = cubev_reg_dout1[1:0] == 2'b11 ? rd_i_s2_c3 : 0;
wire [4:0] rd_s2_j_c3 = instr_c_jal_s2_c1 | (instr_c_jalr_s2_c1 & rs2_c_s2_eq0_c3) ? 1 : 0;
wire [2:0] rds42_c_s2_c3 = cubev_reg_dout1[4:2];
wire [4:0] rd_s2_c_1_c3 = instr_c_lw_s2_c1 | instr_c_addi4spn_s2_c1 ? {2'b01, rds42_c_s2_c3} : 0;
wire [2:0] rds97_c_s2_c3 = cubev_reg_dout1[9:7];
wire [4:0] rd_s2_c_2_c3 = instr_c_srli_s2_c1 | instr_c_srai_s2_c1 | instr_c_andi_s2_c1 | 
                       funct6_c_s2_23_opcode_2_c3 ? {2'b01, rds97_c_s2_c3} : 0;

wire [4:0] rd_s2_c3 = !((/*instr_s2_c1*/ cubev_reg_dout1[1:0] == 2'b11) |
                     (instr_c_jal_s2_c1 | (instr_c_jalr_s2_c1 & rs2_c_s2_eq0_c3)) |
                     (instr_c_lw_s2_c1 | instr_c_addi4spn_s2_c1) |
                     (instr_c_srli_s2_c1 | instr_c_srai_s2_c1 | instr_c_andi_s2_c1 |
                     funct6_c_s2_23_opcode_2_c3)) ? rd_c_s2_c3 :
                   (rd_s2_i_c3 | rd_s2_j_c3 | rd_s2_c_1_c3 | rd_s2_c_2_c3);

wire rf1_wea_s2 = (pc_set_int/*[0] & data_set[0]*/) |
                  ((pvalid_c3 == 2) & //thread_pipe_valid/*[0]*/ &
                   (dp_wr_s2 |
                    instr_i_load_s2_c3 |
                    instr_c_lw_s2_c3 |
                    instr_c_lwsp_s2_c3));
                    //(instr_load_s2 & !stalled_next_c3)));
wire [4:0] rf1_addra_s2 = (pc_set_int/*[0] & data_set[0]*/) ? 5'h0a : rd_s2_c3;
wire [31:0] rf1_dina_s2 = pc_set_int ? {16'h0000, pc_set_data_int[29:14]} : //dbus_rd_i_data :
                          (dp_wr_s2) ? dp_out_s2 : dp_load_s2;

wire [4:0] rf1_addrb_s1 = mulh_access_0 ? instr_s2_c1[19:15] : rs1_s1;

wire [31:0] rf1_doutb_s1;

wire rf2_wea_s2 = (pc_set_int/*[0] & data_set[0]*/) |
                  ((pvalid_c3 == 2) & //thread_pipe_valid/*[0]*/ &
                   (instr_m_divrem_s2_c3 |
                    dp_wr_s2 |
                    instr_i_load_s2_c3 |
                    instr_c_lw_s2_c3 |
                    instr_c_lwsp_s2_c3));
                    //(instr_load_s2 & !stalled_next_c3)));
wire mulh_access_0 = instr_m_mulhx_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1 & (cubev_reg_dout5[8:3] == 1); //state_eq1_s2_c1;
wire divrem_access_0 = instr_m_divrem_s2_c3 & !(cubev_reg_dout5[8:3] == 32); //state_eq32_s2_c3;
wire divrem_access_0_d1_next = divrem_access_0 & !(cubev_reg_dout5[8:3] == 31); //state_eq31_s2_c3);
wire [4:0] rf2_addra_s2 = (pc_set_int/*[0] & data_set[0]*/) ? 5'h0a : divrem_access_0 ? 0 : rd_s2_c3;
wire [31:0] rf2_dina_s2 = pc_set_int ? {16'h0000, pc_set_data_int[29:14]} : //dbus_rd_i_data :
                          (divrem_access_0) ? dp_divrem_rfin_s2_c3 :
                          (dp_wr_s2) ? dp_out_s2 : dp_load_s2;

wire [4:0] rf2_addrb_s1 = divrem_access_0_d1 ? 0 :
                          mulh_access_0 ? instr_s2_c1[24:20] : rs2_s1;

wire [31:0] rf2_doutb_s1;

/*
wire [31:0] rf1_doutb_s1_dummy;
wire [31:0] rf2_doutb_s1_dummy;

RF_D16 RF1it (.clka(clk),
              .rstn(rstn),
              .wea(rf1_wea_s2 & !stalled_by_ext),
              .addra({tidwr, rf1_addra_s2}),
              .dina(rf1_dina_s2),
              .douta(),
              .clkb(~clk_c2),
              .addrb({tidrd2, rf1_addrb_s1}),
              .doutb(rf1_doutb_s1_dummy));

RF_D16 RF2it (.clka(clk),
              .rstn(rstn),
              .wea(rf2_wea_s2 & !stalled_by_ext),
              .addra({tidwr, rf2_addra_s2}),
              .dina(rf2_dina_s2),
              .douta(),
              .clkb(~clk_c2),
              .addrb({tidrd2, rf2_addrb_s1}),
              .doutb(rf2_doutb_s1_dummy)); 
*/

assign cubev_rf1_we = ~rf1_wea_s2;
assign cubev_rf1_wr_add = rf1_addra_s2;
assign cubev_rf1_din = rf1_dina_s2;
assign cubev_rf1_rd_add = rf1_addrb_s0; //rf1_addrb_s1;
assign rf1_doutb_s1 = cubev_rf1_dout;

assign cubev_rf2_we = ~rf2_wea_s2;
assign cubev_rf2_wr_add = rf2_addra_s2;
assign cubev_rf2_din = rf2_dina_s2;
assign cubev_rf2_rd_add = rf2_addrb_s0; //rf2_addrb_s1;
assign rf2_doutb_s1 = cubev_rf2_dout;

wire rf1_addrb_s1_zero = /* cubev_reg_dout5[20]*/ (rf1_addrb_s1 == 0) & (state_s2_c1 == 0);

wire [31:0] dp_rs1_s1 = rf1_addrb_s1_zero_c2 ? 0 : rf1_doutb_s1;

wire rf2_addrb_s1_zero = /* cubev_reg_dout5[21]; */ rf2_addrb_s1 == 0;

wire [31:0] dp_rs2_s1 = rf2_addrb_s1_zero_c2 ? 0 : rf2_doutb_s1;

wire [7:0] dp_rs1_2c_0_s1_c3;
wire [7:0] dp_rs1_2c_1_s1_c3;
wire [7:0] dp_rs1_2c_2_s1_c3;
wire [7:0] dp_rs1_2c_3_s1_c3;
wire [7:0] dp_rs2_2c_0_s1_c3;
wire [7:0] dp_rs2_2c_1_s1_c3;
wire [7:0] dp_rs2_2c_2_s1_c3;
wire [7:0] dp_rs2_2c_3_s1_c3;

//always @ (posedge clk_c3) begin
assign dp_rs1_2c_0_s1_c3 = ~dp_rs1_s1[ 7: 0] + 1;
assign dp_rs1_2c_1_s1_c3 = ~dp_rs1_s1[15: 8] + 1;
assign dp_rs1_2c_2_s1_c3 = ~dp_rs1_s1[23:16] + 1;
assign dp_rs1_2c_3_s1_c3 = ~dp_rs1_s1[31:24] + 1;
assign dp_rs2_2c_0_s1_c3 = ~dp_rs2_s1[ 7: 0] + 1;
assign dp_rs2_2c_1_s1_c3 = ~dp_rs2_s1[15: 8] + 1;
assign dp_rs2_2c_2_s1_c3 = ~dp_rs2_s1[23:16] + 1;
assign dp_rs2_2c_3_s1_c3 = ~dp_rs2_s1[31:24] + 1;
//end

wire [31:0] dp_rs1_2c_s1;
wire [31:0] dp_rs2_2c_s1;

wire dp_rs1_0_0_c3;
wire dp_rs1_1_0_c3;
wire dp_rs1_2_0_c3;
wire dp_rs2_0_0_c3;
wire dp_rs2_1_0_c3;
wire dp_rs2_2_0_c3;

//always @ (posedge clk_c3) begin
assign dp_rs1_0_0_c3 = dp_rs1_s1[ 7: 0] == 0;
assign dp_rs1_1_0_c3 = dp_rs1_s1[15: 8] == 0;
assign dp_rs1_2_0_c3 = dp_rs1_s1[23:16] == 0;
assign dp_rs2_0_0_c3 = dp_rs2_s1[ 7: 0] == 0;
assign dp_rs2_1_0_c3 = dp_rs2_s1[15: 8] == 0;
assign dp_rs2_2_0_c3 = dp_rs2_s1[23:16] == 0;
//end

assign dp_rs1_2c_s1[ 7: 0] = dp_rs1_2c_0_s1_c3;
assign dp_rs1_2c_s1[15: 8] = dp_rs1_0_0_c3 ? dp_rs1_2c_1_s1_c3 : ~dp_rs1_s1_c3[15: 8];
assign dp_rs1_2c_s1[23:16] = dp_rs1_0_0_c3 & dp_rs1_1_0_c3 ? dp_rs1_2c_2_s1_c3 : ~dp_rs1_s1_c3[23:16];
assign dp_rs1_2c_s1[31:24] = dp_rs1_0_0_c3 & dp_rs1_1_0_c3 & dp_rs1_2_0_c3 ? dp_rs1_2c_3_s1_c3 : ~dp_rs1_s1_c3[31:24];
assign dp_rs2_2c_s1[ 7: 0] = dp_rs2_2c_0_s1_c3;
assign dp_rs2_2c_s1[15: 8] = dp_rs2_0_0_c3 ? dp_rs2_2c_1_s1_c3 : ~dp_rs2_s1_c3[15: 8];
assign dp_rs2_2c_s1[23:16] = dp_rs2_0_0_c3 & dp_rs2_1_0_c3 ? dp_rs2_2c_2_s1_c3 : ~dp_rs2_s1_c3[23:16];
assign dp_rs2_2c_s1[31:24] = dp_rs2_0_0_c3 & dp_rs2_1_0_c3 & dp_rs2_2_0_c3 ? dp_rs2_2c_3_s1_c3 : ~dp_rs2_s1_c3[31:24];

wire [31:0] dp_rs1_abs_s1 = dp_rs1_s1_c3[31] ? dp_rs1_2c_s1 : dp_rs1_s1_c3;
wire [31:0] dp_rs2_abs_s1 = dp_rs2_s1_c3[31] ? dp_rs2_2c_s1 : dp_rs2_s1_c3;

////////////////////////////////////////////////////////////
//
//   PC
//
////////////////////////////////////////////////////////////
wire [31:0] pc_jal_s2 = instr_i_jal_s2_c1 ? {{11{imm_20_1_s2_c1[19]}}, imm_20_1_s2_c1, 1'b0} : 0;
wire [31:0] pc_c_j_s2 = instr_c_j_s2_c1 ? {{19{imm_11_10_9_8_7_6_5_4_3_1_s2_c1[10]}}, imm_11_10_9_8_7_6_5_4_3_1_s2_c1, 1'b0} : 0;
wire [31:0] pc_c_jal_s2 = instr_c_jal_s2_c1 ? {{19{imm_11_10_9_8_7_6_5_4_3_1_s2_c1[10]}}, imm_11_10_9_8_7_6_5_4_3_1_s2_c1, 1'b0} : 0;
wire [31:0] pc_c_jr_s2 = instr_c_jr_s2_c1 & rs2_c_s2_eq0_c1 ? dp_rs1_s2_c1 : 0;
wire [31:0] pc_c_jalr_s2 = instr_c_jalr_s2_c1 & rs2_c_s2_eq0_c1 ? dp_rs1_s2_c1 : 0;

wire dp_eq_0_s2 = dp_rs1_s2[ 3: 0] == dp_rs2_s2[ 3: 0];
wire dp_eq_1_s2 = dp_rs1_s2[ 7: 4] == dp_rs2_s2[ 7: 4];
wire dp_eq_2_s2 = dp_rs1_s2[11: 8] == dp_rs2_s2[11: 8];
wire dp_eq_3_s2 = dp_rs1_s2[15:12] == dp_rs2_s2[15:12];
wire dp_eq_4_s2 = dp_rs1_s2[19:16] == dp_rs2_s2[19:16];
wire dp_eq_5_s2 = dp_rs1_s2[23:20] == dp_rs2_s2[23:20];
wire dp_eq_6_s2 = dp_rs1_s2[27:24] == dp_rs2_s2[27:24];
wire dp_eq_7_s2 = dp_rs1_s2[31:28] == dp_rs2_s2[31:28]; 
wire beq_s2 = dp_eq_0_s2_c1 & dp_eq_1_s2_c1 & dp_eq_2_s2_c1 & dp_eq_3_s2_c1 &
              dp_eq_4_s2_c1 & dp_eq_5_s2_c1 & dp_eq_6_s2_c1 & dp_eq_7_s2_c1;

wire blt_s2 = (~dp_rs1_s2_c1[31] &  dp_rs2_s2_c1[31]) ? 1'b0 :	// + !< - 
              ( dp_rs1_s2_c1[31] & ~dp_rs2_s2_c1[31]) ? 1'b1 :	// -  < +  
              bltu_s2; 

wire dp_lt_0_s2 = dp_rs1_s2[ 3: 0] < dp_rs2_s2[ 3: 0];
wire dp_lt_1_s2 = dp_rs1_s2[ 7: 4] < dp_rs2_s2[ 7: 4];
wire dp_lt_2_s2 = dp_rs1_s2[11: 8] < dp_rs2_s2[11: 8];
wire dp_lt_3_s2 = dp_rs1_s2[15:12] < dp_rs2_s2[15:12];
wire dp_lt_4_s2 = dp_rs1_s2[19:16] < dp_rs2_s2[19:16];
wire dp_lt_5_s2 = dp_rs1_s2[23:20] < dp_rs2_s2[23:20];
wire dp_lt_6_s2 = dp_rs1_s2[27:24] < dp_rs2_s2[27:24];
wire dp_lt_7_s2 = dp_rs1_s2[31:28] < dp_rs2_s2[31:28]; 
wire bltu_s2 = dp_lt_7_s2_c1 |
                    (dp_eq_7_s2_c1 & dp_lt_6_s2_c1) |
                    (dp_eq_6_s2_c1 & dp_eq_7_s2_c1 & dp_lt_5_s2_c1) |
                    (dp_eq_5_s2_c1 & dp_eq_6_s2_c1 & dp_eq_7_s2_c1 & dp_lt_4_s2_c1) |
                    (dp_eq_4_s2_c1 & dp_eq_5_s2_c1 & dp_eq_6_s2_c1 & dp_eq_7_s2_c1 & dp_lt_3_s2_c1) |
                    (dp_eq_3_s2_c1 & dp_eq_4_s2_c1 & dp_eq_5_s2_c1 & dp_eq_6_s2_c1 & dp_eq_7_s2_c1 & dp_lt_2_s2_c1) |
                    (dp_eq_2_s2_c1 & dp_eq_3_s2_c1 & dp_eq_4_s2_c1 & dp_eq_5_s2_c1 & dp_eq_6_s2_c1 & dp_eq_7_s2_c1 & dp_lt_1_s2_c1) |
                    (dp_eq_1_s2_c1 & dp_eq_2_s2_c1 & dp_eq_3_s2_c1 & dp_eq_4_s2_c1 & dp_eq_5_s2_c1 & dp_eq_6_s2_c1 & dp_eq_7_s2_c1 & dp_lt_0_s2_c1);   
                   
wire [31:0] pc_beq_s2 = instr_i_beq_s2_c1 & opcode_i_s2_eq63_c1 ? {{19{imm_12_1_s2_c1[11]}}, imm_12_1_s2_c1, 1'b0} : 0;
wire [31:0] pc_beqz_s2 = instr_c_beqz_s2_c1 ? {{23{imm_8_7_6_5_4_3_2_1_s2_c1[7]}}, imm_8_7_6_5_4_3_2_1_s2_c1, 1'b0} : 0;                     
wire [31:0] pc_bne_s2 = instr_i_bne_s2_c1 & opcode_i_s2_eq63_c1 ? {{19{imm_12_1_s2_c1[11]}}, imm_12_1_s2_c1, 1'b0} : 0;                     
wire [31:0] pc_bnez_s2 = instr_c_bnez_s2_c1 ? {{23{imm_8_7_6_5_4_3_2_1_s2_c1[7]}}, imm_8_7_6_5_4_3_2_1_s2_c1, 1'b0} : 0;                     
wire [31:0] pc_blt_s2 = instr_i_blt_s2_c1 & opcode_i_s2_eq63_c1 ? {{19{imm_12_1_s2_c1[11]}}, imm_12_1_s2_c1, 1'b0} : 0;                     
wire [31:0] pc_bge_s2 = instr_i_bge_s2_c1 & opcode_i_s2_eq63_c1 ? {{19{imm_12_1_s2_c1[11]}}, imm_12_1_s2_c1, 1'b0} : 0;                     
wire [31:0] pc_bltu_s2 = instr_i_bltu_s2_c1 & opcode_i_s2_eq63_c1 ? {{19{imm_12_1_s2_c1[11]}}, imm_12_1_s2_c1, 1'b0} : 0;                     
wire [31:0] pc_bgeu_s2 = instr_i_bgeu_s2_c1 & opcode_i_s2_eq63_c1 ? {{19{imm_12_1_s2_c1[11]}}, imm_12_1_s2_c1, 1'b0} : 0;                     

wire branch_s2 = (instr_i_beq_s2_c1 & opcode_i_s2_eq63_c1 & beq_s2) |
                 (instr_c_beqz_s2_c1 & beq_s2) |
                 (instr_i_bne_s2_c1 & opcode_i_s2_eq63_c1 & !beq_s2) |
                 (instr_c_bnez_s2_c1 & !beq_s2) |
                 (instr_i_blt_s2_c1 & opcode_i_s2_eq63_c1 & blt_s2) |
                 (instr_i_bge_s2_c1 & opcode_i_s2_eq63_c1 & (beq_s2 | !blt_s2)) |
                 (instr_i_bltu_s2_c1 & opcode_i_s2_eq63_c1 & bltu_s2) |
                 (instr_i_bgeu_s2_c1 & opcode_i_s2_eq63_c1 & (!bltu_s2 | beq_s2));
wire jump_s2 = instr_i_jal_s2_c1 | instr_i_jalr_s2_c1 | instr_c_j_s2_c1 | instr_c_jal_s2_c1 |
               (instr_c_jr_s2_c1 & rs2_c_s2_eq0_c1) |
               (instr_c_jalr_s2_c1 & rs2_c_s2_eq0_c1);
wire jump_or_branch_s2 = branch_s2_c3 | jump_s2_c3;

wire [23:0] pc_s2_c2_late = {1'b0, cubev_reg_dout4_late[31:19]};
wire [23:0] pc_step_high_p1_s2 = pc_s2_c2_late[23:8] + 1;
wire [8:0] pc_step_low_p2_s2 = pc_s2_c2_late[7:0] + 2;
wire [8:0] pc_step_low_p4_s2 = pc_s2_c2_late[7:0] + 4;
wire [31:0] pc_step_p4_s2 = pc_step_low_p4_s2[8] ? {pc_step_high_p1_s2, pc_step_low_p4_s2[7:0]} : {pc_s2_c2_late[24:8], pc_step_low_p4_s2[7:0]};
wire [31:0] pc_step_p2_s2 = pc_step_low_p2_s2[8] ? {pc_step_high_p1_s2, pc_step_low_p2_s2[7:0]} : {pc_s2_c2_late[24:8], pc_step_low_p2_s2[7:0]};
wire [31:0] pc_step_s2 = instr[1:0] == 2'b11 ?
                              pc_step_p4_s2 :
                              pc_step_p2_s2;

wire [31:0] pc_jump_or_branch_dp_s2 = dp_rs1_jalr32_s2 | pc_beq_s2 | pc_bne_s2 | pc_bnez_s2 | pc_blt_s2 | pc_bge_s2 | pc_bltu_s2 | pc_bgeu_s2 | pc_beqz_s2 | 
                                      pc_jal_s2 |
                                      pc_c_j_s2 | pc_c_jr_s2 | pc_c_jal_s2 | pc_c_jalr_s2;

wire [31:0] pc_dp_a_s2 = ((branch_s2_c2 | jump_s2_c2) ? pc_jump_or_branch_dp_s2_c2 : 0);

wire [31:0] pc_dp_b_s2 = (!instr_i_jalr_s2_c2 &
                         ((!(branch_s2_c2 | jump_s2_c2)) |
                         instr_i_beq_s2_c2 | instr_i_bne_s2_c2 | instr_c_bnez_s2_c2 |
                         instr_i_blt_s2_c2 | instr_i_bge_s2_c2 | instr_i_bltu_s2_c2 | instr_i_bgeu_s2_c2 | instr_c_beqz_s2_c2 |
                         instr_i_jal_s2_c2 |
                         instr_c_j_s2_c2 | instr_c_jal_s2_c2)) ? pc_s2_c2 : dp_imm_jalr32_s2;

wire [31:0] pc_clear_s2 = (pcadv1 & pcadv2) ? 8 :
                          (!pcadv1 & !pcadv2) ? 4 : 6;
wire [31:0] pc_dp_c_s2 = !(branch_s2_c2 | instr_i_jal_s2_c2 | instr_c_j_s2_c2 | instr_c_jal_s2_c2) ? 0 : pc_clear_s2_c2;

wire [31:0] pc_dp_d_s2 = (pc_dp_a_s2 + pc_dp_b_s2 - pc_dp_c_s2);

wire [31:0] pc_dp_s2 = (!instr_i_jalr_s2_c3 & !jump_or_branch_s2) ? (pc_step_s2_c3) :
                       pc_dp_d_s2_c3; 

wire pc_stalled_s2 = stalled_next_c3 |
                     (instr_m_divrem_s2_c3 & !state_eq32_s2_c3) |
                     (instr_m_mul_s2_c3 & state_eq0_s2_c3) |
                     (instr_m_mulhx_s2_c3 & state_lt3_s2_c3);

wire [31:0] pc_s2_next_stalled_s2 = pc_stalled_s2 ? cubev_reg_dout4_late[31:19] : 0; //pc_s2_c3 : 0;
wire [31:0] pc_s2_next_continue_s2 = !pc_stalled_s2 ? pc_dp_s2 : 0;
assign pc_s2_next = pc_s2_next_stalled_s2 |
                    pc_s2_next_continue_s2;

wire [31:0] pc_cleared_s2 = pc_s2_c1 - pc_clear_s2_c1;

////////////////////////////////////////////////////////////
//
// Datapath Memory Handling (S1)
//
////////////////////////////////////////////////////////////
wire [4:0] imm_6_5_3_2_s1_c0 = {instr_s1[5], instr_s1[12:10], instr_s1[6]};
wire [5:0] offset_7_6_5_4_2_s1_c0 = {instr_s1[3:2], instr_s1[12], instr_s1[6:4]};
wire [11:0] imm_11_5_4_0_s1_c0 = {instr_s1[31:25], instr_s1[11:7]};
wire [5:0] offset_7_6_5_2_s1_c0 = {instr_s1[8:7], instr_s1[12:9]};

/*
wire [31:0] dbus_rdwr_offset_load_s1 = instr_i_load_s1_c1_next ? {{20{imm_11_0_s1[11]}}, imm_11_0_s1} : 0;
wire [31:0] dbus_rdwr_offset_c_lw_s1 = instr_c_lw_s1_c1_next ? {24'h000000, imm_6_5_3_2_s1_c0, 2'b00} : 0;
wire [31:0] dbus_rdwr_offset_c_lwsp_s1 = instr_c_lwsp_s1_c1_next ? {25'h0000000, offset_7_6_5_4_2_s1_c0, 2'b00} : 0;
*/
wire [31:0] dbus_rdwr_offset_store_s1 = instr_i_store_s1_c1_next ? {{20{imm_11_5_4_0_s1_c0[11]}}, imm_11_5_4_0_s1_c0} : 0;
wire [31:0] dbus_rdwr_offset_c_sw_s1 = instr_c_sw_s1_c1_next ? {24'h000000, imm_6_5_3_2_s1_c0, 2'b00} : 0;
wire [31:0] dbus_rdwr_offset_c_swsp_s1 = instr_c_swsp_s1_c1_next ? {25'h0000000, offset_7_6_5_2_s1_c0, 2'b00} : 0;

wire [31:0] dbus_rdwr_add_a_s1 = (dbus_rdwr_offset_load_s1 |
                                  dbus_rdwr_offset_c_lw_s1 |
                                  dbus_rdwr_offset_c_lwsp_s1 |
                                  dbus_rdwr_offset_store_s1 |
                                  dbus_rdwr_offset_c_sw_s1 |
                                  dbus_rdwr_offset_c_swsp_s1);

wire [31:0] dbus_rdwr_add_s1 = dbus_rdwr_add_a_s1 + dp_rs1_s2_next_int;

////////////////////////////////////////////////////////////
//
// Datapath Memory Handling
//
////////////////////////////////////////////////////////////
assign dbus_rdwr_width = (instr_i_load_s2_c1 | instr_i_store_s2_c1) ? instr_s2_c1[13:12] : 2;
wire [31:0] dbus_rdwr_offset_load_s2 = instr_i_load_s2 ? {{20{imm_11_0_s2[11]}}, imm_11_0_s2} : 0;
wire [31:0] dbus_rdwr_offset_c_lw_s2 = instr_c_lw_s2 ? {24'h000000, imm_6_5_3_2_s2_c0, 2'b00} : 0;
wire [31:0] dbus_rdwr_offset_c_lwsp_s2 = instr_c_lwsp_s2 ? {25'h0000000, offset_7_6_5_4_2_s2_c0, 2'b00} : 0;
assign dbus_rd_i_req = (!stalled_c1) & 
                       instr_load_valid_c1;

wire dp_lw_s2_sel = (//pc_set_int | //(/*pc_set_int[1] & data_set[1]*/) |
                     (instr_s2_c2[14:12] == 3'b010) | instr_c_lw_s2_c2 | instr_c_lwsp_s2_c2) ? 1'b1 : 0;
wire [31:0] dp_lw_s2 = dp_lw_s2_sel_c3 ? dbus_rd_i_data : 0;
wire [31:0] dp_lb_s2 = instr_s2_c3[14:12] == 3'b000 ? {{24{dbus_rd_i_data[7]}}, dbus_rd_i_data[7:0]} : 0;
wire [31:0] dp_lh_s2 = instr_s2_c3[14:12] == 3'b001 ? {{16{dbus_rd_i_data[15]}}, dbus_rd_i_data[15:0]} : 0;
wire [31:0] dp_lbu_s2 = instr_s2_c3[14:12] == 3'b100 ? {24'h000000, dbus_rd_i_data[7:0]} : 0;
wire [31:0] dp_lhu_s2 = instr_s2_c3[14:12] == 3'b101 ? {16'h000000, dbus_rd_i_data[15:0]} : 0;
wire [31:0] dp_load_s2 = dp_lb_s2 |
                      dp_lh_s2 |
                      dp_lw_s2 |
                      dp_lbu_s2 |
                      dp_lhu_s2;

wire [31:0] dbus_rdwr_offset_store_s2 = instr_i_store_s2 ? {{20{imm_11_5_4_0_s2_c0[11]}}, imm_11_5_4_0_s2_c0} : 0;
wire [31:0] dbus_rdwr_offset_c_sw_s2 = (instr_c_sw_s2) ? {24'h000000, imm_6_5_3_2_s2_c0, 2'b00} : 0;
wire [31:0] dbus_rdwr_offset_c_swsp_s2 = (instr_c_swsp_s2) ? {25'h0000000, offset_7_6_5_2_s2_c0, 2'b00} : 0;

assign dbus_wr_en = glue_out[11]; //(!stalled_next) & instr_store_valid_c2;

//wire [31:0] dbus_rdwr_add_a = (dbus_rdwr_offset_load_s2 |
//                                dbus_rdwr_offset_c_lw_s2 |
//                                dbus_rdwr_offset_c_lwsp_s2 |
//                                dbus_rdwr_offset_store_s2 |
//                                dbus_rdwr_offset_c_sw_s2 |
//                                dbus_rdwr_offset_c_swsp_s2);

//assign dbus_rdwr_add = dbus_rdwr_add_a_c1 + dp_rs1_s2_c1;

//assign dbus_rd_add_fast = dp_rs2_s2 + dp_rs1_s2;

assign dbus_rd_add = (dbus_rdwr_offset_load_s2 |
                      dbus_rdwr_offset_c_lw_s2 |
                      dbus_rdwr_offset_c_lwsp_s2) + dp_rs1_s2_c1;
assign dbus_wr_add = (dbus_rdwr_offset_store_s2 |
                      dbus_rdwr_offset_c_sw_s2 |
                      dbus_rdwr_offset_c_swsp_s2) + dp_rs1_s2_c1;

assign dbus_wr_data = dp_rs2_s2_c1;

////////////////////////////////////////////////////////////
//
//	SHP-Memories
//
////////////////////////////////////////////////////////////
wire [1:0] glue_in_tmp = (instr_m_mulhx_s2_c3 & state_lt3_s2_c3) ? mul_carry_s2_next : pvalid_next;
wire [31:0] glue_in; 

parameter TC_START       = 18'h00000;
parameter TC_KILL        = 18'h00004;
parameter TC_SAK         = 18'h00008;
parameter CLK_SEL        = 18'h00010;
parameter CLK_VAL        = 18'h00018;
//parameter CLK_DBG        = 18'h00018;
parameter EXT_PATH       = 18'h00020;
parameter CA_PER = 14'h0100;

wire dbus_rdwr_add_per_int = dbus_rdwr_add_s1[31:18] == 14'h2000;
wire kill_int = dbus_wr_en_s1 & dbus_rdwr_add_per_int & (dbus_rdwr_add_s1[17:0] == TC_KILL);
wire start_int = dbus_wr_en_s1 & dbus_rdwr_add_per_int & (dbus_rdwr_add_s1[17:0] == TC_START);
wire sak_int = dbus_wr_en_s1 & dbus_rdwr_add_per_int & (dbus_rdwr_add_s1[17:0] == TC_SAK);
wire wr_clk_sel_int = dbus_wr_en_s1 & dbus_rdwr_add_per_int & (dbus_rdwr_add_s1[17:0] == CLK_SEL);
wire wr_clk_val_int = dbus_wr_en_s1 & dbus_rdwr_add_per_int & (dbus_rdwr_add_s1[17:0] == CLK_VAL);
//wire wr_clk_dbg_int = dbus_wr_en_s1 & dbus_rdwr_add_per_int & (dbus_rdwr_add_s1[17:0] == CLK_DBG);
wire ext_path_int = dbus_wr_en_s1 & dbus_rdwr_add_per_int & (dbus_rdwr_add_s1[17:0] == EXT_PATH);
wire ca_per = (dbus_rdwr_add_s1[17:4] == CA_PER);

assign glue_in[31] = pc_set_int ? 0 : kill_int;
assign glue_in[30] = pc_set_int ? 0 : start_int;
assign glue_in[29] = pc_set_int ? 0 : sak_int;
assign glue_in[28] = pc_set_int ? 0 : wr_clk_sel_int;
assign glue_in[27] = pc_set_int ? 0 : wr_clk_val_int;
assign glue_in[26] = pc_set_int ? 0 : ca_per;
assign glue_in[25] = pc_set_int ? 0 : ext_path_int;

assign glue_in[24] = pc_set_int ? 0 : instr_m_mulhx_s2_c3;
// assign glue_in[23] = pc[13];

assign glue_in[22:18] = rf2_addrb_s0;
assign glue_in[17:13] = rf1_addrb_s0;

wire instr_load_valid_s1 = (pvalid_next_late == 2) &
                           (instr_i_load_s1_c3 | instr_c_lw_s1_c3 | instr_c_lwsp_s1_c3);
assign dbus_rd_req_s1 = instr_load_valid_s1;

wire instr_store_valid_s1 = (pvalid_next_late == 2) & 
                            (instr_i_store_s1_c3 | instr_c_sw_s1_c3 | instr_c_swsp_s1_c3);
wire dbus_wr_en_s1 = instr_store_valid_s1;

assign glue_in[12: 0] = pc_set_int ? 0 : 
                        {dbus_rd_req_s1,
                         dbus_wr_en_s1, 
                         divrem_access_0_d1_next,
                         sign_s2_next, 
                         state_s2_next, 
                         stalled_next_c3,
                         glue_in_tmp};
wire [31:0] instr_s1_out;
wire [31:0] instr_s2_out;
wire [31:0] glue_out;

/*
Reg_D16 Reg_instr_s1 (.clka(clk),
                      .wea(thread_pipe_valid[0] & !stalled_by_ext), // & !(instr_load_s2 & stalled_next_c3)),
                      .addra(tidwr),
                      .dina(instr_s1_next),
                      .douta(),
                      .clkb(clk),
                      .addrb(tidrd0),
                      .doutb(instr_s1_out));

Reg_D16 Reg_instr_s2 (.clka(clk),
                      .wea(thread_pipe_valid[0] & !stalled_by_ext), // & !(instr_load_s2 & stalled_next_c3)),
                      .addra(tidwr),
                      .dina(instr_s2_next),
                      .douta(),
                      .clkb(clk),
                      .addrb(tidrd0),
                      .doutb(instr_s2_out));

Reg_D16 Reg_dp_rs1_s2 (.clka(clk),
                       .wea(thread_pipe_valid[0] & !stalled_by_ext), // & !(instr_load_s2 & stalled_next_c3)),
                       .addra(tidwr),
                       .dina(dp_rs1_s2_next),
                       .douta(),
                       .clkb(clk),
                       .addrb(tidrd0),
                       .doutb(dp_rs1_s2));

Reg_D16 Reg_dp_rs2_s2 (.clka(clk),
                       .wea(thread_pipe_valid[0] & !stalled_by_ext), // & !(instr_load_s2 & stalled_next_c3)),
                       .addra(tidwr),
                       .dina(dp_rs2_s2_next),
                       .douta(),
                       .clkb(clk),
                       .addrb(tidrd0),
                       .doutb(dp_rs2_s2));

Reg_D16 Reg_glue (.clka(clk),
                  .wea(thread_pipe_valid[0] & !stalled_by_ext),
                  .addra(tidwr),
                  .dina(glue_in),
                  .douta(),
                  .clkb(clk),
                  .addrb(tidrd0),
                  .doutb(glue_out));
*/
assign cubev_reg_din0 = pc_set_int ? 32'h00000013 : instr_s1_next;
assign cubev_reg_din1 = pc_set_int ? 32'h00000013 : instr_s2_next;
assign cubev_reg_din2 = dp_rs1_s2_next;
assign cubev_reg_din3 = dp_rs2_s2_next;
assign cubev_reg_din4[17:0] = dbus_rdwr_add_s1;
assign cubev_reg_din4[18] = dbus_rdwr_add_s1[31:18] == 14'h2000;
assign cubev_reg_din4[31:19] = pc_set_int ? {pc_set_data_int[11:0], 1'b0} : pc_s2_next[12:0]; 
assign cubev_reg_din5 = glue_in[31:0];


assign instr_s1_out = cubev_reg_dout0;
assign instr_s2_out = cubev_reg_dout1;
assign dp_rs1_s2 = cubev_reg_dout2;
assign dp_rs2_s2 = cubev_reg_dout3;

assign glue_out[31:0] = cubev_reg_dout5;
assign instr_s1 = instr_s1_out;
assign instr_s2 = instr_s2_out;
wire [1:0] pvalid_late = state_eq0_s2 ? cubev_reg_dout5_late[1:0] : 2;
assign pvalid = state_eq0_s2 ? cubev_reg_dout5[1:0] : 2;
assign mul_carry_s2 = ((state_s2 == 2) | (state_s2 == 3)) ? glue_out[1:0] : 0;
assign stalled = glue_out[2];
assign state_s2 = glue_out[8:3];
assign sign_s2 = cubev_reg_dout5[9];
wire sign_s2_c1 = cubev_reg_dout5[9];
assign sign_s2_late = cubev_reg_dout5_late[9];
assign divrem_access_0_d1 = glue_out_c1[10];

assign pc_s2[12:0] = cubev_reg_dout4[31:19];
assign pc_s2[31:13] = 0; 


assign instr_i_load_s2  = opcode_i_s2 == 7'b0000011;
assign instr_c_lw_s2    = opcode_c_s2 == 2'b00 & funct3_c_s2 == 3'b010;
assign instr_c_lwsp_s2  = opcode_c_s2 == 2'b10 & funct3_c_s2 == 3'b010;
assign instr_i_store_s2 = opcode_i_s2 == 7'b0100011;
assign instr_c_sw_s2    = opcode_c_s2 == 2'b00 & funct3_c_s2 == 3'b110;
assign instr_c_swsp_s2  = opcode_c_s2 == 2'b10 & funct3_c_s2 == 3'b110;

////////////////////////////////////////////////////////////
//
//	Previous C-Slow Retiming Register
//
////////////////////////////////////////////////////////////
wire [31:0] instr_s1_c1;
wire instr_i_lui_s1_c1;
wire instr_i_auipc_s1_c1;
wire instr_i_jal_s1_c1;
wire instr_i_load_s1_c1;
wire instr_i_store_s1_c1;
wire instr_i_slli_s1_c1;
wire instr_i_srli_s1_c1;
wire instr_i_srai_s1_c1;
wire instr_i_sll_s1_c1;
wire instr_i_srl_s1_c1;
wire instr_i_sra_s1_c1;
wire instr_m_mul_s1_c1;
wire instr_m_mulh_s1_c1;
wire instr_m_mulhsu_s1_c1;
wire instr_m_div_s1_c1;
wire instr_m_rem_s1_c1;
wire instr_c_lwsp_s1_c1;
wire instr_c_swsp_s1_c1;
wire instr_c_lw_s1_c1;
wire instr_c_sw_s1_c1;
wire instr_c_j_s1_c1;
wire instr_c_jal_s1_c1;
wire instr_c_jr_s1_c1;
wire instr_c_jalr_s1_c1;
wire instr_c_li_s1_c1;
wire instr_c_lui_s1_c1;
wire instr_c_beqz_s1_c1;
wire instr_c_bnez_s1_c1;
wire instr_c_addi_s1_c1;
wire instr_c_addi16sp_s1_c1;
wire instr_c_addi4spn_s1_c1;
wire instr_c_slli_s1_c1;
wire instr_c_srli_s1_c1;
wire instr_c_srai_s1_c1;
wire instr_c_andi_s1_c1;
wire instr_c_mv_s1_c1;
wire instr_c_add_s1_c1;
wire [31:0] instr_s2_c1;
wire instr_i_lui_s2_c1;
wire instr_i_auipc_s2_c1;
wire instr_i_jal_s2_c1;
wire instr_i_jalr_s2_c1;
wire instr_i_beq_s2_c1;
wire instr_i_bne_s2_c1;
wire instr_i_blt_s2_c1;
wire instr_i_bge_s2_c1;
wire instr_i_bltu_s2_c1;
wire instr_i_bgeu_s2_c1;
wire instr_i_addi_s2_c1;
wire instr_i_slti_s2_c1;
wire instr_i_sltiu_s2_c1;
wire instr_i_xori_s2_c1;
wire instr_i_ori_s2_c1;
wire instr_i_andi_s2_c1;
wire instr_i_slli_s2_c1;
wire instr_i_srli_s2_c1;
wire instr_i_srai_s2_c1;
wire instr_i_add_s2_c1;
wire instr_i_sub_s2_c1;
wire instr_i_sll_s2_c1;
wire instr_i_slt_s2_c1;
wire instr_i_sltu_s2_c1;
wire instr_i_xor_s2_c1;
wire instr_i_srl_s2_c1;
wire instr_i_sra_s2_c1;
wire instr_i_or_s2_c1;
wire instr_i_and_s2_c1;
wire instr_m_mul_s2_c1;
wire instr_m_mulh_s2_c1;
wire instr_m_mulhsu_s2_c1;
wire instr_m_mulhu_s2_c1;
wire instr_m_div_s2_c1;
wire instr_m_divu_s2_c1;
wire instr_m_rem_s2_c1;
wire instr_c_j_s2_c1;
wire instr_c_jal_s2_c1;
wire instr_c_jr_s2_c1;
wire instr_c_jalr_s2_c1;
wire instr_c_li_s2_c1;
wire instr_c_lui_s2_c1;
wire instr_c_beqz_s2_c1;
wire instr_c_bnez_s2_c1;
wire instr_c_addi_s2_c1;
wire instr_c_addi16sp_s2_c1;
wire instr_c_addi4spn_s2_c1;
wire instr_c_slli_s2_c1;
wire instr_c_srli_s2_c1;
wire instr_c_srai_s2_c1;
wire instr_c_andi_s2_c1;
wire instr_c_mv_s2_c1;
wire instr_c_add_s2_c1;
wire instr_c_and_s2_c1;
wire instr_c_or_s2_c1;
wire instr_c_xor_s2_c1;
wire instr_c_sub_s2_c1;
wire [31:0] glue_out_c1;
wire [31:0] dp_rs1_s2_c1;
wire [31:0] dp_rs2_s2_c1;
wire [31:0] pc_s2_c1;
wire instr_i_load_s2_c1;
wire instr_c_lw_s2_c1;
wire instr_c_lwsp_s2_c1;
wire instr_load_valid_c1;
wire instr_i_store_s2_c1;
wire instr_c_sw_s2_c1;
wire instr_c_swsp_s2_c1;
wire [1:0] pvalid_c1;
wire stalled_c1;
wire instr_m_s1_c1;
wire [5:0] state_s2_c1;
wire state_eq0_s2_c1;
wire state_eq1_s2_c1;
wire state_eq32_s2_c1;
wire instr_m_divrem_s2_c1;
wire instr_m_mulx_s2_c1;
wire [31:0] pc_clear_s2_c1;
wire [63:0] dp_div_divisor_s2_c1;
//wire [31:0] dbus_rdwr_add_a_c1;
wire instr_m_mulhx_s2_c1;
wire [1:0] mul_carry_s2_c1;
wire funct7_i_s2_eq0_c1;
wire funct7_i_s2_eq20_c1;
wire funct7_i_s2_eq1_c1;
wire [32:0] dp_mul_add_s2_cd_def_c1;
wire [16:0] dp_mul_add_s2_ab_def_p1_c1;
wire [16:0] dp_mul_add_s2_ab_def_p2_c1;
wire [16:0] dp_mul_add_s2_ab_def_hw_p1_c1;
wire dp_eq_0_s2_c1;
wire dp_eq_1_s2_c1;
wire dp_eq_2_s2_c1;
wire dp_eq_3_s2_c1;
wire dp_eq_4_s2_c1;
wire dp_eq_5_s2_c1;
wire dp_eq_6_s2_c1;
wire dp_eq_7_s2_c1;
wire dp_lt_0_s2_c1;
wire dp_lt_1_s2_c1;
wire dp_lt_2_s2_c1;
wire dp_lt_3_s2_c1;
wire dp_lt_4_s2_c1;
wire dp_lt_5_s2_c1;
wire dp_lt_6_s2_c1;
wire dp_lt_7_s2_c1; 
wire opcode_i_s1_13_shamt_c1;
wire opcode_i_s1_13_c1;
wire opcode_i_s1_23_c1;
wire opcode_i_s1_33_c1;
wire opcode_i_s1_63_c1;
wire funct6_c_s1_23_opcode_2_c1;
wire funct6_c_s2_23_opcode_2_c1;
wire opcode_i_s2_eq13_c1;
wire opcode_i_s2_eq33_c1;
wire opcode_i_s2_eq63_c1;
wire rs2_c_s2_eq0_c1;
wire rs2_c_s1_eq0_c1;
wire instr_s1_11_7_eq_02_c1;
wire instr_s2_11_7_eq_02_c1;
wire rs2_def_sel_s1_c1;

assign instr_s1_c1 = instr_s1;
assign instr_i_lui_s1_c1 = instr_i_lui_s1_c1_next;
assign instr_i_auipc_s1_c1 = instr_i_auipc_s1_c1_next;
assign instr_i_jal_s1_c1 = instr_i_jal_s1_c1_next;
assign instr_i_load_s1_c1 = instr_i_load_s1_c1_next;
assign instr_i_store_s1_c1 = instr_i_store_s1_c1_next;
assign instr_i_slli_s1_c1 = instr_i_slli_s1_c1_next;
assign instr_i_srli_s1_c1 = instr_i_srli_s1_c1_next;
assign instr_i_srai_s1_c1 = instr_i_srai_s1_c1_next;
assign instr_i_sll_s1_c1 = instr_i_sll_s1_c1_next;
assign instr_i_srl_s1_c1 = instr_i_srl_s1_c1_next;
assign instr_i_sra_s1_c1 = instr_i_sra_s1_c1_next;
assign instr_m_mul_s1_c1 = instr_m_mul_s1_c1_next;
assign instr_m_mulh_s1_c1 = instr_m_mulh_s1_c1_next;
assign instr_m_mulhsu_s1_c1 = instr_m_mulhsu_s1_c1_next;
assign instr_m_div_s1_c1 = instr_m_div_s1_c1_next;
assign instr_m_rem_s1_c1 = instr_m_rem_s1_c1_next;
assign instr_c_lwsp_s1_c1 = instr_c_lwsp_s1_c1_next;
assign instr_c_swsp_s1_c1 = instr_c_swsp_s1_c1_next;
assign instr_c_lw_s1_c1 = instr_c_lw_s1_c1_next;
assign instr_c_sw_s1_c1 = instr_c_sw_s1_c1_next;
assign instr_c_j_s1_c1 = instr_c_j_s1_c1_next;
assign instr_c_jal_s1_c1 = instr_c_jal_s1_c1_next;
assign instr_c_jr_s1_c1 = instr_c_jr_s1_c1_next;
assign instr_c_jalr_s1_c1 = instr_c_jalr_s1_c1_next;
assign instr_c_li_s1_c1 = instr_c_li_s1_c1_next;
assign instr_c_lui_s1_c1 = instr_c_lui_s1_c1_next;
assign instr_c_beqz_s1_c1 = instr_c_beqz_s1_c1_next;
assign instr_c_bnez_s1_c1 = instr_c_bnez_s1_c1_next;
assign instr_c_addi_s1_c1 = instr_c_addi_s1_c1_next;
assign instr_c_addi16sp_s1_c1 = instr_c_addi16sp_s1_c1_next;
assign instr_c_addi4spn_s1_c1 = instr_c_addi4spn_s1_c1_next;
assign instr_c_slli_s1_c1 = instr_c_slli_s1_c1_next;
assign instr_c_srli_s1_c1 = instr_c_srli_s1_c1_next;
assign instr_c_srai_s1_c1 = instr_c_srai_s1_c1_next;
assign instr_c_andi_s1_c1 = instr_c_andi_s1_c1_next;
assign instr_c_mv_s1_c1 = instr_c_mv_s1_c1_next;
assign instr_c_add_s1_c1 = instr_c_add_s1_c1_next;
assign glue_out_c1 = glue_out;
assign dp_rs1_s2_c1 = dp_rs1_s2;
assign dp_rs2_s2_c1 = dp_rs2_s2;
assign pc_s2_c1 = pc_s2;
assign instr_i_load_s2_c1 = instr_i_load_s2;
assign instr_c_lw_s2_c1 = instr_c_lw_s2;
assign instr_c_lwsp_s2_c1 = instr_c_lwsp_s2;
assign instr_load_valid_c1 = (pvalid == 2) &
                          (instr_i_load_s2 | instr_c_lw_s2 | instr_c_lwsp_s2); // &
                          //thread_pipe_valid/*[3]*/;
assign instr_i_store_s2_c1 = instr_i_store_s2;
assign instr_c_sw_s2_c1 = instr_c_sw_s2;
assign instr_c_swsp_s2_c1 = instr_c_swsp_s2;
assign pvalid_c1 = pvalid;
assign stalled_c1 = stalled;
assign instr_m_s1_c1 = instr_m_s1;
assign state_s2_c1 = state_s2;
assign state_eq0_s2_c1 = state_eq0_s2;
assign state_eq1_s2_c1 = state_eq1_s2;
assign state_eq32_s2_c1 = state_eq32_s2;
assign instr_m_divrem_s2_c1 = instr_m_divrem_s2;
assign instr_m_mulx_s2_c1 = instr_m_mulx_s2;
assign pc_clear_s2_c1 = pc_clear_s2;
assign dp_div_divisor_s2_c1 = dp_div_divisor_s2;
//assign dbus_rdwr_add_a_c1 = dbus_rdwr_add_a; 
assign instr_m_mulhx_s2_c1 = instr_m_mulhx_s2;
assign mul_carry_s2_c1 = mul_carry_s2;
assign funct7_i_s2_eq0_c1 = funct7_i_s2_eq0;
assign funct7_i_s2_eq20_c1 = funct7_i_s2_eq20;
assign funct7_i_s2_eq1_c1 = funct7_i_s2_eq1;
assign dp_mul_add_s2_cd_def_c1 = dp_mul_add_s2_cd_def;
assign dp_mul_add_s2_ab_def_p1_c1 = dp_mul_add_s2_ab_def_p1;
assign dp_mul_add_s2_ab_def_p2_c1 = dp_mul_add_s2_ab_def_p2;
assign dp_mul_add_s2_ab_def_hw_p1_c1 = dp_mul_add_s2_ab_def_hw_p1;
assign dp_eq_0_s2_c1 = dp_eq_0_s2;
assign dp_eq_1_s2_c1 = dp_eq_1_s2;
assign dp_eq_2_s2_c1 = dp_eq_2_s2;
assign dp_eq_3_s2_c1 = dp_eq_3_s2;
assign dp_eq_4_s2_c1 = dp_eq_4_s2;
assign dp_eq_5_s2_c1 = dp_eq_5_s2;
assign dp_eq_6_s2_c1 = dp_eq_6_s2;
assign dp_eq_7_s2_c1 = dp_eq_7_s2;
assign dp_lt_0_s2_c1 = dp_lt_0_s2;
assign dp_lt_1_s2_c1 = dp_lt_1_s2;
assign dp_lt_2_s2_c1 = dp_lt_2_s2;
assign dp_lt_3_s2_c1 = dp_lt_3_s2;
assign dp_lt_4_s2_c1 = dp_lt_4_s2;
assign dp_lt_5_s2_c1 = dp_lt_5_s2;
assign dp_lt_6_s2_c1 = dp_lt_6_s2;
assign dp_lt_7_s2_c1 = dp_lt_7_s2; 
assign opcode_i_s1_13_shamt_c1 = opcode_i_s1_13_shamt;
assign opcode_i_s1_13_c1 = opcode_i_s1_13;
assign opcode_i_s1_23_c1 = opcode_i_s1_23;
assign opcode_i_s1_33_c1 = opcode_i_s1_33;
assign opcode_i_s1_63_c1 = opcode_i_s1_63;
assign funct6_c_s1_23_opcode_2_c1 = (opcode_c_s1 == 2'b01) & (funct6_c_s1 == 6'b100011);
assign funct6_c_s2_23_opcode_2_c1 = (opcode_c_s2 == 2'b01) & (funct6_c_s2 == 6'b100011);
assign opcode_i_s2_eq13_c1 = opcode_i_s2_eq13;
assign opcode_i_s2_eq33_c1 = opcode_i_s2_eq33; 
assign opcode_i_s2_eq63_c1 = opcode_i_s2_eq63;
assign instr_s2_c1 = instr_s2;
assign instr_i_lui_s2_c1 = instr_i_lui_s2_c1_next;
assign instr_i_auipc_s2_c1 = instr_i_auipc_s2_c1_next;
assign instr_i_jal_s2_c1 = instr_i_jal_s2_c1_next;
assign instr_i_jalr_s2_c1 = instr_i_jalr_s2_c1_next;
assign instr_i_beq_s2_c1 = instr_i_beq_s2_c1_next;
assign instr_i_bne_s2_c1 = instr_i_bne_s2_c1_next;
assign instr_i_blt_s2_c1 = instr_i_blt_s2_c1_next;
assign instr_i_bge_s2_c1 = instr_i_bge_s2_c1_next;
assign instr_i_bltu_s2_c1 = instr_i_bltu_s2_c1_next;
assign instr_i_bgeu_s2_c1 = instr_i_bgeu_s2_c1_next;
assign instr_i_addi_s2_c1 = instr_i_addi_s2_c1_next;
assign instr_i_slti_s2_c1 = instr_i_slti_s2_c1_next;
assign instr_i_sltiu_s2_c1 = instr_i_sltiu_s2_c1_next;
assign instr_i_xori_s2_c1 = instr_i_xori_s2_c1_next;
assign instr_i_ori_s2_c1 = instr_i_ori_s2_c1_next;
assign instr_i_andi_s2_c1 = instr_i_andi_s2_c1_next;
assign instr_i_slli_s2_c1 = instr_i_slli_s2_c1_next;
assign instr_i_srli_s2_c1 = instr_i_srli_s2_c1_next;
assign instr_i_srai_s2_c1 = instr_i_srai_s2_c1_next;
assign instr_i_add_s2_c1 = instr_i_add_s2_c1_next;
assign instr_i_sub_s2_c1 = instr_i_sub_s2_c1_next;
assign instr_i_sll_s2_c1 = instr_i_sll_s2_c1_next;
assign instr_i_slt_s2_c1 = instr_i_slt_s2_c1_next;
assign instr_i_sltu_s2_c1 = instr_i_sltu_s2_c1_next;
assign instr_i_xor_s2_c1 = instr_i_xor_s2_c1_next;
assign instr_i_srl_s2_c1 = instr_i_srl_s2_c1_next;
assign instr_i_sra_s2_c1 = instr_i_sra_s2_c1_next;
assign instr_i_or_s2_c1 = instr_i_or_s2_c1_next;
assign instr_i_and_s2_c1 = instr_i_and_s2_c1_next;
assign instr_m_mul_s2_c1 = instr_m_mul_s2_c1_next;
assign instr_m_mulh_s2_c1 = instr_m_mulh_s2_c1_next;
assign instr_m_mulhsu_s2_c1 = instr_m_mulhsu_s2_c1_next;
assign instr_m_mulhu_s2_c1 = instr_m_mulhu_s2_c1_next;
assign instr_m_div_s2_c1 = instr_m_div_s2_c1_next;
assign instr_m_divu_s2_c1 = instr_m_divu_s2_c1_next;
assign instr_m_rem_s2_c1 = instr_m_rem_s2_c1_next;
assign instr_c_j_s2_c1 = instr_c_j_s2_c1_next;
assign instr_c_jal_s2_c1 = instr_c_jal_s2_c1_next;
assign instr_c_jr_s2_c1 = instr_c_jr_s2_c1_next;
assign instr_c_jalr_s2_c1 = instr_c_jalr_s2_c1_next;
assign instr_c_li_s2_c1 = instr_c_li_s2_c1_next;
assign instr_c_lui_s2_c1 = instr_c_lui_s2_c1_next;
assign instr_c_beqz_s2_c1 = instr_c_beqz_s2_c1_next;
assign instr_c_bnez_s2_c1 = instr_c_bnez_s2_c1_next;
assign instr_c_addi_s2_c1 = instr_c_addi_s2_c1_next;
assign instr_c_addi16sp_s2_c1 = instr_c_addi16sp_s2_c1_next;
assign instr_c_addi4spn_s2_c1 = instr_c_addi4spn_s2_c1_next;
assign instr_c_slli_s2_c1 = instr_c_slli_s2_c1_next;
assign instr_c_srli_s2_c1 = instr_c_srli_s2_c1_next;
assign instr_c_srai_s2_c1 = instr_c_srai_s2_c1_next;
assign instr_c_andi_s2_c1 = instr_c_andi_s2_c1_next;
assign instr_c_mv_s2_c1 = instr_c_mv_s2_c1_next;
assign instr_c_add_s2_c1 = instr_c_add_s2_c1_next;
assign instr_c_and_s2_c1 = instr_c_and_s2_c1_next;
assign instr_c_or_s2_c1 = instr_c_or_s2_c1_next;
assign instr_c_xor_s2_c1 = instr_c_xor_s2_c1_next;
assign instr_c_sub_s2_c1 = instr_c_sub_s2_c1_next;
assign rs2_c_s2_eq0_c1 = rs2_c_s2_eq0;
assign rs2_c_s1_eq0_c1 = rs2_c_s1_eq0;
assign instr_s1_11_7_eq_02_c1 = instr_s1_11_7_eq_02;
assign instr_s2_11_7_eq_02_c1 = instr_s2_11_7_eq_02;
assign rs2_def_sel_s1_c1 = rs2_def_sel_s1;

wire [31:0] instr_s1_c2;
wire instr_i_load_s1_c2;
wire instr_i_store_s1_c2;
wire instr_i_slli_s1_c2;
wire instr_i_srli_s1_c2;
wire instr_i_srai_s1_c2;
wire instr_i_sll_s1_c2;
wire instr_i_srl_s1_c2;
wire instr_i_sra_s1_c2;
wire instr_m_mul_s1_c2;
wire instr_m_mulh_s1_c2;
wire instr_m_mulhsu_s1_c2;
wire instr_m_div_s1_c2;
wire instr_m_rem_s1_c2;
wire instr_c_lwsp_s1_c2;
wire instr_c_swsp_s1_c2;
wire instr_c_lw_s1_c2;
wire instr_c_sw_s1_c2;
wire instr_c_slli_s1_c2;
wire instr_c_srli_s1_c2;
wire instr_c_srai_s1_c2;
wire [31:0] instr_s2_c2;
wire instr_i_jal_s2_c2;
wire instr_i_jalr_s2_c2;
wire instr_i_beq_s2_c2;
wire instr_i_bne_s2_c2;
wire instr_i_blt_s2_c2;
wire instr_i_bge_s2_c2;
wire instr_i_bltu_s2_c2;
wire instr_i_bgeu_s2_c2;
wire instr_i_slli_s2_c2;
wire instr_i_srli_s2_c2;
wire instr_i_srai_s2_c2;
wire instr_i_sll_s2_c2;
wire instr_i_srl_s2_c2;
wire instr_i_sra_s2_c2;
wire instr_m_mul_s2_c2;
wire instr_m_mulh_s2_c2;
wire instr_m_mulhsu_s2_c2;
wire instr_m_div_s2_c2;
wire instr_m_divu_s2_c2;
wire instr_m_rem_s2_c2;
wire instr_c_j_s2_c2;
wire instr_c_jal_s2_c2;
wire instr_c_beqz_s2_c2;
wire instr_c_bnez_s2_c2;
wire instr_c_slli_s2_c2;
wire instr_c_srli_s2_c2;
wire instr_c_srai_s2_c2;
wire [4:0] rs1_s1_c2;
wire [4:0] rs2_s1_c2;
wire [31:0] glue_out_c2;
wire rs1_valid_s1_c2;
wire rs2_valid_s1_c2;
wire [31:0] dp_rs1_s2_c2;
wire [31:0] dp_rs2_s2_c2;
wire [31:0] pc_s2_c2;
wire instr_i_load_s2_c2;
wire instr_c_lw_s2_c2;
wire instr_c_lwsp_s2_c2;
wire instr_store_valid_c2;
wire [1:0] pvalid_c2;
wire instr_m_s1_c2;
wire [5:0] state_s2_c2;
wire state_eq0_s2_c2;
wire state_eq1_s2_c2;
wire state_eq32_s2_c2;
wire instr_m_divrem_s2_c2;
wire instr_m_mulx_s2_c2;
wire rd_valid_s2_c2;
wire [4:0] rd_s2_c2;
wire rf1_addrb_s1_zero_c2;
wire rf2_addrb_s1_zero_c2;
wire [31:0] dp_comb_s2_c2;
wire dp_wr_s2_a_c2;
wire [31:0] pc_clear_s2_c2;
wire [32:0] dp_add_a_s2_c2;
wire [32:0] dp_add_b_s2_c2;
wire [4:0] dp_shmul_32a_in_s2_c2;
wire [4:0] dp_shmul_a_s2_c2;
wire noshift_s2_c2; 
wire [31:0] dp_divrem_s2_c2;
wire dp_div_greater_s2_c2;
wire [31:0] dp_div_remainder_s2_c2;
wire branch_s2_c2;
wire jump_s2_c2;
wire [31:0] pc_jump_or_branch_dp_s2_c2;
wire dbus_rd_i_req_c2;
wire instr_m_mulhx_s2_c2;  
wire state_eq3_s2_c2;
wire [1:0] mul_carry_s2_c2;
wire stalled_next_sel1_c2;
wire stalled_next_sel2_c2;
wire dp_slt_s2_lt_0_c2;
wire dp_slt_s2_lt_1_c2;
wire dp_slt_s2_lt_2_c2;
wire dp_slt_s2_lt_3_c2;
wire dp_slt_s2_lt_4_c2;
wire dp_slt_s2_lt_5_c2;
wire dp_slt_s2_lt_6_c2;
wire dp_slt_s2_lt_7_c2;
wire dp_slt_s2_eq_0_c2;
wire dp_slt_s2_eq_1_c2;
wire dp_slt_s2_eq_2_c2;
wire dp_slt_s2_eq_3_c2;
wire dp_slt_s2_eq_4_c2;
wire dp_slt_s2_eq_5_c2;
wire dp_slt_s2_eq_6_c2;
wire dp_slt_s2_eq_7_c2; 
wire [32:0] dp_mul_add_s2_ab_used_c2;
wire [32:0] dp_mul_add_s2_cd_used_c2;
wire [32:0] dp_mul_add_s2_ab_neg_used_c2;
wire [32:0] dp_mul_add_s2_cd_sub_used_c2;
wire [32:0] dp_mul_add_s2_cd_neg_used_c2;
wire dp_slt_sel_s2_c2;
wire dp_slt_inv_s2_c2;
   
assign instr_s1_c2 = instr_s1_c1;
assign instr_i_load_s1_c2 = instr_i_load_s1_c1;
assign instr_i_store_s1_c2 = instr_i_store_s1_c1;
assign instr_i_slli_s1_c2 = instr_i_slli_s1_c1 & opcode_i_s1_13_c1 & funct7_i_s1_eq0;
assign instr_i_srli_s1_c2 = instr_i_srli_s1_c1 & opcode_i_s1_13_c1 & funct7_i_s1_eq0;
assign instr_i_srai_s1_c2 = instr_i_srai_s1_c1 & opcode_i_s1_13_c1 & funct7_i_s1_eq20;
assign instr_i_sll_s1_c2 = instr_i_sll_s1_c1 & opcode_i_s1_33_c1 & funct7_i_s1_eq0;
assign instr_i_srl_s1_c2 = instr_i_srl_s1_c1 & opcode_i_s1_33_c1 & funct7_i_s1_eq0;
assign instr_i_sra_s1_c2 = instr_i_sra_s1_c1 & opcode_i_s1_33_c1 & funct7_i_s1_eq20;
assign instr_m_mul_s1_c2 = instr_m_mul_s1_c1 & opcode_i_s1_33_c1 & funct7_i_s1_eq1;
assign instr_m_mulh_s1_c2 = instr_m_mulh_s1_c1 & opcode_i_s1_33_c1 & funct7_i_s1_eq1;
assign instr_m_mulhsu_s1_c2 = instr_m_mulhsu_s1_c1 & opcode_i_s1_33_c1 & funct7_i_s1_eq1;
assign instr_m_div_s1_c2 = instr_m_div_s1_c1 & opcode_i_s1_33_c1 & funct7_i_s1_eq1;
assign instr_m_rem_s1_c2 = instr_m_rem_s1_c1 & opcode_i_s1_33_c1 & funct7_i_s1_eq1;
assign instr_c_lwsp_s1_c2 = instr_c_lwsp_s1_c1;
assign instr_c_swsp_s1_c2 = instr_c_swsp_s1_c1;
assign instr_c_lw_s1_c2 = instr_c_lw_s1_c1;
assign instr_c_sw_s1_c2 = instr_c_sw_s1_c1;
assign instr_c_slli_s1_c2 = instr_c_slli_s1_c1;
assign instr_c_srli_s1_c2 = instr_c_srli_s1_c1;
assign instr_c_srai_s1_c2 = instr_c_srai_s1_c1;
assign instr_s2_c2 = instr_s2_c1;
assign instr_i_jal_s2_c2 = instr_i_jal_s2_c1;
assign instr_i_jalr_s2_c2 = instr_i_jalr_s2_c1;
assign instr_i_beq_s2_c2 = instr_i_beq_s2_c1 & opcode_i_s2_eq63_c1;
assign instr_i_bne_s2_c2 = instr_i_bne_s2_c1 & opcode_i_s2_eq63_c1;
assign instr_i_blt_s2_c2 = instr_i_blt_s2_c1 & opcode_i_s2_eq63_c1;
assign instr_i_bge_s2_c2 = instr_i_bge_s2_c1 & opcode_i_s2_eq63_c1;
assign instr_i_bltu_s2_c2 = instr_i_bltu_s2_c1 & opcode_i_s2_eq63_c1;
assign instr_i_bgeu_s2_c2 = instr_i_bgeu_s2_c1 & opcode_i_s2_eq63_c1;
assign instr_i_slli_s2_c2 = instr_i_slli_s2_c1 & opcode_i_s2_eq13_c1 & funct7_i_s2_eq0_c1;
assign instr_i_srli_s2_c2 = instr_i_srli_s2_c1 & opcode_i_s2_eq13_c1 & funct7_i_s2_eq0_c1;
assign instr_i_srai_s2_c2 = instr_i_srai_s2_c1 & opcode_i_s2_eq13_c1 & funct7_i_s2_eq20_c1;
assign instr_i_sll_s2_c2 = instr_i_sll_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq0_c1;
assign instr_i_srl_s2_c2 = instr_i_srl_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq0_c1;
assign instr_i_sra_s2_c2 = instr_i_sra_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq20_c1;
assign instr_m_mul_s2_c2 = instr_m_mul_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1;
assign instr_m_mulh_s2_c2 = instr_m_mulh_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1;
assign instr_m_mulhsu_s2_c2 = instr_m_mulhsu_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1;
assign instr_m_div_s2_c2 = instr_m_div_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1;
assign instr_m_divu_s2_c2 = instr_m_divu_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1;
assign instr_m_rem_s2_c2 = instr_m_rem_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1;
assign instr_c_j_s2_c2 = instr_c_j_s2_c1;
assign instr_c_jal_s2_c2 = instr_c_jal_s2_c1;
assign instr_c_beqz_s2_c2 = instr_c_beqz_s2_c1;
assign instr_c_bnez_s2_c2 = instr_c_bnez_s2_c1;
assign instr_c_slli_s2_c2 = instr_c_slli_s2_c1;
assign instr_c_srli_s2_c2 = instr_c_srli_s2_c1;
assign instr_c_srai_s2_c2 = instr_c_srai_s2_c1;
assign rs1_s1_c2 = rs1_s1;
assign rs2_s1_c2 = rs2_s1;
assign glue_out_c2 = glue_out_c1;
assign rs1_valid_s1_c2 = rs1_valid_s1;
assign rs2_valid_s1_c2 = rs2_valid_s1;
assign dp_rs1_s2_c2 = dp_rs1_s2_c1;
assign dp_rs2_s2_c2 = dp_rs2_s2_c1;
assign pc_s2_c2 = pc_s2_c1;
assign instr_i_load_s2_c2 = instr_i_load_s2_c1;
assign instr_c_lw_s2_c2 = instr_c_lw_s2_c1;
assign instr_c_lwsp_s2_c2 = instr_c_lwsp_s2_c1;
//assign instr_store_valid_c2 = (pvalid_c1 == 2) & 
//                           (instr_i_store_s2_c1 | instr_c_sw_s2_c1 | instr_c_swsp_s2_c1) &
//                           thread_pipe_valid/*[2]*/;
assign pvalid_c2 = pvalid_c1;
assign instr_m_s1_c2 = instr_m_s1_c1 & opcode_i_s1_33_c1 & funct7_i_s1_eq1;
assign state_s2_c2 = state_s2_c1;
assign state_eq0_s2_c2 = state_eq0_s2_c1;
assign state_eq1_s2_c2 = state_eq1_s2_c1;
assign state_eq32_s2_c2 = state_eq32_s2_c1;
assign instr_m_divrem_s2_c2 = instr_m_divrem_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1;
assign instr_m_mulx_s2_c2 = instr_m_mulx_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1;
assign rd_valid_s2_c2 = rd_valid_s2;
assign rd_s2_c2 = rd_s2;
assign rf1_addrb_s1_zero_c2 = rf1_addrb_s1_zero;
assign rf2_addrb_s1_zero_c2 = rf2_addrb_s1_zero;
assign dp_comb_s2_c2 = dp_comb_s2;
assign dp_wr_s2_a_c2 = dp_wr_s2_a;
assign pc_clear_s2_c2 = pc_clear_s2_c1;
assign dp_add_a_s2_c2 = dp_add_a_s2;
assign dp_add_b_s2_c2 = dp_add_b_s2;
assign dp_shmul_32a_in_s2_c2 = dp_shmul_32a_in_s2;
assign dp_shmul_a_s2_c2 = dp_shmul_a_s2;
assign noshift_s2_c2 = noshift_s2;
assign dp_divrem_s2_c2 = dp_divrem_s2;
assign dp_div_greater_s2_c2 = dp_div_greater_s2;
assign dp_div_remainder_s2_c2 = dp_div_remainder_s2;
assign branch_s2_c2 = branch_s2;
assign jump_s2_c2 = jump_s2;
assign pc_jump_or_branch_dp_s2_c2 = pc_jump_or_branch_dp_s2;
assign dbus_rd_i_req_c2 = dbus_rd_i_req;
assign instr_m_mulhx_s2_c2 = instr_m_mulhx_s2_c1 & opcode_i_s2_eq33_c1 & funct7_i_s2_eq1_c1;
assign state_eq3_s2_c2 = state_eq3_s2;
assign mul_carry_s2_c2 = mul_carry_s2_c1;
assign stalled_next_sel1_c2 = stalled_next_sel1;
assign stalled_next_sel2_c2 = stalled_next_sel2;
assign dp_slt_s2_lt_0_c2 = dp_slt_s2_lt_0;
assign dp_slt_s2_lt_1_c2 = dp_slt_s2_lt_1;
assign dp_slt_s2_lt_2_c2 = dp_slt_s2_lt_2;
assign dp_slt_s2_lt_3_c2 = dp_slt_s2_lt_3;
assign dp_slt_s2_lt_4_c2 = dp_slt_s2_lt_4;
assign dp_slt_s2_lt_5_c2 = dp_slt_s2_lt_5;
assign dp_slt_s2_lt_6_c2 = dp_slt_s2_lt_6;
assign dp_slt_s2_lt_7_c2 = dp_slt_s2_lt_7;
assign dp_slt_s2_eq_0_c2 = dp_slt_s2_eq_0;
assign dp_slt_s2_eq_1_c2 = dp_slt_s2_eq_1;
assign dp_slt_s2_eq_2_c2 = dp_slt_s2_eq_2;
assign dp_slt_s2_eq_3_c2 = dp_slt_s2_eq_3;
assign dp_slt_s2_eq_4_c2 = dp_slt_s2_eq_4;
assign dp_slt_s2_eq_5_c2 = dp_slt_s2_eq_5;
assign dp_slt_s2_eq_6_c2 = dp_slt_s2_eq_6;
assign dp_slt_s2_eq_7_c2 = dp_slt_s2_eq_7;
assign dp_mul_add_s2_ab_used_c2 = dp_mul_add_s2_ab_used;
assign dp_mul_add_s2_cd_used_c2 = dp_mul_add_s2_cd_used;
assign dp_mul_add_s2_ab_neg_used_c2 = dp_mul_add_s2_ab_neg_used;
assign dp_mul_add_s2_cd_sub_used_c2 = dp_mul_add_s2_cd_sub_used;
assign dp_mul_add_s2_cd_neg_used_c2 = dp_mul_add_s2_cd_neg_used;
assign dp_slt_sel_s2_c2 = dp_slt_sel_s2;
assign dp_slt_inv_s2_c2 = dp_slt_inv_s2;

wire [31:0] instr_s1_c3;
wire instr_i_load_s1_c3;
wire instr_i_store_s1_c3;
wire instr_i_sra_s1_c3;
wire instr_m_mul_s1_c3;
wire instr_m_mulh_s1_c3;
wire instr_m_mulhsu_s1_c3;
wire instr_m_div_s1_c3;
wire instr_m_rem_s1_c3;
wire instr_c_lwsp_s1_c3;
wire instr_c_swsp_s1_c3;
wire instr_c_lw_s1_c3;
wire instr_c_sw_s1_c3;
wire [31:0] instr_s2_c3;
wire instr_i_jalr_s2_c3;
wire instr_m_mul_s2_c3;
wire instr_m_div_s2_c3;
wire instr_m_rem_s2_c3;
wire [31:0] dp_rs1_s2_c3;
wire [31:0] dp_rs2_s2_c3;
wire [31:0] glue_out_c3;
wire [31:0] pc_s2_c3; 
wire [31:0] instr_c3;
wire [31:0] pc_step_s2_c3;
wire instr_i_load_s2_c3;
wire instr_c_lw_s2_c3;
wire instr_c_lwsp_s2_c3;
wire [1:0] pvalid_c3;
wire [5:0] state_s2_c3;
wire state_eq0_s2_c3;
wire state_eq1_s2_c3;
wire state_eq32_s2_c3;
wire instr_m_divrem_s2_c3;
wire instr_m_mulx_s2_c3;
//wire [4:0] rd_s2_c3;
wire stalled_next_c3;
wire [4:0] dp_shmul_a_s1_c3;
wire [31:0] dp_rs1_s1_c3;
wire [31:0] dp_rs2_s1_c3;
wire dp_wr_s2_b_c3;
wire [33:0] dp_add_s2_c3;
wire [31:0] dp_shmul_s2_c3;
wire [31:0] dp_divrem_rfin_s2_c3;
wire branch_s2_c3;
wire jump_s2_c3;
wire [31:0] pc_dp_d_s2_c3;
wire rs1_wth_s1_c3;
wire rs2_wth_s1_c3;
wire state_eq31_s2_c3;
wire dp_rs1_s2_next_sel1_c3;
wire [31:0] dp_rs1_s2_next_div_c3;
wire [31:0] dp_out_s2_early_c3;
wire instr_m_mulhx_s2_c3;
wire state_lt3_s2_c3;
wire state_eq2_s2_c3;
wire [1:0] mul_carry_s2_c3;
wire dp_rs1_s2_next_mul_sel_c3;
wire dp_lw_s2_sel_c3;
wire state_s2_next_sel1_c3;
wire state_s2_next_sel2_c3;
wire dp_rs2_s2_next_mul_sel_c3;
wire dp_rs2_s2_next_sh_sel_c3;
wire dp_rs2_s2_next_def_sel_c3;
wire dp_rs2_s2_next_sel_c3;
wire [31:0] dp_rs2_s2_next_stalled_c3;
wire [31:0] dp_rs2_s2_next_offset_c3;
wire dp_rs1_s2_next_def_sel_c3;
wire dp_rs2_s2_next_div_sel_c3;
wire dp_rs2_s2_next_mul2_sel1_c3;
wire dp_rs2_s2_next_mul2_sel2_c3;
wire dp_rs2_s2_next_rf_dp_load_sel_c3;

assign instr_s1_c3 = instr_s1_c2;
assign instr_i_load_s1_c3 = instr_i_load_s1_c2;
assign instr_i_store_s1_c3 = instr_i_store_s1_c2;
assign instr_i_sra_s1_c3 = instr_i_sra_s1_c2;
assign instr_m_mul_s1_c3 = instr_m_mul_s1_c2;
assign instr_m_mulh_s1_c3 = instr_m_mulh_s1_c2;
assign instr_m_mulhsu_s1_c3 = instr_m_mulhsu_s1_c2;
assign instr_m_div_s1_c3 = instr_m_div_s1_c2;
assign instr_m_rem_s1_c3 = instr_m_rem_s1_c2;
assign instr_c_lwsp_s1_c3 = instr_c_lwsp_s1_c2;
assign instr_c_swsp_s1_c3 = instr_c_swsp_s1_c2;
assign instr_c_lw_s1_c3 = instr_c_lw_s1_c2;
assign instr_c_sw_s1_c3 = instr_c_sw_s1_c2;
assign instr_s2_c3 = instr_s2_c2;
assign instr_i_jalr_s2_c3 = instr_i_jalr_s2_c2;
assign instr_m_mul_s2_c3 = instr_m_mul_s2_c2;
assign instr_m_div_s2_c3 = instr_m_div_s2_c2;
assign instr_m_rem_s2_c3 = instr_m_rem_s2_c2;
assign dp_rs1_s2_c3 = dp_rs1_s2_c2;
assign dp_rs2_s2_c3 = dp_rs2_s2_c2; 
assign glue_out_c3 = glue_out_c2;
assign pc_s2_c3 = pc_s2_c2;
assign instr_c3 = instr;
assign pc_step_s2_c3 = pc_step_s2;
assign instr_i_load_s2_c3 = instr_i_load_s2_c2;
assign instr_c_lw_s2_c3 = instr_c_lw_s2_c2;
assign instr_c_lwsp_s2_c3 = instr_c_lwsp_s2_c2;
assign pvalid_c3 = pvalid_c2;
assign state_s2_c3 = state_s2_c2;
assign state_eq0_s2_c3 = state_eq0_s2_c2;
assign state_eq1_s2_c3 = state_eq1_s2_c2;
assign state_eq32_s2_c3 = state_eq32_s2_c2;
assign instr_m_divrem_s2_c3 = instr_m_divrem_s2_c2;
assign instr_m_mulx_s2_c3 = instr_m_mulx_s2_c2;
//assign rd_s2_c3 = rd_s2_c2;
assign stalled_next_c3 = stalled_next;
assign dp_shmul_a_s1_c3 = dp_shmul_a_s1;
assign dp_rs1_s1_c3 = dp_rs1_s1;
assign dp_rs2_s1_c3 = dp_rs2_s1;
assign dp_wr_s2_b_c3 = dp_wr_s2_b;
assign dp_add_s2_c3 = dp_add_s2;
assign dp_shmul_s2_c3 = dp_shmul_s2;
assign dp_divrem_rfin_s2_c3 = dp_divrem_rfin_s2;
assign branch_s2_c3 = branch_s2_c2;
assign jump_s2_c3 = jump_s2_c2;
assign pc_dp_d_s2_c3 = pc_dp_d_s2;
assign rs1_wth_s1_c3 = rs1_wth_s1;
assign rs2_wth_s1_c3 = rs2_wth_s1;
assign state_eq31_s2_c3 = state_eq31_s2;
assign dp_rs1_s2_next_sel1_c3 = dp_rs1_s2_next_sel1;
assign dp_rs1_s2_next_div_c3 = dp_rs1_s2_next_div;
assign dp_out_s2_early_c3 = dp_out_s2_early;
assign instr_m_mulhx_s2_c3 = instr_m_mulhx_s2_c2;
assign state_lt3_s2_c3 = state_lt3_s2;
assign state_eq2_s2_c3 = state_eq2_s2;
assign mul_carry_s2_c3 = mul_carry_s2_c2;
assign dp_rs1_s2_next_mul_sel_c3 = dp_rs1_s2_next_mul_sel;
assign dp_lw_s2_sel_c3 = dp_lw_s2_sel;
assign state_s2_next_sel1_c3 = state_s2_next_sel1;
assign state_s2_next_sel2_c3 = state_s2_next_sel2;
assign dp_rs2_s2_next_mul_sel_c3 = dp_rs2_s2_next_mul_sel;
assign dp_rs2_s2_next_sh_sel_c3 = dp_rs2_s2_next_sh_sel;
assign dp_rs2_s2_next_def_sel_c3 = dp_rs2_s2_next_def_sel;
assign dp_rs2_s2_next_sel_c3 = dp_rs2_s2_next_sel;
assign dp_rs2_s2_next_stalled_c3 = dp_rs2_s2_next_stalled;
assign dp_rs2_s2_next_offset_c3 = dp_rs2_s2_next_offset;
assign dp_rs1_s2_next_def_sel_c3 = dp_rs1_s2_next_def_sel;
assign dp_rs2_s2_next_div_sel_c3 = dp_rs2_s2_next_div_sel;
assign dp_rs2_s2_next_mul2_sel1_c3 = dp_rs2_s2_next_mul2_sel1;
assign dp_rs2_s2_next_mul2_sel2_c3 = dp_rs2_s2_next_mul2_sel2;
assign dp_rs2_s2_next_rf_dp_load_sel_c3 = dp_rs2_s2_next_rf_dp_load_sel;

endmodule 


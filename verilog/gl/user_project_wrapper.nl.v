// This is the unpowered netlist.
module user_project_wrapper (user_clock2,
    wb_clk_i,
    wb_rst_i,
    wbs_ack_o,
    wbs_cyc_i,
    wbs_stb_i,
    wbs_we_i,
    analog_io,
    io_in,
    io_oeb,
    io_out,
    la_data_in,
    la_data_out,
    la_oenb,
    user_irq,
    wbs_adr_i,
    wbs_dat_i,
    wbs_dat_o,
    wbs_sel_i);
 input user_clock2;
 input wb_clk_i;
 input wb_rst_i;
 output wbs_ack_o;
 input wbs_cyc_i;
 input wbs_stb_i;
 input wbs_we_i;
 inout [28:0] analog_io;
 input [37:0] io_in;
 output [37:0] io_oeb;
 output [37:0] io_out;
 input [127:0] la_data_in;
 output [127:0] la_data_out;
 input [127:0] la_oenb;
 output [2:0] user_irq;
 input [31:0] wbs_adr_i;
 input [31:0] wbs_dat_i;
 output [31:0] wbs_dat_o;
 input [3:0] wbs_sel_i;

 wire \ca_command[0] ;
 wire \ca_command[10] ;
 wire \ca_command[11] ;
 wire \ca_command[12] ;
 wire \ca_command[13] ;
 wire \ca_command[14] ;
 wire \ca_command[15] ;
 wire \ca_command[16] ;
 wire \ca_command[17] ;
 wire \ca_command[18] ;
 wire \ca_command[19] ;
 wire \ca_command[1] ;
 wire \ca_command[20] ;
 wire \ca_command[21] ;
 wire \ca_command[22] ;
 wire \ca_command[23] ;
 wire \ca_command[24] ;
 wire \ca_command[25] ;
 wire \ca_command[26] ;
 wire \ca_command[27] ;
 wire \ca_command[28] ;
 wire \ca_command[29] ;
 wire \ca_command[2] ;
 wire \ca_command[30] ;
 wire \ca_command[31] ;
 wire \ca_command[3] ;
 wire \ca_command[4] ;
 wire \ca_command[5] ;
 wire \ca_command[6] ;
 wire \ca_command[7] ;
 wire \ca_command[8] ;
 wire \ca_command[9] ;
 wire ca_dbus_ack;
 wire ca_dbus_com;
 wire \ca_dbus_data[0] ;
 wire \ca_dbus_data[10] ;
 wire \ca_dbus_data[11] ;
 wire \ca_dbus_data[12] ;
 wire \ca_dbus_data[13] ;
 wire \ca_dbus_data[14] ;
 wire \ca_dbus_data[15] ;
 wire \ca_dbus_data[16] ;
 wire \ca_dbus_data[17] ;
 wire \ca_dbus_data[18] ;
 wire \ca_dbus_data[19] ;
 wire \ca_dbus_data[1] ;
 wire \ca_dbus_data[20] ;
 wire \ca_dbus_data[21] ;
 wire \ca_dbus_data[22] ;
 wire \ca_dbus_data[23] ;
 wire \ca_dbus_data[24] ;
 wire \ca_dbus_data[25] ;
 wire \ca_dbus_data[26] ;
 wire \ca_dbus_data[27] ;
 wire \ca_dbus_data[28] ;
 wire \ca_dbus_data[29] ;
 wire \ca_dbus_data[2] ;
 wire \ca_dbus_data[30] ;
 wire \ca_dbus_data[31] ;
 wire \ca_dbus_data[3] ;
 wire \ca_dbus_data[4] ;
 wire \ca_dbus_data[5] ;
 wire \ca_dbus_data[6] ;
 wire \ca_dbus_data[7] ;
 wire \ca_dbus_data[8] ;
 wire \ca_dbus_data[9] ;
 wire \ca_dbus_tid[0] ;
 wire \ca_dbus_tid[1] ;
 wire \ca_dbus_tid[2] ;
 wire ca_dbus_valid;
 wire ca_match_ack;
 wire ca_match_valid;
 wire ca_time_ack;
 wire \ca_time_data[0] ;
 wire \ca_time_data[10] ;
 wire \ca_time_data[11] ;
 wire \ca_time_data[12] ;
 wire \ca_time_data[13] ;
 wire \ca_time_data[14] ;
 wire \ca_time_data[15] ;
 wire \ca_time_data[16] ;
 wire \ca_time_data[17] ;
 wire \ca_time_data[18] ;
 wire \ca_time_data[19] ;
 wire \ca_time_data[1] ;
 wire \ca_time_data[20] ;
 wire \ca_time_data[21] ;
 wire \ca_time_data[22] ;
 wire \ca_time_data[2] ;
 wire \ca_time_data[3] ;
 wire \ca_time_data[4] ;
 wire \ca_time_data[5] ;
 wire \ca_time_data[6] ;
 wire \ca_time_data[7] ;
 wire \ca_time_data[8] ;
 wire \ca_time_data[9] ;
 wire ca_time_valid;
 wire \cubev_ca_addr0[0] ;
 wire \cubev_ca_addr0[1] ;
 wire \cubev_ca_addr0[2] ;
 wire \cubev_ca_addr0[3] ;
 wire \cubev_ca_addr0[4] ;
 wire \cubev_ca_addr0[5] ;
 wire \cubev_ca_addr0[6] ;
 wire \cubev_ca_addr0[7] ;
 wire \cubev_ca_addr1[0] ;
 wire \cubev_ca_addr1[1] ;
 wire \cubev_ca_addr1[2] ;
 wire \cubev_ca_addr1[3] ;
 wire \cubev_ca_addr1[4] ;
 wire \cubev_ca_addr1[5] ;
 wire \cubev_ca_addr1[6] ;
 wire \cubev_ca_addr1[7] ;
 wire cubev_ca_clk0;
 wire cubev_ca_clk1;
 wire cubev_ca_csb0;
 wire cubev_ca_csb1;
 wire \cubev_ca_din0[0] ;
 wire \cubev_ca_din0[10] ;
 wire \cubev_ca_din0[11] ;
 wire \cubev_ca_din0[12] ;
 wire \cubev_ca_din0[13] ;
 wire \cubev_ca_din0[14] ;
 wire \cubev_ca_din0[15] ;
 wire \cubev_ca_din0[16] ;
 wire \cubev_ca_din0[17] ;
 wire \cubev_ca_din0[18] ;
 wire \cubev_ca_din0[19] ;
 wire \cubev_ca_din0[1] ;
 wire \cubev_ca_din0[20] ;
 wire \cubev_ca_din0[21] ;
 wire \cubev_ca_din0[22] ;
 wire \cubev_ca_din0[23] ;
 wire \cubev_ca_din0[24] ;
 wire \cubev_ca_din0[25] ;
 wire \cubev_ca_din0[26] ;
 wire \cubev_ca_din0[27] ;
 wire \cubev_ca_din0[28] ;
 wire \cubev_ca_din0[29] ;
 wire \cubev_ca_din0[2] ;
 wire \cubev_ca_din0[30] ;
 wire \cubev_ca_din0[31] ;
 wire \cubev_ca_din0[3] ;
 wire \cubev_ca_din0[4] ;
 wire \cubev_ca_din0[5] ;
 wire \cubev_ca_din0[6] ;
 wire \cubev_ca_din0[7] ;
 wire \cubev_ca_din0[8] ;
 wire \cubev_ca_din0[9] ;
 wire \cubev_ca_dout0[0] ;
 wire \cubev_ca_dout0[10] ;
 wire \cubev_ca_dout0[11] ;
 wire \cubev_ca_dout0[12] ;
 wire \cubev_ca_dout0[13] ;
 wire \cubev_ca_dout0[14] ;
 wire \cubev_ca_dout0[15] ;
 wire \cubev_ca_dout0[16] ;
 wire \cubev_ca_dout0[17] ;
 wire \cubev_ca_dout0[18] ;
 wire \cubev_ca_dout0[19] ;
 wire \cubev_ca_dout0[1] ;
 wire \cubev_ca_dout0[20] ;
 wire \cubev_ca_dout0[21] ;
 wire \cubev_ca_dout0[22] ;
 wire \cubev_ca_dout0[23] ;
 wire \cubev_ca_dout0[24] ;
 wire \cubev_ca_dout0[25] ;
 wire \cubev_ca_dout0[26] ;
 wire \cubev_ca_dout0[27] ;
 wire \cubev_ca_dout0[28] ;
 wire \cubev_ca_dout0[29] ;
 wire \cubev_ca_dout0[2] ;
 wire \cubev_ca_dout0[30] ;
 wire \cubev_ca_dout0[31] ;
 wire \cubev_ca_dout0[3] ;
 wire \cubev_ca_dout0[4] ;
 wire \cubev_ca_dout0[5] ;
 wire \cubev_ca_dout0[6] ;
 wire \cubev_ca_dout0[7] ;
 wire \cubev_ca_dout0[8] ;
 wire \cubev_ca_dout0[9] ;
 wire \cubev_ca_dout1[0] ;
 wire \cubev_ca_dout1[10] ;
 wire \cubev_ca_dout1[11] ;
 wire \cubev_ca_dout1[12] ;
 wire \cubev_ca_dout1[13] ;
 wire \cubev_ca_dout1[14] ;
 wire \cubev_ca_dout1[15] ;
 wire \cubev_ca_dout1[16] ;
 wire \cubev_ca_dout1[17] ;
 wire \cubev_ca_dout1[18] ;
 wire \cubev_ca_dout1[19] ;
 wire \cubev_ca_dout1[1] ;
 wire \cubev_ca_dout1[20] ;
 wire \cubev_ca_dout1[21] ;
 wire \cubev_ca_dout1[22] ;
 wire \cubev_ca_dout1[23] ;
 wire \cubev_ca_dout1[24] ;
 wire \cubev_ca_dout1[25] ;
 wire \cubev_ca_dout1[26] ;
 wire \cubev_ca_dout1[27] ;
 wire \cubev_ca_dout1[28] ;
 wire \cubev_ca_dout1[29] ;
 wire \cubev_ca_dout1[2] ;
 wire \cubev_ca_dout1[30] ;
 wire \cubev_ca_dout1[31] ;
 wire \cubev_ca_dout1[3] ;
 wire \cubev_ca_dout1[4] ;
 wire \cubev_ca_dout1[5] ;
 wire \cubev_ca_dout1[6] ;
 wire \cubev_ca_dout1[7] ;
 wire \cubev_ca_dout1[8] ;
 wire \cubev_ca_dout1[9] ;
 wire cubev_ca_web0;
 wire \cubev_ca_wmask0[0] ;
 wire \cubev_ca_wmask0[1] ;
 wire \cubev_ca_wmask0[2] ;
 wire \cubev_ca_wmask0[3] ;
 wire \cubev_dhi_addr0[0] ;
 wire \cubev_dhi_addr0[1] ;
 wire \cubev_dhi_addr0[2] ;
 wire \cubev_dhi_addr0[3] ;
 wire \cubev_dhi_addr0[4] ;
 wire \cubev_dhi_addr0[5] ;
 wire \cubev_dhi_addr0[6] ;
 wire \cubev_dhi_addr0[7] ;
 wire \cubev_dhi_addr1[0] ;
 wire \cubev_dhi_addr1[1] ;
 wire \cubev_dhi_addr1[2] ;
 wire \cubev_dhi_addr1[3] ;
 wire \cubev_dhi_addr1[4] ;
 wire \cubev_dhi_addr1[5] ;
 wire \cubev_dhi_addr1[6] ;
 wire \cubev_dhi_addr1[7] ;
 wire cubev_dhi_clk0;
 wire cubev_dhi_clk1;
 wire cubev_dhi_csb0;
 wire cubev_dhi_csb1;
 wire \cubev_dhi_din0[0] ;
 wire \cubev_dhi_din0[10] ;
 wire \cubev_dhi_din0[11] ;
 wire \cubev_dhi_din0[12] ;
 wire \cubev_dhi_din0[13] ;
 wire \cubev_dhi_din0[14] ;
 wire \cubev_dhi_din0[15] ;
 wire \cubev_dhi_din0[16] ;
 wire \cubev_dhi_din0[17] ;
 wire \cubev_dhi_din0[18] ;
 wire \cubev_dhi_din0[19] ;
 wire \cubev_dhi_din0[1] ;
 wire \cubev_dhi_din0[20] ;
 wire \cubev_dhi_din0[21] ;
 wire \cubev_dhi_din0[22] ;
 wire \cubev_dhi_din0[23] ;
 wire \cubev_dhi_din0[24] ;
 wire \cubev_dhi_din0[25] ;
 wire \cubev_dhi_din0[26] ;
 wire \cubev_dhi_din0[27] ;
 wire \cubev_dhi_din0[28] ;
 wire \cubev_dhi_din0[29] ;
 wire \cubev_dhi_din0[2] ;
 wire \cubev_dhi_din0[30] ;
 wire \cubev_dhi_din0[31] ;
 wire \cubev_dhi_din0[3] ;
 wire \cubev_dhi_din0[4] ;
 wire \cubev_dhi_din0[5] ;
 wire \cubev_dhi_din0[6] ;
 wire \cubev_dhi_din0[7] ;
 wire \cubev_dhi_din0[8] ;
 wire \cubev_dhi_din0[9] ;
 wire \cubev_dhi_dout0[0] ;
 wire \cubev_dhi_dout0[10] ;
 wire \cubev_dhi_dout0[11] ;
 wire \cubev_dhi_dout0[12] ;
 wire \cubev_dhi_dout0[13] ;
 wire \cubev_dhi_dout0[14] ;
 wire \cubev_dhi_dout0[15] ;
 wire \cubev_dhi_dout0[16] ;
 wire \cubev_dhi_dout0[17] ;
 wire \cubev_dhi_dout0[18] ;
 wire \cubev_dhi_dout0[19] ;
 wire \cubev_dhi_dout0[1] ;
 wire \cubev_dhi_dout0[20] ;
 wire \cubev_dhi_dout0[21] ;
 wire \cubev_dhi_dout0[22] ;
 wire \cubev_dhi_dout0[23] ;
 wire \cubev_dhi_dout0[24] ;
 wire \cubev_dhi_dout0[25] ;
 wire \cubev_dhi_dout0[26] ;
 wire \cubev_dhi_dout0[27] ;
 wire \cubev_dhi_dout0[28] ;
 wire \cubev_dhi_dout0[29] ;
 wire \cubev_dhi_dout0[2] ;
 wire \cubev_dhi_dout0[30] ;
 wire \cubev_dhi_dout0[31] ;
 wire \cubev_dhi_dout0[3] ;
 wire \cubev_dhi_dout0[4] ;
 wire \cubev_dhi_dout0[5] ;
 wire \cubev_dhi_dout0[6] ;
 wire \cubev_dhi_dout0[7] ;
 wire \cubev_dhi_dout0[8] ;
 wire \cubev_dhi_dout0[9] ;
 wire \cubev_dhi_dout1[0] ;
 wire \cubev_dhi_dout1[10] ;
 wire \cubev_dhi_dout1[11] ;
 wire \cubev_dhi_dout1[12] ;
 wire \cubev_dhi_dout1[13] ;
 wire \cubev_dhi_dout1[14] ;
 wire \cubev_dhi_dout1[15] ;
 wire \cubev_dhi_dout1[16] ;
 wire \cubev_dhi_dout1[17] ;
 wire \cubev_dhi_dout1[18] ;
 wire \cubev_dhi_dout1[19] ;
 wire \cubev_dhi_dout1[1] ;
 wire \cubev_dhi_dout1[20] ;
 wire \cubev_dhi_dout1[21] ;
 wire \cubev_dhi_dout1[22] ;
 wire \cubev_dhi_dout1[23] ;
 wire \cubev_dhi_dout1[24] ;
 wire \cubev_dhi_dout1[25] ;
 wire \cubev_dhi_dout1[26] ;
 wire \cubev_dhi_dout1[27] ;
 wire \cubev_dhi_dout1[28] ;
 wire \cubev_dhi_dout1[29] ;
 wire \cubev_dhi_dout1[2] ;
 wire \cubev_dhi_dout1[30] ;
 wire \cubev_dhi_dout1[31] ;
 wire \cubev_dhi_dout1[3] ;
 wire \cubev_dhi_dout1[4] ;
 wire \cubev_dhi_dout1[5] ;
 wire \cubev_dhi_dout1[6] ;
 wire \cubev_dhi_dout1[7] ;
 wire \cubev_dhi_dout1[8] ;
 wire \cubev_dhi_dout1[9] ;
 wire \cubev_dhi_dout1_reg[0] ;
 wire \cubev_dhi_dout1_reg[10] ;
 wire \cubev_dhi_dout1_reg[11] ;
 wire \cubev_dhi_dout1_reg[12] ;
 wire \cubev_dhi_dout1_reg[13] ;
 wire \cubev_dhi_dout1_reg[14] ;
 wire \cubev_dhi_dout1_reg[15] ;
 wire \cubev_dhi_dout1_reg[16] ;
 wire \cubev_dhi_dout1_reg[17] ;
 wire \cubev_dhi_dout1_reg[18] ;
 wire \cubev_dhi_dout1_reg[19] ;
 wire \cubev_dhi_dout1_reg[1] ;
 wire \cubev_dhi_dout1_reg[20] ;
 wire \cubev_dhi_dout1_reg[21] ;
 wire \cubev_dhi_dout1_reg[22] ;
 wire \cubev_dhi_dout1_reg[23] ;
 wire \cubev_dhi_dout1_reg[24] ;
 wire \cubev_dhi_dout1_reg[25] ;
 wire \cubev_dhi_dout1_reg[26] ;
 wire \cubev_dhi_dout1_reg[27] ;
 wire \cubev_dhi_dout1_reg[28] ;
 wire \cubev_dhi_dout1_reg[29] ;
 wire \cubev_dhi_dout1_reg[2] ;
 wire \cubev_dhi_dout1_reg[30] ;
 wire \cubev_dhi_dout1_reg[31] ;
 wire \cubev_dhi_dout1_reg[3] ;
 wire \cubev_dhi_dout1_reg[4] ;
 wire \cubev_dhi_dout1_reg[5] ;
 wire \cubev_dhi_dout1_reg[6] ;
 wire \cubev_dhi_dout1_reg[7] ;
 wire \cubev_dhi_dout1_reg[8] ;
 wire \cubev_dhi_dout1_reg[9] ;
 wire cubev_dhi_rstn;
 wire cubev_dhi_web0;
 wire \cubev_dhi_wmask0[0] ;
 wire \cubev_dhi_wmask0[1] ;
 wire \cubev_dhi_wmask0[2] ;
 wire \cubev_dhi_wmask0[3] ;
 wire \cubev_dli_addr0[0] ;
 wire \cubev_dli_addr0[1] ;
 wire \cubev_dli_addr0[2] ;
 wire \cubev_dli_addr0[3] ;
 wire \cubev_dli_addr0[4] ;
 wire \cubev_dli_addr0[5] ;
 wire \cubev_dli_addr0[6] ;
 wire \cubev_dli_addr0[7] ;
 wire \cubev_dli_addr1[0] ;
 wire \cubev_dli_addr1[1] ;
 wire \cubev_dli_addr1[2] ;
 wire \cubev_dli_addr1[3] ;
 wire \cubev_dli_addr1[4] ;
 wire \cubev_dli_addr1[5] ;
 wire \cubev_dli_addr1[6] ;
 wire \cubev_dli_addr1[7] ;
 wire cubev_dli_clk0;
 wire cubev_dli_clk1;
 wire cubev_dli_csb0;
 wire cubev_dli_csb1;
 wire \cubev_dli_din0[0] ;
 wire \cubev_dli_din0[10] ;
 wire \cubev_dli_din0[11] ;
 wire \cubev_dli_din0[12] ;
 wire \cubev_dli_din0[13] ;
 wire \cubev_dli_din0[14] ;
 wire \cubev_dli_din0[15] ;
 wire \cubev_dli_din0[16] ;
 wire \cubev_dli_din0[17] ;
 wire \cubev_dli_din0[18] ;
 wire \cubev_dli_din0[19] ;
 wire \cubev_dli_din0[1] ;
 wire \cubev_dli_din0[20] ;
 wire \cubev_dli_din0[21] ;
 wire \cubev_dli_din0[22] ;
 wire \cubev_dli_din0[23] ;
 wire \cubev_dli_din0[24] ;
 wire \cubev_dli_din0[25] ;
 wire \cubev_dli_din0[26] ;
 wire \cubev_dli_din0[27] ;
 wire \cubev_dli_din0[28] ;
 wire \cubev_dli_din0[29] ;
 wire \cubev_dli_din0[2] ;
 wire \cubev_dli_din0[30] ;
 wire \cubev_dli_din0[31] ;
 wire \cubev_dli_din0[3] ;
 wire \cubev_dli_din0[4] ;
 wire \cubev_dli_din0[5] ;
 wire \cubev_dli_din0[6] ;
 wire \cubev_dli_din0[7] ;
 wire \cubev_dli_din0[8] ;
 wire \cubev_dli_din0[9] ;
 wire \cubev_dli_dout0[0] ;
 wire \cubev_dli_dout0[10] ;
 wire \cubev_dli_dout0[11] ;
 wire \cubev_dli_dout0[12] ;
 wire \cubev_dli_dout0[13] ;
 wire \cubev_dli_dout0[14] ;
 wire \cubev_dli_dout0[15] ;
 wire \cubev_dli_dout0[16] ;
 wire \cubev_dli_dout0[17] ;
 wire \cubev_dli_dout0[18] ;
 wire \cubev_dli_dout0[19] ;
 wire \cubev_dli_dout0[1] ;
 wire \cubev_dli_dout0[20] ;
 wire \cubev_dli_dout0[21] ;
 wire \cubev_dli_dout0[22] ;
 wire \cubev_dli_dout0[23] ;
 wire \cubev_dli_dout0[24] ;
 wire \cubev_dli_dout0[25] ;
 wire \cubev_dli_dout0[26] ;
 wire \cubev_dli_dout0[27] ;
 wire \cubev_dli_dout0[28] ;
 wire \cubev_dli_dout0[29] ;
 wire \cubev_dli_dout0[2] ;
 wire \cubev_dli_dout0[30] ;
 wire \cubev_dli_dout0[31] ;
 wire \cubev_dli_dout0[3] ;
 wire \cubev_dli_dout0[4] ;
 wire \cubev_dli_dout0[5] ;
 wire \cubev_dli_dout0[6] ;
 wire \cubev_dli_dout0[7] ;
 wire \cubev_dli_dout0[8] ;
 wire \cubev_dli_dout0[9] ;
 wire \cubev_dli_dout1[0] ;
 wire \cubev_dli_dout1[10] ;
 wire \cubev_dli_dout1[11] ;
 wire \cubev_dli_dout1[12] ;
 wire \cubev_dli_dout1[13] ;
 wire \cubev_dli_dout1[14] ;
 wire \cubev_dli_dout1[15] ;
 wire \cubev_dli_dout1[16] ;
 wire \cubev_dli_dout1[17] ;
 wire \cubev_dli_dout1[18] ;
 wire \cubev_dli_dout1[19] ;
 wire \cubev_dli_dout1[1] ;
 wire \cubev_dli_dout1[20] ;
 wire \cubev_dli_dout1[21] ;
 wire \cubev_dli_dout1[22] ;
 wire \cubev_dli_dout1[23] ;
 wire \cubev_dli_dout1[24] ;
 wire \cubev_dli_dout1[25] ;
 wire \cubev_dli_dout1[26] ;
 wire \cubev_dli_dout1[27] ;
 wire \cubev_dli_dout1[28] ;
 wire \cubev_dli_dout1[29] ;
 wire \cubev_dli_dout1[2] ;
 wire \cubev_dli_dout1[30] ;
 wire \cubev_dli_dout1[31] ;
 wire \cubev_dli_dout1[3] ;
 wire \cubev_dli_dout1[4] ;
 wire \cubev_dli_dout1[5] ;
 wire \cubev_dli_dout1[6] ;
 wire \cubev_dli_dout1[7] ;
 wire \cubev_dli_dout1[8] ;
 wire \cubev_dli_dout1[9] ;
 wire \cubev_dli_dout1_reg[0] ;
 wire \cubev_dli_dout1_reg[10] ;
 wire \cubev_dli_dout1_reg[11] ;
 wire \cubev_dli_dout1_reg[12] ;
 wire \cubev_dli_dout1_reg[13] ;
 wire \cubev_dli_dout1_reg[14] ;
 wire \cubev_dli_dout1_reg[15] ;
 wire \cubev_dli_dout1_reg[16] ;
 wire \cubev_dli_dout1_reg[17] ;
 wire \cubev_dli_dout1_reg[18] ;
 wire \cubev_dli_dout1_reg[19] ;
 wire \cubev_dli_dout1_reg[1] ;
 wire \cubev_dli_dout1_reg[20] ;
 wire \cubev_dli_dout1_reg[21] ;
 wire \cubev_dli_dout1_reg[22] ;
 wire \cubev_dli_dout1_reg[23] ;
 wire \cubev_dli_dout1_reg[24] ;
 wire \cubev_dli_dout1_reg[25] ;
 wire \cubev_dli_dout1_reg[26] ;
 wire \cubev_dli_dout1_reg[27] ;
 wire \cubev_dli_dout1_reg[28] ;
 wire \cubev_dli_dout1_reg[29] ;
 wire \cubev_dli_dout1_reg[2] ;
 wire \cubev_dli_dout1_reg[30] ;
 wire \cubev_dli_dout1_reg[31] ;
 wire \cubev_dli_dout1_reg[3] ;
 wire \cubev_dli_dout1_reg[4] ;
 wire \cubev_dli_dout1_reg[5] ;
 wire \cubev_dli_dout1_reg[6] ;
 wire \cubev_dli_dout1_reg[7] ;
 wire \cubev_dli_dout1_reg[8] ;
 wire \cubev_dli_dout1_reg[9] ;
 wire cubev_dli_rstn;
 wire cubev_dli_web0;
 wire \cubev_dli_wmask0[0] ;
 wire \cubev_dli_wmask0[1] ;
 wire \cubev_dli_wmask0[2] ;
 wire \cubev_dli_wmask0[3] ;
 wire \cubev_phi_addr0[0] ;
 wire \cubev_phi_addr0[1] ;
 wire \cubev_phi_addr0[2] ;
 wire \cubev_phi_addr0[3] ;
 wire \cubev_phi_addr0[4] ;
 wire \cubev_phi_addr0[5] ;
 wire \cubev_phi_addr0[6] ;
 wire \cubev_phi_addr0[7] ;
 wire \cubev_phi_addr1[0] ;
 wire \cubev_phi_addr1[1] ;
 wire \cubev_phi_addr1[2] ;
 wire \cubev_phi_addr1[3] ;
 wire \cubev_phi_addr1[4] ;
 wire \cubev_phi_addr1[5] ;
 wire \cubev_phi_addr1[6] ;
 wire \cubev_phi_addr1[7] ;
 wire cubev_phi_clk0;
 wire cubev_phi_clk1;
 wire cubev_phi_csb0;
 wire cubev_phi_csb1;
 wire \cubev_phi_din0[0] ;
 wire \cubev_phi_din0[10] ;
 wire \cubev_phi_din0[11] ;
 wire \cubev_phi_din0[12] ;
 wire \cubev_phi_din0[13] ;
 wire \cubev_phi_din0[14] ;
 wire \cubev_phi_din0[15] ;
 wire \cubev_phi_din0[16] ;
 wire \cubev_phi_din0[17] ;
 wire \cubev_phi_din0[18] ;
 wire \cubev_phi_din0[19] ;
 wire \cubev_phi_din0[1] ;
 wire \cubev_phi_din0[20] ;
 wire \cubev_phi_din0[21] ;
 wire \cubev_phi_din0[22] ;
 wire \cubev_phi_din0[23] ;
 wire \cubev_phi_din0[24] ;
 wire \cubev_phi_din0[25] ;
 wire \cubev_phi_din0[26] ;
 wire \cubev_phi_din0[27] ;
 wire \cubev_phi_din0[28] ;
 wire \cubev_phi_din0[29] ;
 wire \cubev_phi_din0[2] ;
 wire \cubev_phi_din0[30] ;
 wire \cubev_phi_din0[31] ;
 wire \cubev_phi_din0[3] ;
 wire \cubev_phi_din0[4] ;
 wire \cubev_phi_din0[5] ;
 wire \cubev_phi_din0[6] ;
 wire \cubev_phi_din0[7] ;
 wire \cubev_phi_din0[8] ;
 wire \cubev_phi_din0[9] ;
 wire \cubev_phi_dout0[0] ;
 wire \cubev_phi_dout0[10] ;
 wire \cubev_phi_dout0[11] ;
 wire \cubev_phi_dout0[12] ;
 wire \cubev_phi_dout0[13] ;
 wire \cubev_phi_dout0[14] ;
 wire \cubev_phi_dout0[15] ;
 wire \cubev_phi_dout0[16] ;
 wire \cubev_phi_dout0[17] ;
 wire \cubev_phi_dout0[18] ;
 wire \cubev_phi_dout0[19] ;
 wire \cubev_phi_dout0[1] ;
 wire \cubev_phi_dout0[20] ;
 wire \cubev_phi_dout0[21] ;
 wire \cubev_phi_dout0[22] ;
 wire \cubev_phi_dout0[23] ;
 wire \cubev_phi_dout0[24] ;
 wire \cubev_phi_dout0[25] ;
 wire \cubev_phi_dout0[26] ;
 wire \cubev_phi_dout0[27] ;
 wire \cubev_phi_dout0[28] ;
 wire \cubev_phi_dout0[29] ;
 wire \cubev_phi_dout0[2] ;
 wire \cubev_phi_dout0[30] ;
 wire \cubev_phi_dout0[31] ;
 wire \cubev_phi_dout0[3] ;
 wire \cubev_phi_dout0[4] ;
 wire \cubev_phi_dout0[5] ;
 wire \cubev_phi_dout0[6] ;
 wire \cubev_phi_dout0[7] ;
 wire \cubev_phi_dout0[8] ;
 wire \cubev_phi_dout0[9] ;
 wire \cubev_phi_dout1[0] ;
 wire \cubev_phi_dout1[10] ;
 wire \cubev_phi_dout1[11] ;
 wire \cubev_phi_dout1[12] ;
 wire \cubev_phi_dout1[13] ;
 wire \cubev_phi_dout1[14] ;
 wire \cubev_phi_dout1[15] ;
 wire \cubev_phi_dout1[16] ;
 wire \cubev_phi_dout1[17] ;
 wire \cubev_phi_dout1[18] ;
 wire \cubev_phi_dout1[19] ;
 wire \cubev_phi_dout1[1] ;
 wire \cubev_phi_dout1[20] ;
 wire \cubev_phi_dout1[21] ;
 wire \cubev_phi_dout1[22] ;
 wire \cubev_phi_dout1[23] ;
 wire \cubev_phi_dout1[24] ;
 wire \cubev_phi_dout1[25] ;
 wire \cubev_phi_dout1[26] ;
 wire \cubev_phi_dout1[27] ;
 wire \cubev_phi_dout1[28] ;
 wire \cubev_phi_dout1[29] ;
 wire \cubev_phi_dout1[2] ;
 wire \cubev_phi_dout1[30] ;
 wire \cubev_phi_dout1[31] ;
 wire \cubev_phi_dout1[3] ;
 wire \cubev_phi_dout1[4] ;
 wire \cubev_phi_dout1[5] ;
 wire \cubev_phi_dout1[6] ;
 wire \cubev_phi_dout1[7] ;
 wire \cubev_phi_dout1[8] ;
 wire \cubev_phi_dout1[9] ;
 wire \cubev_phi_dout1_reg[0] ;
 wire \cubev_phi_dout1_reg[10] ;
 wire \cubev_phi_dout1_reg[11] ;
 wire \cubev_phi_dout1_reg[12] ;
 wire \cubev_phi_dout1_reg[13] ;
 wire \cubev_phi_dout1_reg[14] ;
 wire \cubev_phi_dout1_reg[15] ;
 wire \cubev_phi_dout1_reg[16] ;
 wire \cubev_phi_dout1_reg[17] ;
 wire \cubev_phi_dout1_reg[18] ;
 wire \cubev_phi_dout1_reg[19] ;
 wire \cubev_phi_dout1_reg[1] ;
 wire \cubev_phi_dout1_reg[20] ;
 wire \cubev_phi_dout1_reg[21] ;
 wire \cubev_phi_dout1_reg[22] ;
 wire \cubev_phi_dout1_reg[23] ;
 wire \cubev_phi_dout1_reg[24] ;
 wire \cubev_phi_dout1_reg[25] ;
 wire \cubev_phi_dout1_reg[26] ;
 wire \cubev_phi_dout1_reg[27] ;
 wire \cubev_phi_dout1_reg[28] ;
 wire \cubev_phi_dout1_reg[29] ;
 wire \cubev_phi_dout1_reg[2] ;
 wire \cubev_phi_dout1_reg[30] ;
 wire \cubev_phi_dout1_reg[31] ;
 wire \cubev_phi_dout1_reg[3] ;
 wire \cubev_phi_dout1_reg[4] ;
 wire \cubev_phi_dout1_reg[5] ;
 wire \cubev_phi_dout1_reg[6] ;
 wire \cubev_phi_dout1_reg[7] ;
 wire \cubev_phi_dout1_reg[8] ;
 wire \cubev_phi_dout1_reg[9] ;
 wire cubev_phi_rstn;
 wire cubev_phi_web0;
 wire \cubev_phi_wmask0[0] ;
 wire \cubev_phi_wmask0[1] ;
 wire \cubev_phi_wmask0[2] ;
 wire \cubev_phi_wmask0[3] ;
 wire \cubev_pli_addr0[0] ;
 wire \cubev_pli_addr0[1] ;
 wire \cubev_pli_addr0[2] ;
 wire \cubev_pli_addr0[3] ;
 wire \cubev_pli_addr0[4] ;
 wire \cubev_pli_addr0[5] ;
 wire \cubev_pli_addr0[6] ;
 wire \cubev_pli_addr0[7] ;
 wire \cubev_pli_addr1[0] ;
 wire \cubev_pli_addr1[1] ;
 wire \cubev_pli_addr1[2] ;
 wire \cubev_pli_addr1[3] ;
 wire \cubev_pli_addr1[4] ;
 wire \cubev_pli_addr1[5] ;
 wire \cubev_pli_addr1[6] ;
 wire \cubev_pli_addr1[7] ;
 wire cubev_pli_clk0;
 wire cubev_pli_clk1;
 wire cubev_pli_csb0;
 wire cubev_pli_csb1;
 wire \cubev_pli_din0[0] ;
 wire \cubev_pli_din0[10] ;
 wire \cubev_pli_din0[11] ;
 wire \cubev_pli_din0[12] ;
 wire \cubev_pli_din0[13] ;
 wire \cubev_pli_din0[14] ;
 wire \cubev_pli_din0[15] ;
 wire \cubev_pli_din0[16] ;
 wire \cubev_pli_din0[17] ;
 wire \cubev_pli_din0[18] ;
 wire \cubev_pli_din0[19] ;
 wire \cubev_pli_din0[1] ;
 wire \cubev_pli_din0[20] ;
 wire \cubev_pli_din0[21] ;
 wire \cubev_pli_din0[22] ;
 wire \cubev_pli_din0[23] ;
 wire \cubev_pli_din0[24] ;
 wire \cubev_pli_din0[25] ;
 wire \cubev_pli_din0[26] ;
 wire \cubev_pli_din0[27] ;
 wire \cubev_pli_din0[28] ;
 wire \cubev_pli_din0[29] ;
 wire \cubev_pli_din0[2] ;
 wire \cubev_pli_din0[30] ;
 wire \cubev_pli_din0[31] ;
 wire \cubev_pli_din0[3] ;
 wire \cubev_pli_din0[4] ;
 wire \cubev_pli_din0[5] ;
 wire \cubev_pli_din0[6] ;
 wire \cubev_pli_din0[7] ;
 wire \cubev_pli_din0[8] ;
 wire \cubev_pli_din0[9] ;
 wire \cubev_pli_dout0[0] ;
 wire \cubev_pli_dout0[10] ;
 wire \cubev_pli_dout0[11] ;
 wire \cubev_pli_dout0[12] ;
 wire \cubev_pli_dout0[13] ;
 wire \cubev_pli_dout0[14] ;
 wire \cubev_pli_dout0[15] ;
 wire \cubev_pli_dout0[16] ;
 wire \cubev_pli_dout0[17] ;
 wire \cubev_pli_dout0[18] ;
 wire \cubev_pli_dout0[19] ;
 wire \cubev_pli_dout0[1] ;
 wire \cubev_pli_dout0[20] ;
 wire \cubev_pli_dout0[21] ;
 wire \cubev_pli_dout0[22] ;
 wire \cubev_pli_dout0[23] ;
 wire \cubev_pli_dout0[24] ;
 wire \cubev_pli_dout0[25] ;
 wire \cubev_pli_dout0[26] ;
 wire \cubev_pli_dout0[27] ;
 wire \cubev_pli_dout0[28] ;
 wire \cubev_pli_dout0[29] ;
 wire \cubev_pli_dout0[2] ;
 wire \cubev_pli_dout0[30] ;
 wire \cubev_pli_dout0[31] ;
 wire \cubev_pli_dout0[3] ;
 wire \cubev_pli_dout0[4] ;
 wire \cubev_pli_dout0[5] ;
 wire \cubev_pli_dout0[6] ;
 wire \cubev_pli_dout0[7] ;
 wire \cubev_pli_dout0[8] ;
 wire \cubev_pli_dout0[9] ;
 wire \cubev_pli_dout1[0] ;
 wire \cubev_pli_dout1[10] ;
 wire \cubev_pli_dout1[11] ;
 wire \cubev_pli_dout1[12] ;
 wire \cubev_pli_dout1[13] ;
 wire \cubev_pli_dout1[14] ;
 wire \cubev_pli_dout1[15] ;
 wire \cubev_pli_dout1[16] ;
 wire \cubev_pli_dout1[17] ;
 wire \cubev_pli_dout1[18] ;
 wire \cubev_pli_dout1[19] ;
 wire \cubev_pli_dout1[1] ;
 wire \cubev_pli_dout1[20] ;
 wire \cubev_pli_dout1[21] ;
 wire \cubev_pli_dout1[22] ;
 wire \cubev_pli_dout1[23] ;
 wire \cubev_pli_dout1[24] ;
 wire \cubev_pli_dout1[25] ;
 wire \cubev_pli_dout1[26] ;
 wire \cubev_pli_dout1[27] ;
 wire \cubev_pli_dout1[28] ;
 wire \cubev_pli_dout1[29] ;
 wire \cubev_pli_dout1[2] ;
 wire \cubev_pli_dout1[30] ;
 wire \cubev_pli_dout1[31] ;
 wire \cubev_pli_dout1[3] ;
 wire \cubev_pli_dout1[4] ;
 wire \cubev_pli_dout1[5] ;
 wire \cubev_pli_dout1[6] ;
 wire \cubev_pli_dout1[7] ;
 wire \cubev_pli_dout1[8] ;
 wire \cubev_pli_dout1[9] ;
 wire \cubev_pli_dout1_reg[0] ;
 wire \cubev_pli_dout1_reg[10] ;
 wire \cubev_pli_dout1_reg[11] ;
 wire \cubev_pli_dout1_reg[12] ;
 wire \cubev_pli_dout1_reg[13] ;
 wire \cubev_pli_dout1_reg[14] ;
 wire \cubev_pli_dout1_reg[15] ;
 wire \cubev_pli_dout1_reg[16] ;
 wire \cubev_pli_dout1_reg[17] ;
 wire \cubev_pli_dout1_reg[18] ;
 wire \cubev_pli_dout1_reg[19] ;
 wire \cubev_pli_dout1_reg[1] ;
 wire \cubev_pli_dout1_reg[20] ;
 wire \cubev_pli_dout1_reg[21] ;
 wire \cubev_pli_dout1_reg[22] ;
 wire \cubev_pli_dout1_reg[23] ;
 wire \cubev_pli_dout1_reg[24] ;
 wire \cubev_pli_dout1_reg[25] ;
 wire \cubev_pli_dout1_reg[26] ;
 wire \cubev_pli_dout1_reg[27] ;
 wire \cubev_pli_dout1_reg[28] ;
 wire \cubev_pli_dout1_reg[29] ;
 wire \cubev_pli_dout1_reg[2] ;
 wire \cubev_pli_dout1_reg[30] ;
 wire \cubev_pli_dout1_reg[31] ;
 wire \cubev_pli_dout1_reg[3] ;
 wire \cubev_pli_dout1_reg[4] ;
 wire \cubev_pli_dout1_reg[5] ;
 wire \cubev_pli_dout1_reg[6] ;
 wire \cubev_pli_dout1_reg[7] ;
 wire \cubev_pli_dout1_reg[8] ;
 wire \cubev_pli_dout1_reg[9] ;
 wire cubev_pli_rstn;
 wire cubev_pli_web0;
 wire \cubev_pli_wmask0[0] ;
 wire \cubev_pli_wmask0[1] ;
 wire \cubev_pli_wmask0[2] ;
 wire \cubev_pli_wmask0[3] ;
 wire \cubev_reg_0_addr0[0] ;
 wire \cubev_reg_0_addr0[1] ;
 wire \cubev_reg_0_addr0[2] ;
 wire \cubev_reg_0_addr0[3] ;
 wire \cubev_reg_0_addr0[4] ;
 wire \cubev_reg_0_addr0[5] ;
 wire \cubev_reg_0_addr0[6] ;
 wire \cubev_reg_0_addr0[7] ;
 wire \cubev_reg_0_addr1[0] ;
 wire \cubev_reg_0_addr1[1] ;
 wire \cubev_reg_0_addr1[2] ;
 wire \cubev_reg_0_addr1[3] ;
 wire \cubev_reg_0_addr1[4] ;
 wire \cubev_reg_0_addr1[5] ;
 wire \cubev_reg_0_addr1[6] ;
 wire \cubev_reg_0_addr1[7] ;
 wire cubev_reg_0_clk0;
 wire cubev_reg_0_clk1;
 wire cubev_reg_0_csb0;
 wire cubev_reg_0_csb1;
 wire \cubev_reg_0_din0[0] ;
 wire \cubev_reg_0_din0[10] ;
 wire \cubev_reg_0_din0[11] ;
 wire \cubev_reg_0_din0[12] ;
 wire \cubev_reg_0_din0[13] ;
 wire \cubev_reg_0_din0[14] ;
 wire \cubev_reg_0_din0[15] ;
 wire \cubev_reg_0_din0[16] ;
 wire \cubev_reg_0_din0[17] ;
 wire \cubev_reg_0_din0[18] ;
 wire \cubev_reg_0_din0[19] ;
 wire \cubev_reg_0_din0[1] ;
 wire \cubev_reg_0_din0[20] ;
 wire \cubev_reg_0_din0[21] ;
 wire \cubev_reg_0_din0[22] ;
 wire \cubev_reg_0_din0[23] ;
 wire \cubev_reg_0_din0[24] ;
 wire \cubev_reg_0_din0[25] ;
 wire \cubev_reg_0_din0[26] ;
 wire \cubev_reg_0_din0[27] ;
 wire \cubev_reg_0_din0[28] ;
 wire \cubev_reg_0_din0[29] ;
 wire \cubev_reg_0_din0[2] ;
 wire \cubev_reg_0_din0[30] ;
 wire \cubev_reg_0_din0[31] ;
 wire \cubev_reg_0_din0[3] ;
 wire \cubev_reg_0_din0[4] ;
 wire \cubev_reg_0_din0[5] ;
 wire \cubev_reg_0_din0[6] ;
 wire \cubev_reg_0_din0[7] ;
 wire \cubev_reg_0_din0[8] ;
 wire \cubev_reg_0_din0[9] ;
 wire \cubev_reg_0_dout0[0] ;
 wire \cubev_reg_0_dout0[10] ;
 wire \cubev_reg_0_dout0[11] ;
 wire \cubev_reg_0_dout0[12] ;
 wire \cubev_reg_0_dout0[13] ;
 wire \cubev_reg_0_dout0[14] ;
 wire \cubev_reg_0_dout0[15] ;
 wire \cubev_reg_0_dout0[16] ;
 wire \cubev_reg_0_dout0[17] ;
 wire \cubev_reg_0_dout0[18] ;
 wire \cubev_reg_0_dout0[19] ;
 wire \cubev_reg_0_dout0[1] ;
 wire \cubev_reg_0_dout0[20] ;
 wire \cubev_reg_0_dout0[21] ;
 wire \cubev_reg_0_dout0[22] ;
 wire \cubev_reg_0_dout0[23] ;
 wire \cubev_reg_0_dout0[24] ;
 wire \cubev_reg_0_dout0[25] ;
 wire \cubev_reg_0_dout0[26] ;
 wire \cubev_reg_0_dout0[27] ;
 wire \cubev_reg_0_dout0[28] ;
 wire \cubev_reg_0_dout0[29] ;
 wire \cubev_reg_0_dout0[2] ;
 wire \cubev_reg_0_dout0[30] ;
 wire \cubev_reg_0_dout0[31] ;
 wire \cubev_reg_0_dout0[3] ;
 wire \cubev_reg_0_dout0[4] ;
 wire \cubev_reg_0_dout0[5] ;
 wire \cubev_reg_0_dout0[6] ;
 wire \cubev_reg_0_dout0[7] ;
 wire \cubev_reg_0_dout0[8] ;
 wire \cubev_reg_0_dout0[9] ;
 wire \cubev_reg_0_dout1[0] ;
 wire \cubev_reg_0_dout1[10] ;
 wire \cubev_reg_0_dout1[11] ;
 wire \cubev_reg_0_dout1[12] ;
 wire \cubev_reg_0_dout1[13] ;
 wire \cubev_reg_0_dout1[14] ;
 wire \cubev_reg_0_dout1[15] ;
 wire \cubev_reg_0_dout1[16] ;
 wire \cubev_reg_0_dout1[17] ;
 wire \cubev_reg_0_dout1[18] ;
 wire \cubev_reg_0_dout1[19] ;
 wire \cubev_reg_0_dout1[1] ;
 wire \cubev_reg_0_dout1[20] ;
 wire \cubev_reg_0_dout1[21] ;
 wire \cubev_reg_0_dout1[22] ;
 wire \cubev_reg_0_dout1[23] ;
 wire \cubev_reg_0_dout1[24] ;
 wire \cubev_reg_0_dout1[25] ;
 wire \cubev_reg_0_dout1[26] ;
 wire \cubev_reg_0_dout1[27] ;
 wire \cubev_reg_0_dout1[28] ;
 wire \cubev_reg_0_dout1[29] ;
 wire \cubev_reg_0_dout1[2] ;
 wire \cubev_reg_0_dout1[30] ;
 wire \cubev_reg_0_dout1[31] ;
 wire \cubev_reg_0_dout1[3] ;
 wire \cubev_reg_0_dout1[4] ;
 wire \cubev_reg_0_dout1[5] ;
 wire \cubev_reg_0_dout1[6] ;
 wire \cubev_reg_0_dout1[7] ;
 wire \cubev_reg_0_dout1[8] ;
 wire \cubev_reg_0_dout1[9] ;
 wire \cubev_reg_0_dout1_reg[0] ;
 wire \cubev_reg_0_dout1_reg[10] ;
 wire \cubev_reg_0_dout1_reg[11] ;
 wire \cubev_reg_0_dout1_reg[12] ;
 wire \cubev_reg_0_dout1_reg[13] ;
 wire \cubev_reg_0_dout1_reg[14] ;
 wire \cubev_reg_0_dout1_reg[15] ;
 wire \cubev_reg_0_dout1_reg[16] ;
 wire \cubev_reg_0_dout1_reg[17] ;
 wire \cubev_reg_0_dout1_reg[18] ;
 wire \cubev_reg_0_dout1_reg[19] ;
 wire \cubev_reg_0_dout1_reg[1] ;
 wire \cubev_reg_0_dout1_reg[20] ;
 wire \cubev_reg_0_dout1_reg[21] ;
 wire \cubev_reg_0_dout1_reg[22] ;
 wire \cubev_reg_0_dout1_reg[23] ;
 wire \cubev_reg_0_dout1_reg[24] ;
 wire \cubev_reg_0_dout1_reg[25] ;
 wire \cubev_reg_0_dout1_reg[26] ;
 wire \cubev_reg_0_dout1_reg[27] ;
 wire \cubev_reg_0_dout1_reg[28] ;
 wire \cubev_reg_0_dout1_reg[29] ;
 wire \cubev_reg_0_dout1_reg[2] ;
 wire \cubev_reg_0_dout1_reg[30] ;
 wire \cubev_reg_0_dout1_reg[31] ;
 wire \cubev_reg_0_dout1_reg[3] ;
 wire \cubev_reg_0_dout1_reg[4] ;
 wire \cubev_reg_0_dout1_reg[5] ;
 wire \cubev_reg_0_dout1_reg[6] ;
 wire \cubev_reg_0_dout1_reg[7] ;
 wire \cubev_reg_0_dout1_reg[8] ;
 wire \cubev_reg_0_dout1_reg[9] ;
 wire cubev_reg_0_rstn;
 wire cubev_reg_0_web0;
 wire \cubev_reg_0_wmask0[0] ;
 wire \cubev_reg_0_wmask0[1] ;
 wire \cubev_reg_0_wmask0[2] ;
 wire \cubev_reg_0_wmask0[3] ;
 wire \cubev_reg_1_addr0[0] ;
 wire \cubev_reg_1_addr0[1] ;
 wire \cubev_reg_1_addr0[2] ;
 wire \cubev_reg_1_addr0[3] ;
 wire \cubev_reg_1_addr0[4] ;
 wire \cubev_reg_1_addr0[5] ;
 wire \cubev_reg_1_addr0[6] ;
 wire \cubev_reg_1_addr0[7] ;
 wire \cubev_reg_1_addr1[0] ;
 wire \cubev_reg_1_addr1[1] ;
 wire \cubev_reg_1_addr1[2] ;
 wire \cubev_reg_1_addr1[3] ;
 wire \cubev_reg_1_addr1[4] ;
 wire \cubev_reg_1_addr1[5] ;
 wire \cubev_reg_1_addr1[6] ;
 wire \cubev_reg_1_addr1[7] ;
 wire cubev_reg_1_clk0;
 wire cubev_reg_1_clk1;
 wire cubev_reg_1_csb0;
 wire cubev_reg_1_csb1;
 wire \cubev_reg_1_din0[0] ;
 wire \cubev_reg_1_din0[10] ;
 wire \cubev_reg_1_din0[11] ;
 wire \cubev_reg_1_din0[12] ;
 wire \cubev_reg_1_din0[13] ;
 wire \cubev_reg_1_din0[14] ;
 wire \cubev_reg_1_din0[15] ;
 wire \cubev_reg_1_din0[16] ;
 wire \cubev_reg_1_din0[17] ;
 wire \cubev_reg_1_din0[18] ;
 wire \cubev_reg_1_din0[19] ;
 wire \cubev_reg_1_din0[1] ;
 wire \cubev_reg_1_din0[20] ;
 wire \cubev_reg_1_din0[21] ;
 wire \cubev_reg_1_din0[22] ;
 wire \cubev_reg_1_din0[23] ;
 wire \cubev_reg_1_din0[24] ;
 wire \cubev_reg_1_din0[25] ;
 wire \cubev_reg_1_din0[26] ;
 wire \cubev_reg_1_din0[27] ;
 wire \cubev_reg_1_din0[28] ;
 wire \cubev_reg_1_din0[29] ;
 wire \cubev_reg_1_din0[2] ;
 wire \cubev_reg_1_din0[30] ;
 wire \cubev_reg_1_din0[31] ;
 wire \cubev_reg_1_din0[3] ;
 wire \cubev_reg_1_din0[4] ;
 wire \cubev_reg_1_din0[5] ;
 wire \cubev_reg_1_din0[6] ;
 wire \cubev_reg_1_din0[7] ;
 wire \cubev_reg_1_din0[8] ;
 wire \cubev_reg_1_din0[9] ;
 wire \cubev_reg_1_dout0[0] ;
 wire \cubev_reg_1_dout0[10] ;
 wire \cubev_reg_1_dout0[11] ;
 wire \cubev_reg_1_dout0[12] ;
 wire \cubev_reg_1_dout0[13] ;
 wire \cubev_reg_1_dout0[14] ;
 wire \cubev_reg_1_dout0[15] ;
 wire \cubev_reg_1_dout0[16] ;
 wire \cubev_reg_1_dout0[17] ;
 wire \cubev_reg_1_dout0[18] ;
 wire \cubev_reg_1_dout0[19] ;
 wire \cubev_reg_1_dout0[1] ;
 wire \cubev_reg_1_dout0[20] ;
 wire \cubev_reg_1_dout0[21] ;
 wire \cubev_reg_1_dout0[22] ;
 wire \cubev_reg_1_dout0[23] ;
 wire \cubev_reg_1_dout0[24] ;
 wire \cubev_reg_1_dout0[25] ;
 wire \cubev_reg_1_dout0[26] ;
 wire \cubev_reg_1_dout0[27] ;
 wire \cubev_reg_1_dout0[28] ;
 wire \cubev_reg_1_dout0[29] ;
 wire \cubev_reg_1_dout0[2] ;
 wire \cubev_reg_1_dout0[30] ;
 wire \cubev_reg_1_dout0[31] ;
 wire \cubev_reg_1_dout0[3] ;
 wire \cubev_reg_1_dout0[4] ;
 wire \cubev_reg_1_dout0[5] ;
 wire \cubev_reg_1_dout0[6] ;
 wire \cubev_reg_1_dout0[7] ;
 wire \cubev_reg_1_dout0[8] ;
 wire \cubev_reg_1_dout0[9] ;
 wire \cubev_reg_1_dout1[0] ;
 wire \cubev_reg_1_dout1[10] ;
 wire \cubev_reg_1_dout1[11] ;
 wire \cubev_reg_1_dout1[12] ;
 wire \cubev_reg_1_dout1[13] ;
 wire \cubev_reg_1_dout1[14] ;
 wire \cubev_reg_1_dout1[15] ;
 wire \cubev_reg_1_dout1[16] ;
 wire \cubev_reg_1_dout1[17] ;
 wire \cubev_reg_1_dout1[18] ;
 wire \cubev_reg_1_dout1[19] ;
 wire \cubev_reg_1_dout1[1] ;
 wire \cubev_reg_1_dout1[20] ;
 wire \cubev_reg_1_dout1[21] ;
 wire \cubev_reg_1_dout1[22] ;
 wire \cubev_reg_1_dout1[23] ;
 wire \cubev_reg_1_dout1[24] ;
 wire \cubev_reg_1_dout1[25] ;
 wire \cubev_reg_1_dout1[26] ;
 wire \cubev_reg_1_dout1[27] ;
 wire \cubev_reg_1_dout1[28] ;
 wire \cubev_reg_1_dout1[29] ;
 wire \cubev_reg_1_dout1[2] ;
 wire \cubev_reg_1_dout1[30] ;
 wire \cubev_reg_1_dout1[31] ;
 wire \cubev_reg_1_dout1[3] ;
 wire \cubev_reg_1_dout1[4] ;
 wire \cubev_reg_1_dout1[5] ;
 wire \cubev_reg_1_dout1[6] ;
 wire \cubev_reg_1_dout1[7] ;
 wire \cubev_reg_1_dout1[8] ;
 wire \cubev_reg_1_dout1[9] ;
 wire \cubev_reg_1_dout1_reg[0] ;
 wire \cubev_reg_1_dout1_reg[10] ;
 wire \cubev_reg_1_dout1_reg[11] ;
 wire \cubev_reg_1_dout1_reg[12] ;
 wire \cubev_reg_1_dout1_reg[13] ;
 wire \cubev_reg_1_dout1_reg[14] ;
 wire \cubev_reg_1_dout1_reg[15] ;
 wire \cubev_reg_1_dout1_reg[16] ;
 wire \cubev_reg_1_dout1_reg[17] ;
 wire \cubev_reg_1_dout1_reg[18] ;
 wire \cubev_reg_1_dout1_reg[19] ;
 wire \cubev_reg_1_dout1_reg[1] ;
 wire \cubev_reg_1_dout1_reg[20] ;
 wire \cubev_reg_1_dout1_reg[21] ;
 wire \cubev_reg_1_dout1_reg[22] ;
 wire \cubev_reg_1_dout1_reg[23] ;
 wire \cubev_reg_1_dout1_reg[24] ;
 wire \cubev_reg_1_dout1_reg[25] ;
 wire \cubev_reg_1_dout1_reg[26] ;
 wire \cubev_reg_1_dout1_reg[27] ;
 wire \cubev_reg_1_dout1_reg[28] ;
 wire \cubev_reg_1_dout1_reg[29] ;
 wire \cubev_reg_1_dout1_reg[2] ;
 wire \cubev_reg_1_dout1_reg[30] ;
 wire \cubev_reg_1_dout1_reg[31] ;
 wire \cubev_reg_1_dout1_reg[3] ;
 wire \cubev_reg_1_dout1_reg[4] ;
 wire \cubev_reg_1_dout1_reg[5] ;
 wire \cubev_reg_1_dout1_reg[6] ;
 wire \cubev_reg_1_dout1_reg[7] ;
 wire \cubev_reg_1_dout1_reg[8] ;
 wire \cubev_reg_1_dout1_reg[9] ;
 wire cubev_reg_1_rstn;
 wire cubev_reg_1_web0;
 wire \cubev_reg_1_wmask0[0] ;
 wire \cubev_reg_1_wmask0[1] ;
 wire \cubev_reg_1_wmask0[2] ;
 wire \cubev_reg_1_wmask0[3] ;
 wire \cubev_reg_2_addr0[0] ;
 wire \cubev_reg_2_addr0[1] ;
 wire \cubev_reg_2_addr0[2] ;
 wire \cubev_reg_2_addr0[3] ;
 wire \cubev_reg_2_addr0[4] ;
 wire \cubev_reg_2_addr0[5] ;
 wire \cubev_reg_2_addr0[6] ;
 wire \cubev_reg_2_addr0[7] ;
 wire \cubev_reg_2_addr1[0] ;
 wire \cubev_reg_2_addr1[1] ;
 wire \cubev_reg_2_addr1[2] ;
 wire \cubev_reg_2_addr1[3] ;
 wire \cubev_reg_2_addr1[4] ;
 wire \cubev_reg_2_addr1[5] ;
 wire \cubev_reg_2_addr1[6] ;
 wire \cubev_reg_2_addr1[7] ;
 wire cubev_reg_2_clk0;
 wire cubev_reg_2_clk1;
 wire cubev_reg_2_csb0;
 wire cubev_reg_2_csb1;
 wire \cubev_reg_2_din0[0] ;
 wire \cubev_reg_2_din0[10] ;
 wire \cubev_reg_2_din0[11] ;
 wire \cubev_reg_2_din0[12] ;
 wire \cubev_reg_2_din0[13] ;
 wire \cubev_reg_2_din0[14] ;
 wire \cubev_reg_2_din0[15] ;
 wire \cubev_reg_2_din0[16] ;
 wire \cubev_reg_2_din0[17] ;
 wire \cubev_reg_2_din0[18] ;
 wire \cubev_reg_2_din0[19] ;
 wire \cubev_reg_2_din0[1] ;
 wire \cubev_reg_2_din0[20] ;
 wire \cubev_reg_2_din0[21] ;
 wire \cubev_reg_2_din0[22] ;
 wire \cubev_reg_2_din0[23] ;
 wire \cubev_reg_2_din0[24] ;
 wire \cubev_reg_2_din0[25] ;
 wire \cubev_reg_2_din0[26] ;
 wire \cubev_reg_2_din0[27] ;
 wire \cubev_reg_2_din0[28] ;
 wire \cubev_reg_2_din0[29] ;
 wire \cubev_reg_2_din0[2] ;
 wire \cubev_reg_2_din0[30] ;
 wire \cubev_reg_2_din0[31] ;
 wire \cubev_reg_2_din0[3] ;
 wire \cubev_reg_2_din0[4] ;
 wire \cubev_reg_2_din0[5] ;
 wire \cubev_reg_2_din0[6] ;
 wire \cubev_reg_2_din0[7] ;
 wire \cubev_reg_2_din0[8] ;
 wire \cubev_reg_2_din0[9] ;
 wire \cubev_reg_2_dout0[0] ;
 wire \cubev_reg_2_dout0[10] ;
 wire \cubev_reg_2_dout0[11] ;
 wire \cubev_reg_2_dout0[12] ;
 wire \cubev_reg_2_dout0[13] ;
 wire \cubev_reg_2_dout0[14] ;
 wire \cubev_reg_2_dout0[15] ;
 wire \cubev_reg_2_dout0[16] ;
 wire \cubev_reg_2_dout0[17] ;
 wire \cubev_reg_2_dout0[18] ;
 wire \cubev_reg_2_dout0[19] ;
 wire \cubev_reg_2_dout0[1] ;
 wire \cubev_reg_2_dout0[20] ;
 wire \cubev_reg_2_dout0[21] ;
 wire \cubev_reg_2_dout0[22] ;
 wire \cubev_reg_2_dout0[23] ;
 wire \cubev_reg_2_dout0[24] ;
 wire \cubev_reg_2_dout0[25] ;
 wire \cubev_reg_2_dout0[26] ;
 wire \cubev_reg_2_dout0[27] ;
 wire \cubev_reg_2_dout0[28] ;
 wire \cubev_reg_2_dout0[29] ;
 wire \cubev_reg_2_dout0[2] ;
 wire \cubev_reg_2_dout0[30] ;
 wire \cubev_reg_2_dout0[31] ;
 wire \cubev_reg_2_dout0[3] ;
 wire \cubev_reg_2_dout0[4] ;
 wire \cubev_reg_2_dout0[5] ;
 wire \cubev_reg_2_dout0[6] ;
 wire \cubev_reg_2_dout0[7] ;
 wire \cubev_reg_2_dout0[8] ;
 wire \cubev_reg_2_dout0[9] ;
 wire \cubev_reg_2_dout1[0] ;
 wire \cubev_reg_2_dout1[10] ;
 wire \cubev_reg_2_dout1[11] ;
 wire \cubev_reg_2_dout1[12] ;
 wire \cubev_reg_2_dout1[13] ;
 wire \cubev_reg_2_dout1[14] ;
 wire \cubev_reg_2_dout1[15] ;
 wire \cubev_reg_2_dout1[16] ;
 wire \cubev_reg_2_dout1[17] ;
 wire \cubev_reg_2_dout1[18] ;
 wire \cubev_reg_2_dout1[19] ;
 wire \cubev_reg_2_dout1[1] ;
 wire \cubev_reg_2_dout1[20] ;
 wire \cubev_reg_2_dout1[21] ;
 wire \cubev_reg_2_dout1[22] ;
 wire \cubev_reg_2_dout1[23] ;
 wire \cubev_reg_2_dout1[24] ;
 wire \cubev_reg_2_dout1[25] ;
 wire \cubev_reg_2_dout1[26] ;
 wire \cubev_reg_2_dout1[27] ;
 wire \cubev_reg_2_dout1[28] ;
 wire \cubev_reg_2_dout1[29] ;
 wire \cubev_reg_2_dout1[2] ;
 wire \cubev_reg_2_dout1[30] ;
 wire \cubev_reg_2_dout1[31] ;
 wire \cubev_reg_2_dout1[3] ;
 wire \cubev_reg_2_dout1[4] ;
 wire \cubev_reg_2_dout1[5] ;
 wire \cubev_reg_2_dout1[6] ;
 wire \cubev_reg_2_dout1[7] ;
 wire \cubev_reg_2_dout1[8] ;
 wire \cubev_reg_2_dout1[9] ;
 wire \cubev_reg_2_dout1_reg[0] ;
 wire \cubev_reg_2_dout1_reg[10] ;
 wire \cubev_reg_2_dout1_reg[11] ;
 wire \cubev_reg_2_dout1_reg[12] ;
 wire \cubev_reg_2_dout1_reg[13] ;
 wire \cubev_reg_2_dout1_reg[14] ;
 wire \cubev_reg_2_dout1_reg[15] ;
 wire \cubev_reg_2_dout1_reg[16] ;
 wire \cubev_reg_2_dout1_reg[17] ;
 wire \cubev_reg_2_dout1_reg[18] ;
 wire \cubev_reg_2_dout1_reg[19] ;
 wire \cubev_reg_2_dout1_reg[1] ;
 wire \cubev_reg_2_dout1_reg[20] ;
 wire \cubev_reg_2_dout1_reg[21] ;
 wire \cubev_reg_2_dout1_reg[22] ;
 wire \cubev_reg_2_dout1_reg[23] ;
 wire \cubev_reg_2_dout1_reg[24] ;
 wire \cubev_reg_2_dout1_reg[25] ;
 wire \cubev_reg_2_dout1_reg[26] ;
 wire \cubev_reg_2_dout1_reg[27] ;
 wire \cubev_reg_2_dout1_reg[28] ;
 wire \cubev_reg_2_dout1_reg[29] ;
 wire \cubev_reg_2_dout1_reg[2] ;
 wire \cubev_reg_2_dout1_reg[30] ;
 wire \cubev_reg_2_dout1_reg[31] ;
 wire \cubev_reg_2_dout1_reg[3] ;
 wire \cubev_reg_2_dout1_reg[4] ;
 wire \cubev_reg_2_dout1_reg[5] ;
 wire \cubev_reg_2_dout1_reg[6] ;
 wire \cubev_reg_2_dout1_reg[7] ;
 wire \cubev_reg_2_dout1_reg[8] ;
 wire \cubev_reg_2_dout1_reg[9] ;
 wire cubev_reg_2_rstn;
 wire cubev_reg_2_web0;
 wire \cubev_reg_2_wmask0[0] ;
 wire \cubev_reg_2_wmask0[1] ;
 wire \cubev_reg_2_wmask0[2] ;
 wire \cubev_reg_2_wmask0[3] ;
 wire \cubev_reg_3_addr0[0] ;
 wire \cubev_reg_3_addr0[1] ;
 wire \cubev_reg_3_addr0[2] ;
 wire \cubev_reg_3_addr0[3] ;
 wire \cubev_reg_3_addr0[4] ;
 wire \cubev_reg_3_addr0[5] ;
 wire \cubev_reg_3_addr0[6] ;
 wire \cubev_reg_3_addr0[7] ;
 wire \cubev_reg_3_addr1[0] ;
 wire \cubev_reg_3_addr1[1] ;
 wire \cubev_reg_3_addr1[2] ;
 wire \cubev_reg_3_addr1[3] ;
 wire \cubev_reg_3_addr1[4] ;
 wire \cubev_reg_3_addr1[5] ;
 wire \cubev_reg_3_addr1[6] ;
 wire \cubev_reg_3_addr1[7] ;
 wire cubev_reg_3_clk0;
 wire cubev_reg_3_clk1;
 wire cubev_reg_3_csb0;
 wire cubev_reg_3_csb1;
 wire \cubev_reg_3_din0[0] ;
 wire \cubev_reg_3_din0[10] ;
 wire \cubev_reg_3_din0[11] ;
 wire \cubev_reg_3_din0[12] ;
 wire \cubev_reg_3_din0[13] ;
 wire \cubev_reg_3_din0[14] ;
 wire \cubev_reg_3_din0[15] ;
 wire \cubev_reg_3_din0[16] ;
 wire \cubev_reg_3_din0[17] ;
 wire \cubev_reg_3_din0[18] ;
 wire \cubev_reg_3_din0[19] ;
 wire \cubev_reg_3_din0[1] ;
 wire \cubev_reg_3_din0[20] ;
 wire \cubev_reg_3_din0[21] ;
 wire \cubev_reg_3_din0[22] ;
 wire \cubev_reg_3_din0[23] ;
 wire \cubev_reg_3_din0[24] ;
 wire \cubev_reg_3_din0[25] ;
 wire \cubev_reg_3_din0[26] ;
 wire \cubev_reg_3_din0[27] ;
 wire \cubev_reg_3_din0[28] ;
 wire \cubev_reg_3_din0[29] ;
 wire \cubev_reg_3_din0[2] ;
 wire \cubev_reg_3_din0[30] ;
 wire \cubev_reg_3_din0[31] ;
 wire \cubev_reg_3_din0[3] ;
 wire \cubev_reg_3_din0[4] ;
 wire \cubev_reg_3_din0[5] ;
 wire \cubev_reg_3_din0[6] ;
 wire \cubev_reg_3_din0[7] ;
 wire \cubev_reg_3_din0[8] ;
 wire \cubev_reg_3_din0[9] ;
 wire \cubev_reg_3_dout0[0] ;
 wire \cubev_reg_3_dout0[10] ;
 wire \cubev_reg_3_dout0[11] ;
 wire \cubev_reg_3_dout0[12] ;
 wire \cubev_reg_3_dout0[13] ;
 wire \cubev_reg_3_dout0[14] ;
 wire \cubev_reg_3_dout0[15] ;
 wire \cubev_reg_3_dout0[16] ;
 wire \cubev_reg_3_dout0[17] ;
 wire \cubev_reg_3_dout0[18] ;
 wire \cubev_reg_3_dout0[19] ;
 wire \cubev_reg_3_dout0[1] ;
 wire \cubev_reg_3_dout0[20] ;
 wire \cubev_reg_3_dout0[21] ;
 wire \cubev_reg_3_dout0[22] ;
 wire \cubev_reg_3_dout0[23] ;
 wire \cubev_reg_3_dout0[24] ;
 wire \cubev_reg_3_dout0[25] ;
 wire \cubev_reg_3_dout0[26] ;
 wire \cubev_reg_3_dout0[27] ;
 wire \cubev_reg_3_dout0[28] ;
 wire \cubev_reg_3_dout0[29] ;
 wire \cubev_reg_3_dout0[2] ;
 wire \cubev_reg_3_dout0[30] ;
 wire \cubev_reg_3_dout0[31] ;
 wire \cubev_reg_3_dout0[3] ;
 wire \cubev_reg_3_dout0[4] ;
 wire \cubev_reg_3_dout0[5] ;
 wire \cubev_reg_3_dout0[6] ;
 wire \cubev_reg_3_dout0[7] ;
 wire \cubev_reg_3_dout0[8] ;
 wire \cubev_reg_3_dout0[9] ;
 wire \cubev_reg_3_dout1[0] ;
 wire \cubev_reg_3_dout1[10] ;
 wire \cubev_reg_3_dout1[11] ;
 wire \cubev_reg_3_dout1[12] ;
 wire \cubev_reg_3_dout1[13] ;
 wire \cubev_reg_3_dout1[14] ;
 wire \cubev_reg_3_dout1[15] ;
 wire \cubev_reg_3_dout1[16] ;
 wire \cubev_reg_3_dout1[17] ;
 wire \cubev_reg_3_dout1[18] ;
 wire \cubev_reg_3_dout1[19] ;
 wire \cubev_reg_3_dout1[1] ;
 wire \cubev_reg_3_dout1[20] ;
 wire \cubev_reg_3_dout1[21] ;
 wire \cubev_reg_3_dout1[22] ;
 wire \cubev_reg_3_dout1[23] ;
 wire \cubev_reg_3_dout1[24] ;
 wire \cubev_reg_3_dout1[25] ;
 wire \cubev_reg_3_dout1[26] ;
 wire \cubev_reg_3_dout1[27] ;
 wire \cubev_reg_3_dout1[28] ;
 wire \cubev_reg_3_dout1[29] ;
 wire \cubev_reg_3_dout1[2] ;
 wire \cubev_reg_3_dout1[30] ;
 wire \cubev_reg_3_dout1[31] ;
 wire \cubev_reg_3_dout1[3] ;
 wire \cubev_reg_3_dout1[4] ;
 wire \cubev_reg_3_dout1[5] ;
 wire \cubev_reg_3_dout1[6] ;
 wire \cubev_reg_3_dout1[7] ;
 wire \cubev_reg_3_dout1[8] ;
 wire \cubev_reg_3_dout1[9] ;
 wire \cubev_reg_3_dout1_reg[0] ;
 wire \cubev_reg_3_dout1_reg[10] ;
 wire \cubev_reg_3_dout1_reg[11] ;
 wire \cubev_reg_3_dout1_reg[12] ;
 wire \cubev_reg_3_dout1_reg[13] ;
 wire \cubev_reg_3_dout1_reg[14] ;
 wire \cubev_reg_3_dout1_reg[15] ;
 wire \cubev_reg_3_dout1_reg[16] ;
 wire \cubev_reg_3_dout1_reg[17] ;
 wire \cubev_reg_3_dout1_reg[18] ;
 wire \cubev_reg_3_dout1_reg[19] ;
 wire \cubev_reg_3_dout1_reg[1] ;
 wire \cubev_reg_3_dout1_reg[20] ;
 wire \cubev_reg_3_dout1_reg[21] ;
 wire \cubev_reg_3_dout1_reg[22] ;
 wire \cubev_reg_3_dout1_reg[23] ;
 wire \cubev_reg_3_dout1_reg[24] ;
 wire \cubev_reg_3_dout1_reg[25] ;
 wire \cubev_reg_3_dout1_reg[26] ;
 wire \cubev_reg_3_dout1_reg[27] ;
 wire \cubev_reg_3_dout1_reg[28] ;
 wire \cubev_reg_3_dout1_reg[29] ;
 wire \cubev_reg_3_dout1_reg[2] ;
 wire \cubev_reg_3_dout1_reg[30] ;
 wire \cubev_reg_3_dout1_reg[31] ;
 wire \cubev_reg_3_dout1_reg[3] ;
 wire \cubev_reg_3_dout1_reg[4] ;
 wire \cubev_reg_3_dout1_reg[5] ;
 wire \cubev_reg_3_dout1_reg[6] ;
 wire \cubev_reg_3_dout1_reg[7] ;
 wire \cubev_reg_3_dout1_reg[8] ;
 wire \cubev_reg_3_dout1_reg[9] ;
 wire cubev_reg_3_rstn;
 wire cubev_reg_3_web0;
 wire \cubev_reg_3_wmask0[0] ;
 wire \cubev_reg_3_wmask0[1] ;
 wire \cubev_reg_3_wmask0[2] ;
 wire \cubev_reg_3_wmask0[3] ;
 wire \cubev_reg_4_addr0[0] ;
 wire \cubev_reg_4_addr0[1] ;
 wire \cubev_reg_4_addr0[2] ;
 wire \cubev_reg_4_addr0[3] ;
 wire \cubev_reg_4_addr0[4] ;
 wire \cubev_reg_4_addr0[5] ;
 wire \cubev_reg_4_addr0[6] ;
 wire \cubev_reg_4_addr0[7] ;
 wire \cubev_reg_4_addr1[0] ;
 wire \cubev_reg_4_addr1[1] ;
 wire \cubev_reg_4_addr1[2] ;
 wire \cubev_reg_4_addr1[3] ;
 wire \cubev_reg_4_addr1[4] ;
 wire \cubev_reg_4_addr1[5] ;
 wire \cubev_reg_4_addr1[6] ;
 wire \cubev_reg_4_addr1[7] ;
 wire cubev_reg_4_clk0;
 wire cubev_reg_4_clk1;
 wire cubev_reg_4_csb0;
 wire cubev_reg_4_csb1;
 wire \cubev_reg_4_din0[0] ;
 wire \cubev_reg_4_din0[10] ;
 wire \cubev_reg_4_din0[11] ;
 wire \cubev_reg_4_din0[12] ;
 wire \cubev_reg_4_din0[13] ;
 wire \cubev_reg_4_din0[14] ;
 wire \cubev_reg_4_din0[15] ;
 wire \cubev_reg_4_din0[16] ;
 wire \cubev_reg_4_din0[17] ;
 wire \cubev_reg_4_din0[18] ;
 wire \cubev_reg_4_din0[19] ;
 wire \cubev_reg_4_din0[1] ;
 wire \cubev_reg_4_din0[20] ;
 wire \cubev_reg_4_din0[21] ;
 wire \cubev_reg_4_din0[22] ;
 wire \cubev_reg_4_din0[23] ;
 wire \cubev_reg_4_din0[24] ;
 wire \cubev_reg_4_din0[25] ;
 wire \cubev_reg_4_din0[26] ;
 wire \cubev_reg_4_din0[27] ;
 wire \cubev_reg_4_din0[28] ;
 wire \cubev_reg_4_din0[29] ;
 wire \cubev_reg_4_din0[2] ;
 wire \cubev_reg_4_din0[30] ;
 wire \cubev_reg_4_din0[31] ;
 wire \cubev_reg_4_din0[3] ;
 wire \cubev_reg_4_din0[4] ;
 wire \cubev_reg_4_din0[5] ;
 wire \cubev_reg_4_din0[6] ;
 wire \cubev_reg_4_din0[7] ;
 wire \cubev_reg_4_din0[8] ;
 wire \cubev_reg_4_din0[9] ;
 wire \cubev_reg_4_dout0[0] ;
 wire \cubev_reg_4_dout0[10] ;
 wire \cubev_reg_4_dout0[11] ;
 wire \cubev_reg_4_dout0[12] ;
 wire \cubev_reg_4_dout0[13] ;
 wire \cubev_reg_4_dout0[14] ;
 wire \cubev_reg_4_dout0[15] ;
 wire \cubev_reg_4_dout0[16] ;
 wire \cubev_reg_4_dout0[17] ;
 wire \cubev_reg_4_dout0[18] ;
 wire \cubev_reg_4_dout0[19] ;
 wire \cubev_reg_4_dout0[1] ;
 wire \cubev_reg_4_dout0[20] ;
 wire \cubev_reg_4_dout0[21] ;
 wire \cubev_reg_4_dout0[22] ;
 wire \cubev_reg_4_dout0[23] ;
 wire \cubev_reg_4_dout0[24] ;
 wire \cubev_reg_4_dout0[25] ;
 wire \cubev_reg_4_dout0[26] ;
 wire \cubev_reg_4_dout0[27] ;
 wire \cubev_reg_4_dout0[28] ;
 wire \cubev_reg_4_dout0[29] ;
 wire \cubev_reg_4_dout0[2] ;
 wire \cubev_reg_4_dout0[30] ;
 wire \cubev_reg_4_dout0[31] ;
 wire \cubev_reg_4_dout0[3] ;
 wire \cubev_reg_4_dout0[4] ;
 wire \cubev_reg_4_dout0[5] ;
 wire \cubev_reg_4_dout0[6] ;
 wire \cubev_reg_4_dout0[7] ;
 wire \cubev_reg_4_dout0[8] ;
 wire \cubev_reg_4_dout0[9] ;
 wire \cubev_reg_4_dout1[0] ;
 wire \cubev_reg_4_dout1[10] ;
 wire \cubev_reg_4_dout1[11] ;
 wire \cubev_reg_4_dout1[12] ;
 wire \cubev_reg_4_dout1[13] ;
 wire \cubev_reg_4_dout1[14] ;
 wire \cubev_reg_4_dout1[15] ;
 wire \cubev_reg_4_dout1[16] ;
 wire \cubev_reg_4_dout1[17] ;
 wire \cubev_reg_4_dout1[18] ;
 wire \cubev_reg_4_dout1[19] ;
 wire \cubev_reg_4_dout1[1] ;
 wire \cubev_reg_4_dout1[20] ;
 wire \cubev_reg_4_dout1[21] ;
 wire \cubev_reg_4_dout1[22] ;
 wire \cubev_reg_4_dout1[23] ;
 wire \cubev_reg_4_dout1[24] ;
 wire \cubev_reg_4_dout1[25] ;
 wire \cubev_reg_4_dout1[26] ;
 wire \cubev_reg_4_dout1[27] ;
 wire \cubev_reg_4_dout1[28] ;
 wire \cubev_reg_4_dout1[29] ;
 wire \cubev_reg_4_dout1[2] ;
 wire \cubev_reg_4_dout1[30] ;
 wire \cubev_reg_4_dout1[31] ;
 wire \cubev_reg_4_dout1[3] ;
 wire \cubev_reg_4_dout1[4] ;
 wire \cubev_reg_4_dout1[5] ;
 wire \cubev_reg_4_dout1[6] ;
 wire \cubev_reg_4_dout1[7] ;
 wire \cubev_reg_4_dout1[8] ;
 wire \cubev_reg_4_dout1[9] ;
 wire \cubev_reg_4_dout1_reg[0] ;
 wire \cubev_reg_4_dout1_reg[10] ;
 wire \cubev_reg_4_dout1_reg[11] ;
 wire \cubev_reg_4_dout1_reg[12] ;
 wire \cubev_reg_4_dout1_reg[13] ;
 wire \cubev_reg_4_dout1_reg[14] ;
 wire \cubev_reg_4_dout1_reg[15] ;
 wire \cubev_reg_4_dout1_reg[16] ;
 wire \cubev_reg_4_dout1_reg[17] ;
 wire \cubev_reg_4_dout1_reg[18] ;
 wire \cubev_reg_4_dout1_reg[19] ;
 wire \cubev_reg_4_dout1_reg[1] ;
 wire \cubev_reg_4_dout1_reg[20] ;
 wire \cubev_reg_4_dout1_reg[21] ;
 wire \cubev_reg_4_dout1_reg[22] ;
 wire \cubev_reg_4_dout1_reg[23] ;
 wire \cubev_reg_4_dout1_reg[24] ;
 wire \cubev_reg_4_dout1_reg[25] ;
 wire \cubev_reg_4_dout1_reg[26] ;
 wire \cubev_reg_4_dout1_reg[27] ;
 wire \cubev_reg_4_dout1_reg[28] ;
 wire \cubev_reg_4_dout1_reg[29] ;
 wire \cubev_reg_4_dout1_reg[2] ;
 wire \cubev_reg_4_dout1_reg[30] ;
 wire \cubev_reg_4_dout1_reg[31] ;
 wire \cubev_reg_4_dout1_reg[3] ;
 wire \cubev_reg_4_dout1_reg[4] ;
 wire \cubev_reg_4_dout1_reg[5] ;
 wire \cubev_reg_4_dout1_reg[6] ;
 wire \cubev_reg_4_dout1_reg[7] ;
 wire \cubev_reg_4_dout1_reg[8] ;
 wire \cubev_reg_4_dout1_reg[9] ;
 wire cubev_reg_4_rstn;
 wire cubev_reg_4_web0;
 wire \cubev_reg_4_wmask0[0] ;
 wire \cubev_reg_4_wmask0[1] ;
 wire \cubev_reg_4_wmask0[2] ;
 wire \cubev_reg_4_wmask0[3] ;
 wire \cubev_reg_5_addr0[0] ;
 wire \cubev_reg_5_addr0[1] ;
 wire \cubev_reg_5_addr0[2] ;
 wire \cubev_reg_5_addr0[3] ;
 wire \cubev_reg_5_addr0[4] ;
 wire \cubev_reg_5_addr0[5] ;
 wire \cubev_reg_5_addr0[6] ;
 wire \cubev_reg_5_addr0[7] ;
 wire \cubev_reg_5_addr1[0] ;
 wire \cubev_reg_5_addr1[1] ;
 wire \cubev_reg_5_addr1[2] ;
 wire \cubev_reg_5_addr1[3] ;
 wire \cubev_reg_5_addr1[4] ;
 wire \cubev_reg_5_addr1[5] ;
 wire \cubev_reg_5_addr1[6] ;
 wire \cubev_reg_5_addr1[7] ;
 wire cubev_reg_5_clk0;
 wire cubev_reg_5_clk1;
 wire cubev_reg_5_csb0;
 wire cubev_reg_5_csb1;
 wire \cubev_reg_5_din0[0] ;
 wire \cubev_reg_5_din0[10] ;
 wire \cubev_reg_5_din0[11] ;
 wire \cubev_reg_5_din0[12] ;
 wire \cubev_reg_5_din0[13] ;
 wire \cubev_reg_5_din0[14] ;
 wire \cubev_reg_5_din0[15] ;
 wire \cubev_reg_5_din0[16] ;
 wire \cubev_reg_5_din0[17] ;
 wire \cubev_reg_5_din0[18] ;
 wire \cubev_reg_5_din0[19] ;
 wire \cubev_reg_5_din0[1] ;
 wire \cubev_reg_5_din0[20] ;
 wire \cubev_reg_5_din0[21] ;
 wire \cubev_reg_5_din0[22] ;
 wire \cubev_reg_5_din0[23] ;
 wire \cubev_reg_5_din0[24] ;
 wire \cubev_reg_5_din0[25] ;
 wire \cubev_reg_5_din0[26] ;
 wire \cubev_reg_5_din0[27] ;
 wire \cubev_reg_5_din0[28] ;
 wire \cubev_reg_5_din0[29] ;
 wire \cubev_reg_5_din0[2] ;
 wire \cubev_reg_5_din0[30] ;
 wire \cubev_reg_5_din0[31] ;
 wire \cubev_reg_5_din0[3] ;
 wire \cubev_reg_5_din0[4] ;
 wire \cubev_reg_5_din0[5] ;
 wire \cubev_reg_5_din0[6] ;
 wire \cubev_reg_5_din0[7] ;
 wire \cubev_reg_5_din0[8] ;
 wire \cubev_reg_5_din0[9] ;
 wire \cubev_reg_5_dout0[0] ;
 wire \cubev_reg_5_dout0[10] ;
 wire \cubev_reg_5_dout0[11] ;
 wire \cubev_reg_5_dout0[12] ;
 wire \cubev_reg_5_dout0[13] ;
 wire \cubev_reg_5_dout0[14] ;
 wire \cubev_reg_5_dout0[15] ;
 wire \cubev_reg_5_dout0[16] ;
 wire \cubev_reg_5_dout0[17] ;
 wire \cubev_reg_5_dout0[18] ;
 wire \cubev_reg_5_dout0[19] ;
 wire \cubev_reg_5_dout0[1] ;
 wire \cubev_reg_5_dout0[20] ;
 wire \cubev_reg_5_dout0[21] ;
 wire \cubev_reg_5_dout0[22] ;
 wire \cubev_reg_5_dout0[23] ;
 wire \cubev_reg_5_dout0[24] ;
 wire \cubev_reg_5_dout0[25] ;
 wire \cubev_reg_5_dout0[26] ;
 wire \cubev_reg_5_dout0[27] ;
 wire \cubev_reg_5_dout0[28] ;
 wire \cubev_reg_5_dout0[29] ;
 wire \cubev_reg_5_dout0[2] ;
 wire \cubev_reg_5_dout0[30] ;
 wire \cubev_reg_5_dout0[31] ;
 wire \cubev_reg_5_dout0[3] ;
 wire \cubev_reg_5_dout0[4] ;
 wire \cubev_reg_5_dout0[5] ;
 wire \cubev_reg_5_dout0[6] ;
 wire \cubev_reg_5_dout0[7] ;
 wire \cubev_reg_5_dout0[8] ;
 wire \cubev_reg_5_dout0[9] ;
 wire \cubev_reg_5_dout1[0] ;
 wire \cubev_reg_5_dout1[10] ;
 wire \cubev_reg_5_dout1[11] ;
 wire \cubev_reg_5_dout1[12] ;
 wire \cubev_reg_5_dout1[13] ;
 wire \cubev_reg_5_dout1[14] ;
 wire \cubev_reg_5_dout1[15] ;
 wire \cubev_reg_5_dout1[16] ;
 wire \cubev_reg_5_dout1[17] ;
 wire \cubev_reg_5_dout1[18] ;
 wire \cubev_reg_5_dout1[19] ;
 wire \cubev_reg_5_dout1[1] ;
 wire \cubev_reg_5_dout1[20] ;
 wire \cubev_reg_5_dout1[21] ;
 wire \cubev_reg_5_dout1[22] ;
 wire \cubev_reg_5_dout1[23] ;
 wire \cubev_reg_5_dout1[24] ;
 wire \cubev_reg_5_dout1[25] ;
 wire \cubev_reg_5_dout1[26] ;
 wire \cubev_reg_5_dout1[27] ;
 wire \cubev_reg_5_dout1[28] ;
 wire \cubev_reg_5_dout1[29] ;
 wire \cubev_reg_5_dout1[2] ;
 wire \cubev_reg_5_dout1[30] ;
 wire \cubev_reg_5_dout1[31] ;
 wire \cubev_reg_5_dout1[3] ;
 wire \cubev_reg_5_dout1[4] ;
 wire \cubev_reg_5_dout1[5] ;
 wire \cubev_reg_5_dout1[6] ;
 wire \cubev_reg_5_dout1[7] ;
 wire \cubev_reg_5_dout1[8] ;
 wire \cubev_reg_5_dout1[9] ;
 wire \cubev_reg_5_dout1_reg[0] ;
 wire \cubev_reg_5_dout1_reg[10] ;
 wire \cubev_reg_5_dout1_reg[11] ;
 wire \cubev_reg_5_dout1_reg[12] ;
 wire \cubev_reg_5_dout1_reg[13] ;
 wire \cubev_reg_5_dout1_reg[14] ;
 wire \cubev_reg_5_dout1_reg[15] ;
 wire \cubev_reg_5_dout1_reg[16] ;
 wire \cubev_reg_5_dout1_reg[17] ;
 wire \cubev_reg_5_dout1_reg[18] ;
 wire \cubev_reg_5_dout1_reg[19] ;
 wire \cubev_reg_5_dout1_reg[1] ;
 wire \cubev_reg_5_dout1_reg[20] ;
 wire \cubev_reg_5_dout1_reg[21] ;
 wire \cubev_reg_5_dout1_reg[22] ;
 wire \cubev_reg_5_dout1_reg[23] ;
 wire \cubev_reg_5_dout1_reg[24] ;
 wire \cubev_reg_5_dout1_reg[25] ;
 wire \cubev_reg_5_dout1_reg[26] ;
 wire \cubev_reg_5_dout1_reg[27] ;
 wire \cubev_reg_5_dout1_reg[28] ;
 wire \cubev_reg_5_dout1_reg[29] ;
 wire \cubev_reg_5_dout1_reg[2] ;
 wire \cubev_reg_5_dout1_reg[30] ;
 wire \cubev_reg_5_dout1_reg[31] ;
 wire \cubev_reg_5_dout1_reg[3] ;
 wire \cubev_reg_5_dout1_reg[4] ;
 wire \cubev_reg_5_dout1_reg[5] ;
 wire \cubev_reg_5_dout1_reg[6] ;
 wire \cubev_reg_5_dout1_reg[7] ;
 wire \cubev_reg_5_dout1_reg[8] ;
 wire \cubev_reg_5_dout1_reg[9] ;
 wire cubev_reg_5_rstn;
 wire cubev_reg_5_web0;
 wire \cubev_reg_5_wmask0[0] ;
 wire \cubev_reg_5_wmask0[1] ;
 wire \cubev_reg_5_wmask0[2] ;
 wire \cubev_reg_5_wmask0[3] ;
 wire \cubev_rf1_addr0[0] ;
 wire \cubev_rf1_addr0[1] ;
 wire \cubev_rf1_addr0[2] ;
 wire \cubev_rf1_addr0[3] ;
 wire \cubev_rf1_addr0[4] ;
 wire \cubev_rf1_addr0[5] ;
 wire \cubev_rf1_addr0[6] ;
 wire \cubev_rf1_addr0[7] ;
 wire \cubev_rf1_addr1[0] ;
 wire \cubev_rf1_addr1[1] ;
 wire \cubev_rf1_addr1[2] ;
 wire \cubev_rf1_addr1[3] ;
 wire \cubev_rf1_addr1[4] ;
 wire \cubev_rf1_addr1[5] ;
 wire \cubev_rf1_addr1[6] ;
 wire \cubev_rf1_addr1[7] ;
 wire cubev_rf1_clk0;
 wire cubev_rf1_clk1;
 wire cubev_rf1_csb0;
 wire cubev_rf1_csb1;
 wire \cubev_rf1_din0[0] ;
 wire \cubev_rf1_din0[10] ;
 wire \cubev_rf1_din0[11] ;
 wire \cubev_rf1_din0[12] ;
 wire \cubev_rf1_din0[13] ;
 wire \cubev_rf1_din0[14] ;
 wire \cubev_rf1_din0[15] ;
 wire \cubev_rf1_din0[16] ;
 wire \cubev_rf1_din0[17] ;
 wire \cubev_rf1_din0[18] ;
 wire \cubev_rf1_din0[19] ;
 wire \cubev_rf1_din0[1] ;
 wire \cubev_rf1_din0[20] ;
 wire \cubev_rf1_din0[21] ;
 wire \cubev_rf1_din0[22] ;
 wire \cubev_rf1_din0[23] ;
 wire \cubev_rf1_din0[24] ;
 wire \cubev_rf1_din0[25] ;
 wire \cubev_rf1_din0[26] ;
 wire \cubev_rf1_din0[27] ;
 wire \cubev_rf1_din0[28] ;
 wire \cubev_rf1_din0[29] ;
 wire \cubev_rf1_din0[2] ;
 wire \cubev_rf1_din0[30] ;
 wire \cubev_rf1_din0[31] ;
 wire \cubev_rf1_din0[3] ;
 wire \cubev_rf1_din0[4] ;
 wire \cubev_rf1_din0[5] ;
 wire \cubev_rf1_din0[6] ;
 wire \cubev_rf1_din0[7] ;
 wire \cubev_rf1_din0[8] ;
 wire \cubev_rf1_din0[9] ;
 wire \cubev_rf1_dout0[0] ;
 wire \cubev_rf1_dout0[10] ;
 wire \cubev_rf1_dout0[11] ;
 wire \cubev_rf1_dout0[12] ;
 wire \cubev_rf1_dout0[13] ;
 wire \cubev_rf1_dout0[14] ;
 wire \cubev_rf1_dout0[15] ;
 wire \cubev_rf1_dout0[16] ;
 wire \cubev_rf1_dout0[17] ;
 wire \cubev_rf1_dout0[18] ;
 wire \cubev_rf1_dout0[19] ;
 wire \cubev_rf1_dout0[1] ;
 wire \cubev_rf1_dout0[20] ;
 wire \cubev_rf1_dout0[21] ;
 wire \cubev_rf1_dout0[22] ;
 wire \cubev_rf1_dout0[23] ;
 wire \cubev_rf1_dout0[24] ;
 wire \cubev_rf1_dout0[25] ;
 wire \cubev_rf1_dout0[26] ;
 wire \cubev_rf1_dout0[27] ;
 wire \cubev_rf1_dout0[28] ;
 wire \cubev_rf1_dout0[29] ;
 wire \cubev_rf1_dout0[2] ;
 wire \cubev_rf1_dout0[30] ;
 wire \cubev_rf1_dout0[31] ;
 wire \cubev_rf1_dout0[3] ;
 wire \cubev_rf1_dout0[4] ;
 wire \cubev_rf1_dout0[5] ;
 wire \cubev_rf1_dout0[6] ;
 wire \cubev_rf1_dout0[7] ;
 wire \cubev_rf1_dout0[8] ;
 wire \cubev_rf1_dout0[9] ;
 wire \cubev_rf1_dout1[0] ;
 wire \cubev_rf1_dout1[10] ;
 wire \cubev_rf1_dout1[11] ;
 wire \cubev_rf1_dout1[12] ;
 wire \cubev_rf1_dout1[13] ;
 wire \cubev_rf1_dout1[14] ;
 wire \cubev_rf1_dout1[15] ;
 wire \cubev_rf1_dout1[16] ;
 wire \cubev_rf1_dout1[17] ;
 wire \cubev_rf1_dout1[18] ;
 wire \cubev_rf1_dout1[19] ;
 wire \cubev_rf1_dout1[1] ;
 wire \cubev_rf1_dout1[20] ;
 wire \cubev_rf1_dout1[21] ;
 wire \cubev_rf1_dout1[22] ;
 wire \cubev_rf1_dout1[23] ;
 wire \cubev_rf1_dout1[24] ;
 wire \cubev_rf1_dout1[25] ;
 wire \cubev_rf1_dout1[26] ;
 wire \cubev_rf1_dout1[27] ;
 wire \cubev_rf1_dout1[28] ;
 wire \cubev_rf1_dout1[29] ;
 wire \cubev_rf1_dout1[2] ;
 wire \cubev_rf1_dout1[30] ;
 wire \cubev_rf1_dout1[31] ;
 wire \cubev_rf1_dout1[3] ;
 wire \cubev_rf1_dout1[4] ;
 wire \cubev_rf1_dout1[5] ;
 wire \cubev_rf1_dout1[6] ;
 wire \cubev_rf1_dout1[7] ;
 wire \cubev_rf1_dout1[8] ;
 wire \cubev_rf1_dout1[9] ;
 wire \cubev_rf1_dout1_reg[0] ;
 wire \cubev_rf1_dout1_reg[10] ;
 wire \cubev_rf1_dout1_reg[11] ;
 wire \cubev_rf1_dout1_reg[12] ;
 wire \cubev_rf1_dout1_reg[13] ;
 wire \cubev_rf1_dout1_reg[14] ;
 wire \cubev_rf1_dout1_reg[15] ;
 wire \cubev_rf1_dout1_reg[16] ;
 wire \cubev_rf1_dout1_reg[17] ;
 wire \cubev_rf1_dout1_reg[18] ;
 wire \cubev_rf1_dout1_reg[19] ;
 wire \cubev_rf1_dout1_reg[1] ;
 wire \cubev_rf1_dout1_reg[20] ;
 wire \cubev_rf1_dout1_reg[21] ;
 wire \cubev_rf1_dout1_reg[22] ;
 wire \cubev_rf1_dout1_reg[23] ;
 wire \cubev_rf1_dout1_reg[24] ;
 wire \cubev_rf1_dout1_reg[25] ;
 wire \cubev_rf1_dout1_reg[26] ;
 wire \cubev_rf1_dout1_reg[27] ;
 wire \cubev_rf1_dout1_reg[28] ;
 wire \cubev_rf1_dout1_reg[29] ;
 wire \cubev_rf1_dout1_reg[2] ;
 wire \cubev_rf1_dout1_reg[30] ;
 wire \cubev_rf1_dout1_reg[31] ;
 wire \cubev_rf1_dout1_reg[3] ;
 wire \cubev_rf1_dout1_reg[4] ;
 wire \cubev_rf1_dout1_reg[5] ;
 wire \cubev_rf1_dout1_reg[6] ;
 wire \cubev_rf1_dout1_reg[7] ;
 wire \cubev_rf1_dout1_reg[8] ;
 wire \cubev_rf1_dout1_reg[9] ;
 wire cubev_rf1_rstn;
 wire cubev_rf1_web0;
 wire \cubev_rf1_wmask0[0] ;
 wire \cubev_rf1_wmask0[1] ;
 wire \cubev_rf1_wmask0[2] ;
 wire \cubev_rf1_wmask0[3] ;
 wire \cubev_rf2_addr0[0] ;
 wire \cubev_rf2_addr0[1] ;
 wire \cubev_rf2_addr0[2] ;
 wire \cubev_rf2_addr0[3] ;
 wire \cubev_rf2_addr0[4] ;
 wire \cubev_rf2_addr0[5] ;
 wire \cubev_rf2_addr0[6] ;
 wire \cubev_rf2_addr0[7] ;
 wire \cubev_rf2_addr1[0] ;
 wire \cubev_rf2_addr1[1] ;
 wire \cubev_rf2_addr1[2] ;
 wire \cubev_rf2_addr1[3] ;
 wire \cubev_rf2_addr1[4] ;
 wire \cubev_rf2_addr1[5] ;
 wire \cubev_rf2_addr1[6] ;
 wire \cubev_rf2_addr1[7] ;
 wire cubev_rf2_clk0;
 wire cubev_rf2_clk1;
 wire cubev_rf2_csb0;
 wire cubev_rf2_csb1;
 wire \cubev_rf2_din0[0] ;
 wire \cubev_rf2_din0[10] ;
 wire \cubev_rf2_din0[11] ;
 wire \cubev_rf2_din0[12] ;
 wire \cubev_rf2_din0[13] ;
 wire \cubev_rf2_din0[14] ;
 wire \cubev_rf2_din0[15] ;
 wire \cubev_rf2_din0[16] ;
 wire \cubev_rf2_din0[17] ;
 wire \cubev_rf2_din0[18] ;
 wire \cubev_rf2_din0[19] ;
 wire \cubev_rf2_din0[1] ;
 wire \cubev_rf2_din0[20] ;
 wire \cubev_rf2_din0[21] ;
 wire \cubev_rf2_din0[22] ;
 wire \cubev_rf2_din0[23] ;
 wire \cubev_rf2_din0[24] ;
 wire \cubev_rf2_din0[25] ;
 wire \cubev_rf2_din0[26] ;
 wire \cubev_rf2_din0[27] ;
 wire \cubev_rf2_din0[28] ;
 wire \cubev_rf2_din0[29] ;
 wire \cubev_rf2_din0[2] ;
 wire \cubev_rf2_din0[30] ;
 wire \cubev_rf2_din0[31] ;
 wire \cubev_rf2_din0[3] ;
 wire \cubev_rf2_din0[4] ;
 wire \cubev_rf2_din0[5] ;
 wire \cubev_rf2_din0[6] ;
 wire \cubev_rf2_din0[7] ;
 wire \cubev_rf2_din0[8] ;
 wire \cubev_rf2_din0[9] ;
 wire \cubev_rf2_dout0[0] ;
 wire \cubev_rf2_dout0[10] ;
 wire \cubev_rf2_dout0[11] ;
 wire \cubev_rf2_dout0[12] ;
 wire \cubev_rf2_dout0[13] ;
 wire \cubev_rf2_dout0[14] ;
 wire \cubev_rf2_dout0[15] ;
 wire \cubev_rf2_dout0[16] ;
 wire \cubev_rf2_dout0[17] ;
 wire \cubev_rf2_dout0[18] ;
 wire \cubev_rf2_dout0[19] ;
 wire \cubev_rf2_dout0[1] ;
 wire \cubev_rf2_dout0[20] ;
 wire \cubev_rf2_dout0[21] ;
 wire \cubev_rf2_dout0[22] ;
 wire \cubev_rf2_dout0[23] ;
 wire \cubev_rf2_dout0[24] ;
 wire \cubev_rf2_dout0[25] ;
 wire \cubev_rf2_dout0[26] ;
 wire \cubev_rf2_dout0[27] ;
 wire \cubev_rf2_dout0[28] ;
 wire \cubev_rf2_dout0[29] ;
 wire \cubev_rf2_dout0[2] ;
 wire \cubev_rf2_dout0[30] ;
 wire \cubev_rf2_dout0[31] ;
 wire \cubev_rf2_dout0[3] ;
 wire \cubev_rf2_dout0[4] ;
 wire \cubev_rf2_dout0[5] ;
 wire \cubev_rf2_dout0[6] ;
 wire \cubev_rf2_dout0[7] ;
 wire \cubev_rf2_dout0[8] ;
 wire \cubev_rf2_dout0[9] ;
 wire \cubev_rf2_dout1[0] ;
 wire \cubev_rf2_dout1[10] ;
 wire \cubev_rf2_dout1[11] ;
 wire \cubev_rf2_dout1[12] ;
 wire \cubev_rf2_dout1[13] ;
 wire \cubev_rf2_dout1[14] ;
 wire \cubev_rf2_dout1[15] ;
 wire \cubev_rf2_dout1[16] ;
 wire \cubev_rf2_dout1[17] ;
 wire \cubev_rf2_dout1[18] ;
 wire \cubev_rf2_dout1[19] ;
 wire \cubev_rf2_dout1[1] ;
 wire \cubev_rf2_dout1[20] ;
 wire \cubev_rf2_dout1[21] ;
 wire \cubev_rf2_dout1[22] ;
 wire \cubev_rf2_dout1[23] ;
 wire \cubev_rf2_dout1[24] ;
 wire \cubev_rf2_dout1[25] ;
 wire \cubev_rf2_dout1[26] ;
 wire \cubev_rf2_dout1[27] ;
 wire \cubev_rf2_dout1[28] ;
 wire \cubev_rf2_dout1[29] ;
 wire \cubev_rf2_dout1[2] ;
 wire \cubev_rf2_dout1[30] ;
 wire \cubev_rf2_dout1[31] ;
 wire \cubev_rf2_dout1[3] ;
 wire \cubev_rf2_dout1[4] ;
 wire \cubev_rf2_dout1[5] ;
 wire \cubev_rf2_dout1[6] ;
 wire \cubev_rf2_dout1[7] ;
 wire \cubev_rf2_dout1[8] ;
 wire \cubev_rf2_dout1[9] ;
 wire \cubev_rf2_dout1_reg[0] ;
 wire \cubev_rf2_dout1_reg[10] ;
 wire \cubev_rf2_dout1_reg[11] ;
 wire \cubev_rf2_dout1_reg[12] ;
 wire \cubev_rf2_dout1_reg[13] ;
 wire \cubev_rf2_dout1_reg[14] ;
 wire \cubev_rf2_dout1_reg[15] ;
 wire \cubev_rf2_dout1_reg[16] ;
 wire \cubev_rf2_dout1_reg[17] ;
 wire \cubev_rf2_dout1_reg[18] ;
 wire \cubev_rf2_dout1_reg[19] ;
 wire \cubev_rf2_dout1_reg[1] ;
 wire \cubev_rf2_dout1_reg[20] ;
 wire \cubev_rf2_dout1_reg[21] ;
 wire \cubev_rf2_dout1_reg[22] ;
 wire \cubev_rf2_dout1_reg[23] ;
 wire \cubev_rf2_dout1_reg[24] ;
 wire \cubev_rf2_dout1_reg[25] ;
 wire \cubev_rf2_dout1_reg[26] ;
 wire \cubev_rf2_dout1_reg[27] ;
 wire \cubev_rf2_dout1_reg[28] ;
 wire \cubev_rf2_dout1_reg[29] ;
 wire \cubev_rf2_dout1_reg[2] ;
 wire \cubev_rf2_dout1_reg[30] ;
 wire \cubev_rf2_dout1_reg[31] ;
 wire \cubev_rf2_dout1_reg[3] ;
 wire \cubev_rf2_dout1_reg[4] ;
 wire \cubev_rf2_dout1_reg[5] ;
 wire \cubev_rf2_dout1_reg[6] ;
 wire \cubev_rf2_dout1_reg[7] ;
 wire \cubev_rf2_dout1_reg[8] ;
 wire \cubev_rf2_dout1_reg[9] ;
 wire cubev_rf2_rstn;
 wire cubev_rf2_web0;
 wire \cubev_rf2_wmask0[0] ;
 wire \cubev_rf2_wmask0[1] ;
 wire \cubev_rf2_wmask0[2] ;
 wire \cubev_rf2_wmask0[3] ;
 wire rstn_reg;

 cawb cai (.ca_dbus_ack(ca_dbus_ack),
    .ca_dbus_com(ca_dbus_com),
    .ca_dbus_valid(ca_dbus_valid),
    .ca_match_ack(ca_match_ack),
    .ca_match_valid(ca_match_valid),
    .ca_time_ack(ca_time_ack),
    .ca_time_valid(ca_time_valid),
    .cubev_ca_clk0(cubev_ca_clk0),
    .cubev_ca_clk1(cubev_ca_clk1),
    .cubev_ca_csb0(cubev_ca_csb0),
    .cubev_ca_csb1(cubev_ca_csb1),
    .cubev_ca_web0(cubev_ca_web0),
    .cubev_phi_clk0(cubev_phi_clk0),
    .cubev_phi_csb0(cubev_phi_csb0),
    .cubev_phi_web0(cubev_phi_web0),
    .cubev_pli_clk0(cubev_pli_clk0),
    .cubev_pli_csb0(cubev_pli_csb0),
    .cubev_pli_web0(cubev_pli_web0),
    .rstn_reg(rstn_reg),
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .wbs_ack_o(wbs_ack_o),
    .wbs_cyc_i(wbs_cyc_i),
    .wbs_stb_i(wbs_stb_i),
    .wbs_we_i(wbs_we_i),
    .ca_command({\ca_command[31] ,
    \ca_command[30] ,
    \ca_command[29] ,
    \ca_command[28] ,
    \ca_command[27] ,
    \ca_command[26] ,
    \ca_command[25] ,
    \ca_command[24] ,
    \ca_command[23] ,
    \ca_command[22] ,
    \ca_command[21] ,
    \ca_command[20] ,
    \ca_command[19] ,
    \ca_command[18] ,
    \ca_command[17] ,
    \ca_command[16] ,
    \ca_command[15] ,
    \ca_command[14] ,
    \ca_command[13] ,
    \ca_command[12] ,
    \ca_command[11] ,
    \ca_command[10] ,
    \ca_command[9] ,
    \ca_command[8] ,
    \ca_command[7] ,
    \ca_command[6] ,
    \ca_command[5] ,
    \ca_command[4] ,
    \ca_command[3] ,
    \ca_command[2] ,
    \ca_command[1] ,
    \ca_command[0] }),
    .ca_dbus_data({\ca_dbus_data[31] ,
    \ca_dbus_data[30] ,
    \ca_dbus_data[29] ,
    \ca_dbus_data[28] ,
    \ca_dbus_data[27] ,
    \ca_dbus_data[26] ,
    \ca_dbus_data[25] ,
    \ca_dbus_data[24] ,
    \ca_dbus_data[23] ,
    \ca_dbus_data[22] ,
    \ca_dbus_data[21] ,
    \ca_dbus_data[20] ,
    \ca_dbus_data[19] ,
    \ca_dbus_data[18] ,
    \ca_dbus_data[17] ,
    \ca_dbus_data[16] ,
    \ca_dbus_data[15] ,
    \ca_dbus_data[14] ,
    \ca_dbus_data[13] ,
    \ca_dbus_data[12] ,
    \ca_dbus_data[11] ,
    \ca_dbus_data[10] ,
    \ca_dbus_data[9] ,
    \ca_dbus_data[8] ,
    \ca_dbus_data[7] ,
    \ca_dbus_data[6] ,
    \ca_dbus_data[5] ,
    \ca_dbus_data[4] ,
    \ca_dbus_data[3] ,
    \ca_dbus_data[2] ,
    \ca_dbus_data[1] ,
    \ca_dbus_data[0] }),
    .ca_dbus_tid({\ca_dbus_tid[2] ,
    \ca_dbus_tid[1] ,
    \ca_dbus_tid[0] }),
    .ca_time_data({\ca_time_data[22] ,
    \ca_time_data[21] ,
    \ca_time_data[20] ,
    \ca_time_data[19] ,
    \ca_time_data[18] ,
    \ca_time_data[17] ,
    \ca_time_data[16] ,
    \ca_time_data[15] ,
    \ca_time_data[14] ,
    \ca_time_data[13] ,
    \ca_time_data[12] ,
    \ca_time_data[11] ,
    \ca_time_data[10] ,
    \ca_time_data[9] ,
    \ca_time_data[8] ,
    \ca_time_data[7] ,
    \ca_time_data[6] ,
    \ca_time_data[5] ,
    \ca_time_data[4] ,
    \ca_time_data[3] ,
    \ca_time_data[2] ,
    \ca_time_data[1] ,
    \ca_time_data[0] }),
    .cubev_ca_addr0({\cubev_ca_addr0[7] ,
    \cubev_ca_addr0[6] ,
    \cubev_ca_addr0[5] ,
    \cubev_ca_addr0[4] ,
    \cubev_ca_addr0[3] ,
    \cubev_ca_addr0[2] ,
    \cubev_ca_addr0[1] ,
    \cubev_ca_addr0[0] }),
    .cubev_ca_addr1({\cubev_ca_addr1[7] ,
    \cubev_ca_addr1[6] ,
    \cubev_ca_addr1[5] ,
    \cubev_ca_addr1[4] ,
    \cubev_ca_addr1[3] ,
    \cubev_ca_addr1[2] ,
    \cubev_ca_addr1[1] ,
    \cubev_ca_addr1[0] }),
    .cubev_ca_din0({\cubev_ca_din0[31] ,
    \cubev_ca_din0[30] ,
    \cubev_ca_din0[29] ,
    \cubev_ca_din0[28] ,
    \cubev_ca_din0[27] ,
    \cubev_ca_din0[26] ,
    \cubev_ca_din0[25] ,
    \cubev_ca_din0[24] ,
    \cubev_ca_din0[23] ,
    \cubev_ca_din0[22] ,
    \cubev_ca_din0[21] ,
    \cubev_ca_din0[20] ,
    \cubev_ca_din0[19] ,
    \cubev_ca_din0[18] ,
    \cubev_ca_din0[17] ,
    \cubev_ca_din0[16] ,
    \cubev_ca_din0[15] ,
    \cubev_ca_din0[14] ,
    \cubev_ca_din0[13] ,
    \cubev_ca_din0[12] ,
    \cubev_ca_din0[11] ,
    \cubev_ca_din0[10] ,
    \cubev_ca_din0[9] ,
    \cubev_ca_din0[8] ,
    \cubev_ca_din0[7] ,
    \cubev_ca_din0[6] ,
    \cubev_ca_din0[5] ,
    \cubev_ca_din0[4] ,
    \cubev_ca_din0[3] ,
    \cubev_ca_din0[2] ,
    \cubev_ca_din0[1] ,
    \cubev_ca_din0[0] }),
    .cubev_ca_dout0({\cubev_ca_dout0[31] ,
    \cubev_ca_dout0[30] ,
    \cubev_ca_dout0[29] ,
    \cubev_ca_dout0[28] ,
    \cubev_ca_dout0[27] ,
    \cubev_ca_dout0[26] ,
    \cubev_ca_dout0[25] ,
    \cubev_ca_dout0[24] ,
    \cubev_ca_dout0[23] ,
    \cubev_ca_dout0[22] ,
    \cubev_ca_dout0[21] ,
    \cubev_ca_dout0[20] ,
    \cubev_ca_dout0[19] ,
    \cubev_ca_dout0[18] ,
    \cubev_ca_dout0[17] ,
    \cubev_ca_dout0[16] ,
    \cubev_ca_dout0[15] ,
    \cubev_ca_dout0[14] ,
    \cubev_ca_dout0[13] ,
    \cubev_ca_dout0[12] ,
    \cubev_ca_dout0[11] ,
    \cubev_ca_dout0[10] ,
    \cubev_ca_dout0[9] ,
    \cubev_ca_dout0[8] ,
    \cubev_ca_dout0[7] ,
    \cubev_ca_dout0[6] ,
    \cubev_ca_dout0[5] ,
    \cubev_ca_dout0[4] ,
    \cubev_ca_dout0[3] ,
    \cubev_ca_dout0[2] ,
    \cubev_ca_dout0[1] ,
    \cubev_ca_dout0[0] }),
    .cubev_ca_dout1({\cubev_ca_dout1[31] ,
    \cubev_ca_dout1[30] ,
    \cubev_ca_dout1[29] ,
    \cubev_ca_dout1[28] ,
    \cubev_ca_dout1[27] ,
    \cubev_ca_dout1[26] ,
    \cubev_ca_dout1[25] ,
    \cubev_ca_dout1[24] ,
    \cubev_ca_dout1[23] ,
    \cubev_ca_dout1[22] ,
    \cubev_ca_dout1[21] ,
    \cubev_ca_dout1[20] ,
    \cubev_ca_dout1[19] ,
    \cubev_ca_dout1[18] ,
    \cubev_ca_dout1[17] ,
    \cubev_ca_dout1[16] ,
    \cubev_ca_dout1[15] ,
    \cubev_ca_dout1[14] ,
    \cubev_ca_dout1[13] ,
    \cubev_ca_dout1[12] ,
    \cubev_ca_dout1[11] ,
    \cubev_ca_dout1[10] ,
    \cubev_ca_dout1[9] ,
    \cubev_ca_dout1[8] ,
    \cubev_ca_dout1[7] ,
    \cubev_ca_dout1[6] ,
    \cubev_ca_dout1[5] ,
    \cubev_ca_dout1[4] ,
    \cubev_ca_dout1[3] ,
    \cubev_ca_dout1[2] ,
    \cubev_ca_dout1[1] ,
    \cubev_ca_dout1[0] }),
    .cubev_ca_wmask0({\cubev_ca_wmask0[3] ,
    \cubev_ca_wmask0[2] ,
    \cubev_ca_wmask0[1] ,
    \cubev_ca_wmask0[0] }),
    .cubev_phi_addr0({\cubev_phi_addr0[7] ,
    \cubev_phi_addr0[6] ,
    \cubev_phi_addr0[5] ,
    \cubev_phi_addr0[4] ,
    \cubev_phi_addr0[3] ,
    \cubev_phi_addr0[2] ,
    \cubev_phi_addr0[1] ,
    \cubev_phi_addr0[0] }),
    .cubev_phi_din0({\cubev_phi_din0[31] ,
    \cubev_phi_din0[30] ,
    \cubev_phi_din0[29] ,
    \cubev_phi_din0[28] ,
    \cubev_phi_din0[27] ,
    \cubev_phi_din0[26] ,
    \cubev_phi_din0[25] ,
    \cubev_phi_din0[24] ,
    \cubev_phi_din0[23] ,
    \cubev_phi_din0[22] ,
    \cubev_phi_din0[21] ,
    \cubev_phi_din0[20] ,
    \cubev_phi_din0[19] ,
    \cubev_phi_din0[18] ,
    \cubev_phi_din0[17] ,
    \cubev_phi_din0[16] ,
    \cubev_phi_din0[15] ,
    \cubev_phi_din0[14] ,
    \cubev_phi_din0[13] ,
    \cubev_phi_din0[12] ,
    \cubev_phi_din0[11] ,
    \cubev_phi_din0[10] ,
    \cubev_phi_din0[9] ,
    \cubev_phi_din0[8] ,
    \cubev_phi_din0[7] ,
    \cubev_phi_din0[6] ,
    \cubev_phi_din0[5] ,
    \cubev_phi_din0[4] ,
    \cubev_phi_din0[3] ,
    \cubev_phi_din0[2] ,
    \cubev_phi_din0[1] ,
    \cubev_phi_din0[0] }),
    .cubev_phi_dout0({\cubev_phi_dout0[31] ,
    \cubev_phi_dout0[30] ,
    \cubev_phi_dout0[29] ,
    \cubev_phi_dout0[28] ,
    \cubev_phi_dout0[27] ,
    \cubev_phi_dout0[26] ,
    \cubev_phi_dout0[25] ,
    \cubev_phi_dout0[24] ,
    \cubev_phi_dout0[23] ,
    \cubev_phi_dout0[22] ,
    \cubev_phi_dout0[21] ,
    \cubev_phi_dout0[20] ,
    \cubev_phi_dout0[19] ,
    \cubev_phi_dout0[18] ,
    \cubev_phi_dout0[17] ,
    \cubev_phi_dout0[16] ,
    \cubev_phi_dout0[15] ,
    \cubev_phi_dout0[14] ,
    \cubev_phi_dout0[13] ,
    \cubev_phi_dout0[12] ,
    \cubev_phi_dout0[11] ,
    \cubev_phi_dout0[10] ,
    \cubev_phi_dout0[9] ,
    \cubev_phi_dout0[8] ,
    \cubev_phi_dout0[7] ,
    \cubev_phi_dout0[6] ,
    \cubev_phi_dout0[5] ,
    \cubev_phi_dout0[4] ,
    \cubev_phi_dout0[3] ,
    \cubev_phi_dout0[2] ,
    \cubev_phi_dout0[1] ,
    \cubev_phi_dout0[0] }),
    .cubev_phi_wmask0({\cubev_phi_wmask0[3] ,
    \cubev_phi_wmask0[2] ,
    \cubev_phi_wmask0[1] ,
    \cubev_phi_wmask0[0] }),
    .cubev_pli_addr0({\cubev_pli_addr0[7] ,
    \cubev_pli_addr0[6] ,
    \cubev_pli_addr0[5] ,
    \cubev_pli_addr0[4] ,
    \cubev_pli_addr0[3] ,
    \cubev_pli_addr0[2] ,
    \cubev_pli_addr0[1] ,
    \cubev_pli_addr0[0] }),
    .cubev_pli_din0({\cubev_pli_din0[31] ,
    \cubev_pli_din0[30] ,
    \cubev_pli_din0[29] ,
    \cubev_pli_din0[28] ,
    \cubev_pli_din0[27] ,
    \cubev_pli_din0[26] ,
    \cubev_pli_din0[25] ,
    \cubev_pli_din0[24] ,
    \cubev_pli_din0[23] ,
    \cubev_pli_din0[22] ,
    \cubev_pli_din0[21] ,
    \cubev_pli_din0[20] ,
    \cubev_pli_din0[19] ,
    \cubev_pli_din0[18] ,
    \cubev_pli_din0[17] ,
    \cubev_pli_din0[16] ,
    \cubev_pli_din0[15] ,
    \cubev_pli_din0[14] ,
    \cubev_pli_din0[13] ,
    \cubev_pli_din0[12] ,
    \cubev_pli_din0[11] ,
    \cubev_pli_din0[10] ,
    \cubev_pli_din0[9] ,
    \cubev_pli_din0[8] ,
    \cubev_pli_din0[7] ,
    \cubev_pli_din0[6] ,
    \cubev_pli_din0[5] ,
    \cubev_pli_din0[4] ,
    \cubev_pli_din0[3] ,
    \cubev_pli_din0[2] ,
    \cubev_pli_din0[1] ,
    \cubev_pli_din0[0] }),
    .cubev_pli_dout0({\cubev_pli_dout0[31] ,
    \cubev_pli_dout0[30] ,
    \cubev_pli_dout0[29] ,
    \cubev_pli_dout0[28] ,
    \cubev_pli_dout0[27] ,
    \cubev_pli_dout0[26] ,
    \cubev_pli_dout0[25] ,
    \cubev_pli_dout0[24] ,
    \cubev_pli_dout0[23] ,
    \cubev_pli_dout0[22] ,
    \cubev_pli_dout0[21] ,
    \cubev_pli_dout0[20] ,
    \cubev_pli_dout0[19] ,
    \cubev_pli_dout0[18] ,
    \cubev_pli_dout0[17] ,
    \cubev_pli_dout0[16] ,
    \cubev_pli_dout0[15] ,
    \cubev_pli_dout0[14] ,
    \cubev_pli_dout0[13] ,
    \cubev_pli_dout0[12] ,
    \cubev_pli_dout0[11] ,
    \cubev_pli_dout0[10] ,
    \cubev_pli_dout0[9] ,
    \cubev_pli_dout0[8] ,
    \cubev_pli_dout0[7] ,
    \cubev_pli_dout0[6] ,
    \cubev_pli_dout0[5] ,
    \cubev_pli_dout0[4] ,
    \cubev_pli_dout0[3] ,
    \cubev_pli_dout0[2] ,
    \cubev_pli_dout0[1] ,
    \cubev_pli_dout0[0] }),
    .cubev_pli_wmask0({\cubev_pli_wmask0[3] ,
    \cubev_pli_wmask0[2] ,
    \cubev_pli_wmask0[1] ,
    \cubev_pli_wmask0[0] }),
    .irq({user_irq[2],
    user_irq[1],
    user_irq[0]}),
    .la_data_in({la_data_in[127],
    la_data_in[126],
    la_data_in[125],
    la_data_in[124],
    la_data_in[123],
    la_data_in[122],
    la_data_in[121],
    la_data_in[120],
    la_data_in[119],
    la_data_in[118],
    la_data_in[117],
    la_data_in[116],
    la_data_in[115],
    la_data_in[114],
    la_data_in[113],
    la_data_in[112],
    la_data_in[111],
    la_data_in[110],
    la_data_in[109],
    la_data_in[108],
    la_data_in[107],
    la_data_in[106],
    la_data_in[105],
    la_data_in[104],
    la_data_in[103],
    la_data_in[102],
    la_data_in[101],
    la_data_in[100],
    la_data_in[99],
    la_data_in[98],
    la_data_in[97],
    la_data_in[96],
    la_data_in[95],
    la_data_in[94],
    la_data_in[93],
    la_data_in[92],
    la_data_in[91],
    la_data_in[90],
    la_data_in[89],
    la_data_in[88],
    la_data_in[87],
    la_data_in[86],
    la_data_in[85],
    la_data_in[84],
    la_data_in[83],
    la_data_in[82],
    la_data_in[81],
    la_data_in[80],
    la_data_in[79],
    la_data_in[78],
    la_data_in[77],
    la_data_in[76],
    la_data_in[75],
    la_data_in[74],
    la_data_in[73],
    la_data_in[72],
    la_data_in[71],
    la_data_in[70],
    la_data_in[69],
    la_data_in[68],
    la_data_in[67],
    la_data_in[66],
    la_data_in[65],
    la_data_in[64],
    la_data_in[63],
    la_data_in[62],
    la_data_in[61],
    la_data_in[60],
    la_data_in[59],
    la_data_in[58],
    la_data_in[57],
    la_data_in[56],
    la_data_in[55],
    la_data_in[54],
    la_data_in[53],
    la_data_in[52],
    la_data_in[51],
    la_data_in[50],
    la_data_in[49],
    la_data_in[48],
    la_data_in[47],
    la_data_in[46],
    la_data_in[45],
    la_data_in[44],
    la_data_in[43],
    la_data_in[42],
    la_data_in[41],
    la_data_in[40],
    la_data_in[39],
    la_data_in[38],
    la_data_in[37],
    la_data_in[36],
    la_data_in[35],
    la_data_in[34],
    la_data_in[33],
    la_data_in[32],
    la_data_in[31],
    la_data_in[30],
    la_data_in[29],
    la_data_in[28],
    la_data_in[27],
    la_data_in[26],
    la_data_in[25],
    la_data_in[24],
    la_data_in[23],
    la_data_in[22],
    la_data_in[21],
    la_data_in[20],
    la_data_in[19],
    la_data_in[18],
    la_data_in[17],
    la_data_in[16],
    la_data_in[15],
    la_data_in[14],
    la_data_in[13],
    la_data_in[12],
    la_data_in[11],
    la_data_in[10],
    la_data_in[9],
    la_data_in[8],
    la_data_in[7],
    la_data_in[6],
    la_data_in[5],
    la_data_in[4],
    la_data_in[3],
    la_data_in[2],
    la_data_in[1],
    la_data_in[0]}),
    .la_data_out({la_data_out[127],
    la_data_out[126],
    la_data_out[125],
    la_data_out[124],
    la_data_out[123],
    la_data_out[122],
    la_data_out[121],
    la_data_out[120],
    la_data_out[119],
    la_data_out[118],
    la_data_out[117],
    la_data_out[116],
    la_data_out[115],
    la_data_out[114],
    la_data_out[113],
    la_data_out[112],
    la_data_out[111],
    la_data_out[110],
    la_data_out[109],
    la_data_out[108],
    la_data_out[107],
    la_data_out[106],
    la_data_out[105],
    la_data_out[104],
    la_data_out[103],
    la_data_out[102],
    la_data_out[101],
    la_data_out[100],
    la_data_out[99],
    la_data_out[98],
    la_data_out[97],
    la_data_out[96],
    la_data_out[95],
    la_data_out[94],
    la_data_out[93],
    la_data_out[92],
    la_data_out[91],
    la_data_out[90],
    la_data_out[89],
    la_data_out[88],
    la_data_out[87],
    la_data_out[86],
    la_data_out[85],
    la_data_out[84],
    la_data_out[83],
    la_data_out[82],
    la_data_out[81],
    la_data_out[80],
    la_data_out[79],
    la_data_out[78],
    la_data_out[77],
    la_data_out[76],
    la_data_out[75],
    la_data_out[74],
    la_data_out[73],
    la_data_out[72],
    la_data_out[71],
    la_data_out[70],
    la_data_out[69],
    la_data_out[68],
    la_data_out[67],
    la_data_out[66],
    la_data_out[65],
    la_data_out[64],
    la_data_out[63],
    la_data_out[62],
    la_data_out[61],
    la_data_out[60],
    la_data_out[59],
    la_data_out[58],
    la_data_out[57],
    la_data_out[56],
    la_data_out[55],
    la_data_out[54],
    la_data_out[53],
    la_data_out[52],
    la_data_out[51],
    la_data_out[50],
    la_data_out[49],
    la_data_out[48],
    la_data_out[47],
    la_data_out[46],
    la_data_out[45],
    la_data_out[44],
    la_data_out[43],
    la_data_out[42],
    la_data_out[41],
    la_data_out[40],
    la_data_out[39],
    la_data_out[38],
    la_data_out[37],
    la_data_out[36],
    la_data_out[35],
    la_data_out[34],
    la_data_out[33],
    la_data_out[32],
    la_data_out[31],
    la_data_out[30],
    la_data_out[29],
    la_data_out[28],
    la_data_out[27],
    la_data_out[26],
    la_data_out[25],
    la_data_out[24],
    la_data_out[23],
    la_data_out[22],
    la_data_out[21],
    la_data_out[20],
    la_data_out[19],
    la_data_out[18],
    la_data_out[17],
    la_data_out[16],
    la_data_out[15],
    la_data_out[14],
    la_data_out[13],
    la_data_out[12],
    la_data_out[11],
    la_data_out[10],
    la_data_out[9],
    la_data_out[8],
    la_data_out[7],
    la_data_out[6],
    la_data_out[5],
    la_data_out[4],
    la_data_out[3],
    la_data_out[2],
    la_data_out[1],
    la_data_out[0]}),
    .la_oenb({la_oenb[127],
    la_oenb[126],
    la_oenb[125],
    la_oenb[124],
    la_oenb[123],
    la_oenb[122],
    la_oenb[121],
    la_oenb[120],
    la_oenb[119],
    la_oenb[118],
    la_oenb[117],
    la_oenb[116],
    la_oenb[115],
    la_oenb[114],
    la_oenb[113],
    la_oenb[112],
    la_oenb[111],
    la_oenb[110],
    la_oenb[109],
    la_oenb[108],
    la_oenb[107],
    la_oenb[106],
    la_oenb[105],
    la_oenb[104],
    la_oenb[103],
    la_oenb[102],
    la_oenb[101],
    la_oenb[100],
    la_oenb[99],
    la_oenb[98],
    la_oenb[97],
    la_oenb[96],
    la_oenb[95],
    la_oenb[94],
    la_oenb[93],
    la_oenb[92],
    la_oenb[91],
    la_oenb[90],
    la_oenb[89],
    la_oenb[88],
    la_oenb[87],
    la_oenb[86],
    la_oenb[85],
    la_oenb[84],
    la_oenb[83],
    la_oenb[82],
    la_oenb[81],
    la_oenb[80],
    la_oenb[79],
    la_oenb[78],
    la_oenb[77],
    la_oenb[76],
    la_oenb[75],
    la_oenb[74],
    la_oenb[73],
    la_oenb[72],
    la_oenb[71],
    la_oenb[70],
    la_oenb[69],
    la_oenb[68],
    la_oenb[67],
    la_oenb[66],
    la_oenb[65],
    la_oenb[64],
    la_oenb[63],
    la_oenb[62],
    la_oenb[61],
    la_oenb[60],
    la_oenb[59],
    la_oenb[58],
    la_oenb[57],
    la_oenb[56],
    la_oenb[55],
    la_oenb[54],
    la_oenb[53],
    la_oenb[52],
    la_oenb[51],
    la_oenb[50],
    la_oenb[49],
    la_oenb[48],
    la_oenb[47],
    la_oenb[46],
    la_oenb[45],
    la_oenb[44],
    la_oenb[43],
    la_oenb[42],
    la_oenb[41],
    la_oenb[40],
    la_oenb[39],
    la_oenb[38],
    la_oenb[37],
    la_oenb[36],
    la_oenb[35],
    la_oenb[34],
    la_oenb[33],
    la_oenb[32],
    la_oenb[31],
    la_oenb[30],
    la_oenb[29],
    la_oenb[28],
    la_oenb[27],
    la_oenb[26],
    la_oenb[25],
    la_oenb[24],
    la_oenb[23],
    la_oenb[22],
    la_oenb[21],
    la_oenb[20],
    la_oenb[19],
    la_oenb[18],
    la_oenb[17],
    la_oenb[16],
    la_oenb[15],
    la_oenb[14],
    la_oenb[13],
    la_oenb[12],
    la_oenb[11],
    la_oenb[10],
    la_oenb[9],
    la_oenb[8],
    la_oenb[7],
    la_oenb[6],
    la_oenb[5],
    la_oenb[4],
    la_oenb[3],
    la_oenb[2],
    la_oenb[1],
    la_oenb[0]}),
    .wbs_adr_i({wbs_adr_i[31],
    wbs_adr_i[30],
    wbs_adr_i[29],
    wbs_adr_i[28],
    wbs_adr_i[27],
    wbs_adr_i[26],
    wbs_adr_i[25],
    wbs_adr_i[24],
    wbs_adr_i[23],
    wbs_adr_i[22],
    wbs_adr_i[21],
    wbs_adr_i[20],
    wbs_adr_i[19],
    wbs_adr_i[18],
    wbs_adr_i[17],
    wbs_adr_i[16],
    wbs_adr_i[15],
    wbs_adr_i[14],
    wbs_adr_i[13],
    wbs_adr_i[12],
    wbs_adr_i[11],
    wbs_adr_i[10],
    wbs_adr_i[9],
    wbs_adr_i[8],
    wbs_adr_i[7],
    wbs_adr_i[6],
    wbs_adr_i[5],
    wbs_adr_i[4],
    wbs_adr_i[3],
    wbs_adr_i[2],
    wbs_adr_i[1],
    wbs_adr_i[0]}),
    .wbs_dat_i({wbs_dat_i[31],
    wbs_dat_i[30],
    wbs_dat_i[29],
    wbs_dat_i[28],
    wbs_dat_i[27],
    wbs_dat_i[26],
    wbs_dat_i[25],
    wbs_dat_i[24],
    wbs_dat_i[23],
    wbs_dat_i[22],
    wbs_dat_i[21],
    wbs_dat_i[20],
    wbs_dat_i[19],
    wbs_dat_i[18],
    wbs_dat_i[17],
    wbs_dat_i[16],
    wbs_dat_i[15],
    wbs_dat_i[14],
    wbs_dat_i[13],
    wbs_dat_i[12],
    wbs_dat_i[11],
    wbs_dat_i[10],
    wbs_dat_i[9],
    wbs_dat_i[8],
    wbs_dat_i[7],
    wbs_dat_i[6],
    wbs_dat_i[5],
    wbs_dat_i[4],
    wbs_dat_i[3],
    wbs_dat_i[2],
    wbs_dat_i[1],
    wbs_dat_i[0]}),
    .wbs_dat_o({wbs_dat_o[31],
    wbs_dat_o[30],
    wbs_dat_o[29],
    wbs_dat_o[28],
    wbs_dat_o[27],
    wbs_dat_o[26],
    wbs_dat_o[25],
    wbs_dat_o[24],
    wbs_dat_o[23],
    wbs_dat_o[22],
    wbs_dat_o[21],
    wbs_dat_o[20],
    wbs_dat_o[19],
    wbs_dat_o[18],
    wbs_dat_o[17],
    wbs_dat_o[16],
    wbs_dat_o[15],
    wbs_dat_o[14],
    wbs_dat_o[13],
    wbs_dat_o[12],
    wbs_dat_o[11],
    wbs_dat_o[10],
    wbs_dat_o[9],
    wbs_dat_o[8],
    wbs_dat_o[7],
    wbs_dat_o[6],
    wbs_dat_o[5],
    wbs_dat_o[4],
    wbs_dat_o[3],
    wbs_dat_o[2],
    wbs_dat_o[1],
    wbs_dat_o[0]}),
    .wbs_sel_i({wbs_sel_i[3],
    wbs_sel_i[2],
    wbs_sel_i[1],
    wbs_sel_i[0]}));
 sky130_sram_1kbyte_1rw1r_32x256_8 cubev_cai (.csb0(cubev_ca_csb0),
    .csb1(cubev_ca_csb1),
    .web0(cubev_ca_web0),
    .clk0(cubev_ca_clk0),
    .clk1(cubev_ca_clk1),
    .addr0({\cubev_ca_addr0[7] ,
    \cubev_ca_addr0[6] ,
    \cubev_ca_addr0[5] ,
    \cubev_ca_addr0[4] ,
    \cubev_ca_addr0[3] ,
    \cubev_ca_addr0[2] ,
    \cubev_ca_addr0[1] ,
    \cubev_ca_addr0[0] }),
    .addr1({\cubev_ca_addr1[7] ,
    \cubev_ca_addr1[6] ,
    \cubev_ca_addr1[5] ,
    \cubev_ca_addr1[4] ,
    \cubev_ca_addr1[3] ,
    \cubev_ca_addr1[2] ,
    \cubev_ca_addr1[1] ,
    \cubev_ca_addr1[0] }),
    .din0({\cubev_ca_din0[31] ,
    \cubev_ca_din0[30] ,
    \cubev_ca_din0[29] ,
    \cubev_ca_din0[28] ,
    \cubev_ca_din0[27] ,
    \cubev_ca_din0[26] ,
    \cubev_ca_din0[25] ,
    \cubev_ca_din0[24] ,
    \cubev_ca_din0[23] ,
    \cubev_ca_din0[22] ,
    \cubev_ca_din0[21] ,
    \cubev_ca_din0[20] ,
    \cubev_ca_din0[19] ,
    \cubev_ca_din0[18] ,
    \cubev_ca_din0[17] ,
    \cubev_ca_din0[16] ,
    \cubev_ca_din0[15] ,
    \cubev_ca_din0[14] ,
    \cubev_ca_din0[13] ,
    \cubev_ca_din0[12] ,
    \cubev_ca_din0[11] ,
    \cubev_ca_din0[10] ,
    \cubev_ca_din0[9] ,
    \cubev_ca_din0[8] ,
    \cubev_ca_din0[7] ,
    \cubev_ca_din0[6] ,
    \cubev_ca_din0[5] ,
    \cubev_ca_din0[4] ,
    \cubev_ca_din0[3] ,
    \cubev_ca_din0[2] ,
    \cubev_ca_din0[1] ,
    \cubev_ca_din0[0] }),
    .dout0({\cubev_ca_dout0[31] ,
    \cubev_ca_dout0[30] ,
    \cubev_ca_dout0[29] ,
    \cubev_ca_dout0[28] ,
    \cubev_ca_dout0[27] ,
    \cubev_ca_dout0[26] ,
    \cubev_ca_dout0[25] ,
    \cubev_ca_dout0[24] ,
    \cubev_ca_dout0[23] ,
    \cubev_ca_dout0[22] ,
    \cubev_ca_dout0[21] ,
    \cubev_ca_dout0[20] ,
    \cubev_ca_dout0[19] ,
    \cubev_ca_dout0[18] ,
    \cubev_ca_dout0[17] ,
    \cubev_ca_dout0[16] ,
    \cubev_ca_dout0[15] ,
    \cubev_ca_dout0[14] ,
    \cubev_ca_dout0[13] ,
    \cubev_ca_dout0[12] ,
    \cubev_ca_dout0[11] ,
    \cubev_ca_dout0[10] ,
    \cubev_ca_dout0[9] ,
    \cubev_ca_dout0[8] ,
    \cubev_ca_dout0[7] ,
    \cubev_ca_dout0[6] ,
    \cubev_ca_dout0[5] ,
    \cubev_ca_dout0[4] ,
    \cubev_ca_dout0[3] ,
    \cubev_ca_dout0[2] ,
    \cubev_ca_dout0[1] ,
    \cubev_ca_dout0[0] }),
    .dout1({\cubev_ca_dout1[31] ,
    \cubev_ca_dout1[30] ,
    \cubev_ca_dout1[29] ,
    \cubev_ca_dout1[28] ,
    \cubev_ca_dout1[27] ,
    \cubev_ca_dout1[26] ,
    \cubev_ca_dout1[25] ,
    \cubev_ca_dout1[24] ,
    \cubev_ca_dout1[23] ,
    \cubev_ca_dout1[22] ,
    \cubev_ca_dout1[21] ,
    \cubev_ca_dout1[20] ,
    \cubev_ca_dout1[19] ,
    \cubev_ca_dout1[18] ,
    \cubev_ca_dout1[17] ,
    \cubev_ca_dout1[16] ,
    \cubev_ca_dout1[15] ,
    \cubev_ca_dout1[14] ,
    \cubev_ca_dout1[13] ,
    \cubev_ca_dout1[12] ,
    \cubev_ca_dout1[11] ,
    \cubev_ca_dout1[10] ,
    \cubev_ca_dout1[9] ,
    \cubev_ca_dout1[8] ,
    \cubev_ca_dout1[7] ,
    \cubev_ca_dout1[6] ,
    \cubev_ca_dout1[5] ,
    \cubev_ca_dout1[4] ,
    \cubev_ca_dout1[3] ,
    \cubev_ca_dout1[2] ,
    \cubev_ca_dout1[1] ,
    \cubev_ca_dout1[0] }),
    .wmask0({\cubev_ca_wmask0[3] ,
    \cubev_ca_wmask0[2] ,
    \cubev_ca_wmask0[1] ,
    \cubev_ca_wmask0[0] }));
 sky130_sram_1kbyte_1rw1r_32x256_8 cubev_dhi (.csb0(cubev_dhi_csb0),
    .csb1(cubev_dhi_csb1),
    .web0(cubev_dhi_web0),
    .clk0(cubev_dhi_clk0),
    .clk1(cubev_dhi_clk1),
    .addr0({\cubev_dhi_addr0[7] ,
    \cubev_dhi_addr0[6] ,
    \cubev_dhi_addr0[5] ,
    \cubev_dhi_addr0[4] ,
    \cubev_dhi_addr0[3] ,
    \cubev_dhi_addr0[2] ,
    \cubev_dhi_addr0[1] ,
    \cubev_dhi_addr0[0] }),
    .addr1({\cubev_dhi_addr1[7] ,
    \cubev_dhi_addr1[6] ,
    \cubev_dhi_addr1[5] ,
    \cubev_dhi_addr1[4] ,
    \cubev_dhi_addr1[3] ,
    \cubev_dhi_addr1[2] ,
    \cubev_dhi_addr1[1] ,
    \cubev_dhi_addr1[0] }),
    .din0({\cubev_dhi_din0[31] ,
    \cubev_dhi_din0[30] ,
    \cubev_dhi_din0[29] ,
    \cubev_dhi_din0[28] ,
    \cubev_dhi_din0[27] ,
    \cubev_dhi_din0[26] ,
    \cubev_dhi_din0[25] ,
    \cubev_dhi_din0[24] ,
    \cubev_dhi_din0[23] ,
    \cubev_dhi_din0[22] ,
    \cubev_dhi_din0[21] ,
    \cubev_dhi_din0[20] ,
    \cubev_dhi_din0[19] ,
    \cubev_dhi_din0[18] ,
    \cubev_dhi_din0[17] ,
    \cubev_dhi_din0[16] ,
    \cubev_dhi_din0[15] ,
    \cubev_dhi_din0[14] ,
    \cubev_dhi_din0[13] ,
    \cubev_dhi_din0[12] ,
    \cubev_dhi_din0[11] ,
    \cubev_dhi_din0[10] ,
    \cubev_dhi_din0[9] ,
    \cubev_dhi_din0[8] ,
    \cubev_dhi_din0[7] ,
    \cubev_dhi_din0[6] ,
    \cubev_dhi_din0[5] ,
    \cubev_dhi_din0[4] ,
    \cubev_dhi_din0[3] ,
    \cubev_dhi_din0[2] ,
    \cubev_dhi_din0[1] ,
    \cubev_dhi_din0[0] }),
    .dout0({\cubev_dhi_dout0[31] ,
    \cubev_dhi_dout0[30] ,
    \cubev_dhi_dout0[29] ,
    \cubev_dhi_dout0[28] ,
    \cubev_dhi_dout0[27] ,
    \cubev_dhi_dout0[26] ,
    \cubev_dhi_dout0[25] ,
    \cubev_dhi_dout0[24] ,
    \cubev_dhi_dout0[23] ,
    \cubev_dhi_dout0[22] ,
    \cubev_dhi_dout0[21] ,
    \cubev_dhi_dout0[20] ,
    \cubev_dhi_dout0[19] ,
    \cubev_dhi_dout0[18] ,
    \cubev_dhi_dout0[17] ,
    \cubev_dhi_dout0[16] ,
    \cubev_dhi_dout0[15] ,
    \cubev_dhi_dout0[14] ,
    \cubev_dhi_dout0[13] ,
    \cubev_dhi_dout0[12] ,
    \cubev_dhi_dout0[11] ,
    \cubev_dhi_dout0[10] ,
    \cubev_dhi_dout0[9] ,
    \cubev_dhi_dout0[8] ,
    \cubev_dhi_dout0[7] ,
    \cubev_dhi_dout0[6] ,
    \cubev_dhi_dout0[5] ,
    \cubev_dhi_dout0[4] ,
    \cubev_dhi_dout0[3] ,
    \cubev_dhi_dout0[2] ,
    \cubev_dhi_dout0[1] ,
    \cubev_dhi_dout0[0] }),
    .dout1({\cubev_dhi_dout1[31] ,
    \cubev_dhi_dout1[30] ,
    \cubev_dhi_dout1[29] ,
    \cubev_dhi_dout1[28] ,
    \cubev_dhi_dout1[27] ,
    \cubev_dhi_dout1[26] ,
    \cubev_dhi_dout1[25] ,
    \cubev_dhi_dout1[24] ,
    \cubev_dhi_dout1[23] ,
    \cubev_dhi_dout1[22] ,
    \cubev_dhi_dout1[21] ,
    \cubev_dhi_dout1[20] ,
    \cubev_dhi_dout1[19] ,
    \cubev_dhi_dout1[18] ,
    \cubev_dhi_dout1[17] ,
    \cubev_dhi_dout1[16] ,
    \cubev_dhi_dout1[15] ,
    \cubev_dhi_dout1[14] ,
    \cubev_dhi_dout1[13] ,
    \cubev_dhi_dout1[12] ,
    \cubev_dhi_dout1[11] ,
    \cubev_dhi_dout1[10] ,
    \cubev_dhi_dout1[9] ,
    \cubev_dhi_dout1[8] ,
    \cubev_dhi_dout1[7] ,
    \cubev_dhi_dout1[6] ,
    \cubev_dhi_dout1[5] ,
    \cubev_dhi_dout1[4] ,
    \cubev_dhi_dout1[3] ,
    \cubev_dhi_dout1[2] ,
    \cubev_dhi_dout1[1] ,
    \cubev_dhi_dout1[0] }),
    .wmask0({\cubev_dhi_wmask0[3] ,
    \cubev_dhi_wmask0[2] ,
    \cubev_dhi_wmask0[1] ,
    \cubev_dhi_wmask0[0] }));
 rb cubev_dhi_rb (.clk(cubev_dhi_clk1),
    .rstn(cubev_dhi_rstn),
    .dati({\cubev_dhi_dout1[31] ,
    \cubev_dhi_dout1[30] ,
    \cubev_dhi_dout1[29] ,
    \cubev_dhi_dout1[28] ,
    \cubev_dhi_dout1[27] ,
    \cubev_dhi_dout1[26] ,
    \cubev_dhi_dout1[25] ,
    \cubev_dhi_dout1[24] ,
    \cubev_dhi_dout1[23] ,
    \cubev_dhi_dout1[22] ,
    \cubev_dhi_dout1[21] ,
    \cubev_dhi_dout1[20] ,
    \cubev_dhi_dout1[19] ,
    \cubev_dhi_dout1[18] ,
    \cubev_dhi_dout1[17] ,
    \cubev_dhi_dout1[16] ,
    \cubev_dhi_dout1[15] ,
    \cubev_dhi_dout1[14] ,
    \cubev_dhi_dout1[13] ,
    \cubev_dhi_dout1[12] ,
    \cubev_dhi_dout1[11] ,
    \cubev_dhi_dout1[10] ,
    \cubev_dhi_dout1[9] ,
    \cubev_dhi_dout1[8] ,
    \cubev_dhi_dout1[7] ,
    \cubev_dhi_dout1[6] ,
    \cubev_dhi_dout1[5] ,
    \cubev_dhi_dout1[4] ,
    \cubev_dhi_dout1[3] ,
    \cubev_dhi_dout1[2] ,
    \cubev_dhi_dout1[1] ,
    \cubev_dhi_dout1[0] }),
    .dato({\cubev_dhi_dout1_reg[31] ,
    \cubev_dhi_dout1_reg[30] ,
    \cubev_dhi_dout1_reg[29] ,
    \cubev_dhi_dout1_reg[28] ,
    \cubev_dhi_dout1_reg[27] ,
    \cubev_dhi_dout1_reg[26] ,
    \cubev_dhi_dout1_reg[25] ,
    \cubev_dhi_dout1_reg[24] ,
    \cubev_dhi_dout1_reg[23] ,
    \cubev_dhi_dout1_reg[22] ,
    \cubev_dhi_dout1_reg[21] ,
    \cubev_dhi_dout1_reg[20] ,
    \cubev_dhi_dout1_reg[19] ,
    \cubev_dhi_dout1_reg[18] ,
    \cubev_dhi_dout1_reg[17] ,
    \cubev_dhi_dout1_reg[16] ,
    \cubev_dhi_dout1_reg[15] ,
    \cubev_dhi_dout1_reg[14] ,
    \cubev_dhi_dout1_reg[13] ,
    \cubev_dhi_dout1_reg[12] ,
    \cubev_dhi_dout1_reg[11] ,
    \cubev_dhi_dout1_reg[10] ,
    \cubev_dhi_dout1_reg[9] ,
    \cubev_dhi_dout1_reg[8] ,
    \cubev_dhi_dout1_reg[7] ,
    \cubev_dhi_dout1_reg[6] ,
    \cubev_dhi_dout1_reg[5] ,
    \cubev_dhi_dout1_reg[4] ,
    \cubev_dhi_dout1_reg[3] ,
    \cubev_dhi_dout1_reg[2] ,
    \cubev_dhi_dout1_reg[1] ,
    \cubev_dhi_dout1_reg[0] }));
 sky130_sram_1kbyte_1rw1r_32x256_8 cubev_dli (.csb0(cubev_dli_csb0),
    .csb1(cubev_dli_csb1),
    .web0(cubev_dli_web0),
    .clk0(cubev_dli_clk0),
    .clk1(cubev_dli_clk1),
    .addr0({\cubev_dli_addr0[7] ,
    \cubev_dli_addr0[6] ,
    \cubev_dli_addr0[5] ,
    \cubev_dli_addr0[4] ,
    \cubev_dli_addr0[3] ,
    \cubev_dli_addr0[2] ,
    \cubev_dli_addr0[1] ,
    \cubev_dli_addr0[0] }),
    .addr1({\cubev_dli_addr1[7] ,
    \cubev_dli_addr1[6] ,
    \cubev_dli_addr1[5] ,
    \cubev_dli_addr1[4] ,
    \cubev_dli_addr1[3] ,
    \cubev_dli_addr1[2] ,
    \cubev_dli_addr1[1] ,
    \cubev_dli_addr1[0] }),
    .din0({\cubev_dli_din0[31] ,
    \cubev_dli_din0[30] ,
    \cubev_dli_din0[29] ,
    \cubev_dli_din0[28] ,
    \cubev_dli_din0[27] ,
    \cubev_dli_din0[26] ,
    \cubev_dli_din0[25] ,
    \cubev_dli_din0[24] ,
    \cubev_dli_din0[23] ,
    \cubev_dli_din0[22] ,
    \cubev_dli_din0[21] ,
    \cubev_dli_din0[20] ,
    \cubev_dli_din0[19] ,
    \cubev_dli_din0[18] ,
    \cubev_dli_din0[17] ,
    \cubev_dli_din0[16] ,
    \cubev_dli_din0[15] ,
    \cubev_dli_din0[14] ,
    \cubev_dli_din0[13] ,
    \cubev_dli_din0[12] ,
    \cubev_dli_din0[11] ,
    \cubev_dli_din0[10] ,
    \cubev_dli_din0[9] ,
    \cubev_dli_din0[8] ,
    \cubev_dli_din0[7] ,
    \cubev_dli_din0[6] ,
    \cubev_dli_din0[5] ,
    \cubev_dli_din0[4] ,
    \cubev_dli_din0[3] ,
    \cubev_dli_din0[2] ,
    \cubev_dli_din0[1] ,
    \cubev_dli_din0[0] }),
    .dout0({\cubev_dli_dout0[31] ,
    \cubev_dli_dout0[30] ,
    \cubev_dli_dout0[29] ,
    \cubev_dli_dout0[28] ,
    \cubev_dli_dout0[27] ,
    \cubev_dli_dout0[26] ,
    \cubev_dli_dout0[25] ,
    \cubev_dli_dout0[24] ,
    \cubev_dli_dout0[23] ,
    \cubev_dli_dout0[22] ,
    \cubev_dli_dout0[21] ,
    \cubev_dli_dout0[20] ,
    \cubev_dli_dout0[19] ,
    \cubev_dli_dout0[18] ,
    \cubev_dli_dout0[17] ,
    \cubev_dli_dout0[16] ,
    \cubev_dli_dout0[15] ,
    \cubev_dli_dout0[14] ,
    \cubev_dli_dout0[13] ,
    \cubev_dli_dout0[12] ,
    \cubev_dli_dout0[11] ,
    \cubev_dli_dout0[10] ,
    \cubev_dli_dout0[9] ,
    \cubev_dli_dout0[8] ,
    \cubev_dli_dout0[7] ,
    \cubev_dli_dout0[6] ,
    \cubev_dli_dout0[5] ,
    \cubev_dli_dout0[4] ,
    \cubev_dli_dout0[3] ,
    \cubev_dli_dout0[2] ,
    \cubev_dli_dout0[1] ,
    \cubev_dli_dout0[0] }),
    .dout1({\cubev_dli_dout1[31] ,
    \cubev_dli_dout1[30] ,
    \cubev_dli_dout1[29] ,
    \cubev_dli_dout1[28] ,
    \cubev_dli_dout1[27] ,
    \cubev_dli_dout1[26] ,
    \cubev_dli_dout1[25] ,
    \cubev_dli_dout1[24] ,
    \cubev_dli_dout1[23] ,
    \cubev_dli_dout1[22] ,
    \cubev_dli_dout1[21] ,
    \cubev_dli_dout1[20] ,
    \cubev_dli_dout1[19] ,
    \cubev_dli_dout1[18] ,
    \cubev_dli_dout1[17] ,
    \cubev_dli_dout1[16] ,
    \cubev_dli_dout1[15] ,
    \cubev_dli_dout1[14] ,
    \cubev_dli_dout1[13] ,
    \cubev_dli_dout1[12] ,
    \cubev_dli_dout1[11] ,
    \cubev_dli_dout1[10] ,
    \cubev_dli_dout1[9] ,
    \cubev_dli_dout1[8] ,
    \cubev_dli_dout1[7] ,
    \cubev_dli_dout1[6] ,
    \cubev_dli_dout1[5] ,
    \cubev_dli_dout1[4] ,
    \cubev_dli_dout1[3] ,
    \cubev_dli_dout1[2] ,
    \cubev_dli_dout1[1] ,
    \cubev_dli_dout1[0] }),
    .wmask0({\cubev_dli_wmask0[3] ,
    \cubev_dli_wmask0[2] ,
    \cubev_dli_wmask0[1] ,
    \cubev_dli_wmask0[0] }));
 rb cubev_dli_rb (.clk(cubev_dli_clk1),
    .rstn(cubev_dli_rstn),
    .dati({\cubev_dli_dout1[31] ,
    \cubev_dli_dout1[30] ,
    \cubev_dli_dout1[29] ,
    \cubev_dli_dout1[28] ,
    \cubev_dli_dout1[27] ,
    \cubev_dli_dout1[26] ,
    \cubev_dli_dout1[25] ,
    \cubev_dli_dout1[24] ,
    \cubev_dli_dout1[23] ,
    \cubev_dli_dout1[22] ,
    \cubev_dli_dout1[21] ,
    \cubev_dli_dout1[20] ,
    \cubev_dli_dout1[19] ,
    \cubev_dli_dout1[18] ,
    \cubev_dli_dout1[17] ,
    \cubev_dli_dout1[16] ,
    \cubev_dli_dout1[15] ,
    \cubev_dli_dout1[14] ,
    \cubev_dli_dout1[13] ,
    \cubev_dli_dout1[12] ,
    \cubev_dli_dout1[11] ,
    \cubev_dli_dout1[10] ,
    \cubev_dli_dout1[9] ,
    \cubev_dli_dout1[8] ,
    \cubev_dli_dout1[7] ,
    \cubev_dli_dout1[6] ,
    \cubev_dli_dout1[5] ,
    \cubev_dli_dout1[4] ,
    \cubev_dli_dout1[3] ,
    \cubev_dli_dout1[2] ,
    \cubev_dli_dout1[1] ,
    \cubev_dli_dout1[0] }),
    .dato({\cubev_dli_dout1_reg[31] ,
    \cubev_dli_dout1_reg[30] ,
    \cubev_dli_dout1_reg[29] ,
    \cubev_dli_dout1_reg[28] ,
    \cubev_dli_dout1_reg[27] ,
    \cubev_dli_dout1_reg[26] ,
    \cubev_dli_dout1_reg[25] ,
    \cubev_dli_dout1_reg[24] ,
    \cubev_dli_dout1_reg[23] ,
    \cubev_dli_dout1_reg[22] ,
    \cubev_dli_dout1_reg[21] ,
    \cubev_dli_dout1_reg[20] ,
    \cubev_dli_dout1_reg[19] ,
    \cubev_dli_dout1_reg[18] ,
    \cubev_dli_dout1_reg[17] ,
    \cubev_dli_dout1_reg[16] ,
    \cubev_dli_dout1_reg[15] ,
    \cubev_dli_dout1_reg[14] ,
    \cubev_dli_dout1_reg[13] ,
    \cubev_dli_dout1_reg[12] ,
    \cubev_dli_dout1_reg[11] ,
    \cubev_dli_dout1_reg[10] ,
    \cubev_dli_dout1_reg[9] ,
    \cubev_dli_dout1_reg[8] ,
    \cubev_dli_dout1_reg[7] ,
    \cubev_dli_dout1_reg[6] ,
    \cubev_dli_dout1_reg[5] ,
    \cubev_dli_dout1_reg[4] ,
    \cubev_dli_dout1_reg[3] ,
    \cubev_dli_dout1_reg[2] ,
    \cubev_dli_dout1_reg[1] ,
    \cubev_dli_dout1_reg[0] }));
 sky130_sram_1kbyte_1rw1r_32x256_8 cubev_phi (.csb0(cubev_phi_csb0),
    .csb1(cubev_phi_csb1),
    .web0(cubev_phi_web0),
    .clk0(cubev_phi_clk0),
    .clk1(cubev_phi_clk1),
    .addr0({\cubev_phi_addr0[7] ,
    \cubev_phi_addr0[6] ,
    \cubev_phi_addr0[5] ,
    \cubev_phi_addr0[4] ,
    \cubev_phi_addr0[3] ,
    \cubev_phi_addr0[2] ,
    \cubev_phi_addr0[1] ,
    \cubev_phi_addr0[0] }),
    .addr1({\cubev_phi_addr1[7] ,
    \cubev_phi_addr1[6] ,
    \cubev_phi_addr1[5] ,
    \cubev_phi_addr1[4] ,
    \cubev_phi_addr1[3] ,
    \cubev_phi_addr1[2] ,
    \cubev_phi_addr1[1] ,
    \cubev_phi_addr1[0] }),
    .din0({\cubev_phi_din0[31] ,
    \cubev_phi_din0[30] ,
    \cubev_phi_din0[29] ,
    \cubev_phi_din0[28] ,
    \cubev_phi_din0[27] ,
    \cubev_phi_din0[26] ,
    \cubev_phi_din0[25] ,
    \cubev_phi_din0[24] ,
    \cubev_phi_din0[23] ,
    \cubev_phi_din0[22] ,
    \cubev_phi_din0[21] ,
    \cubev_phi_din0[20] ,
    \cubev_phi_din0[19] ,
    \cubev_phi_din0[18] ,
    \cubev_phi_din0[17] ,
    \cubev_phi_din0[16] ,
    \cubev_phi_din0[15] ,
    \cubev_phi_din0[14] ,
    \cubev_phi_din0[13] ,
    \cubev_phi_din0[12] ,
    \cubev_phi_din0[11] ,
    \cubev_phi_din0[10] ,
    \cubev_phi_din0[9] ,
    \cubev_phi_din0[8] ,
    \cubev_phi_din0[7] ,
    \cubev_phi_din0[6] ,
    \cubev_phi_din0[5] ,
    \cubev_phi_din0[4] ,
    \cubev_phi_din0[3] ,
    \cubev_phi_din0[2] ,
    \cubev_phi_din0[1] ,
    \cubev_phi_din0[0] }),
    .dout0({\cubev_phi_dout0[31] ,
    \cubev_phi_dout0[30] ,
    \cubev_phi_dout0[29] ,
    \cubev_phi_dout0[28] ,
    \cubev_phi_dout0[27] ,
    \cubev_phi_dout0[26] ,
    \cubev_phi_dout0[25] ,
    \cubev_phi_dout0[24] ,
    \cubev_phi_dout0[23] ,
    \cubev_phi_dout0[22] ,
    \cubev_phi_dout0[21] ,
    \cubev_phi_dout0[20] ,
    \cubev_phi_dout0[19] ,
    \cubev_phi_dout0[18] ,
    \cubev_phi_dout0[17] ,
    \cubev_phi_dout0[16] ,
    \cubev_phi_dout0[15] ,
    \cubev_phi_dout0[14] ,
    \cubev_phi_dout0[13] ,
    \cubev_phi_dout0[12] ,
    \cubev_phi_dout0[11] ,
    \cubev_phi_dout0[10] ,
    \cubev_phi_dout0[9] ,
    \cubev_phi_dout0[8] ,
    \cubev_phi_dout0[7] ,
    \cubev_phi_dout0[6] ,
    \cubev_phi_dout0[5] ,
    \cubev_phi_dout0[4] ,
    \cubev_phi_dout0[3] ,
    \cubev_phi_dout0[2] ,
    \cubev_phi_dout0[1] ,
    \cubev_phi_dout0[0] }),
    .dout1({\cubev_phi_dout1[31] ,
    \cubev_phi_dout1[30] ,
    \cubev_phi_dout1[29] ,
    \cubev_phi_dout1[28] ,
    \cubev_phi_dout1[27] ,
    \cubev_phi_dout1[26] ,
    \cubev_phi_dout1[25] ,
    \cubev_phi_dout1[24] ,
    \cubev_phi_dout1[23] ,
    \cubev_phi_dout1[22] ,
    \cubev_phi_dout1[21] ,
    \cubev_phi_dout1[20] ,
    \cubev_phi_dout1[19] ,
    \cubev_phi_dout1[18] ,
    \cubev_phi_dout1[17] ,
    \cubev_phi_dout1[16] ,
    \cubev_phi_dout1[15] ,
    \cubev_phi_dout1[14] ,
    \cubev_phi_dout1[13] ,
    \cubev_phi_dout1[12] ,
    \cubev_phi_dout1[11] ,
    \cubev_phi_dout1[10] ,
    \cubev_phi_dout1[9] ,
    \cubev_phi_dout1[8] ,
    \cubev_phi_dout1[7] ,
    \cubev_phi_dout1[6] ,
    \cubev_phi_dout1[5] ,
    \cubev_phi_dout1[4] ,
    \cubev_phi_dout1[3] ,
    \cubev_phi_dout1[2] ,
    \cubev_phi_dout1[1] ,
    \cubev_phi_dout1[0] }),
    .wmask0({\cubev_phi_wmask0[3] ,
    \cubev_phi_wmask0[2] ,
    \cubev_phi_wmask0[1] ,
    \cubev_phi_wmask0[0] }));
 rb cubev_phi_rb (.clk(cubev_phi_clk1),
    .rstn(cubev_phi_rstn),
    .dati({\cubev_phi_dout1[31] ,
    \cubev_phi_dout1[30] ,
    \cubev_phi_dout1[29] ,
    \cubev_phi_dout1[28] ,
    \cubev_phi_dout1[27] ,
    \cubev_phi_dout1[26] ,
    \cubev_phi_dout1[25] ,
    \cubev_phi_dout1[24] ,
    \cubev_phi_dout1[23] ,
    \cubev_phi_dout1[22] ,
    \cubev_phi_dout1[21] ,
    \cubev_phi_dout1[20] ,
    \cubev_phi_dout1[19] ,
    \cubev_phi_dout1[18] ,
    \cubev_phi_dout1[17] ,
    \cubev_phi_dout1[16] ,
    \cubev_phi_dout1[15] ,
    \cubev_phi_dout1[14] ,
    \cubev_phi_dout1[13] ,
    \cubev_phi_dout1[12] ,
    \cubev_phi_dout1[11] ,
    \cubev_phi_dout1[10] ,
    \cubev_phi_dout1[9] ,
    \cubev_phi_dout1[8] ,
    \cubev_phi_dout1[7] ,
    \cubev_phi_dout1[6] ,
    \cubev_phi_dout1[5] ,
    \cubev_phi_dout1[4] ,
    \cubev_phi_dout1[3] ,
    \cubev_phi_dout1[2] ,
    \cubev_phi_dout1[1] ,
    \cubev_phi_dout1[0] }),
    .dato({\cubev_phi_dout1_reg[31] ,
    \cubev_phi_dout1_reg[30] ,
    \cubev_phi_dout1_reg[29] ,
    \cubev_phi_dout1_reg[28] ,
    \cubev_phi_dout1_reg[27] ,
    \cubev_phi_dout1_reg[26] ,
    \cubev_phi_dout1_reg[25] ,
    \cubev_phi_dout1_reg[24] ,
    \cubev_phi_dout1_reg[23] ,
    \cubev_phi_dout1_reg[22] ,
    \cubev_phi_dout1_reg[21] ,
    \cubev_phi_dout1_reg[20] ,
    \cubev_phi_dout1_reg[19] ,
    \cubev_phi_dout1_reg[18] ,
    \cubev_phi_dout1_reg[17] ,
    \cubev_phi_dout1_reg[16] ,
    \cubev_phi_dout1_reg[15] ,
    \cubev_phi_dout1_reg[14] ,
    \cubev_phi_dout1_reg[13] ,
    \cubev_phi_dout1_reg[12] ,
    \cubev_phi_dout1_reg[11] ,
    \cubev_phi_dout1_reg[10] ,
    \cubev_phi_dout1_reg[9] ,
    \cubev_phi_dout1_reg[8] ,
    \cubev_phi_dout1_reg[7] ,
    \cubev_phi_dout1_reg[6] ,
    \cubev_phi_dout1_reg[5] ,
    \cubev_phi_dout1_reg[4] ,
    \cubev_phi_dout1_reg[3] ,
    \cubev_phi_dout1_reg[2] ,
    \cubev_phi_dout1_reg[1] ,
    \cubev_phi_dout1_reg[0] }));
 sky130_sram_1kbyte_1rw1r_32x256_8 cubev_pli (.csb0(cubev_pli_csb0),
    .csb1(cubev_pli_csb1),
    .web0(cubev_pli_web0),
    .clk0(cubev_pli_clk0),
    .clk1(cubev_pli_clk1),
    .addr0({\cubev_pli_addr0[7] ,
    \cubev_pli_addr0[6] ,
    \cubev_pli_addr0[5] ,
    \cubev_pli_addr0[4] ,
    \cubev_pli_addr0[3] ,
    \cubev_pli_addr0[2] ,
    \cubev_pli_addr0[1] ,
    \cubev_pli_addr0[0] }),
    .addr1({\cubev_pli_addr1[7] ,
    \cubev_pli_addr1[6] ,
    \cubev_pli_addr1[5] ,
    \cubev_pli_addr1[4] ,
    \cubev_pli_addr1[3] ,
    \cubev_pli_addr1[2] ,
    \cubev_pli_addr1[1] ,
    \cubev_pli_addr1[0] }),
    .din0({\cubev_pli_din0[31] ,
    \cubev_pli_din0[30] ,
    \cubev_pli_din0[29] ,
    \cubev_pli_din0[28] ,
    \cubev_pli_din0[27] ,
    \cubev_pli_din0[26] ,
    \cubev_pli_din0[25] ,
    \cubev_pli_din0[24] ,
    \cubev_pli_din0[23] ,
    \cubev_pli_din0[22] ,
    \cubev_pli_din0[21] ,
    \cubev_pli_din0[20] ,
    \cubev_pli_din0[19] ,
    \cubev_pli_din0[18] ,
    \cubev_pli_din0[17] ,
    \cubev_pli_din0[16] ,
    \cubev_pli_din0[15] ,
    \cubev_pli_din0[14] ,
    \cubev_pli_din0[13] ,
    \cubev_pli_din0[12] ,
    \cubev_pli_din0[11] ,
    \cubev_pli_din0[10] ,
    \cubev_pli_din0[9] ,
    \cubev_pli_din0[8] ,
    \cubev_pli_din0[7] ,
    \cubev_pli_din0[6] ,
    \cubev_pli_din0[5] ,
    \cubev_pli_din0[4] ,
    \cubev_pli_din0[3] ,
    \cubev_pli_din0[2] ,
    \cubev_pli_din0[1] ,
    \cubev_pli_din0[0] }),
    .dout0({\cubev_pli_dout0[31] ,
    \cubev_pli_dout0[30] ,
    \cubev_pli_dout0[29] ,
    \cubev_pli_dout0[28] ,
    \cubev_pli_dout0[27] ,
    \cubev_pli_dout0[26] ,
    \cubev_pli_dout0[25] ,
    \cubev_pli_dout0[24] ,
    \cubev_pli_dout0[23] ,
    \cubev_pli_dout0[22] ,
    \cubev_pli_dout0[21] ,
    \cubev_pli_dout0[20] ,
    \cubev_pli_dout0[19] ,
    \cubev_pli_dout0[18] ,
    \cubev_pli_dout0[17] ,
    \cubev_pli_dout0[16] ,
    \cubev_pli_dout0[15] ,
    \cubev_pli_dout0[14] ,
    \cubev_pli_dout0[13] ,
    \cubev_pli_dout0[12] ,
    \cubev_pli_dout0[11] ,
    \cubev_pli_dout0[10] ,
    \cubev_pli_dout0[9] ,
    \cubev_pli_dout0[8] ,
    \cubev_pli_dout0[7] ,
    \cubev_pli_dout0[6] ,
    \cubev_pli_dout0[5] ,
    \cubev_pli_dout0[4] ,
    \cubev_pli_dout0[3] ,
    \cubev_pli_dout0[2] ,
    \cubev_pli_dout0[1] ,
    \cubev_pli_dout0[0] }),
    .dout1({\cubev_pli_dout1[31] ,
    \cubev_pli_dout1[30] ,
    \cubev_pli_dout1[29] ,
    \cubev_pli_dout1[28] ,
    \cubev_pli_dout1[27] ,
    \cubev_pli_dout1[26] ,
    \cubev_pli_dout1[25] ,
    \cubev_pli_dout1[24] ,
    \cubev_pli_dout1[23] ,
    \cubev_pli_dout1[22] ,
    \cubev_pli_dout1[21] ,
    \cubev_pli_dout1[20] ,
    \cubev_pli_dout1[19] ,
    \cubev_pli_dout1[18] ,
    \cubev_pli_dout1[17] ,
    \cubev_pli_dout1[16] ,
    \cubev_pli_dout1[15] ,
    \cubev_pli_dout1[14] ,
    \cubev_pli_dout1[13] ,
    \cubev_pli_dout1[12] ,
    \cubev_pli_dout1[11] ,
    \cubev_pli_dout1[10] ,
    \cubev_pli_dout1[9] ,
    \cubev_pli_dout1[8] ,
    \cubev_pli_dout1[7] ,
    \cubev_pli_dout1[6] ,
    \cubev_pli_dout1[5] ,
    \cubev_pli_dout1[4] ,
    \cubev_pli_dout1[3] ,
    \cubev_pli_dout1[2] ,
    \cubev_pli_dout1[1] ,
    \cubev_pli_dout1[0] }),
    .wmask0({\cubev_pli_wmask0[3] ,
    \cubev_pli_wmask0[2] ,
    \cubev_pli_wmask0[1] ,
    \cubev_pli_wmask0[0] }));
 rb cubev_pli_rb (.clk(cubev_pli_clk1),
    .rstn(cubev_pli_rstn),
    .dati({\cubev_pli_dout1[31] ,
    \cubev_pli_dout1[30] ,
    \cubev_pli_dout1[29] ,
    \cubev_pli_dout1[28] ,
    \cubev_pli_dout1[27] ,
    \cubev_pli_dout1[26] ,
    \cubev_pli_dout1[25] ,
    \cubev_pli_dout1[24] ,
    \cubev_pli_dout1[23] ,
    \cubev_pli_dout1[22] ,
    \cubev_pli_dout1[21] ,
    \cubev_pli_dout1[20] ,
    \cubev_pli_dout1[19] ,
    \cubev_pli_dout1[18] ,
    \cubev_pli_dout1[17] ,
    \cubev_pli_dout1[16] ,
    \cubev_pli_dout1[15] ,
    \cubev_pli_dout1[14] ,
    \cubev_pli_dout1[13] ,
    \cubev_pli_dout1[12] ,
    \cubev_pli_dout1[11] ,
    \cubev_pli_dout1[10] ,
    \cubev_pli_dout1[9] ,
    \cubev_pli_dout1[8] ,
    \cubev_pli_dout1[7] ,
    \cubev_pli_dout1[6] ,
    \cubev_pli_dout1[5] ,
    \cubev_pli_dout1[4] ,
    \cubev_pli_dout1[3] ,
    \cubev_pli_dout1[2] ,
    \cubev_pli_dout1[1] ,
    \cubev_pli_dout1[0] }),
    .dato({\cubev_pli_dout1_reg[31] ,
    \cubev_pli_dout1_reg[30] ,
    \cubev_pli_dout1_reg[29] ,
    \cubev_pli_dout1_reg[28] ,
    \cubev_pli_dout1_reg[27] ,
    \cubev_pli_dout1_reg[26] ,
    \cubev_pli_dout1_reg[25] ,
    \cubev_pli_dout1_reg[24] ,
    \cubev_pli_dout1_reg[23] ,
    \cubev_pli_dout1_reg[22] ,
    \cubev_pli_dout1_reg[21] ,
    \cubev_pli_dout1_reg[20] ,
    \cubev_pli_dout1_reg[19] ,
    \cubev_pli_dout1_reg[18] ,
    \cubev_pli_dout1_reg[17] ,
    \cubev_pli_dout1_reg[16] ,
    \cubev_pli_dout1_reg[15] ,
    \cubev_pli_dout1_reg[14] ,
    \cubev_pli_dout1_reg[13] ,
    \cubev_pli_dout1_reg[12] ,
    \cubev_pli_dout1_reg[11] ,
    \cubev_pli_dout1_reg[10] ,
    \cubev_pli_dout1_reg[9] ,
    \cubev_pli_dout1_reg[8] ,
    \cubev_pli_dout1_reg[7] ,
    \cubev_pli_dout1_reg[6] ,
    \cubev_pli_dout1_reg[5] ,
    \cubev_pli_dout1_reg[4] ,
    \cubev_pli_dout1_reg[3] ,
    \cubev_pli_dout1_reg[2] ,
    \cubev_pli_dout1_reg[1] ,
    \cubev_pli_dout1_reg[0] }));
 sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_0 (.csb0(cubev_reg_0_csb0),
    .csb1(cubev_reg_0_csb1),
    .web0(cubev_reg_0_web0),
    .clk0(cubev_reg_0_clk0),
    .clk1(cubev_reg_0_clk1),
    .addr0({\cubev_reg_0_addr0[7] ,
    \cubev_reg_0_addr0[6] ,
    \cubev_reg_0_addr0[5] ,
    \cubev_reg_0_addr0[4] ,
    \cubev_reg_0_addr0[3] ,
    \cubev_reg_0_addr0[2] ,
    \cubev_reg_0_addr0[1] ,
    \cubev_reg_0_addr0[0] }),
    .addr1({\cubev_reg_0_addr1[7] ,
    \cubev_reg_0_addr1[6] ,
    \cubev_reg_0_addr1[5] ,
    \cubev_reg_0_addr1[4] ,
    \cubev_reg_0_addr1[3] ,
    \cubev_reg_0_addr1[2] ,
    \cubev_reg_0_addr1[1] ,
    \cubev_reg_0_addr1[0] }),
    .din0({\cubev_reg_0_din0[31] ,
    \cubev_reg_0_din0[30] ,
    \cubev_reg_0_din0[29] ,
    \cubev_reg_0_din0[28] ,
    \cubev_reg_0_din0[27] ,
    \cubev_reg_0_din0[26] ,
    \cubev_reg_0_din0[25] ,
    \cubev_reg_0_din0[24] ,
    \cubev_reg_0_din0[23] ,
    \cubev_reg_0_din0[22] ,
    \cubev_reg_0_din0[21] ,
    \cubev_reg_0_din0[20] ,
    \cubev_reg_0_din0[19] ,
    \cubev_reg_0_din0[18] ,
    \cubev_reg_0_din0[17] ,
    \cubev_reg_0_din0[16] ,
    \cubev_reg_0_din0[15] ,
    \cubev_reg_0_din0[14] ,
    \cubev_reg_0_din0[13] ,
    \cubev_reg_0_din0[12] ,
    \cubev_reg_0_din0[11] ,
    \cubev_reg_0_din0[10] ,
    \cubev_reg_0_din0[9] ,
    \cubev_reg_0_din0[8] ,
    \cubev_reg_0_din0[7] ,
    \cubev_reg_0_din0[6] ,
    \cubev_reg_0_din0[5] ,
    \cubev_reg_0_din0[4] ,
    \cubev_reg_0_din0[3] ,
    \cubev_reg_0_din0[2] ,
    \cubev_reg_0_din0[1] ,
    \cubev_reg_0_din0[0] }),
    .dout0({\cubev_reg_0_dout0[31] ,
    \cubev_reg_0_dout0[30] ,
    \cubev_reg_0_dout0[29] ,
    \cubev_reg_0_dout0[28] ,
    \cubev_reg_0_dout0[27] ,
    \cubev_reg_0_dout0[26] ,
    \cubev_reg_0_dout0[25] ,
    \cubev_reg_0_dout0[24] ,
    \cubev_reg_0_dout0[23] ,
    \cubev_reg_0_dout0[22] ,
    \cubev_reg_0_dout0[21] ,
    \cubev_reg_0_dout0[20] ,
    \cubev_reg_0_dout0[19] ,
    \cubev_reg_0_dout0[18] ,
    \cubev_reg_0_dout0[17] ,
    \cubev_reg_0_dout0[16] ,
    \cubev_reg_0_dout0[15] ,
    \cubev_reg_0_dout0[14] ,
    \cubev_reg_0_dout0[13] ,
    \cubev_reg_0_dout0[12] ,
    \cubev_reg_0_dout0[11] ,
    \cubev_reg_0_dout0[10] ,
    \cubev_reg_0_dout0[9] ,
    \cubev_reg_0_dout0[8] ,
    \cubev_reg_0_dout0[7] ,
    \cubev_reg_0_dout0[6] ,
    \cubev_reg_0_dout0[5] ,
    \cubev_reg_0_dout0[4] ,
    \cubev_reg_0_dout0[3] ,
    \cubev_reg_0_dout0[2] ,
    \cubev_reg_0_dout0[1] ,
    \cubev_reg_0_dout0[0] }),
    .dout1({\cubev_reg_0_dout1[31] ,
    \cubev_reg_0_dout1[30] ,
    \cubev_reg_0_dout1[29] ,
    \cubev_reg_0_dout1[28] ,
    \cubev_reg_0_dout1[27] ,
    \cubev_reg_0_dout1[26] ,
    \cubev_reg_0_dout1[25] ,
    \cubev_reg_0_dout1[24] ,
    \cubev_reg_0_dout1[23] ,
    \cubev_reg_0_dout1[22] ,
    \cubev_reg_0_dout1[21] ,
    \cubev_reg_0_dout1[20] ,
    \cubev_reg_0_dout1[19] ,
    \cubev_reg_0_dout1[18] ,
    \cubev_reg_0_dout1[17] ,
    \cubev_reg_0_dout1[16] ,
    \cubev_reg_0_dout1[15] ,
    \cubev_reg_0_dout1[14] ,
    \cubev_reg_0_dout1[13] ,
    \cubev_reg_0_dout1[12] ,
    \cubev_reg_0_dout1[11] ,
    \cubev_reg_0_dout1[10] ,
    \cubev_reg_0_dout1[9] ,
    \cubev_reg_0_dout1[8] ,
    \cubev_reg_0_dout1[7] ,
    \cubev_reg_0_dout1[6] ,
    \cubev_reg_0_dout1[5] ,
    \cubev_reg_0_dout1[4] ,
    \cubev_reg_0_dout1[3] ,
    \cubev_reg_0_dout1[2] ,
    \cubev_reg_0_dout1[1] ,
    \cubev_reg_0_dout1[0] }),
    .wmask0({\cubev_reg_0_wmask0[3] ,
    \cubev_reg_0_wmask0[2] ,
    \cubev_reg_0_wmask0[1] ,
    \cubev_reg_0_wmask0[0] }));
 rb cubev_reg_0_rb (.clk(cubev_reg_0_clk1),
    .rstn(cubev_reg_0_rstn),
    .dati({\cubev_reg_0_dout1[31] ,
    \cubev_reg_0_dout1[30] ,
    \cubev_reg_0_dout1[29] ,
    \cubev_reg_0_dout1[28] ,
    \cubev_reg_0_dout1[27] ,
    \cubev_reg_0_dout1[26] ,
    \cubev_reg_0_dout1[25] ,
    \cubev_reg_0_dout1[24] ,
    \cubev_reg_0_dout1[23] ,
    \cubev_reg_0_dout1[22] ,
    \cubev_reg_0_dout1[21] ,
    \cubev_reg_0_dout1[20] ,
    \cubev_reg_0_dout1[19] ,
    \cubev_reg_0_dout1[18] ,
    \cubev_reg_0_dout1[17] ,
    \cubev_reg_0_dout1[16] ,
    \cubev_reg_0_dout1[15] ,
    \cubev_reg_0_dout1[14] ,
    \cubev_reg_0_dout1[13] ,
    \cubev_reg_0_dout1[12] ,
    \cubev_reg_0_dout1[11] ,
    \cubev_reg_0_dout1[10] ,
    \cubev_reg_0_dout1[9] ,
    \cubev_reg_0_dout1[8] ,
    \cubev_reg_0_dout1[7] ,
    \cubev_reg_0_dout1[6] ,
    \cubev_reg_0_dout1[5] ,
    \cubev_reg_0_dout1[4] ,
    \cubev_reg_0_dout1[3] ,
    \cubev_reg_0_dout1[2] ,
    \cubev_reg_0_dout1[1] ,
    \cubev_reg_0_dout1[0] }),
    .dato({\cubev_reg_0_dout1_reg[31] ,
    \cubev_reg_0_dout1_reg[30] ,
    \cubev_reg_0_dout1_reg[29] ,
    \cubev_reg_0_dout1_reg[28] ,
    \cubev_reg_0_dout1_reg[27] ,
    \cubev_reg_0_dout1_reg[26] ,
    \cubev_reg_0_dout1_reg[25] ,
    \cubev_reg_0_dout1_reg[24] ,
    \cubev_reg_0_dout1_reg[23] ,
    \cubev_reg_0_dout1_reg[22] ,
    \cubev_reg_0_dout1_reg[21] ,
    \cubev_reg_0_dout1_reg[20] ,
    \cubev_reg_0_dout1_reg[19] ,
    \cubev_reg_0_dout1_reg[18] ,
    \cubev_reg_0_dout1_reg[17] ,
    \cubev_reg_0_dout1_reg[16] ,
    \cubev_reg_0_dout1_reg[15] ,
    \cubev_reg_0_dout1_reg[14] ,
    \cubev_reg_0_dout1_reg[13] ,
    \cubev_reg_0_dout1_reg[12] ,
    \cubev_reg_0_dout1_reg[11] ,
    \cubev_reg_0_dout1_reg[10] ,
    \cubev_reg_0_dout1_reg[9] ,
    \cubev_reg_0_dout1_reg[8] ,
    \cubev_reg_0_dout1_reg[7] ,
    \cubev_reg_0_dout1_reg[6] ,
    \cubev_reg_0_dout1_reg[5] ,
    \cubev_reg_0_dout1_reg[4] ,
    \cubev_reg_0_dout1_reg[3] ,
    \cubev_reg_0_dout1_reg[2] ,
    \cubev_reg_0_dout1_reg[1] ,
    \cubev_reg_0_dout1_reg[0] }));
 sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_1 (.csb0(cubev_reg_1_csb0),
    .csb1(cubev_reg_1_csb1),
    .web0(cubev_reg_1_web0),
    .clk0(cubev_reg_1_clk0),
    .clk1(cubev_reg_1_clk1),
    .addr0({\cubev_reg_1_addr0[7] ,
    \cubev_reg_1_addr0[6] ,
    \cubev_reg_1_addr0[5] ,
    \cubev_reg_1_addr0[4] ,
    \cubev_reg_1_addr0[3] ,
    \cubev_reg_1_addr0[2] ,
    \cubev_reg_1_addr0[1] ,
    \cubev_reg_1_addr0[0] }),
    .addr1({\cubev_reg_1_addr1[7] ,
    \cubev_reg_1_addr1[6] ,
    \cubev_reg_1_addr1[5] ,
    \cubev_reg_1_addr1[4] ,
    \cubev_reg_1_addr1[3] ,
    \cubev_reg_1_addr1[2] ,
    \cubev_reg_1_addr1[1] ,
    \cubev_reg_1_addr1[0] }),
    .din0({\cubev_reg_1_din0[31] ,
    \cubev_reg_1_din0[30] ,
    \cubev_reg_1_din0[29] ,
    \cubev_reg_1_din0[28] ,
    \cubev_reg_1_din0[27] ,
    \cubev_reg_1_din0[26] ,
    \cubev_reg_1_din0[25] ,
    \cubev_reg_1_din0[24] ,
    \cubev_reg_1_din0[23] ,
    \cubev_reg_1_din0[22] ,
    \cubev_reg_1_din0[21] ,
    \cubev_reg_1_din0[20] ,
    \cubev_reg_1_din0[19] ,
    \cubev_reg_1_din0[18] ,
    \cubev_reg_1_din0[17] ,
    \cubev_reg_1_din0[16] ,
    \cubev_reg_1_din0[15] ,
    \cubev_reg_1_din0[14] ,
    \cubev_reg_1_din0[13] ,
    \cubev_reg_1_din0[12] ,
    \cubev_reg_1_din0[11] ,
    \cubev_reg_1_din0[10] ,
    \cubev_reg_1_din0[9] ,
    \cubev_reg_1_din0[8] ,
    \cubev_reg_1_din0[7] ,
    \cubev_reg_1_din0[6] ,
    \cubev_reg_1_din0[5] ,
    \cubev_reg_1_din0[4] ,
    \cubev_reg_1_din0[3] ,
    \cubev_reg_1_din0[2] ,
    \cubev_reg_1_din0[1] ,
    \cubev_reg_1_din0[0] }),
    .dout0({\cubev_reg_1_dout0[31] ,
    \cubev_reg_1_dout0[30] ,
    \cubev_reg_1_dout0[29] ,
    \cubev_reg_1_dout0[28] ,
    \cubev_reg_1_dout0[27] ,
    \cubev_reg_1_dout0[26] ,
    \cubev_reg_1_dout0[25] ,
    \cubev_reg_1_dout0[24] ,
    \cubev_reg_1_dout0[23] ,
    \cubev_reg_1_dout0[22] ,
    \cubev_reg_1_dout0[21] ,
    \cubev_reg_1_dout0[20] ,
    \cubev_reg_1_dout0[19] ,
    \cubev_reg_1_dout0[18] ,
    \cubev_reg_1_dout0[17] ,
    \cubev_reg_1_dout0[16] ,
    \cubev_reg_1_dout0[15] ,
    \cubev_reg_1_dout0[14] ,
    \cubev_reg_1_dout0[13] ,
    \cubev_reg_1_dout0[12] ,
    \cubev_reg_1_dout0[11] ,
    \cubev_reg_1_dout0[10] ,
    \cubev_reg_1_dout0[9] ,
    \cubev_reg_1_dout0[8] ,
    \cubev_reg_1_dout0[7] ,
    \cubev_reg_1_dout0[6] ,
    \cubev_reg_1_dout0[5] ,
    \cubev_reg_1_dout0[4] ,
    \cubev_reg_1_dout0[3] ,
    \cubev_reg_1_dout0[2] ,
    \cubev_reg_1_dout0[1] ,
    \cubev_reg_1_dout0[0] }),
    .dout1({\cubev_reg_1_dout1[31] ,
    \cubev_reg_1_dout1[30] ,
    \cubev_reg_1_dout1[29] ,
    \cubev_reg_1_dout1[28] ,
    \cubev_reg_1_dout1[27] ,
    \cubev_reg_1_dout1[26] ,
    \cubev_reg_1_dout1[25] ,
    \cubev_reg_1_dout1[24] ,
    \cubev_reg_1_dout1[23] ,
    \cubev_reg_1_dout1[22] ,
    \cubev_reg_1_dout1[21] ,
    \cubev_reg_1_dout1[20] ,
    \cubev_reg_1_dout1[19] ,
    \cubev_reg_1_dout1[18] ,
    \cubev_reg_1_dout1[17] ,
    \cubev_reg_1_dout1[16] ,
    \cubev_reg_1_dout1[15] ,
    \cubev_reg_1_dout1[14] ,
    \cubev_reg_1_dout1[13] ,
    \cubev_reg_1_dout1[12] ,
    \cubev_reg_1_dout1[11] ,
    \cubev_reg_1_dout1[10] ,
    \cubev_reg_1_dout1[9] ,
    \cubev_reg_1_dout1[8] ,
    \cubev_reg_1_dout1[7] ,
    \cubev_reg_1_dout1[6] ,
    \cubev_reg_1_dout1[5] ,
    \cubev_reg_1_dout1[4] ,
    \cubev_reg_1_dout1[3] ,
    \cubev_reg_1_dout1[2] ,
    \cubev_reg_1_dout1[1] ,
    \cubev_reg_1_dout1[0] }),
    .wmask0({\cubev_reg_1_wmask0[3] ,
    \cubev_reg_1_wmask0[2] ,
    \cubev_reg_1_wmask0[1] ,
    \cubev_reg_1_wmask0[0] }));
 rb cubev_reg_1_rb (.clk(cubev_reg_1_clk1),
    .rstn(cubev_reg_1_rstn),
    .dati({\cubev_reg_1_dout1[31] ,
    \cubev_reg_1_dout1[30] ,
    \cubev_reg_1_dout1[29] ,
    \cubev_reg_1_dout1[28] ,
    \cubev_reg_1_dout1[27] ,
    \cubev_reg_1_dout1[26] ,
    \cubev_reg_1_dout1[25] ,
    \cubev_reg_1_dout1[24] ,
    \cubev_reg_1_dout1[23] ,
    \cubev_reg_1_dout1[22] ,
    \cubev_reg_1_dout1[21] ,
    \cubev_reg_1_dout1[20] ,
    \cubev_reg_1_dout1[19] ,
    \cubev_reg_1_dout1[18] ,
    \cubev_reg_1_dout1[17] ,
    \cubev_reg_1_dout1[16] ,
    \cubev_reg_1_dout1[15] ,
    \cubev_reg_1_dout1[14] ,
    \cubev_reg_1_dout1[13] ,
    \cubev_reg_1_dout1[12] ,
    \cubev_reg_1_dout1[11] ,
    \cubev_reg_1_dout1[10] ,
    \cubev_reg_1_dout1[9] ,
    \cubev_reg_1_dout1[8] ,
    \cubev_reg_1_dout1[7] ,
    \cubev_reg_1_dout1[6] ,
    \cubev_reg_1_dout1[5] ,
    \cubev_reg_1_dout1[4] ,
    \cubev_reg_1_dout1[3] ,
    \cubev_reg_1_dout1[2] ,
    \cubev_reg_1_dout1[1] ,
    \cubev_reg_1_dout1[0] }),
    .dato({\cubev_reg_1_dout1_reg[31] ,
    \cubev_reg_1_dout1_reg[30] ,
    \cubev_reg_1_dout1_reg[29] ,
    \cubev_reg_1_dout1_reg[28] ,
    \cubev_reg_1_dout1_reg[27] ,
    \cubev_reg_1_dout1_reg[26] ,
    \cubev_reg_1_dout1_reg[25] ,
    \cubev_reg_1_dout1_reg[24] ,
    \cubev_reg_1_dout1_reg[23] ,
    \cubev_reg_1_dout1_reg[22] ,
    \cubev_reg_1_dout1_reg[21] ,
    \cubev_reg_1_dout1_reg[20] ,
    \cubev_reg_1_dout1_reg[19] ,
    \cubev_reg_1_dout1_reg[18] ,
    \cubev_reg_1_dout1_reg[17] ,
    \cubev_reg_1_dout1_reg[16] ,
    \cubev_reg_1_dout1_reg[15] ,
    \cubev_reg_1_dout1_reg[14] ,
    \cubev_reg_1_dout1_reg[13] ,
    \cubev_reg_1_dout1_reg[12] ,
    \cubev_reg_1_dout1_reg[11] ,
    \cubev_reg_1_dout1_reg[10] ,
    \cubev_reg_1_dout1_reg[9] ,
    \cubev_reg_1_dout1_reg[8] ,
    \cubev_reg_1_dout1_reg[7] ,
    \cubev_reg_1_dout1_reg[6] ,
    \cubev_reg_1_dout1_reg[5] ,
    \cubev_reg_1_dout1_reg[4] ,
    \cubev_reg_1_dout1_reg[3] ,
    \cubev_reg_1_dout1_reg[2] ,
    \cubev_reg_1_dout1_reg[1] ,
    \cubev_reg_1_dout1_reg[0] }));
 sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_2 (.csb0(cubev_reg_2_csb0),
    .csb1(cubev_reg_2_csb1),
    .web0(cubev_reg_2_web0),
    .clk0(cubev_reg_2_clk0),
    .clk1(cubev_reg_2_clk1),
    .addr0({\cubev_reg_2_addr0[7] ,
    \cubev_reg_2_addr0[6] ,
    \cubev_reg_2_addr0[5] ,
    \cubev_reg_2_addr0[4] ,
    \cubev_reg_2_addr0[3] ,
    \cubev_reg_2_addr0[2] ,
    \cubev_reg_2_addr0[1] ,
    \cubev_reg_2_addr0[0] }),
    .addr1({\cubev_reg_2_addr1[7] ,
    \cubev_reg_2_addr1[6] ,
    \cubev_reg_2_addr1[5] ,
    \cubev_reg_2_addr1[4] ,
    \cubev_reg_2_addr1[3] ,
    \cubev_reg_2_addr1[2] ,
    \cubev_reg_2_addr1[1] ,
    \cubev_reg_2_addr1[0] }),
    .din0({\cubev_reg_2_din0[31] ,
    \cubev_reg_2_din0[30] ,
    \cubev_reg_2_din0[29] ,
    \cubev_reg_2_din0[28] ,
    \cubev_reg_2_din0[27] ,
    \cubev_reg_2_din0[26] ,
    \cubev_reg_2_din0[25] ,
    \cubev_reg_2_din0[24] ,
    \cubev_reg_2_din0[23] ,
    \cubev_reg_2_din0[22] ,
    \cubev_reg_2_din0[21] ,
    \cubev_reg_2_din0[20] ,
    \cubev_reg_2_din0[19] ,
    \cubev_reg_2_din0[18] ,
    \cubev_reg_2_din0[17] ,
    \cubev_reg_2_din0[16] ,
    \cubev_reg_2_din0[15] ,
    \cubev_reg_2_din0[14] ,
    \cubev_reg_2_din0[13] ,
    \cubev_reg_2_din0[12] ,
    \cubev_reg_2_din0[11] ,
    \cubev_reg_2_din0[10] ,
    \cubev_reg_2_din0[9] ,
    \cubev_reg_2_din0[8] ,
    \cubev_reg_2_din0[7] ,
    \cubev_reg_2_din0[6] ,
    \cubev_reg_2_din0[5] ,
    \cubev_reg_2_din0[4] ,
    \cubev_reg_2_din0[3] ,
    \cubev_reg_2_din0[2] ,
    \cubev_reg_2_din0[1] ,
    \cubev_reg_2_din0[0] }),
    .dout0({\cubev_reg_2_dout0[31] ,
    \cubev_reg_2_dout0[30] ,
    \cubev_reg_2_dout0[29] ,
    \cubev_reg_2_dout0[28] ,
    \cubev_reg_2_dout0[27] ,
    \cubev_reg_2_dout0[26] ,
    \cubev_reg_2_dout0[25] ,
    \cubev_reg_2_dout0[24] ,
    \cubev_reg_2_dout0[23] ,
    \cubev_reg_2_dout0[22] ,
    \cubev_reg_2_dout0[21] ,
    \cubev_reg_2_dout0[20] ,
    \cubev_reg_2_dout0[19] ,
    \cubev_reg_2_dout0[18] ,
    \cubev_reg_2_dout0[17] ,
    \cubev_reg_2_dout0[16] ,
    \cubev_reg_2_dout0[15] ,
    \cubev_reg_2_dout0[14] ,
    \cubev_reg_2_dout0[13] ,
    \cubev_reg_2_dout0[12] ,
    \cubev_reg_2_dout0[11] ,
    \cubev_reg_2_dout0[10] ,
    \cubev_reg_2_dout0[9] ,
    \cubev_reg_2_dout0[8] ,
    \cubev_reg_2_dout0[7] ,
    \cubev_reg_2_dout0[6] ,
    \cubev_reg_2_dout0[5] ,
    \cubev_reg_2_dout0[4] ,
    \cubev_reg_2_dout0[3] ,
    \cubev_reg_2_dout0[2] ,
    \cubev_reg_2_dout0[1] ,
    \cubev_reg_2_dout0[0] }),
    .dout1({\cubev_reg_2_dout1[31] ,
    \cubev_reg_2_dout1[30] ,
    \cubev_reg_2_dout1[29] ,
    \cubev_reg_2_dout1[28] ,
    \cubev_reg_2_dout1[27] ,
    \cubev_reg_2_dout1[26] ,
    \cubev_reg_2_dout1[25] ,
    \cubev_reg_2_dout1[24] ,
    \cubev_reg_2_dout1[23] ,
    \cubev_reg_2_dout1[22] ,
    \cubev_reg_2_dout1[21] ,
    \cubev_reg_2_dout1[20] ,
    \cubev_reg_2_dout1[19] ,
    \cubev_reg_2_dout1[18] ,
    \cubev_reg_2_dout1[17] ,
    \cubev_reg_2_dout1[16] ,
    \cubev_reg_2_dout1[15] ,
    \cubev_reg_2_dout1[14] ,
    \cubev_reg_2_dout1[13] ,
    \cubev_reg_2_dout1[12] ,
    \cubev_reg_2_dout1[11] ,
    \cubev_reg_2_dout1[10] ,
    \cubev_reg_2_dout1[9] ,
    \cubev_reg_2_dout1[8] ,
    \cubev_reg_2_dout1[7] ,
    \cubev_reg_2_dout1[6] ,
    \cubev_reg_2_dout1[5] ,
    \cubev_reg_2_dout1[4] ,
    \cubev_reg_2_dout1[3] ,
    \cubev_reg_2_dout1[2] ,
    \cubev_reg_2_dout1[1] ,
    \cubev_reg_2_dout1[0] }),
    .wmask0({\cubev_reg_2_wmask0[3] ,
    \cubev_reg_2_wmask0[2] ,
    \cubev_reg_2_wmask0[1] ,
    \cubev_reg_2_wmask0[0] }));
 rb cubev_reg_2_rb (.clk(cubev_reg_2_clk1),
    .rstn(cubev_reg_2_rstn),
    .dati({\cubev_reg_2_dout1[31] ,
    \cubev_reg_2_dout1[30] ,
    \cubev_reg_2_dout1[29] ,
    \cubev_reg_2_dout1[28] ,
    \cubev_reg_2_dout1[27] ,
    \cubev_reg_2_dout1[26] ,
    \cubev_reg_2_dout1[25] ,
    \cubev_reg_2_dout1[24] ,
    \cubev_reg_2_dout1[23] ,
    \cubev_reg_2_dout1[22] ,
    \cubev_reg_2_dout1[21] ,
    \cubev_reg_2_dout1[20] ,
    \cubev_reg_2_dout1[19] ,
    \cubev_reg_2_dout1[18] ,
    \cubev_reg_2_dout1[17] ,
    \cubev_reg_2_dout1[16] ,
    \cubev_reg_2_dout1[15] ,
    \cubev_reg_2_dout1[14] ,
    \cubev_reg_2_dout1[13] ,
    \cubev_reg_2_dout1[12] ,
    \cubev_reg_2_dout1[11] ,
    \cubev_reg_2_dout1[10] ,
    \cubev_reg_2_dout1[9] ,
    \cubev_reg_2_dout1[8] ,
    \cubev_reg_2_dout1[7] ,
    \cubev_reg_2_dout1[6] ,
    \cubev_reg_2_dout1[5] ,
    \cubev_reg_2_dout1[4] ,
    \cubev_reg_2_dout1[3] ,
    \cubev_reg_2_dout1[2] ,
    \cubev_reg_2_dout1[1] ,
    \cubev_reg_2_dout1[0] }),
    .dato({\cubev_reg_2_dout1_reg[31] ,
    \cubev_reg_2_dout1_reg[30] ,
    \cubev_reg_2_dout1_reg[29] ,
    \cubev_reg_2_dout1_reg[28] ,
    \cubev_reg_2_dout1_reg[27] ,
    \cubev_reg_2_dout1_reg[26] ,
    \cubev_reg_2_dout1_reg[25] ,
    \cubev_reg_2_dout1_reg[24] ,
    \cubev_reg_2_dout1_reg[23] ,
    \cubev_reg_2_dout1_reg[22] ,
    \cubev_reg_2_dout1_reg[21] ,
    \cubev_reg_2_dout1_reg[20] ,
    \cubev_reg_2_dout1_reg[19] ,
    \cubev_reg_2_dout1_reg[18] ,
    \cubev_reg_2_dout1_reg[17] ,
    \cubev_reg_2_dout1_reg[16] ,
    \cubev_reg_2_dout1_reg[15] ,
    \cubev_reg_2_dout1_reg[14] ,
    \cubev_reg_2_dout1_reg[13] ,
    \cubev_reg_2_dout1_reg[12] ,
    \cubev_reg_2_dout1_reg[11] ,
    \cubev_reg_2_dout1_reg[10] ,
    \cubev_reg_2_dout1_reg[9] ,
    \cubev_reg_2_dout1_reg[8] ,
    \cubev_reg_2_dout1_reg[7] ,
    \cubev_reg_2_dout1_reg[6] ,
    \cubev_reg_2_dout1_reg[5] ,
    \cubev_reg_2_dout1_reg[4] ,
    \cubev_reg_2_dout1_reg[3] ,
    \cubev_reg_2_dout1_reg[2] ,
    \cubev_reg_2_dout1_reg[1] ,
    \cubev_reg_2_dout1_reg[0] }));
 sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_3 (.csb0(cubev_reg_3_csb0),
    .csb1(cubev_reg_3_csb1),
    .web0(cubev_reg_3_web0),
    .clk0(cubev_reg_3_clk0),
    .clk1(cubev_reg_3_clk1),
    .addr0({\cubev_reg_3_addr0[7] ,
    \cubev_reg_3_addr0[6] ,
    \cubev_reg_3_addr0[5] ,
    \cubev_reg_3_addr0[4] ,
    \cubev_reg_3_addr0[3] ,
    \cubev_reg_3_addr0[2] ,
    \cubev_reg_3_addr0[1] ,
    \cubev_reg_3_addr0[0] }),
    .addr1({\cubev_reg_3_addr1[7] ,
    \cubev_reg_3_addr1[6] ,
    \cubev_reg_3_addr1[5] ,
    \cubev_reg_3_addr1[4] ,
    \cubev_reg_3_addr1[3] ,
    \cubev_reg_3_addr1[2] ,
    \cubev_reg_3_addr1[1] ,
    \cubev_reg_3_addr1[0] }),
    .din0({\cubev_reg_3_din0[31] ,
    \cubev_reg_3_din0[30] ,
    \cubev_reg_3_din0[29] ,
    \cubev_reg_3_din0[28] ,
    \cubev_reg_3_din0[27] ,
    \cubev_reg_3_din0[26] ,
    \cubev_reg_3_din0[25] ,
    \cubev_reg_3_din0[24] ,
    \cubev_reg_3_din0[23] ,
    \cubev_reg_3_din0[22] ,
    \cubev_reg_3_din0[21] ,
    \cubev_reg_3_din0[20] ,
    \cubev_reg_3_din0[19] ,
    \cubev_reg_3_din0[18] ,
    \cubev_reg_3_din0[17] ,
    \cubev_reg_3_din0[16] ,
    \cubev_reg_3_din0[15] ,
    \cubev_reg_3_din0[14] ,
    \cubev_reg_3_din0[13] ,
    \cubev_reg_3_din0[12] ,
    \cubev_reg_3_din0[11] ,
    \cubev_reg_3_din0[10] ,
    \cubev_reg_3_din0[9] ,
    \cubev_reg_3_din0[8] ,
    \cubev_reg_3_din0[7] ,
    \cubev_reg_3_din0[6] ,
    \cubev_reg_3_din0[5] ,
    \cubev_reg_3_din0[4] ,
    \cubev_reg_3_din0[3] ,
    \cubev_reg_3_din0[2] ,
    \cubev_reg_3_din0[1] ,
    \cubev_reg_3_din0[0] }),
    .dout0({\cubev_reg_3_dout0[31] ,
    \cubev_reg_3_dout0[30] ,
    \cubev_reg_3_dout0[29] ,
    \cubev_reg_3_dout0[28] ,
    \cubev_reg_3_dout0[27] ,
    \cubev_reg_3_dout0[26] ,
    \cubev_reg_3_dout0[25] ,
    \cubev_reg_3_dout0[24] ,
    \cubev_reg_3_dout0[23] ,
    \cubev_reg_3_dout0[22] ,
    \cubev_reg_3_dout0[21] ,
    \cubev_reg_3_dout0[20] ,
    \cubev_reg_3_dout0[19] ,
    \cubev_reg_3_dout0[18] ,
    \cubev_reg_3_dout0[17] ,
    \cubev_reg_3_dout0[16] ,
    \cubev_reg_3_dout0[15] ,
    \cubev_reg_3_dout0[14] ,
    \cubev_reg_3_dout0[13] ,
    \cubev_reg_3_dout0[12] ,
    \cubev_reg_3_dout0[11] ,
    \cubev_reg_3_dout0[10] ,
    \cubev_reg_3_dout0[9] ,
    \cubev_reg_3_dout0[8] ,
    \cubev_reg_3_dout0[7] ,
    \cubev_reg_3_dout0[6] ,
    \cubev_reg_3_dout0[5] ,
    \cubev_reg_3_dout0[4] ,
    \cubev_reg_3_dout0[3] ,
    \cubev_reg_3_dout0[2] ,
    \cubev_reg_3_dout0[1] ,
    \cubev_reg_3_dout0[0] }),
    .dout1({\cubev_reg_3_dout1[31] ,
    \cubev_reg_3_dout1[30] ,
    \cubev_reg_3_dout1[29] ,
    \cubev_reg_3_dout1[28] ,
    \cubev_reg_3_dout1[27] ,
    \cubev_reg_3_dout1[26] ,
    \cubev_reg_3_dout1[25] ,
    \cubev_reg_3_dout1[24] ,
    \cubev_reg_3_dout1[23] ,
    \cubev_reg_3_dout1[22] ,
    \cubev_reg_3_dout1[21] ,
    \cubev_reg_3_dout1[20] ,
    \cubev_reg_3_dout1[19] ,
    \cubev_reg_3_dout1[18] ,
    \cubev_reg_3_dout1[17] ,
    \cubev_reg_3_dout1[16] ,
    \cubev_reg_3_dout1[15] ,
    \cubev_reg_3_dout1[14] ,
    \cubev_reg_3_dout1[13] ,
    \cubev_reg_3_dout1[12] ,
    \cubev_reg_3_dout1[11] ,
    \cubev_reg_3_dout1[10] ,
    \cubev_reg_3_dout1[9] ,
    \cubev_reg_3_dout1[8] ,
    \cubev_reg_3_dout1[7] ,
    \cubev_reg_3_dout1[6] ,
    \cubev_reg_3_dout1[5] ,
    \cubev_reg_3_dout1[4] ,
    \cubev_reg_3_dout1[3] ,
    \cubev_reg_3_dout1[2] ,
    \cubev_reg_3_dout1[1] ,
    \cubev_reg_3_dout1[0] }),
    .wmask0({\cubev_reg_3_wmask0[3] ,
    \cubev_reg_3_wmask0[2] ,
    \cubev_reg_3_wmask0[1] ,
    \cubev_reg_3_wmask0[0] }));
 rb cubev_reg_3_rb (.clk(cubev_reg_3_clk1),
    .rstn(cubev_reg_3_rstn),
    .dati({\cubev_reg_3_dout1[31] ,
    \cubev_reg_3_dout1[30] ,
    \cubev_reg_3_dout1[29] ,
    \cubev_reg_3_dout1[28] ,
    \cubev_reg_3_dout1[27] ,
    \cubev_reg_3_dout1[26] ,
    \cubev_reg_3_dout1[25] ,
    \cubev_reg_3_dout1[24] ,
    \cubev_reg_3_dout1[23] ,
    \cubev_reg_3_dout1[22] ,
    \cubev_reg_3_dout1[21] ,
    \cubev_reg_3_dout1[20] ,
    \cubev_reg_3_dout1[19] ,
    \cubev_reg_3_dout1[18] ,
    \cubev_reg_3_dout1[17] ,
    \cubev_reg_3_dout1[16] ,
    \cubev_reg_3_dout1[15] ,
    \cubev_reg_3_dout1[14] ,
    \cubev_reg_3_dout1[13] ,
    \cubev_reg_3_dout1[12] ,
    \cubev_reg_3_dout1[11] ,
    \cubev_reg_3_dout1[10] ,
    \cubev_reg_3_dout1[9] ,
    \cubev_reg_3_dout1[8] ,
    \cubev_reg_3_dout1[7] ,
    \cubev_reg_3_dout1[6] ,
    \cubev_reg_3_dout1[5] ,
    \cubev_reg_3_dout1[4] ,
    \cubev_reg_3_dout1[3] ,
    \cubev_reg_3_dout1[2] ,
    \cubev_reg_3_dout1[1] ,
    \cubev_reg_3_dout1[0] }),
    .dato({\cubev_reg_3_dout1_reg[31] ,
    \cubev_reg_3_dout1_reg[30] ,
    \cubev_reg_3_dout1_reg[29] ,
    \cubev_reg_3_dout1_reg[28] ,
    \cubev_reg_3_dout1_reg[27] ,
    \cubev_reg_3_dout1_reg[26] ,
    \cubev_reg_3_dout1_reg[25] ,
    \cubev_reg_3_dout1_reg[24] ,
    \cubev_reg_3_dout1_reg[23] ,
    \cubev_reg_3_dout1_reg[22] ,
    \cubev_reg_3_dout1_reg[21] ,
    \cubev_reg_3_dout1_reg[20] ,
    \cubev_reg_3_dout1_reg[19] ,
    \cubev_reg_3_dout1_reg[18] ,
    \cubev_reg_3_dout1_reg[17] ,
    \cubev_reg_3_dout1_reg[16] ,
    \cubev_reg_3_dout1_reg[15] ,
    \cubev_reg_3_dout1_reg[14] ,
    \cubev_reg_3_dout1_reg[13] ,
    \cubev_reg_3_dout1_reg[12] ,
    \cubev_reg_3_dout1_reg[11] ,
    \cubev_reg_3_dout1_reg[10] ,
    \cubev_reg_3_dout1_reg[9] ,
    \cubev_reg_3_dout1_reg[8] ,
    \cubev_reg_3_dout1_reg[7] ,
    \cubev_reg_3_dout1_reg[6] ,
    \cubev_reg_3_dout1_reg[5] ,
    \cubev_reg_3_dout1_reg[4] ,
    \cubev_reg_3_dout1_reg[3] ,
    \cubev_reg_3_dout1_reg[2] ,
    \cubev_reg_3_dout1_reg[1] ,
    \cubev_reg_3_dout1_reg[0] }));
 sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_4 (.csb0(cubev_reg_4_csb0),
    .csb1(cubev_reg_4_csb1),
    .web0(cubev_reg_4_web0),
    .clk0(cubev_reg_4_clk0),
    .clk1(cubev_reg_4_clk1),
    .addr0({\cubev_reg_4_addr0[7] ,
    \cubev_reg_4_addr0[6] ,
    \cubev_reg_4_addr0[5] ,
    \cubev_reg_4_addr0[4] ,
    \cubev_reg_4_addr0[3] ,
    \cubev_reg_4_addr0[2] ,
    \cubev_reg_4_addr0[1] ,
    \cubev_reg_4_addr0[0] }),
    .addr1({\cubev_reg_4_addr1[7] ,
    \cubev_reg_4_addr1[6] ,
    \cubev_reg_4_addr1[5] ,
    \cubev_reg_4_addr1[4] ,
    \cubev_reg_4_addr1[3] ,
    \cubev_reg_4_addr1[2] ,
    \cubev_reg_4_addr1[1] ,
    \cubev_reg_4_addr1[0] }),
    .din0({\cubev_reg_4_din0[31] ,
    \cubev_reg_4_din0[30] ,
    \cubev_reg_4_din0[29] ,
    \cubev_reg_4_din0[28] ,
    \cubev_reg_4_din0[27] ,
    \cubev_reg_4_din0[26] ,
    \cubev_reg_4_din0[25] ,
    \cubev_reg_4_din0[24] ,
    \cubev_reg_4_din0[23] ,
    \cubev_reg_4_din0[22] ,
    \cubev_reg_4_din0[21] ,
    \cubev_reg_4_din0[20] ,
    \cubev_reg_4_din0[19] ,
    \cubev_reg_4_din0[18] ,
    \cubev_reg_4_din0[17] ,
    \cubev_reg_4_din0[16] ,
    \cubev_reg_4_din0[15] ,
    \cubev_reg_4_din0[14] ,
    \cubev_reg_4_din0[13] ,
    \cubev_reg_4_din0[12] ,
    \cubev_reg_4_din0[11] ,
    \cubev_reg_4_din0[10] ,
    \cubev_reg_4_din0[9] ,
    \cubev_reg_4_din0[8] ,
    \cubev_reg_4_din0[7] ,
    \cubev_reg_4_din0[6] ,
    \cubev_reg_4_din0[5] ,
    \cubev_reg_4_din0[4] ,
    \cubev_reg_4_din0[3] ,
    \cubev_reg_4_din0[2] ,
    \cubev_reg_4_din0[1] ,
    \cubev_reg_4_din0[0] }),
    .dout0({\cubev_reg_4_dout0[31] ,
    \cubev_reg_4_dout0[30] ,
    \cubev_reg_4_dout0[29] ,
    \cubev_reg_4_dout0[28] ,
    \cubev_reg_4_dout0[27] ,
    \cubev_reg_4_dout0[26] ,
    \cubev_reg_4_dout0[25] ,
    \cubev_reg_4_dout0[24] ,
    \cubev_reg_4_dout0[23] ,
    \cubev_reg_4_dout0[22] ,
    \cubev_reg_4_dout0[21] ,
    \cubev_reg_4_dout0[20] ,
    \cubev_reg_4_dout0[19] ,
    \cubev_reg_4_dout0[18] ,
    \cubev_reg_4_dout0[17] ,
    \cubev_reg_4_dout0[16] ,
    \cubev_reg_4_dout0[15] ,
    \cubev_reg_4_dout0[14] ,
    \cubev_reg_4_dout0[13] ,
    \cubev_reg_4_dout0[12] ,
    \cubev_reg_4_dout0[11] ,
    \cubev_reg_4_dout0[10] ,
    \cubev_reg_4_dout0[9] ,
    \cubev_reg_4_dout0[8] ,
    \cubev_reg_4_dout0[7] ,
    \cubev_reg_4_dout0[6] ,
    \cubev_reg_4_dout0[5] ,
    \cubev_reg_4_dout0[4] ,
    \cubev_reg_4_dout0[3] ,
    \cubev_reg_4_dout0[2] ,
    \cubev_reg_4_dout0[1] ,
    \cubev_reg_4_dout0[0] }),
    .dout1({\cubev_reg_4_dout1[31] ,
    \cubev_reg_4_dout1[30] ,
    \cubev_reg_4_dout1[29] ,
    \cubev_reg_4_dout1[28] ,
    \cubev_reg_4_dout1[27] ,
    \cubev_reg_4_dout1[26] ,
    \cubev_reg_4_dout1[25] ,
    \cubev_reg_4_dout1[24] ,
    \cubev_reg_4_dout1[23] ,
    \cubev_reg_4_dout1[22] ,
    \cubev_reg_4_dout1[21] ,
    \cubev_reg_4_dout1[20] ,
    \cubev_reg_4_dout1[19] ,
    \cubev_reg_4_dout1[18] ,
    \cubev_reg_4_dout1[17] ,
    \cubev_reg_4_dout1[16] ,
    \cubev_reg_4_dout1[15] ,
    \cubev_reg_4_dout1[14] ,
    \cubev_reg_4_dout1[13] ,
    \cubev_reg_4_dout1[12] ,
    \cubev_reg_4_dout1[11] ,
    \cubev_reg_4_dout1[10] ,
    \cubev_reg_4_dout1[9] ,
    \cubev_reg_4_dout1[8] ,
    \cubev_reg_4_dout1[7] ,
    \cubev_reg_4_dout1[6] ,
    \cubev_reg_4_dout1[5] ,
    \cubev_reg_4_dout1[4] ,
    \cubev_reg_4_dout1[3] ,
    \cubev_reg_4_dout1[2] ,
    \cubev_reg_4_dout1[1] ,
    \cubev_reg_4_dout1[0] }),
    .wmask0({\cubev_reg_4_wmask0[3] ,
    \cubev_reg_4_wmask0[2] ,
    \cubev_reg_4_wmask0[1] ,
    \cubev_reg_4_wmask0[0] }));
 rb cubev_reg_4_rb (.clk(cubev_reg_4_clk1),
    .rstn(cubev_reg_4_rstn),
    .dati({\cubev_reg_4_dout1[31] ,
    \cubev_reg_4_dout1[30] ,
    \cubev_reg_4_dout1[29] ,
    \cubev_reg_4_dout1[28] ,
    \cubev_reg_4_dout1[27] ,
    \cubev_reg_4_dout1[26] ,
    \cubev_reg_4_dout1[25] ,
    \cubev_reg_4_dout1[24] ,
    \cubev_reg_4_dout1[23] ,
    \cubev_reg_4_dout1[22] ,
    \cubev_reg_4_dout1[21] ,
    \cubev_reg_4_dout1[20] ,
    \cubev_reg_4_dout1[19] ,
    \cubev_reg_4_dout1[18] ,
    \cubev_reg_4_dout1[17] ,
    \cubev_reg_4_dout1[16] ,
    \cubev_reg_4_dout1[15] ,
    \cubev_reg_4_dout1[14] ,
    \cubev_reg_4_dout1[13] ,
    \cubev_reg_4_dout1[12] ,
    \cubev_reg_4_dout1[11] ,
    \cubev_reg_4_dout1[10] ,
    \cubev_reg_4_dout1[9] ,
    \cubev_reg_4_dout1[8] ,
    \cubev_reg_4_dout1[7] ,
    \cubev_reg_4_dout1[6] ,
    \cubev_reg_4_dout1[5] ,
    \cubev_reg_4_dout1[4] ,
    \cubev_reg_4_dout1[3] ,
    \cubev_reg_4_dout1[2] ,
    \cubev_reg_4_dout1[1] ,
    \cubev_reg_4_dout1[0] }),
    .dato({\cubev_reg_4_dout1_reg[31] ,
    \cubev_reg_4_dout1_reg[30] ,
    \cubev_reg_4_dout1_reg[29] ,
    \cubev_reg_4_dout1_reg[28] ,
    \cubev_reg_4_dout1_reg[27] ,
    \cubev_reg_4_dout1_reg[26] ,
    \cubev_reg_4_dout1_reg[25] ,
    \cubev_reg_4_dout1_reg[24] ,
    \cubev_reg_4_dout1_reg[23] ,
    \cubev_reg_4_dout1_reg[22] ,
    \cubev_reg_4_dout1_reg[21] ,
    \cubev_reg_4_dout1_reg[20] ,
    \cubev_reg_4_dout1_reg[19] ,
    \cubev_reg_4_dout1_reg[18] ,
    \cubev_reg_4_dout1_reg[17] ,
    \cubev_reg_4_dout1_reg[16] ,
    \cubev_reg_4_dout1_reg[15] ,
    \cubev_reg_4_dout1_reg[14] ,
    \cubev_reg_4_dout1_reg[13] ,
    \cubev_reg_4_dout1_reg[12] ,
    \cubev_reg_4_dout1_reg[11] ,
    \cubev_reg_4_dout1_reg[10] ,
    \cubev_reg_4_dout1_reg[9] ,
    \cubev_reg_4_dout1_reg[8] ,
    \cubev_reg_4_dout1_reg[7] ,
    \cubev_reg_4_dout1_reg[6] ,
    \cubev_reg_4_dout1_reg[5] ,
    \cubev_reg_4_dout1_reg[4] ,
    \cubev_reg_4_dout1_reg[3] ,
    \cubev_reg_4_dout1_reg[2] ,
    \cubev_reg_4_dout1_reg[1] ,
    \cubev_reg_4_dout1_reg[0] }));
 sky130_sram_1kbyte_1rw1r_32x256_8 cubev_reg_5 (.csb0(cubev_reg_5_csb0),
    .csb1(cubev_reg_5_csb1),
    .web0(cubev_reg_5_web0),
    .clk0(cubev_reg_5_clk0),
    .clk1(cubev_reg_5_clk1),
    .addr0({\cubev_reg_5_addr0[7] ,
    \cubev_reg_5_addr0[6] ,
    \cubev_reg_5_addr0[5] ,
    \cubev_reg_5_addr0[4] ,
    \cubev_reg_5_addr0[3] ,
    \cubev_reg_5_addr0[2] ,
    \cubev_reg_5_addr0[1] ,
    \cubev_reg_5_addr0[0] }),
    .addr1({\cubev_reg_5_addr1[7] ,
    \cubev_reg_5_addr1[6] ,
    \cubev_reg_5_addr1[5] ,
    \cubev_reg_5_addr1[4] ,
    \cubev_reg_5_addr1[3] ,
    \cubev_reg_5_addr1[2] ,
    \cubev_reg_5_addr1[1] ,
    \cubev_reg_5_addr1[0] }),
    .din0({\cubev_reg_5_din0[31] ,
    \cubev_reg_5_din0[30] ,
    \cubev_reg_5_din0[29] ,
    \cubev_reg_5_din0[28] ,
    \cubev_reg_5_din0[27] ,
    \cubev_reg_5_din0[26] ,
    \cubev_reg_5_din0[25] ,
    \cubev_reg_5_din0[24] ,
    \cubev_reg_5_din0[23] ,
    \cubev_reg_5_din0[22] ,
    \cubev_reg_5_din0[21] ,
    \cubev_reg_5_din0[20] ,
    \cubev_reg_5_din0[19] ,
    \cubev_reg_5_din0[18] ,
    \cubev_reg_5_din0[17] ,
    \cubev_reg_5_din0[16] ,
    \cubev_reg_5_din0[15] ,
    \cubev_reg_5_din0[14] ,
    \cubev_reg_5_din0[13] ,
    \cubev_reg_5_din0[12] ,
    \cubev_reg_5_din0[11] ,
    \cubev_reg_5_din0[10] ,
    \cubev_reg_5_din0[9] ,
    \cubev_reg_5_din0[8] ,
    \cubev_reg_5_din0[7] ,
    \cubev_reg_5_din0[6] ,
    \cubev_reg_5_din0[5] ,
    \cubev_reg_5_din0[4] ,
    \cubev_reg_5_din0[3] ,
    \cubev_reg_5_din0[2] ,
    \cubev_reg_5_din0[1] ,
    \cubev_reg_5_din0[0] }),
    .dout0({\cubev_reg_5_dout0[31] ,
    \cubev_reg_5_dout0[30] ,
    \cubev_reg_5_dout0[29] ,
    \cubev_reg_5_dout0[28] ,
    \cubev_reg_5_dout0[27] ,
    \cubev_reg_5_dout0[26] ,
    \cubev_reg_5_dout0[25] ,
    \cubev_reg_5_dout0[24] ,
    \cubev_reg_5_dout0[23] ,
    \cubev_reg_5_dout0[22] ,
    \cubev_reg_5_dout0[21] ,
    \cubev_reg_5_dout0[20] ,
    \cubev_reg_5_dout0[19] ,
    \cubev_reg_5_dout0[18] ,
    \cubev_reg_5_dout0[17] ,
    \cubev_reg_5_dout0[16] ,
    \cubev_reg_5_dout0[15] ,
    \cubev_reg_5_dout0[14] ,
    \cubev_reg_5_dout0[13] ,
    \cubev_reg_5_dout0[12] ,
    \cubev_reg_5_dout0[11] ,
    \cubev_reg_5_dout0[10] ,
    \cubev_reg_5_dout0[9] ,
    \cubev_reg_5_dout0[8] ,
    \cubev_reg_5_dout0[7] ,
    \cubev_reg_5_dout0[6] ,
    \cubev_reg_5_dout0[5] ,
    \cubev_reg_5_dout0[4] ,
    \cubev_reg_5_dout0[3] ,
    \cubev_reg_5_dout0[2] ,
    \cubev_reg_5_dout0[1] ,
    \cubev_reg_5_dout0[0] }),
    .dout1({\cubev_reg_5_dout1[31] ,
    \cubev_reg_5_dout1[30] ,
    \cubev_reg_5_dout1[29] ,
    \cubev_reg_5_dout1[28] ,
    \cubev_reg_5_dout1[27] ,
    \cubev_reg_5_dout1[26] ,
    \cubev_reg_5_dout1[25] ,
    \cubev_reg_5_dout1[24] ,
    \cubev_reg_5_dout1[23] ,
    \cubev_reg_5_dout1[22] ,
    \cubev_reg_5_dout1[21] ,
    \cubev_reg_5_dout1[20] ,
    \cubev_reg_5_dout1[19] ,
    \cubev_reg_5_dout1[18] ,
    \cubev_reg_5_dout1[17] ,
    \cubev_reg_5_dout1[16] ,
    \cubev_reg_5_dout1[15] ,
    \cubev_reg_5_dout1[14] ,
    \cubev_reg_5_dout1[13] ,
    \cubev_reg_5_dout1[12] ,
    \cubev_reg_5_dout1[11] ,
    \cubev_reg_5_dout1[10] ,
    \cubev_reg_5_dout1[9] ,
    \cubev_reg_5_dout1[8] ,
    \cubev_reg_5_dout1[7] ,
    \cubev_reg_5_dout1[6] ,
    \cubev_reg_5_dout1[5] ,
    \cubev_reg_5_dout1[4] ,
    \cubev_reg_5_dout1[3] ,
    \cubev_reg_5_dout1[2] ,
    \cubev_reg_5_dout1[1] ,
    \cubev_reg_5_dout1[0] }),
    .wmask0({\cubev_reg_5_wmask0[3] ,
    \cubev_reg_5_wmask0[2] ,
    \cubev_reg_5_wmask0[1] ,
    \cubev_reg_5_wmask0[0] }));
 rb cubev_reg_5_rb (.clk(cubev_reg_5_clk1),
    .rstn(cubev_reg_5_rstn),
    .dati({\cubev_reg_5_dout1[31] ,
    \cubev_reg_5_dout1[30] ,
    \cubev_reg_5_dout1[29] ,
    \cubev_reg_5_dout1[28] ,
    \cubev_reg_5_dout1[27] ,
    \cubev_reg_5_dout1[26] ,
    \cubev_reg_5_dout1[25] ,
    \cubev_reg_5_dout1[24] ,
    \cubev_reg_5_dout1[23] ,
    \cubev_reg_5_dout1[22] ,
    \cubev_reg_5_dout1[21] ,
    \cubev_reg_5_dout1[20] ,
    \cubev_reg_5_dout1[19] ,
    \cubev_reg_5_dout1[18] ,
    \cubev_reg_5_dout1[17] ,
    \cubev_reg_5_dout1[16] ,
    \cubev_reg_5_dout1[15] ,
    \cubev_reg_5_dout1[14] ,
    \cubev_reg_5_dout1[13] ,
    \cubev_reg_5_dout1[12] ,
    \cubev_reg_5_dout1[11] ,
    \cubev_reg_5_dout1[10] ,
    \cubev_reg_5_dout1[9] ,
    \cubev_reg_5_dout1[8] ,
    \cubev_reg_5_dout1[7] ,
    \cubev_reg_5_dout1[6] ,
    \cubev_reg_5_dout1[5] ,
    \cubev_reg_5_dout1[4] ,
    \cubev_reg_5_dout1[3] ,
    \cubev_reg_5_dout1[2] ,
    \cubev_reg_5_dout1[1] ,
    \cubev_reg_5_dout1[0] }),
    .dato({\cubev_reg_5_dout1_reg[31] ,
    \cubev_reg_5_dout1_reg[30] ,
    \cubev_reg_5_dout1_reg[29] ,
    \cubev_reg_5_dout1_reg[28] ,
    \cubev_reg_5_dout1_reg[27] ,
    \cubev_reg_5_dout1_reg[26] ,
    \cubev_reg_5_dout1_reg[25] ,
    \cubev_reg_5_dout1_reg[24] ,
    \cubev_reg_5_dout1_reg[23] ,
    \cubev_reg_5_dout1_reg[22] ,
    \cubev_reg_5_dout1_reg[21] ,
    \cubev_reg_5_dout1_reg[20] ,
    \cubev_reg_5_dout1_reg[19] ,
    \cubev_reg_5_dout1_reg[18] ,
    \cubev_reg_5_dout1_reg[17] ,
    \cubev_reg_5_dout1_reg[16] ,
    \cubev_reg_5_dout1_reg[15] ,
    \cubev_reg_5_dout1_reg[14] ,
    \cubev_reg_5_dout1_reg[13] ,
    \cubev_reg_5_dout1_reg[12] ,
    \cubev_reg_5_dout1_reg[11] ,
    \cubev_reg_5_dout1_reg[10] ,
    \cubev_reg_5_dout1_reg[9] ,
    \cubev_reg_5_dout1_reg[8] ,
    \cubev_reg_5_dout1_reg[7] ,
    \cubev_reg_5_dout1_reg[6] ,
    \cubev_reg_5_dout1_reg[5] ,
    \cubev_reg_5_dout1_reg[4] ,
    \cubev_reg_5_dout1_reg[3] ,
    \cubev_reg_5_dout1_reg[2] ,
    \cubev_reg_5_dout1_reg[1] ,
    \cubev_reg_5_dout1_reg[0] }));
 sky130_sram_1kbyte_1rw1r_32x256_8 cubev_rf1i (.csb0(cubev_rf1_csb0),
    .csb1(cubev_rf1_csb1),
    .web0(cubev_rf1_web0),
    .clk0(cubev_rf1_clk0),
    .clk1(cubev_rf1_clk1),
    .addr0({\cubev_rf1_addr0[7] ,
    \cubev_rf1_addr0[6] ,
    \cubev_rf1_addr0[5] ,
    \cubev_rf1_addr0[4] ,
    \cubev_rf1_addr0[3] ,
    \cubev_rf1_addr0[2] ,
    \cubev_rf1_addr0[1] ,
    \cubev_rf1_addr0[0] }),
    .addr1({\cubev_rf1_addr1[7] ,
    \cubev_rf1_addr1[6] ,
    \cubev_rf1_addr1[5] ,
    \cubev_rf1_addr1[4] ,
    \cubev_rf1_addr1[3] ,
    \cubev_rf1_addr1[2] ,
    \cubev_rf1_addr1[1] ,
    \cubev_rf1_addr1[0] }),
    .din0({\cubev_rf1_din0[31] ,
    \cubev_rf1_din0[30] ,
    \cubev_rf1_din0[29] ,
    \cubev_rf1_din0[28] ,
    \cubev_rf1_din0[27] ,
    \cubev_rf1_din0[26] ,
    \cubev_rf1_din0[25] ,
    \cubev_rf1_din0[24] ,
    \cubev_rf1_din0[23] ,
    \cubev_rf1_din0[22] ,
    \cubev_rf1_din0[21] ,
    \cubev_rf1_din0[20] ,
    \cubev_rf1_din0[19] ,
    \cubev_rf1_din0[18] ,
    \cubev_rf1_din0[17] ,
    \cubev_rf1_din0[16] ,
    \cubev_rf1_din0[15] ,
    \cubev_rf1_din0[14] ,
    \cubev_rf1_din0[13] ,
    \cubev_rf1_din0[12] ,
    \cubev_rf1_din0[11] ,
    \cubev_rf1_din0[10] ,
    \cubev_rf1_din0[9] ,
    \cubev_rf1_din0[8] ,
    \cubev_rf1_din0[7] ,
    \cubev_rf1_din0[6] ,
    \cubev_rf1_din0[5] ,
    \cubev_rf1_din0[4] ,
    \cubev_rf1_din0[3] ,
    \cubev_rf1_din0[2] ,
    \cubev_rf1_din0[1] ,
    \cubev_rf1_din0[0] }),
    .dout0({\cubev_rf1_dout0[31] ,
    \cubev_rf1_dout0[30] ,
    \cubev_rf1_dout0[29] ,
    \cubev_rf1_dout0[28] ,
    \cubev_rf1_dout0[27] ,
    \cubev_rf1_dout0[26] ,
    \cubev_rf1_dout0[25] ,
    \cubev_rf1_dout0[24] ,
    \cubev_rf1_dout0[23] ,
    \cubev_rf1_dout0[22] ,
    \cubev_rf1_dout0[21] ,
    \cubev_rf1_dout0[20] ,
    \cubev_rf1_dout0[19] ,
    \cubev_rf1_dout0[18] ,
    \cubev_rf1_dout0[17] ,
    \cubev_rf1_dout0[16] ,
    \cubev_rf1_dout0[15] ,
    \cubev_rf1_dout0[14] ,
    \cubev_rf1_dout0[13] ,
    \cubev_rf1_dout0[12] ,
    \cubev_rf1_dout0[11] ,
    \cubev_rf1_dout0[10] ,
    \cubev_rf1_dout0[9] ,
    \cubev_rf1_dout0[8] ,
    \cubev_rf1_dout0[7] ,
    \cubev_rf1_dout0[6] ,
    \cubev_rf1_dout0[5] ,
    \cubev_rf1_dout0[4] ,
    \cubev_rf1_dout0[3] ,
    \cubev_rf1_dout0[2] ,
    \cubev_rf1_dout0[1] ,
    \cubev_rf1_dout0[0] }),
    .dout1({\cubev_rf1_dout1[31] ,
    \cubev_rf1_dout1[30] ,
    \cubev_rf1_dout1[29] ,
    \cubev_rf1_dout1[28] ,
    \cubev_rf1_dout1[27] ,
    \cubev_rf1_dout1[26] ,
    \cubev_rf1_dout1[25] ,
    \cubev_rf1_dout1[24] ,
    \cubev_rf1_dout1[23] ,
    \cubev_rf1_dout1[22] ,
    \cubev_rf1_dout1[21] ,
    \cubev_rf1_dout1[20] ,
    \cubev_rf1_dout1[19] ,
    \cubev_rf1_dout1[18] ,
    \cubev_rf1_dout1[17] ,
    \cubev_rf1_dout1[16] ,
    \cubev_rf1_dout1[15] ,
    \cubev_rf1_dout1[14] ,
    \cubev_rf1_dout1[13] ,
    \cubev_rf1_dout1[12] ,
    \cubev_rf1_dout1[11] ,
    \cubev_rf1_dout1[10] ,
    \cubev_rf1_dout1[9] ,
    \cubev_rf1_dout1[8] ,
    \cubev_rf1_dout1[7] ,
    \cubev_rf1_dout1[6] ,
    \cubev_rf1_dout1[5] ,
    \cubev_rf1_dout1[4] ,
    \cubev_rf1_dout1[3] ,
    \cubev_rf1_dout1[2] ,
    \cubev_rf1_dout1[1] ,
    \cubev_rf1_dout1[0] }),
    .wmask0({\cubev_rf1_wmask0[3] ,
    \cubev_rf1_wmask0[2] ,
    \cubev_rf1_wmask0[1] ,
    \cubev_rf1_wmask0[0] }));
 rb cubev_rf1i_rb (.clk(cubev_rf1_clk1),
    .rstn(cubev_rf1_rstn),
    .dati({\cubev_rf1_dout1[31] ,
    \cubev_rf1_dout1[30] ,
    \cubev_rf1_dout1[29] ,
    \cubev_rf1_dout1[28] ,
    \cubev_rf1_dout1[27] ,
    \cubev_rf1_dout1[26] ,
    \cubev_rf1_dout1[25] ,
    \cubev_rf1_dout1[24] ,
    \cubev_rf1_dout1[23] ,
    \cubev_rf1_dout1[22] ,
    \cubev_rf1_dout1[21] ,
    \cubev_rf1_dout1[20] ,
    \cubev_rf1_dout1[19] ,
    \cubev_rf1_dout1[18] ,
    \cubev_rf1_dout1[17] ,
    \cubev_rf1_dout1[16] ,
    \cubev_rf1_dout1[15] ,
    \cubev_rf1_dout1[14] ,
    \cubev_rf1_dout1[13] ,
    \cubev_rf1_dout1[12] ,
    \cubev_rf1_dout1[11] ,
    \cubev_rf1_dout1[10] ,
    \cubev_rf1_dout1[9] ,
    \cubev_rf1_dout1[8] ,
    \cubev_rf1_dout1[7] ,
    \cubev_rf1_dout1[6] ,
    \cubev_rf1_dout1[5] ,
    \cubev_rf1_dout1[4] ,
    \cubev_rf1_dout1[3] ,
    \cubev_rf1_dout1[2] ,
    \cubev_rf1_dout1[1] ,
    \cubev_rf1_dout1[0] }),
    .dato({\cubev_rf1_dout1_reg[31] ,
    \cubev_rf1_dout1_reg[30] ,
    \cubev_rf1_dout1_reg[29] ,
    \cubev_rf1_dout1_reg[28] ,
    \cubev_rf1_dout1_reg[27] ,
    \cubev_rf1_dout1_reg[26] ,
    \cubev_rf1_dout1_reg[25] ,
    \cubev_rf1_dout1_reg[24] ,
    \cubev_rf1_dout1_reg[23] ,
    \cubev_rf1_dout1_reg[22] ,
    \cubev_rf1_dout1_reg[21] ,
    \cubev_rf1_dout1_reg[20] ,
    \cubev_rf1_dout1_reg[19] ,
    \cubev_rf1_dout1_reg[18] ,
    \cubev_rf1_dout1_reg[17] ,
    \cubev_rf1_dout1_reg[16] ,
    \cubev_rf1_dout1_reg[15] ,
    \cubev_rf1_dout1_reg[14] ,
    \cubev_rf1_dout1_reg[13] ,
    \cubev_rf1_dout1_reg[12] ,
    \cubev_rf1_dout1_reg[11] ,
    \cubev_rf1_dout1_reg[10] ,
    \cubev_rf1_dout1_reg[9] ,
    \cubev_rf1_dout1_reg[8] ,
    \cubev_rf1_dout1_reg[7] ,
    \cubev_rf1_dout1_reg[6] ,
    \cubev_rf1_dout1_reg[5] ,
    \cubev_rf1_dout1_reg[4] ,
    \cubev_rf1_dout1_reg[3] ,
    \cubev_rf1_dout1_reg[2] ,
    \cubev_rf1_dout1_reg[1] ,
    \cubev_rf1_dout1_reg[0] }));
 sky130_sram_1kbyte_1rw1r_32x256_8 cubev_rf2i (.csb0(cubev_rf2_csb0),
    .csb1(cubev_rf2_csb1),
    .web0(cubev_rf2_web0),
    .clk0(cubev_rf2_clk0),
    .clk1(cubev_rf2_clk1),
    .addr0({\cubev_rf2_addr0[7] ,
    \cubev_rf2_addr0[6] ,
    \cubev_rf2_addr0[5] ,
    \cubev_rf2_addr0[4] ,
    \cubev_rf2_addr0[3] ,
    \cubev_rf2_addr0[2] ,
    \cubev_rf2_addr0[1] ,
    \cubev_rf2_addr0[0] }),
    .addr1({\cubev_rf2_addr1[7] ,
    \cubev_rf2_addr1[6] ,
    \cubev_rf2_addr1[5] ,
    \cubev_rf2_addr1[4] ,
    \cubev_rf2_addr1[3] ,
    \cubev_rf2_addr1[2] ,
    \cubev_rf2_addr1[1] ,
    \cubev_rf2_addr1[0] }),
    .din0({\cubev_rf2_din0[31] ,
    \cubev_rf2_din0[30] ,
    \cubev_rf2_din0[29] ,
    \cubev_rf2_din0[28] ,
    \cubev_rf2_din0[27] ,
    \cubev_rf2_din0[26] ,
    \cubev_rf2_din0[25] ,
    \cubev_rf2_din0[24] ,
    \cubev_rf2_din0[23] ,
    \cubev_rf2_din0[22] ,
    \cubev_rf2_din0[21] ,
    \cubev_rf2_din0[20] ,
    \cubev_rf2_din0[19] ,
    \cubev_rf2_din0[18] ,
    \cubev_rf2_din0[17] ,
    \cubev_rf2_din0[16] ,
    \cubev_rf2_din0[15] ,
    \cubev_rf2_din0[14] ,
    \cubev_rf2_din0[13] ,
    \cubev_rf2_din0[12] ,
    \cubev_rf2_din0[11] ,
    \cubev_rf2_din0[10] ,
    \cubev_rf2_din0[9] ,
    \cubev_rf2_din0[8] ,
    \cubev_rf2_din0[7] ,
    \cubev_rf2_din0[6] ,
    \cubev_rf2_din0[5] ,
    \cubev_rf2_din0[4] ,
    \cubev_rf2_din0[3] ,
    \cubev_rf2_din0[2] ,
    \cubev_rf2_din0[1] ,
    \cubev_rf2_din0[0] }),
    .dout0({\cubev_rf2_dout0[31] ,
    \cubev_rf2_dout0[30] ,
    \cubev_rf2_dout0[29] ,
    \cubev_rf2_dout0[28] ,
    \cubev_rf2_dout0[27] ,
    \cubev_rf2_dout0[26] ,
    \cubev_rf2_dout0[25] ,
    \cubev_rf2_dout0[24] ,
    \cubev_rf2_dout0[23] ,
    \cubev_rf2_dout0[22] ,
    \cubev_rf2_dout0[21] ,
    \cubev_rf2_dout0[20] ,
    \cubev_rf2_dout0[19] ,
    \cubev_rf2_dout0[18] ,
    \cubev_rf2_dout0[17] ,
    \cubev_rf2_dout0[16] ,
    \cubev_rf2_dout0[15] ,
    \cubev_rf2_dout0[14] ,
    \cubev_rf2_dout0[13] ,
    \cubev_rf2_dout0[12] ,
    \cubev_rf2_dout0[11] ,
    \cubev_rf2_dout0[10] ,
    \cubev_rf2_dout0[9] ,
    \cubev_rf2_dout0[8] ,
    \cubev_rf2_dout0[7] ,
    \cubev_rf2_dout0[6] ,
    \cubev_rf2_dout0[5] ,
    \cubev_rf2_dout0[4] ,
    \cubev_rf2_dout0[3] ,
    \cubev_rf2_dout0[2] ,
    \cubev_rf2_dout0[1] ,
    \cubev_rf2_dout0[0] }),
    .dout1({\cubev_rf2_dout1[31] ,
    \cubev_rf2_dout1[30] ,
    \cubev_rf2_dout1[29] ,
    \cubev_rf2_dout1[28] ,
    \cubev_rf2_dout1[27] ,
    \cubev_rf2_dout1[26] ,
    \cubev_rf2_dout1[25] ,
    \cubev_rf2_dout1[24] ,
    \cubev_rf2_dout1[23] ,
    \cubev_rf2_dout1[22] ,
    \cubev_rf2_dout1[21] ,
    \cubev_rf2_dout1[20] ,
    \cubev_rf2_dout1[19] ,
    \cubev_rf2_dout1[18] ,
    \cubev_rf2_dout1[17] ,
    \cubev_rf2_dout1[16] ,
    \cubev_rf2_dout1[15] ,
    \cubev_rf2_dout1[14] ,
    \cubev_rf2_dout1[13] ,
    \cubev_rf2_dout1[12] ,
    \cubev_rf2_dout1[11] ,
    \cubev_rf2_dout1[10] ,
    \cubev_rf2_dout1[9] ,
    \cubev_rf2_dout1[8] ,
    \cubev_rf2_dout1[7] ,
    \cubev_rf2_dout1[6] ,
    \cubev_rf2_dout1[5] ,
    \cubev_rf2_dout1[4] ,
    \cubev_rf2_dout1[3] ,
    \cubev_rf2_dout1[2] ,
    \cubev_rf2_dout1[1] ,
    \cubev_rf2_dout1[0] }),
    .wmask0({\cubev_rf2_wmask0[3] ,
    \cubev_rf2_wmask0[2] ,
    \cubev_rf2_wmask0[1] ,
    \cubev_rf2_wmask0[0] }));
 rb cubev_rf2i_rb (.clk(cubev_rf2_clk1),
    .rstn(cubev_rf2_rstn),
    .dati({\cubev_rf2_dout1[31] ,
    \cubev_rf2_dout1[30] ,
    \cubev_rf2_dout1[29] ,
    \cubev_rf2_dout1[28] ,
    \cubev_rf2_dout1[27] ,
    \cubev_rf2_dout1[26] ,
    \cubev_rf2_dout1[25] ,
    \cubev_rf2_dout1[24] ,
    \cubev_rf2_dout1[23] ,
    \cubev_rf2_dout1[22] ,
    \cubev_rf2_dout1[21] ,
    \cubev_rf2_dout1[20] ,
    \cubev_rf2_dout1[19] ,
    \cubev_rf2_dout1[18] ,
    \cubev_rf2_dout1[17] ,
    \cubev_rf2_dout1[16] ,
    \cubev_rf2_dout1[15] ,
    \cubev_rf2_dout1[14] ,
    \cubev_rf2_dout1[13] ,
    \cubev_rf2_dout1[12] ,
    \cubev_rf2_dout1[11] ,
    \cubev_rf2_dout1[10] ,
    \cubev_rf2_dout1[9] ,
    \cubev_rf2_dout1[8] ,
    \cubev_rf2_dout1[7] ,
    \cubev_rf2_dout1[6] ,
    \cubev_rf2_dout1[5] ,
    \cubev_rf2_dout1[4] ,
    \cubev_rf2_dout1[3] ,
    \cubev_rf2_dout1[2] ,
    \cubev_rf2_dout1[1] ,
    \cubev_rf2_dout1[0] }),
    .dato({\cubev_rf2_dout1_reg[31] ,
    \cubev_rf2_dout1_reg[30] ,
    \cubev_rf2_dout1_reg[29] ,
    \cubev_rf2_dout1_reg[28] ,
    \cubev_rf2_dout1_reg[27] ,
    \cubev_rf2_dout1_reg[26] ,
    \cubev_rf2_dout1_reg[25] ,
    \cubev_rf2_dout1_reg[24] ,
    \cubev_rf2_dout1_reg[23] ,
    \cubev_rf2_dout1_reg[22] ,
    \cubev_rf2_dout1_reg[21] ,
    \cubev_rf2_dout1_reg[20] ,
    \cubev_rf2_dout1_reg[19] ,
    \cubev_rf2_dout1_reg[18] ,
    \cubev_rf2_dout1_reg[17] ,
    \cubev_rf2_dout1_reg[16] ,
    \cubev_rf2_dout1_reg[15] ,
    \cubev_rf2_dout1_reg[14] ,
    \cubev_rf2_dout1_reg[13] ,
    \cubev_rf2_dout1_reg[12] ,
    \cubev_rf2_dout1_reg[11] ,
    \cubev_rf2_dout1_reg[10] ,
    \cubev_rf2_dout1_reg[9] ,
    \cubev_rf2_dout1_reg[8] ,
    \cubev_rf2_dout1_reg[7] ,
    \cubev_rf2_dout1_reg[6] ,
    \cubev_rf2_dout1_reg[5] ,
    \cubev_rf2_dout1_reg[4] ,
    \cubev_rf2_dout1_reg[3] ,
    \cubev_rf2_dout1_reg[2] ,
    \cubev_rf2_dout1_reg[1] ,
    \cubev_rf2_dout1_reg[0] }));
 minisoc mprj (.ca_dbus_ack(ca_dbus_ack),
    .ca_dbus_com(ca_dbus_com),
    .ca_dbus_valid(ca_dbus_valid),
    .ca_match_ack(ca_match_ack),
    .ca_match_valid(ca_match_valid),
    .ca_time_ack(ca_time_ack),
    .ca_time_valid(ca_time_valid),
    .cubev_dhi_clk0(cubev_dhi_clk0),
    .cubev_dhi_clk1(cubev_dhi_clk1),
    .cubev_dhi_csb0(cubev_dhi_csb0),
    .cubev_dhi_csb1(cubev_dhi_csb1),
    .cubev_dhi_rstn(cubev_dhi_rstn),
    .cubev_dhi_web0(cubev_dhi_web0),
    .cubev_dli_clk0(cubev_dli_clk0),
    .cubev_dli_clk1(cubev_dli_clk1),
    .cubev_dli_csb0(cubev_dli_csb0),
    .cubev_dli_csb1(cubev_dli_csb1),
    .cubev_dli_rstn(cubev_dli_rstn),
    .cubev_dli_web0(cubev_dli_web0),
    .cubev_phi_clk1(cubev_phi_clk1),
    .cubev_phi_csb1(cubev_phi_csb1),
    .cubev_phi_rstn(cubev_phi_rstn),
    .cubev_pli_clk1(cubev_pli_clk1),
    .cubev_pli_csb1(cubev_pli_csb1),
    .cubev_pli_rstn(cubev_pli_rstn),
    .cubev_reg_0_clk0(cubev_reg_0_clk0),
    .cubev_reg_0_clk1(cubev_reg_0_clk1),
    .cubev_reg_0_csb0(cubev_reg_0_csb0),
    .cubev_reg_0_csb1(cubev_reg_0_csb1),
    .cubev_reg_0_rstn(cubev_reg_0_rstn),
    .cubev_reg_0_web0(cubev_reg_0_web0),
    .cubev_reg_1_clk0(cubev_reg_1_clk0),
    .cubev_reg_1_clk1(cubev_reg_1_clk1),
    .cubev_reg_1_csb0(cubev_reg_1_csb0),
    .cubev_reg_1_csb1(cubev_reg_1_csb1),
    .cubev_reg_1_rstn(cubev_reg_1_rstn),
    .cubev_reg_1_web0(cubev_reg_1_web0),
    .cubev_reg_2_clk0(cubev_reg_2_clk0),
    .cubev_reg_2_clk1(cubev_reg_2_clk1),
    .cubev_reg_2_csb0(cubev_reg_2_csb0),
    .cubev_reg_2_csb1(cubev_reg_2_csb1),
    .cubev_reg_2_rstn(cubev_reg_2_rstn),
    .cubev_reg_2_web0(cubev_reg_2_web0),
    .cubev_reg_3_clk0(cubev_reg_3_clk0),
    .cubev_reg_3_clk1(cubev_reg_3_clk1),
    .cubev_reg_3_csb0(cubev_reg_3_csb0),
    .cubev_reg_3_csb1(cubev_reg_3_csb1),
    .cubev_reg_3_rstn(cubev_reg_3_rstn),
    .cubev_reg_3_web0(cubev_reg_3_web0),
    .cubev_reg_4_clk0(cubev_reg_4_clk0),
    .cubev_reg_4_clk1(cubev_reg_4_clk1),
    .cubev_reg_4_csb0(cubev_reg_4_csb0),
    .cubev_reg_4_csb1(cubev_reg_4_csb1),
    .cubev_reg_4_rstn(cubev_reg_4_rstn),
    .cubev_reg_4_web0(cubev_reg_4_web0),
    .cubev_reg_5_clk0(cubev_reg_5_clk0),
    .cubev_reg_5_clk1(cubev_reg_5_clk1),
    .cubev_reg_5_csb0(cubev_reg_5_csb0),
    .cubev_reg_5_csb1(cubev_reg_5_csb1),
    .cubev_reg_5_rstn(cubev_reg_5_rstn),
    .cubev_reg_5_web0(cubev_reg_5_web0),
    .cubev_rf1_clk0(cubev_rf1_clk0),
    .cubev_rf1_clk1(cubev_rf1_clk1),
    .cubev_rf1_csb0(cubev_rf1_csb0),
    .cubev_rf1_csb1(cubev_rf1_csb1),
    .cubev_rf1_rstn(cubev_rf1_rstn),
    .cubev_rf1_web0(cubev_rf1_web0),
    .cubev_rf2_clk0(cubev_rf2_clk0),
    .cubev_rf2_clk1(cubev_rf2_clk1),
    .cubev_rf2_csb0(cubev_rf2_csb0),
    .cubev_rf2_csb1(cubev_rf2_csb1),
    .cubev_rf2_rstn(cubev_rf2_rstn),
    .cubev_rf2_web0(cubev_rf2_web0),
    .rstn_reg(rstn_reg),
    .ca_command({\ca_command[31] ,
    \ca_command[30] ,
    \ca_command[29] ,
    \ca_command[28] ,
    \ca_command[27] ,
    \ca_command[26] ,
    \ca_command[25] ,
    \ca_command[24] ,
    \ca_command[23] ,
    \ca_command[22] ,
    \ca_command[21] ,
    \ca_command[20] ,
    \ca_command[19] ,
    \ca_command[18] ,
    \ca_command[17] ,
    \ca_command[16] ,
    \ca_command[15] ,
    \ca_command[14] ,
    \ca_command[13] ,
    \ca_command[12] ,
    \ca_command[11] ,
    \ca_command[10] ,
    \ca_command[9] ,
    \ca_command[8] ,
    \ca_command[7] ,
    \ca_command[6] ,
    \ca_command[5] ,
    \ca_command[4] ,
    \ca_command[3] ,
    \ca_command[2] ,
    \ca_command[1] ,
    \ca_command[0] }),
    .ca_dbus_data({\ca_dbus_data[31] ,
    \ca_dbus_data[30] ,
    \ca_dbus_data[29] ,
    \ca_dbus_data[28] ,
    \ca_dbus_data[27] ,
    \ca_dbus_data[26] ,
    \ca_dbus_data[25] ,
    \ca_dbus_data[24] ,
    \ca_dbus_data[23] ,
    \ca_dbus_data[22] ,
    \ca_dbus_data[21] ,
    \ca_dbus_data[20] ,
    \ca_dbus_data[19] ,
    \ca_dbus_data[18] ,
    \ca_dbus_data[17] ,
    \ca_dbus_data[16] ,
    \ca_dbus_data[15] ,
    \ca_dbus_data[14] ,
    \ca_dbus_data[13] ,
    \ca_dbus_data[12] ,
    \ca_dbus_data[11] ,
    \ca_dbus_data[10] ,
    \ca_dbus_data[9] ,
    \ca_dbus_data[8] ,
    \ca_dbus_data[7] ,
    \ca_dbus_data[6] ,
    \ca_dbus_data[5] ,
    \ca_dbus_data[4] ,
    \ca_dbus_data[3] ,
    \ca_dbus_data[2] ,
    \ca_dbus_data[1] ,
    \ca_dbus_data[0] }),
    .ca_dbus_tid({\ca_dbus_tid[2] ,
    \ca_dbus_tid[1] ,
    \ca_dbus_tid[0] }),
    .ca_time_data({\ca_time_data[22] ,
    \ca_time_data[21] ,
    \ca_time_data[20] ,
    \ca_time_data[19] ,
    \ca_time_data[18] ,
    \ca_time_data[17] ,
    \ca_time_data[16] ,
    \ca_time_data[15] ,
    \ca_time_data[14] ,
    \ca_time_data[13] ,
    \ca_time_data[12] ,
    \ca_time_data[11] ,
    \ca_time_data[10] ,
    \ca_time_data[9] ,
    \ca_time_data[8] ,
    \ca_time_data[7] ,
    \ca_time_data[6] ,
    \ca_time_data[5] ,
    \ca_time_data[4] ,
    \ca_time_data[3] ,
    \ca_time_data[2] ,
    \ca_time_data[1] ,
    \ca_time_data[0] }),
    .cubev_dhi_addr0({\cubev_dhi_addr0[7] ,
    \cubev_dhi_addr0[6] ,
    \cubev_dhi_addr0[5] ,
    \cubev_dhi_addr0[4] ,
    \cubev_dhi_addr0[3] ,
    \cubev_dhi_addr0[2] ,
    \cubev_dhi_addr0[1] ,
    \cubev_dhi_addr0[0] }),
    .cubev_dhi_addr1({\cubev_dhi_addr1[7] ,
    \cubev_dhi_addr1[6] ,
    \cubev_dhi_addr1[5] ,
    \cubev_dhi_addr1[4] ,
    \cubev_dhi_addr1[3] ,
    \cubev_dhi_addr1[2] ,
    \cubev_dhi_addr1[1] ,
    \cubev_dhi_addr1[0] }),
    .cubev_dhi_din0({\cubev_dhi_din0[31] ,
    \cubev_dhi_din0[30] ,
    \cubev_dhi_din0[29] ,
    \cubev_dhi_din0[28] ,
    \cubev_dhi_din0[27] ,
    \cubev_dhi_din0[26] ,
    \cubev_dhi_din0[25] ,
    \cubev_dhi_din0[24] ,
    \cubev_dhi_din0[23] ,
    \cubev_dhi_din0[22] ,
    \cubev_dhi_din0[21] ,
    \cubev_dhi_din0[20] ,
    \cubev_dhi_din0[19] ,
    \cubev_dhi_din0[18] ,
    \cubev_dhi_din0[17] ,
    \cubev_dhi_din0[16] ,
    \cubev_dhi_din0[15] ,
    \cubev_dhi_din0[14] ,
    \cubev_dhi_din0[13] ,
    \cubev_dhi_din0[12] ,
    \cubev_dhi_din0[11] ,
    \cubev_dhi_din0[10] ,
    \cubev_dhi_din0[9] ,
    \cubev_dhi_din0[8] ,
    \cubev_dhi_din0[7] ,
    \cubev_dhi_din0[6] ,
    \cubev_dhi_din0[5] ,
    \cubev_dhi_din0[4] ,
    \cubev_dhi_din0[3] ,
    \cubev_dhi_din0[2] ,
    \cubev_dhi_din0[1] ,
    \cubev_dhi_din0[0] }),
    .cubev_dhi_dout0({\cubev_dhi_dout0[31] ,
    \cubev_dhi_dout0[30] ,
    \cubev_dhi_dout0[29] ,
    \cubev_dhi_dout0[28] ,
    \cubev_dhi_dout0[27] ,
    \cubev_dhi_dout0[26] ,
    \cubev_dhi_dout0[25] ,
    \cubev_dhi_dout0[24] ,
    \cubev_dhi_dout0[23] ,
    \cubev_dhi_dout0[22] ,
    \cubev_dhi_dout0[21] ,
    \cubev_dhi_dout0[20] ,
    \cubev_dhi_dout0[19] ,
    \cubev_dhi_dout0[18] ,
    \cubev_dhi_dout0[17] ,
    \cubev_dhi_dout0[16] ,
    \cubev_dhi_dout0[15] ,
    \cubev_dhi_dout0[14] ,
    \cubev_dhi_dout0[13] ,
    \cubev_dhi_dout0[12] ,
    \cubev_dhi_dout0[11] ,
    \cubev_dhi_dout0[10] ,
    \cubev_dhi_dout0[9] ,
    \cubev_dhi_dout0[8] ,
    \cubev_dhi_dout0[7] ,
    \cubev_dhi_dout0[6] ,
    \cubev_dhi_dout0[5] ,
    \cubev_dhi_dout0[4] ,
    \cubev_dhi_dout0[3] ,
    \cubev_dhi_dout0[2] ,
    \cubev_dhi_dout0[1] ,
    \cubev_dhi_dout0[0] }),
    .cubev_dhi_dout1({\cubev_dhi_dout1_reg[31] ,
    \cubev_dhi_dout1_reg[30] ,
    \cubev_dhi_dout1_reg[29] ,
    \cubev_dhi_dout1_reg[28] ,
    \cubev_dhi_dout1_reg[27] ,
    \cubev_dhi_dout1_reg[26] ,
    \cubev_dhi_dout1_reg[25] ,
    \cubev_dhi_dout1_reg[24] ,
    \cubev_dhi_dout1_reg[23] ,
    \cubev_dhi_dout1_reg[22] ,
    \cubev_dhi_dout1_reg[21] ,
    \cubev_dhi_dout1_reg[20] ,
    \cubev_dhi_dout1_reg[19] ,
    \cubev_dhi_dout1_reg[18] ,
    \cubev_dhi_dout1_reg[17] ,
    \cubev_dhi_dout1_reg[16] ,
    \cubev_dhi_dout1_reg[15] ,
    \cubev_dhi_dout1_reg[14] ,
    \cubev_dhi_dout1_reg[13] ,
    \cubev_dhi_dout1_reg[12] ,
    \cubev_dhi_dout1_reg[11] ,
    \cubev_dhi_dout1_reg[10] ,
    \cubev_dhi_dout1_reg[9] ,
    \cubev_dhi_dout1_reg[8] ,
    \cubev_dhi_dout1_reg[7] ,
    \cubev_dhi_dout1_reg[6] ,
    \cubev_dhi_dout1_reg[5] ,
    \cubev_dhi_dout1_reg[4] ,
    \cubev_dhi_dout1_reg[3] ,
    \cubev_dhi_dout1_reg[2] ,
    \cubev_dhi_dout1_reg[1] ,
    \cubev_dhi_dout1_reg[0] }),
    .cubev_dhi_wmask0({\cubev_dhi_wmask0[3] ,
    \cubev_dhi_wmask0[2] ,
    \cubev_dhi_wmask0[1] ,
    \cubev_dhi_wmask0[0] }),
    .cubev_dli_addr0({\cubev_dli_addr0[7] ,
    \cubev_dli_addr0[6] ,
    \cubev_dli_addr0[5] ,
    \cubev_dli_addr0[4] ,
    \cubev_dli_addr0[3] ,
    \cubev_dli_addr0[2] ,
    \cubev_dli_addr0[1] ,
    \cubev_dli_addr0[0] }),
    .cubev_dli_addr1({\cubev_dli_addr1[7] ,
    \cubev_dli_addr1[6] ,
    \cubev_dli_addr1[5] ,
    \cubev_dli_addr1[4] ,
    \cubev_dli_addr1[3] ,
    \cubev_dli_addr1[2] ,
    \cubev_dli_addr1[1] ,
    \cubev_dli_addr1[0] }),
    .cubev_dli_din0({\cubev_dli_din0[31] ,
    \cubev_dli_din0[30] ,
    \cubev_dli_din0[29] ,
    \cubev_dli_din0[28] ,
    \cubev_dli_din0[27] ,
    \cubev_dli_din0[26] ,
    \cubev_dli_din0[25] ,
    \cubev_dli_din0[24] ,
    \cubev_dli_din0[23] ,
    \cubev_dli_din0[22] ,
    \cubev_dli_din0[21] ,
    \cubev_dli_din0[20] ,
    \cubev_dli_din0[19] ,
    \cubev_dli_din0[18] ,
    \cubev_dli_din0[17] ,
    \cubev_dli_din0[16] ,
    \cubev_dli_din0[15] ,
    \cubev_dli_din0[14] ,
    \cubev_dli_din0[13] ,
    \cubev_dli_din0[12] ,
    \cubev_dli_din0[11] ,
    \cubev_dli_din0[10] ,
    \cubev_dli_din0[9] ,
    \cubev_dli_din0[8] ,
    \cubev_dli_din0[7] ,
    \cubev_dli_din0[6] ,
    \cubev_dli_din0[5] ,
    \cubev_dli_din0[4] ,
    \cubev_dli_din0[3] ,
    \cubev_dli_din0[2] ,
    \cubev_dli_din0[1] ,
    \cubev_dli_din0[0] }),
    .cubev_dli_dout0({\cubev_dli_dout0[31] ,
    \cubev_dli_dout0[30] ,
    \cubev_dli_dout0[29] ,
    \cubev_dli_dout0[28] ,
    \cubev_dli_dout0[27] ,
    \cubev_dli_dout0[26] ,
    \cubev_dli_dout0[25] ,
    \cubev_dli_dout0[24] ,
    \cubev_dli_dout0[23] ,
    \cubev_dli_dout0[22] ,
    \cubev_dli_dout0[21] ,
    \cubev_dli_dout0[20] ,
    \cubev_dli_dout0[19] ,
    \cubev_dli_dout0[18] ,
    \cubev_dli_dout0[17] ,
    \cubev_dli_dout0[16] ,
    \cubev_dli_dout0[15] ,
    \cubev_dli_dout0[14] ,
    \cubev_dli_dout0[13] ,
    \cubev_dli_dout0[12] ,
    \cubev_dli_dout0[11] ,
    \cubev_dli_dout0[10] ,
    \cubev_dli_dout0[9] ,
    \cubev_dli_dout0[8] ,
    \cubev_dli_dout0[7] ,
    \cubev_dli_dout0[6] ,
    \cubev_dli_dout0[5] ,
    \cubev_dli_dout0[4] ,
    \cubev_dli_dout0[3] ,
    \cubev_dli_dout0[2] ,
    \cubev_dli_dout0[1] ,
    \cubev_dli_dout0[0] }),
    .cubev_dli_dout1({\cubev_dli_dout1_reg[31] ,
    \cubev_dli_dout1_reg[30] ,
    \cubev_dli_dout1_reg[29] ,
    \cubev_dli_dout1_reg[28] ,
    \cubev_dli_dout1_reg[27] ,
    \cubev_dli_dout1_reg[26] ,
    \cubev_dli_dout1_reg[25] ,
    \cubev_dli_dout1_reg[24] ,
    \cubev_dli_dout1_reg[23] ,
    \cubev_dli_dout1_reg[22] ,
    \cubev_dli_dout1_reg[21] ,
    \cubev_dli_dout1_reg[20] ,
    \cubev_dli_dout1_reg[19] ,
    \cubev_dli_dout1_reg[18] ,
    \cubev_dli_dout1_reg[17] ,
    \cubev_dli_dout1_reg[16] ,
    \cubev_dli_dout1_reg[15] ,
    \cubev_dli_dout1_reg[14] ,
    \cubev_dli_dout1_reg[13] ,
    \cubev_dli_dout1_reg[12] ,
    \cubev_dli_dout1_reg[11] ,
    \cubev_dli_dout1_reg[10] ,
    \cubev_dli_dout1_reg[9] ,
    \cubev_dli_dout1_reg[8] ,
    \cubev_dli_dout1_reg[7] ,
    \cubev_dli_dout1_reg[6] ,
    \cubev_dli_dout1_reg[5] ,
    \cubev_dli_dout1_reg[4] ,
    \cubev_dli_dout1_reg[3] ,
    \cubev_dli_dout1_reg[2] ,
    \cubev_dli_dout1_reg[1] ,
    \cubev_dli_dout1_reg[0] }),
    .cubev_dli_wmask0({\cubev_dli_wmask0[3] ,
    \cubev_dli_wmask0[2] ,
    \cubev_dli_wmask0[1] ,
    \cubev_dli_wmask0[0] }),
    .cubev_phi_addr1({\cubev_phi_addr1[7] ,
    \cubev_phi_addr1[6] ,
    \cubev_phi_addr1[5] ,
    \cubev_phi_addr1[4] ,
    \cubev_phi_addr1[3] ,
    \cubev_phi_addr1[2] ,
    \cubev_phi_addr1[1] ,
    \cubev_phi_addr1[0] }),
    .cubev_phi_dout1({\cubev_phi_dout1_reg[31] ,
    \cubev_phi_dout1_reg[30] ,
    \cubev_phi_dout1_reg[29] ,
    \cubev_phi_dout1_reg[28] ,
    \cubev_phi_dout1_reg[27] ,
    \cubev_phi_dout1_reg[26] ,
    \cubev_phi_dout1_reg[25] ,
    \cubev_phi_dout1_reg[24] ,
    \cubev_phi_dout1_reg[23] ,
    \cubev_phi_dout1_reg[22] ,
    \cubev_phi_dout1_reg[21] ,
    \cubev_phi_dout1_reg[20] ,
    \cubev_phi_dout1_reg[19] ,
    \cubev_phi_dout1_reg[18] ,
    \cubev_phi_dout1_reg[17] ,
    \cubev_phi_dout1_reg[16] ,
    \cubev_phi_dout1_reg[15] ,
    \cubev_phi_dout1_reg[14] ,
    \cubev_phi_dout1_reg[13] ,
    \cubev_phi_dout1_reg[12] ,
    \cubev_phi_dout1_reg[11] ,
    \cubev_phi_dout1_reg[10] ,
    \cubev_phi_dout1_reg[9] ,
    \cubev_phi_dout1_reg[8] ,
    \cubev_phi_dout1_reg[7] ,
    \cubev_phi_dout1_reg[6] ,
    \cubev_phi_dout1_reg[5] ,
    \cubev_phi_dout1_reg[4] ,
    \cubev_phi_dout1_reg[3] ,
    \cubev_phi_dout1_reg[2] ,
    \cubev_phi_dout1_reg[1] ,
    \cubev_phi_dout1_reg[0] }),
    .cubev_pli_addr1({\cubev_pli_addr1[7] ,
    \cubev_pli_addr1[6] ,
    \cubev_pli_addr1[5] ,
    \cubev_pli_addr1[4] ,
    \cubev_pli_addr1[3] ,
    \cubev_pli_addr1[2] ,
    \cubev_pli_addr1[1] ,
    \cubev_pli_addr1[0] }),
    .cubev_pli_dout1({\cubev_pli_dout1_reg[31] ,
    \cubev_pli_dout1_reg[30] ,
    \cubev_pli_dout1_reg[29] ,
    \cubev_pli_dout1_reg[28] ,
    \cubev_pli_dout1_reg[27] ,
    \cubev_pli_dout1_reg[26] ,
    \cubev_pli_dout1_reg[25] ,
    \cubev_pli_dout1_reg[24] ,
    \cubev_pli_dout1_reg[23] ,
    \cubev_pli_dout1_reg[22] ,
    \cubev_pli_dout1_reg[21] ,
    \cubev_pli_dout1_reg[20] ,
    \cubev_pli_dout1_reg[19] ,
    \cubev_pli_dout1_reg[18] ,
    \cubev_pli_dout1_reg[17] ,
    \cubev_pli_dout1_reg[16] ,
    \cubev_pli_dout1_reg[15] ,
    \cubev_pli_dout1_reg[14] ,
    \cubev_pli_dout1_reg[13] ,
    \cubev_pli_dout1_reg[12] ,
    \cubev_pli_dout1_reg[11] ,
    \cubev_pli_dout1_reg[10] ,
    \cubev_pli_dout1_reg[9] ,
    \cubev_pli_dout1_reg[8] ,
    \cubev_pli_dout1_reg[7] ,
    \cubev_pli_dout1_reg[6] ,
    \cubev_pli_dout1_reg[5] ,
    \cubev_pli_dout1_reg[4] ,
    \cubev_pli_dout1_reg[3] ,
    \cubev_pli_dout1_reg[2] ,
    \cubev_pli_dout1_reg[1] ,
    \cubev_pli_dout1_reg[0] }),
    .cubev_reg_0_addr0({\cubev_reg_0_addr0[7] ,
    \cubev_reg_0_addr0[6] ,
    \cubev_reg_0_addr0[5] ,
    \cubev_reg_0_addr0[4] ,
    \cubev_reg_0_addr0[3] ,
    \cubev_reg_0_addr0[2] ,
    \cubev_reg_0_addr0[1] ,
    \cubev_reg_0_addr0[0] }),
    .cubev_reg_0_addr1({\cubev_reg_0_addr1[7] ,
    \cubev_reg_0_addr1[6] ,
    \cubev_reg_0_addr1[5] ,
    \cubev_reg_0_addr1[4] ,
    \cubev_reg_0_addr1[3] ,
    \cubev_reg_0_addr1[2] ,
    \cubev_reg_0_addr1[1] ,
    \cubev_reg_0_addr1[0] }),
    .cubev_reg_0_din0({\cubev_reg_0_din0[31] ,
    \cubev_reg_0_din0[30] ,
    \cubev_reg_0_din0[29] ,
    \cubev_reg_0_din0[28] ,
    \cubev_reg_0_din0[27] ,
    \cubev_reg_0_din0[26] ,
    \cubev_reg_0_din0[25] ,
    \cubev_reg_0_din0[24] ,
    \cubev_reg_0_din0[23] ,
    \cubev_reg_0_din0[22] ,
    \cubev_reg_0_din0[21] ,
    \cubev_reg_0_din0[20] ,
    \cubev_reg_0_din0[19] ,
    \cubev_reg_0_din0[18] ,
    \cubev_reg_0_din0[17] ,
    \cubev_reg_0_din0[16] ,
    \cubev_reg_0_din0[15] ,
    \cubev_reg_0_din0[14] ,
    \cubev_reg_0_din0[13] ,
    \cubev_reg_0_din0[12] ,
    \cubev_reg_0_din0[11] ,
    \cubev_reg_0_din0[10] ,
    \cubev_reg_0_din0[9] ,
    \cubev_reg_0_din0[8] ,
    \cubev_reg_0_din0[7] ,
    \cubev_reg_0_din0[6] ,
    \cubev_reg_0_din0[5] ,
    \cubev_reg_0_din0[4] ,
    \cubev_reg_0_din0[3] ,
    \cubev_reg_0_din0[2] ,
    \cubev_reg_0_din0[1] ,
    \cubev_reg_0_din0[0] }),
    .cubev_reg_0_dout0({\cubev_reg_0_dout0[31] ,
    \cubev_reg_0_dout0[30] ,
    \cubev_reg_0_dout0[29] ,
    \cubev_reg_0_dout0[28] ,
    \cubev_reg_0_dout0[27] ,
    \cubev_reg_0_dout0[26] ,
    \cubev_reg_0_dout0[25] ,
    \cubev_reg_0_dout0[24] ,
    \cubev_reg_0_dout0[23] ,
    \cubev_reg_0_dout0[22] ,
    \cubev_reg_0_dout0[21] ,
    \cubev_reg_0_dout0[20] ,
    \cubev_reg_0_dout0[19] ,
    \cubev_reg_0_dout0[18] ,
    \cubev_reg_0_dout0[17] ,
    \cubev_reg_0_dout0[16] ,
    \cubev_reg_0_dout0[15] ,
    \cubev_reg_0_dout0[14] ,
    \cubev_reg_0_dout0[13] ,
    \cubev_reg_0_dout0[12] ,
    \cubev_reg_0_dout0[11] ,
    \cubev_reg_0_dout0[10] ,
    \cubev_reg_0_dout0[9] ,
    \cubev_reg_0_dout0[8] ,
    \cubev_reg_0_dout0[7] ,
    \cubev_reg_0_dout0[6] ,
    \cubev_reg_0_dout0[5] ,
    \cubev_reg_0_dout0[4] ,
    \cubev_reg_0_dout0[3] ,
    \cubev_reg_0_dout0[2] ,
    \cubev_reg_0_dout0[1] ,
    \cubev_reg_0_dout0[0] }),
    .cubev_reg_0_dout1({\cubev_reg_0_dout1_reg[31] ,
    \cubev_reg_0_dout1_reg[30] ,
    \cubev_reg_0_dout1_reg[29] ,
    \cubev_reg_0_dout1_reg[28] ,
    \cubev_reg_0_dout1_reg[27] ,
    \cubev_reg_0_dout1_reg[26] ,
    \cubev_reg_0_dout1_reg[25] ,
    \cubev_reg_0_dout1_reg[24] ,
    \cubev_reg_0_dout1_reg[23] ,
    \cubev_reg_0_dout1_reg[22] ,
    \cubev_reg_0_dout1_reg[21] ,
    \cubev_reg_0_dout1_reg[20] ,
    \cubev_reg_0_dout1_reg[19] ,
    \cubev_reg_0_dout1_reg[18] ,
    \cubev_reg_0_dout1_reg[17] ,
    \cubev_reg_0_dout1_reg[16] ,
    \cubev_reg_0_dout1_reg[15] ,
    \cubev_reg_0_dout1_reg[14] ,
    \cubev_reg_0_dout1_reg[13] ,
    \cubev_reg_0_dout1_reg[12] ,
    \cubev_reg_0_dout1_reg[11] ,
    \cubev_reg_0_dout1_reg[10] ,
    \cubev_reg_0_dout1_reg[9] ,
    \cubev_reg_0_dout1_reg[8] ,
    \cubev_reg_0_dout1_reg[7] ,
    \cubev_reg_0_dout1_reg[6] ,
    \cubev_reg_0_dout1_reg[5] ,
    \cubev_reg_0_dout1_reg[4] ,
    \cubev_reg_0_dout1_reg[3] ,
    \cubev_reg_0_dout1_reg[2] ,
    \cubev_reg_0_dout1_reg[1] ,
    \cubev_reg_0_dout1_reg[0] }),
    .cubev_reg_0_wmask0({\cubev_reg_0_wmask0[3] ,
    \cubev_reg_0_wmask0[2] ,
    \cubev_reg_0_wmask0[1] ,
    \cubev_reg_0_wmask0[0] }),
    .cubev_reg_1_addr0({\cubev_reg_1_addr0[7] ,
    \cubev_reg_1_addr0[6] ,
    \cubev_reg_1_addr0[5] ,
    \cubev_reg_1_addr0[4] ,
    \cubev_reg_1_addr0[3] ,
    \cubev_reg_1_addr0[2] ,
    \cubev_reg_1_addr0[1] ,
    \cubev_reg_1_addr0[0] }),
    .cubev_reg_1_addr1({\cubev_reg_1_addr1[7] ,
    \cubev_reg_1_addr1[6] ,
    \cubev_reg_1_addr1[5] ,
    \cubev_reg_1_addr1[4] ,
    \cubev_reg_1_addr1[3] ,
    \cubev_reg_1_addr1[2] ,
    \cubev_reg_1_addr1[1] ,
    \cubev_reg_1_addr1[0] }),
    .cubev_reg_1_din0({\cubev_reg_1_din0[31] ,
    \cubev_reg_1_din0[30] ,
    \cubev_reg_1_din0[29] ,
    \cubev_reg_1_din0[28] ,
    \cubev_reg_1_din0[27] ,
    \cubev_reg_1_din0[26] ,
    \cubev_reg_1_din0[25] ,
    \cubev_reg_1_din0[24] ,
    \cubev_reg_1_din0[23] ,
    \cubev_reg_1_din0[22] ,
    \cubev_reg_1_din0[21] ,
    \cubev_reg_1_din0[20] ,
    \cubev_reg_1_din0[19] ,
    \cubev_reg_1_din0[18] ,
    \cubev_reg_1_din0[17] ,
    \cubev_reg_1_din0[16] ,
    \cubev_reg_1_din0[15] ,
    \cubev_reg_1_din0[14] ,
    \cubev_reg_1_din0[13] ,
    \cubev_reg_1_din0[12] ,
    \cubev_reg_1_din0[11] ,
    \cubev_reg_1_din0[10] ,
    \cubev_reg_1_din0[9] ,
    \cubev_reg_1_din0[8] ,
    \cubev_reg_1_din0[7] ,
    \cubev_reg_1_din0[6] ,
    \cubev_reg_1_din0[5] ,
    \cubev_reg_1_din0[4] ,
    \cubev_reg_1_din0[3] ,
    \cubev_reg_1_din0[2] ,
    \cubev_reg_1_din0[1] ,
    \cubev_reg_1_din0[0] }),
    .cubev_reg_1_dout0({\cubev_reg_1_dout0[31] ,
    \cubev_reg_1_dout0[30] ,
    \cubev_reg_1_dout0[29] ,
    \cubev_reg_1_dout0[28] ,
    \cubev_reg_1_dout0[27] ,
    \cubev_reg_1_dout0[26] ,
    \cubev_reg_1_dout0[25] ,
    \cubev_reg_1_dout0[24] ,
    \cubev_reg_1_dout0[23] ,
    \cubev_reg_1_dout0[22] ,
    \cubev_reg_1_dout0[21] ,
    \cubev_reg_1_dout0[20] ,
    \cubev_reg_1_dout0[19] ,
    \cubev_reg_1_dout0[18] ,
    \cubev_reg_1_dout0[17] ,
    \cubev_reg_1_dout0[16] ,
    \cubev_reg_1_dout0[15] ,
    \cubev_reg_1_dout0[14] ,
    \cubev_reg_1_dout0[13] ,
    \cubev_reg_1_dout0[12] ,
    \cubev_reg_1_dout0[11] ,
    \cubev_reg_1_dout0[10] ,
    \cubev_reg_1_dout0[9] ,
    \cubev_reg_1_dout0[8] ,
    \cubev_reg_1_dout0[7] ,
    \cubev_reg_1_dout0[6] ,
    \cubev_reg_1_dout0[5] ,
    \cubev_reg_1_dout0[4] ,
    \cubev_reg_1_dout0[3] ,
    \cubev_reg_1_dout0[2] ,
    \cubev_reg_1_dout0[1] ,
    \cubev_reg_1_dout0[0] }),
    .cubev_reg_1_dout1({\cubev_reg_1_dout1_reg[31] ,
    \cubev_reg_1_dout1_reg[30] ,
    \cubev_reg_1_dout1_reg[29] ,
    \cubev_reg_1_dout1_reg[28] ,
    \cubev_reg_1_dout1_reg[27] ,
    \cubev_reg_1_dout1_reg[26] ,
    \cubev_reg_1_dout1_reg[25] ,
    \cubev_reg_1_dout1_reg[24] ,
    \cubev_reg_1_dout1_reg[23] ,
    \cubev_reg_1_dout1_reg[22] ,
    \cubev_reg_1_dout1_reg[21] ,
    \cubev_reg_1_dout1_reg[20] ,
    \cubev_reg_1_dout1_reg[19] ,
    \cubev_reg_1_dout1_reg[18] ,
    \cubev_reg_1_dout1_reg[17] ,
    \cubev_reg_1_dout1_reg[16] ,
    \cubev_reg_1_dout1_reg[15] ,
    \cubev_reg_1_dout1_reg[14] ,
    \cubev_reg_1_dout1_reg[13] ,
    \cubev_reg_1_dout1_reg[12] ,
    \cubev_reg_1_dout1_reg[11] ,
    \cubev_reg_1_dout1_reg[10] ,
    \cubev_reg_1_dout1_reg[9] ,
    \cubev_reg_1_dout1_reg[8] ,
    \cubev_reg_1_dout1_reg[7] ,
    \cubev_reg_1_dout1_reg[6] ,
    \cubev_reg_1_dout1_reg[5] ,
    \cubev_reg_1_dout1_reg[4] ,
    \cubev_reg_1_dout1_reg[3] ,
    \cubev_reg_1_dout1_reg[2] ,
    \cubev_reg_1_dout1_reg[1] ,
    \cubev_reg_1_dout1_reg[0] }),
    .cubev_reg_1_wmask0({\cubev_reg_1_wmask0[3] ,
    \cubev_reg_1_wmask0[2] ,
    \cubev_reg_1_wmask0[1] ,
    \cubev_reg_1_wmask0[0] }),
    .cubev_reg_2_addr0({\cubev_reg_2_addr0[7] ,
    \cubev_reg_2_addr0[6] ,
    \cubev_reg_2_addr0[5] ,
    \cubev_reg_2_addr0[4] ,
    \cubev_reg_2_addr0[3] ,
    \cubev_reg_2_addr0[2] ,
    \cubev_reg_2_addr0[1] ,
    \cubev_reg_2_addr0[0] }),
    .cubev_reg_2_addr1({\cubev_reg_2_addr1[7] ,
    \cubev_reg_2_addr1[6] ,
    \cubev_reg_2_addr1[5] ,
    \cubev_reg_2_addr1[4] ,
    \cubev_reg_2_addr1[3] ,
    \cubev_reg_2_addr1[2] ,
    \cubev_reg_2_addr1[1] ,
    \cubev_reg_2_addr1[0] }),
    .cubev_reg_2_din0({\cubev_reg_2_din0[31] ,
    \cubev_reg_2_din0[30] ,
    \cubev_reg_2_din0[29] ,
    \cubev_reg_2_din0[28] ,
    \cubev_reg_2_din0[27] ,
    \cubev_reg_2_din0[26] ,
    \cubev_reg_2_din0[25] ,
    \cubev_reg_2_din0[24] ,
    \cubev_reg_2_din0[23] ,
    \cubev_reg_2_din0[22] ,
    \cubev_reg_2_din0[21] ,
    \cubev_reg_2_din0[20] ,
    \cubev_reg_2_din0[19] ,
    \cubev_reg_2_din0[18] ,
    \cubev_reg_2_din0[17] ,
    \cubev_reg_2_din0[16] ,
    \cubev_reg_2_din0[15] ,
    \cubev_reg_2_din0[14] ,
    \cubev_reg_2_din0[13] ,
    \cubev_reg_2_din0[12] ,
    \cubev_reg_2_din0[11] ,
    \cubev_reg_2_din0[10] ,
    \cubev_reg_2_din0[9] ,
    \cubev_reg_2_din0[8] ,
    \cubev_reg_2_din0[7] ,
    \cubev_reg_2_din0[6] ,
    \cubev_reg_2_din0[5] ,
    \cubev_reg_2_din0[4] ,
    \cubev_reg_2_din0[3] ,
    \cubev_reg_2_din0[2] ,
    \cubev_reg_2_din0[1] ,
    \cubev_reg_2_din0[0] }),
    .cubev_reg_2_dout0({\cubev_reg_2_dout0[31] ,
    \cubev_reg_2_dout0[30] ,
    \cubev_reg_2_dout0[29] ,
    \cubev_reg_2_dout0[28] ,
    \cubev_reg_2_dout0[27] ,
    \cubev_reg_2_dout0[26] ,
    \cubev_reg_2_dout0[25] ,
    \cubev_reg_2_dout0[24] ,
    \cubev_reg_2_dout0[23] ,
    \cubev_reg_2_dout0[22] ,
    \cubev_reg_2_dout0[21] ,
    \cubev_reg_2_dout0[20] ,
    \cubev_reg_2_dout0[19] ,
    \cubev_reg_2_dout0[18] ,
    \cubev_reg_2_dout0[17] ,
    \cubev_reg_2_dout0[16] ,
    \cubev_reg_2_dout0[15] ,
    \cubev_reg_2_dout0[14] ,
    \cubev_reg_2_dout0[13] ,
    \cubev_reg_2_dout0[12] ,
    \cubev_reg_2_dout0[11] ,
    \cubev_reg_2_dout0[10] ,
    \cubev_reg_2_dout0[9] ,
    \cubev_reg_2_dout0[8] ,
    \cubev_reg_2_dout0[7] ,
    \cubev_reg_2_dout0[6] ,
    \cubev_reg_2_dout0[5] ,
    \cubev_reg_2_dout0[4] ,
    \cubev_reg_2_dout0[3] ,
    \cubev_reg_2_dout0[2] ,
    \cubev_reg_2_dout0[1] ,
    \cubev_reg_2_dout0[0] }),
    .cubev_reg_2_dout1({\cubev_reg_2_dout1_reg[31] ,
    \cubev_reg_2_dout1_reg[30] ,
    \cubev_reg_2_dout1_reg[29] ,
    \cubev_reg_2_dout1_reg[28] ,
    \cubev_reg_2_dout1_reg[27] ,
    \cubev_reg_2_dout1_reg[26] ,
    \cubev_reg_2_dout1_reg[25] ,
    \cubev_reg_2_dout1_reg[24] ,
    \cubev_reg_2_dout1_reg[23] ,
    \cubev_reg_2_dout1_reg[22] ,
    \cubev_reg_2_dout1_reg[21] ,
    \cubev_reg_2_dout1_reg[20] ,
    \cubev_reg_2_dout1_reg[19] ,
    \cubev_reg_2_dout1_reg[18] ,
    \cubev_reg_2_dout1_reg[17] ,
    \cubev_reg_2_dout1_reg[16] ,
    \cubev_reg_2_dout1_reg[15] ,
    \cubev_reg_2_dout1_reg[14] ,
    \cubev_reg_2_dout1_reg[13] ,
    \cubev_reg_2_dout1_reg[12] ,
    \cubev_reg_2_dout1_reg[11] ,
    \cubev_reg_2_dout1_reg[10] ,
    \cubev_reg_2_dout1_reg[9] ,
    \cubev_reg_2_dout1_reg[8] ,
    \cubev_reg_2_dout1_reg[7] ,
    \cubev_reg_2_dout1_reg[6] ,
    \cubev_reg_2_dout1_reg[5] ,
    \cubev_reg_2_dout1_reg[4] ,
    \cubev_reg_2_dout1_reg[3] ,
    \cubev_reg_2_dout1_reg[2] ,
    \cubev_reg_2_dout1_reg[1] ,
    \cubev_reg_2_dout1_reg[0] }),
    .cubev_reg_2_wmask0({\cubev_reg_2_wmask0[3] ,
    \cubev_reg_2_wmask0[2] ,
    \cubev_reg_2_wmask0[1] ,
    \cubev_reg_2_wmask0[0] }),
    .cubev_reg_3_addr0({\cubev_reg_3_addr0[7] ,
    \cubev_reg_3_addr0[6] ,
    \cubev_reg_3_addr0[5] ,
    \cubev_reg_3_addr0[4] ,
    \cubev_reg_3_addr0[3] ,
    \cubev_reg_3_addr0[2] ,
    \cubev_reg_3_addr0[1] ,
    \cubev_reg_3_addr0[0] }),
    .cubev_reg_3_addr1({\cubev_reg_3_addr1[7] ,
    \cubev_reg_3_addr1[6] ,
    \cubev_reg_3_addr1[5] ,
    \cubev_reg_3_addr1[4] ,
    \cubev_reg_3_addr1[3] ,
    \cubev_reg_3_addr1[2] ,
    \cubev_reg_3_addr1[1] ,
    \cubev_reg_3_addr1[0] }),
    .cubev_reg_3_din0({\cubev_reg_3_din0[31] ,
    \cubev_reg_3_din0[30] ,
    \cubev_reg_3_din0[29] ,
    \cubev_reg_3_din0[28] ,
    \cubev_reg_3_din0[27] ,
    \cubev_reg_3_din0[26] ,
    \cubev_reg_3_din0[25] ,
    \cubev_reg_3_din0[24] ,
    \cubev_reg_3_din0[23] ,
    \cubev_reg_3_din0[22] ,
    \cubev_reg_3_din0[21] ,
    \cubev_reg_3_din0[20] ,
    \cubev_reg_3_din0[19] ,
    \cubev_reg_3_din0[18] ,
    \cubev_reg_3_din0[17] ,
    \cubev_reg_3_din0[16] ,
    \cubev_reg_3_din0[15] ,
    \cubev_reg_3_din0[14] ,
    \cubev_reg_3_din0[13] ,
    \cubev_reg_3_din0[12] ,
    \cubev_reg_3_din0[11] ,
    \cubev_reg_3_din0[10] ,
    \cubev_reg_3_din0[9] ,
    \cubev_reg_3_din0[8] ,
    \cubev_reg_3_din0[7] ,
    \cubev_reg_3_din0[6] ,
    \cubev_reg_3_din0[5] ,
    \cubev_reg_3_din0[4] ,
    \cubev_reg_3_din0[3] ,
    \cubev_reg_3_din0[2] ,
    \cubev_reg_3_din0[1] ,
    \cubev_reg_3_din0[0] }),
    .cubev_reg_3_dout0({\cubev_reg_3_dout0[31] ,
    \cubev_reg_3_dout0[30] ,
    \cubev_reg_3_dout0[29] ,
    \cubev_reg_3_dout0[28] ,
    \cubev_reg_3_dout0[27] ,
    \cubev_reg_3_dout0[26] ,
    \cubev_reg_3_dout0[25] ,
    \cubev_reg_3_dout0[24] ,
    \cubev_reg_3_dout0[23] ,
    \cubev_reg_3_dout0[22] ,
    \cubev_reg_3_dout0[21] ,
    \cubev_reg_3_dout0[20] ,
    \cubev_reg_3_dout0[19] ,
    \cubev_reg_3_dout0[18] ,
    \cubev_reg_3_dout0[17] ,
    \cubev_reg_3_dout0[16] ,
    \cubev_reg_3_dout0[15] ,
    \cubev_reg_3_dout0[14] ,
    \cubev_reg_3_dout0[13] ,
    \cubev_reg_3_dout0[12] ,
    \cubev_reg_3_dout0[11] ,
    \cubev_reg_3_dout0[10] ,
    \cubev_reg_3_dout0[9] ,
    \cubev_reg_3_dout0[8] ,
    \cubev_reg_3_dout0[7] ,
    \cubev_reg_3_dout0[6] ,
    \cubev_reg_3_dout0[5] ,
    \cubev_reg_3_dout0[4] ,
    \cubev_reg_3_dout0[3] ,
    \cubev_reg_3_dout0[2] ,
    \cubev_reg_3_dout0[1] ,
    \cubev_reg_3_dout0[0] }),
    .cubev_reg_3_dout1({\cubev_reg_3_dout1_reg[31] ,
    \cubev_reg_3_dout1_reg[30] ,
    \cubev_reg_3_dout1_reg[29] ,
    \cubev_reg_3_dout1_reg[28] ,
    \cubev_reg_3_dout1_reg[27] ,
    \cubev_reg_3_dout1_reg[26] ,
    \cubev_reg_3_dout1_reg[25] ,
    \cubev_reg_3_dout1_reg[24] ,
    \cubev_reg_3_dout1_reg[23] ,
    \cubev_reg_3_dout1_reg[22] ,
    \cubev_reg_3_dout1_reg[21] ,
    \cubev_reg_3_dout1_reg[20] ,
    \cubev_reg_3_dout1_reg[19] ,
    \cubev_reg_3_dout1_reg[18] ,
    \cubev_reg_3_dout1_reg[17] ,
    \cubev_reg_3_dout1_reg[16] ,
    \cubev_reg_3_dout1_reg[15] ,
    \cubev_reg_3_dout1_reg[14] ,
    \cubev_reg_3_dout1_reg[13] ,
    \cubev_reg_3_dout1_reg[12] ,
    \cubev_reg_3_dout1_reg[11] ,
    \cubev_reg_3_dout1_reg[10] ,
    \cubev_reg_3_dout1_reg[9] ,
    \cubev_reg_3_dout1_reg[8] ,
    \cubev_reg_3_dout1_reg[7] ,
    \cubev_reg_3_dout1_reg[6] ,
    \cubev_reg_3_dout1_reg[5] ,
    \cubev_reg_3_dout1_reg[4] ,
    \cubev_reg_3_dout1_reg[3] ,
    \cubev_reg_3_dout1_reg[2] ,
    \cubev_reg_3_dout1_reg[1] ,
    \cubev_reg_3_dout1_reg[0] }),
    .cubev_reg_3_wmask0({\cubev_reg_3_wmask0[3] ,
    \cubev_reg_3_wmask0[2] ,
    \cubev_reg_3_wmask0[1] ,
    \cubev_reg_3_wmask0[0] }),
    .cubev_reg_4_addr0({\cubev_reg_4_addr0[7] ,
    \cubev_reg_4_addr0[6] ,
    \cubev_reg_4_addr0[5] ,
    \cubev_reg_4_addr0[4] ,
    \cubev_reg_4_addr0[3] ,
    \cubev_reg_4_addr0[2] ,
    \cubev_reg_4_addr0[1] ,
    \cubev_reg_4_addr0[0] }),
    .cubev_reg_4_addr1({\cubev_reg_4_addr1[7] ,
    \cubev_reg_4_addr1[6] ,
    \cubev_reg_4_addr1[5] ,
    \cubev_reg_4_addr1[4] ,
    \cubev_reg_4_addr1[3] ,
    \cubev_reg_4_addr1[2] ,
    \cubev_reg_4_addr1[1] ,
    \cubev_reg_4_addr1[0] }),
    .cubev_reg_4_din0({\cubev_reg_4_din0[31] ,
    \cubev_reg_4_din0[30] ,
    \cubev_reg_4_din0[29] ,
    \cubev_reg_4_din0[28] ,
    \cubev_reg_4_din0[27] ,
    \cubev_reg_4_din0[26] ,
    \cubev_reg_4_din0[25] ,
    \cubev_reg_4_din0[24] ,
    \cubev_reg_4_din0[23] ,
    \cubev_reg_4_din0[22] ,
    \cubev_reg_4_din0[21] ,
    \cubev_reg_4_din0[20] ,
    \cubev_reg_4_din0[19] ,
    \cubev_reg_4_din0[18] ,
    \cubev_reg_4_din0[17] ,
    \cubev_reg_4_din0[16] ,
    \cubev_reg_4_din0[15] ,
    \cubev_reg_4_din0[14] ,
    \cubev_reg_4_din0[13] ,
    \cubev_reg_4_din0[12] ,
    \cubev_reg_4_din0[11] ,
    \cubev_reg_4_din0[10] ,
    \cubev_reg_4_din0[9] ,
    \cubev_reg_4_din0[8] ,
    \cubev_reg_4_din0[7] ,
    \cubev_reg_4_din0[6] ,
    \cubev_reg_4_din0[5] ,
    \cubev_reg_4_din0[4] ,
    \cubev_reg_4_din0[3] ,
    \cubev_reg_4_din0[2] ,
    \cubev_reg_4_din0[1] ,
    \cubev_reg_4_din0[0] }),
    .cubev_reg_4_dout0({\cubev_reg_4_dout0[31] ,
    \cubev_reg_4_dout0[30] ,
    \cubev_reg_4_dout0[29] ,
    \cubev_reg_4_dout0[28] ,
    \cubev_reg_4_dout0[27] ,
    \cubev_reg_4_dout0[26] ,
    \cubev_reg_4_dout0[25] ,
    \cubev_reg_4_dout0[24] ,
    \cubev_reg_4_dout0[23] ,
    \cubev_reg_4_dout0[22] ,
    \cubev_reg_4_dout0[21] ,
    \cubev_reg_4_dout0[20] ,
    \cubev_reg_4_dout0[19] ,
    \cubev_reg_4_dout0[18] ,
    \cubev_reg_4_dout0[17] ,
    \cubev_reg_4_dout0[16] ,
    \cubev_reg_4_dout0[15] ,
    \cubev_reg_4_dout0[14] ,
    \cubev_reg_4_dout0[13] ,
    \cubev_reg_4_dout0[12] ,
    \cubev_reg_4_dout0[11] ,
    \cubev_reg_4_dout0[10] ,
    \cubev_reg_4_dout0[9] ,
    \cubev_reg_4_dout0[8] ,
    \cubev_reg_4_dout0[7] ,
    \cubev_reg_4_dout0[6] ,
    \cubev_reg_4_dout0[5] ,
    \cubev_reg_4_dout0[4] ,
    \cubev_reg_4_dout0[3] ,
    \cubev_reg_4_dout0[2] ,
    \cubev_reg_4_dout0[1] ,
    \cubev_reg_4_dout0[0] }),
    .cubev_reg_4_dout1({\cubev_reg_4_dout1_reg[31] ,
    \cubev_reg_4_dout1_reg[30] ,
    \cubev_reg_4_dout1_reg[29] ,
    \cubev_reg_4_dout1_reg[28] ,
    \cubev_reg_4_dout1_reg[27] ,
    \cubev_reg_4_dout1_reg[26] ,
    \cubev_reg_4_dout1_reg[25] ,
    \cubev_reg_4_dout1_reg[24] ,
    \cubev_reg_4_dout1_reg[23] ,
    \cubev_reg_4_dout1_reg[22] ,
    \cubev_reg_4_dout1_reg[21] ,
    \cubev_reg_4_dout1_reg[20] ,
    \cubev_reg_4_dout1_reg[19] ,
    \cubev_reg_4_dout1_reg[18] ,
    \cubev_reg_4_dout1_reg[17] ,
    \cubev_reg_4_dout1_reg[16] ,
    \cubev_reg_4_dout1_reg[15] ,
    \cubev_reg_4_dout1_reg[14] ,
    \cubev_reg_4_dout1_reg[13] ,
    \cubev_reg_4_dout1_reg[12] ,
    \cubev_reg_4_dout1_reg[11] ,
    \cubev_reg_4_dout1_reg[10] ,
    \cubev_reg_4_dout1_reg[9] ,
    \cubev_reg_4_dout1_reg[8] ,
    \cubev_reg_4_dout1_reg[7] ,
    \cubev_reg_4_dout1_reg[6] ,
    \cubev_reg_4_dout1_reg[5] ,
    \cubev_reg_4_dout1_reg[4] ,
    \cubev_reg_4_dout1_reg[3] ,
    \cubev_reg_4_dout1_reg[2] ,
    \cubev_reg_4_dout1_reg[1] ,
    \cubev_reg_4_dout1_reg[0] }),
    .cubev_reg_4_wmask0({\cubev_reg_4_wmask0[3] ,
    \cubev_reg_4_wmask0[2] ,
    \cubev_reg_4_wmask0[1] ,
    \cubev_reg_4_wmask0[0] }),
    .cubev_reg_5_addr0({\cubev_reg_5_addr0[7] ,
    \cubev_reg_5_addr0[6] ,
    \cubev_reg_5_addr0[5] ,
    \cubev_reg_5_addr0[4] ,
    \cubev_reg_5_addr0[3] ,
    \cubev_reg_5_addr0[2] ,
    \cubev_reg_5_addr0[1] ,
    \cubev_reg_5_addr0[0] }),
    .cubev_reg_5_addr1({\cubev_reg_5_addr1[7] ,
    \cubev_reg_5_addr1[6] ,
    \cubev_reg_5_addr1[5] ,
    \cubev_reg_5_addr1[4] ,
    \cubev_reg_5_addr1[3] ,
    \cubev_reg_5_addr1[2] ,
    \cubev_reg_5_addr1[1] ,
    \cubev_reg_5_addr1[0] }),
    .cubev_reg_5_din0({\cubev_reg_5_din0[31] ,
    \cubev_reg_5_din0[30] ,
    \cubev_reg_5_din0[29] ,
    \cubev_reg_5_din0[28] ,
    \cubev_reg_5_din0[27] ,
    \cubev_reg_5_din0[26] ,
    \cubev_reg_5_din0[25] ,
    \cubev_reg_5_din0[24] ,
    \cubev_reg_5_din0[23] ,
    \cubev_reg_5_din0[22] ,
    \cubev_reg_5_din0[21] ,
    \cubev_reg_5_din0[20] ,
    \cubev_reg_5_din0[19] ,
    \cubev_reg_5_din0[18] ,
    \cubev_reg_5_din0[17] ,
    \cubev_reg_5_din0[16] ,
    \cubev_reg_5_din0[15] ,
    \cubev_reg_5_din0[14] ,
    \cubev_reg_5_din0[13] ,
    \cubev_reg_5_din0[12] ,
    \cubev_reg_5_din0[11] ,
    \cubev_reg_5_din0[10] ,
    \cubev_reg_5_din0[9] ,
    \cubev_reg_5_din0[8] ,
    \cubev_reg_5_din0[7] ,
    \cubev_reg_5_din0[6] ,
    \cubev_reg_5_din0[5] ,
    \cubev_reg_5_din0[4] ,
    \cubev_reg_5_din0[3] ,
    \cubev_reg_5_din0[2] ,
    \cubev_reg_5_din0[1] ,
    \cubev_reg_5_din0[0] }),
    .cubev_reg_5_dout0({\cubev_reg_5_dout0[31] ,
    \cubev_reg_5_dout0[30] ,
    \cubev_reg_5_dout0[29] ,
    \cubev_reg_5_dout0[28] ,
    \cubev_reg_5_dout0[27] ,
    \cubev_reg_5_dout0[26] ,
    \cubev_reg_5_dout0[25] ,
    \cubev_reg_5_dout0[24] ,
    \cubev_reg_5_dout0[23] ,
    \cubev_reg_5_dout0[22] ,
    \cubev_reg_5_dout0[21] ,
    \cubev_reg_5_dout0[20] ,
    \cubev_reg_5_dout0[19] ,
    \cubev_reg_5_dout0[18] ,
    \cubev_reg_5_dout0[17] ,
    \cubev_reg_5_dout0[16] ,
    \cubev_reg_5_dout0[15] ,
    \cubev_reg_5_dout0[14] ,
    \cubev_reg_5_dout0[13] ,
    \cubev_reg_5_dout0[12] ,
    \cubev_reg_5_dout0[11] ,
    \cubev_reg_5_dout0[10] ,
    \cubev_reg_5_dout0[9] ,
    \cubev_reg_5_dout0[8] ,
    \cubev_reg_5_dout0[7] ,
    \cubev_reg_5_dout0[6] ,
    \cubev_reg_5_dout0[5] ,
    \cubev_reg_5_dout0[4] ,
    \cubev_reg_5_dout0[3] ,
    \cubev_reg_5_dout0[2] ,
    \cubev_reg_5_dout0[1] ,
    \cubev_reg_5_dout0[0] }),
    .cubev_reg_5_dout1({\cubev_reg_5_dout1_reg[31] ,
    \cubev_reg_5_dout1_reg[30] ,
    \cubev_reg_5_dout1_reg[29] ,
    \cubev_reg_5_dout1_reg[28] ,
    \cubev_reg_5_dout1_reg[27] ,
    \cubev_reg_5_dout1_reg[26] ,
    \cubev_reg_5_dout1_reg[25] ,
    \cubev_reg_5_dout1_reg[24] ,
    \cubev_reg_5_dout1_reg[23] ,
    \cubev_reg_5_dout1_reg[22] ,
    \cubev_reg_5_dout1_reg[21] ,
    \cubev_reg_5_dout1_reg[20] ,
    \cubev_reg_5_dout1_reg[19] ,
    \cubev_reg_5_dout1_reg[18] ,
    \cubev_reg_5_dout1_reg[17] ,
    \cubev_reg_5_dout1_reg[16] ,
    \cubev_reg_5_dout1_reg[15] ,
    \cubev_reg_5_dout1_reg[14] ,
    \cubev_reg_5_dout1_reg[13] ,
    \cubev_reg_5_dout1_reg[12] ,
    \cubev_reg_5_dout1_reg[11] ,
    \cubev_reg_5_dout1_reg[10] ,
    \cubev_reg_5_dout1_reg[9] ,
    \cubev_reg_5_dout1_reg[8] ,
    \cubev_reg_5_dout1_reg[7] ,
    \cubev_reg_5_dout1_reg[6] ,
    \cubev_reg_5_dout1_reg[5] ,
    \cubev_reg_5_dout1_reg[4] ,
    \cubev_reg_5_dout1_reg[3] ,
    \cubev_reg_5_dout1_reg[2] ,
    \cubev_reg_5_dout1_reg[1] ,
    \cubev_reg_5_dout1_reg[0] }),
    .cubev_reg_5_wmask0({\cubev_reg_5_wmask0[3] ,
    \cubev_reg_5_wmask0[2] ,
    \cubev_reg_5_wmask0[1] ,
    \cubev_reg_5_wmask0[0] }),
    .cubev_rf1_addr0({\cubev_rf1_addr0[7] ,
    \cubev_rf1_addr0[6] ,
    \cubev_rf1_addr0[5] ,
    \cubev_rf1_addr0[4] ,
    \cubev_rf1_addr0[3] ,
    \cubev_rf1_addr0[2] ,
    \cubev_rf1_addr0[1] ,
    \cubev_rf1_addr0[0] }),
    .cubev_rf1_addr1({\cubev_rf1_addr1[7] ,
    \cubev_rf1_addr1[6] ,
    \cubev_rf1_addr1[5] ,
    \cubev_rf1_addr1[4] ,
    \cubev_rf1_addr1[3] ,
    \cubev_rf1_addr1[2] ,
    \cubev_rf1_addr1[1] ,
    \cubev_rf1_addr1[0] }),
    .cubev_rf1_din0({\cubev_rf1_din0[31] ,
    \cubev_rf1_din0[30] ,
    \cubev_rf1_din0[29] ,
    \cubev_rf1_din0[28] ,
    \cubev_rf1_din0[27] ,
    \cubev_rf1_din0[26] ,
    \cubev_rf1_din0[25] ,
    \cubev_rf1_din0[24] ,
    \cubev_rf1_din0[23] ,
    \cubev_rf1_din0[22] ,
    \cubev_rf1_din0[21] ,
    \cubev_rf1_din0[20] ,
    \cubev_rf1_din0[19] ,
    \cubev_rf1_din0[18] ,
    \cubev_rf1_din0[17] ,
    \cubev_rf1_din0[16] ,
    \cubev_rf1_din0[15] ,
    \cubev_rf1_din0[14] ,
    \cubev_rf1_din0[13] ,
    \cubev_rf1_din0[12] ,
    \cubev_rf1_din0[11] ,
    \cubev_rf1_din0[10] ,
    \cubev_rf1_din0[9] ,
    \cubev_rf1_din0[8] ,
    \cubev_rf1_din0[7] ,
    \cubev_rf1_din0[6] ,
    \cubev_rf1_din0[5] ,
    \cubev_rf1_din0[4] ,
    \cubev_rf1_din0[3] ,
    \cubev_rf1_din0[2] ,
    \cubev_rf1_din0[1] ,
    \cubev_rf1_din0[0] }),
    .cubev_rf1_dout0({\cubev_rf1_dout0[31] ,
    \cubev_rf1_dout0[30] ,
    \cubev_rf1_dout0[29] ,
    \cubev_rf1_dout0[28] ,
    \cubev_rf1_dout0[27] ,
    \cubev_rf1_dout0[26] ,
    \cubev_rf1_dout0[25] ,
    \cubev_rf1_dout0[24] ,
    \cubev_rf1_dout0[23] ,
    \cubev_rf1_dout0[22] ,
    \cubev_rf1_dout0[21] ,
    \cubev_rf1_dout0[20] ,
    \cubev_rf1_dout0[19] ,
    \cubev_rf1_dout0[18] ,
    \cubev_rf1_dout0[17] ,
    \cubev_rf1_dout0[16] ,
    \cubev_rf1_dout0[15] ,
    \cubev_rf1_dout0[14] ,
    \cubev_rf1_dout0[13] ,
    \cubev_rf1_dout0[12] ,
    \cubev_rf1_dout0[11] ,
    \cubev_rf1_dout0[10] ,
    \cubev_rf1_dout0[9] ,
    \cubev_rf1_dout0[8] ,
    \cubev_rf1_dout0[7] ,
    \cubev_rf1_dout0[6] ,
    \cubev_rf1_dout0[5] ,
    \cubev_rf1_dout0[4] ,
    \cubev_rf1_dout0[3] ,
    \cubev_rf1_dout0[2] ,
    \cubev_rf1_dout0[1] ,
    \cubev_rf1_dout0[0] }),
    .cubev_rf1_dout1({\cubev_rf1_dout1_reg[31] ,
    \cubev_rf1_dout1_reg[30] ,
    \cubev_rf1_dout1_reg[29] ,
    \cubev_rf1_dout1_reg[28] ,
    \cubev_rf1_dout1_reg[27] ,
    \cubev_rf1_dout1_reg[26] ,
    \cubev_rf1_dout1_reg[25] ,
    \cubev_rf1_dout1_reg[24] ,
    \cubev_rf1_dout1_reg[23] ,
    \cubev_rf1_dout1_reg[22] ,
    \cubev_rf1_dout1_reg[21] ,
    \cubev_rf1_dout1_reg[20] ,
    \cubev_rf1_dout1_reg[19] ,
    \cubev_rf1_dout1_reg[18] ,
    \cubev_rf1_dout1_reg[17] ,
    \cubev_rf1_dout1_reg[16] ,
    \cubev_rf1_dout1_reg[15] ,
    \cubev_rf1_dout1_reg[14] ,
    \cubev_rf1_dout1_reg[13] ,
    \cubev_rf1_dout1_reg[12] ,
    \cubev_rf1_dout1_reg[11] ,
    \cubev_rf1_dout1_reg[10] ,
    \cubev_rf1_dout1_reg[9] ,
    \cubev_rf1_dout1_reg[8] ,
    \cubev_rf1_dout1_reg[7] ,
    \cubev_rf1_dout1_reg[6] ,
    \cubev_rf1_dout1_reg[5] ,
    \cubev_rf1_dout1_reg[4] ,
    \cubev_rf1_dout1_reg[3] ,
    \cubev_rf1_dout1_reg[2] ,
    \cubev_rf1_dout1_reg[1] ,
    \cubev_rf1_dout1_reg[0] }),
    .cubev_rf1_wmask0({\cubev_rf1_wmask0[3] ,
    \cubev_rf1_wmask0[2] ,
    \cubev_rf1_wmask0[1] ,
    \cubev_rf1_wmask0[0] }),
    .cubev_rf2_addr0({\cubev_rf2_addr0[7] ,
    \cubev_rf2_addr0[6] ,
    \cubev_rf2_addr0[5] ,
    \cubev_rf2_addr0[4] ,
    \cubev_rf2_addr0[3] ,
    \cubev_rf2_addr0[2] ,
    \cubev_rf2_addr0[1] ,
    \cubev_rf2_addr0[0] }),
    .cubev_rf2_addr1({\cubev_rf2_addr1[7] ,
    \cubev_rf2_addr1[6] ,
    \cubev_rf2_addr1[5] ,
    \cubev_rf2_addr1[4] ,
    \cubev_rf2_addr1[3] ,
    \cubev_rf2_addr1[2] ,
    \cubev_rf2_addr1[1] ,
    \cubev_rf2_addr1[0] }),
    .cubev_rf2_din0({\cubev_rf2_din0[31] ,
    \cubev_rf2_din0[30] ,
    \cubev_rf2_din0[29] ,
    \cubev_rf2_din0[28] ,
    \cubev_rf2_din0[27] ,
    \cubev_rf2_din0[26] ,
    \cubev_rf2_din0[25] ,
    \cubev_rf2_din0[24] ,
    \cubev_rf2_din0[23] ,
    \cubev_rf2_din0[22] ,
    \cubev_rf2_din0[21] ,
    \cubev_rf2_din0[20] ,
    \cubev_rf2_din0[19] ,
    \cubev_rf2_din0[18] ,
    \cubev_rf2_din0[17] ,
    \cubev_rf2_din0[16] ,
    \cubev_rf2_din0[15] ,
    \cubev_rf2_din0[14] ,
    \cubev_rf2_din0[13] ,
    \cubev_rf2_din0[12] ,
    \cubev_rf2_din0[11] ,
    \cubev_rf2_din0[10] ,
    \cubev_rf2_din0[9] ,
    \cubev_rf2_din0[8] ,
    \cubev_rf2_din0[7] ,
    \cubev_rf2_din0[6] ,
    \cubev_rf2_din0[5] ,
    \cubev_rf2_din0[4] ,
    \cubev_rf2_din0[3] ,
    \cubev_rf2_din0[2] ,
    \cubev_rf2_din0[1] ,
    \cubev_rf2_din0[0] }),
    .cubev_rf2_dout0({\cubev_rf2_dout0[31] ,
    \cubev_rf2_dout0[30] ,
    \cubev_rf2_dout0[29] ,
    \cubev_rf2_dout0[28] ,
    \cubev_rf2_dout0[27] ,
    \cubev_rf2_dout0[26] ,
    \cubev_rf2_dout0[25] ,
    \cubev_rf2_dout0[24] ,
    \cubev_rf2_dout0[23] ,
    \cubev_rf2_dout0[22] ,
    \cubev_rf2_dout0[21] ,
    \cubev_rf2_dout0[20] ,
    \cubev_rf2_dout0[19] ,
    \cubev_rf2_dout0[18] ,
    \cubev_rf2_dout0[17] ,
    \cubev_rf2_dout0[16] ,
    \cubev_rf2_dout0[15] ,
    \cubev_rf2_dout0[14] ,
    \cubev_rf2_dout0[13] ,
    \cubev_rf2_dout0[12] ,
    \cubev_rf2_dout0[11] ,
    \cubev_rf2_dout0[10] ,
    \cubev_rf2_dout0[9] ,
    \cubev_rf2_dout0[8] ,
    \cubev_rf2_dout0[7] ,
    \cubev_rf2_dout0[6] ,
    \cubev_rf2_dout0[5] ,
    \cubev_rf2_dout0[4] ,
    \cubev_rf2_dout0[3] ,
    \cubev_rf2_dout0[2] ,
    \cubev_rf2_dout0[1] ,
    \cubev_rf2_dout0[0] }),
    .cubev_rf2_dout1({\cubev_rf2_dout1_reg[31] ,
    \cubev_rf2_dout1_reg[30] ,
    \cubev_rf2_dout1_reg[29] ,
    \cubev_rf2_dout1_reg[28] ,
    \cubev_rf2_dout1_reg[27] ,
    \cubev_rf2_dout1_reg[26] ,
    \cubev_rf2_dout1_reg[25] ,
    \cubev_rf2_dout1_reg[24] ,
    \cubev_rf2_dout1_reg[23] ,
    \cubev_rf2_dout1_reg[22] ,
    \cubev_rf2_dout1_reg[21] ,
    \cubev_rf2_dout1_reg[20] ,
    \cubev_rf2_dout1_reg[19] ,
    \cubev_rf2_dout1_reg[18] ,
    \cubev_rf2_dout1_reg[17] ,
    \cubev_rf2_dout1_reg[16] ,
    \cubev_rf2_dout1_reg[15] ,
    \cubev_rf2_dout1_reg[14] ,
    \cubev_rf2_dout1_reg[13] ,
    \cubev_rf2_dout1_reg[12] ,
    \cubev_rf2_dout1_reg[11] ,
    \cubev_rf2_dout1_reg[10] ,
    \cubev_rf2_dout1_reg[9] ,
    \cubev_rf2_dout1_reg[8] ,
    \cubev_rf2_dout1_reg[7] ,
    \cubev_rf2_dout1_reg[6] ,
    \cubev_rf2_dout1_reg[5] ,
    \cubev_rf2_dout1_reg[4] ,
    \cubev_rf2_dout1_reg[3] ,
    \cubev_rf2_dout1_reg[2] ,
    \cubev_rf2_dout1_reg[1] ,
    \cubev_rf2_dout1_reg[0] }),
    .cubev_rf2_wmask0({\cubev_rf2_wmask0[3] ,
    \cubev_rf2_wmask0[2] ,
    \cubev_rf2_wmask0[1] ,
    \cubev_rf2_wmask0[0] }),
    .io_in({io_in[37],
    io_in[36],
    io_in[35],
    io_in[34],
    io_in[33],
    io_in[32],
    io_in[31],
    io_in[30],
    io_in[29],
    io_in[28],
    io_in[27],
    io_in[26],
    io_in[25],
    io_in[24],
    io_in[23],
    io_in[22],
    io_in[21],
    io_in[20],
    io_in[19],
    io_in[18],
    io_in[17],
    io_in[16],
    io_in[15],
    io_in[14],
    io_in[13],
    io_in[12],
    io_in[11],
    io_in[10],
    io_in[9],
    io_in[8],
    io_in[7],
    io_in[6],
    io_in[5],
    io_in[4],
    io_in[3],
    io_in[2],
    io_in[1],
    io_in[0]}),
    .io_oeb({io_oeb[37],
    io_oeb[36],
    io_oeb[35],
    io_oeb[34],
    io_oeb[33],
    io_oeb[32],
    io_oeb[31],
    io_oeb[30],
    io_oeb[29],
    io_oeb[28],
    io_oeb[27],
    io_oeb[26],
    io_oeb[25],
    io_oeb[24],
    io_oeb[23],
    io_oeb[22],
    io_oeb[21],
    io_oeb[20],
    io_oeb[19],
    io_oeb[18],
    io_oeb[17],
    io_oeb[16],
    io_oeb[15],
    io_oeb[14],
    io_oeb[13],
    io_oeb[12],
    io_oeb[11],
    io_oeb[10],
    io_oeb[9],
    io_oeb[8],
    io_oeb[7],
    io_oeb[6],
    io_oeb[5],
    io_oeb[4],
    io_oeb[3],
    io_oeb[2],
    io_oeb[1],
    io_oeb[0]}),
    .io_out({io_out[37],
    io_out[36],
    io_out[35],
    io_out[34],
    io_out[33],
    io_out[32],
    io_out[31],
    io_out[30],
    io_out[29],
    io_out[28],
    io_out[27],
    io_out[26],
    io_out[25],
    io_out[24],
    io_out[23],
    io_out[22],
    io_out[21],
    io_out[20],
    io_out[19],
    io_out[18],
    io_out[17],
    io_out[16],
    io_out[15],
    io_out[14],
    io_out[13],
    io_out[12],
    io_out[11],
    io_out[10],
    io_out[9],
    io_out[8],
    io_out[7],
    io_out[6],
    io_out[5],
    io_out[4],
    io_out[3],
    io_out[2],
    io_out[1],
    io_out[0]}));
endmodule


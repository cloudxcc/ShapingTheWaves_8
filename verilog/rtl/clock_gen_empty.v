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

module clock_gen ( clk_in,
                   resetn,
                   wr_clk_sel,
                   wr_conf,
                   //cubev_dli_din0,
                   ext_run_en,
                   clk_root,
                   clk_debug,
                   clk_debug_n);

input clk_in;
input resetn;
input wr_clk_sel;
input wr_conf;
//input [31:0] cubev_dli_din0;
input ext_run_en;
output clk_root;
output clk_debug;
output clk_debug_n;

assign clk_root = clk_in;
assign clk_debug = clk_in;


endmodule

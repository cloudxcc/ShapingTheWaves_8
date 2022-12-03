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

module rb (
`ifdef USE_POWER_PINS
   inout vccd1,	// User area 1 1.8V supply
   inout vssd1,	// User area 1 digital ground
`endif
   input clk,
   input rstn,
   input [31:0] dati,
   output [31:0] dato);

reg [31:0] dato;

always @ (posedge clk or negedge rstn)
if (~rstn)
   dato <= 0;
else
   dato <= dati;

endmodule

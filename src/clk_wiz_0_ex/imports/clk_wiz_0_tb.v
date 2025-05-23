
// file: clk_wiz_0_tb.v
// (c) Copyright 2017-2018, 2023 Advanced Micro Devices, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.

//----------------------------------------------------------------------------
// Clocking wizard demonstration testbench
//----------------------------------------------------------------------------
// This demonstration testbench instantiates the example design for the 
//   clocking wizard. Input clocks are toggled, which cause the clocking
//   network to lock and the counters to increment.
//----------------------------------------------------------------------------

`timescale 1ps/1ps

`define wait_lock @(posedge locked)

module clk_wiz_0_tb ();

  // timescale is 1ps/1ps
  localparam  ONE_NS      = 1000;
  localparam  PHASE_ERR_MARGIN   = 100; // 100ps
  // how many cycles to run
  localparam  COUNT_PHASE = 1024;
  // we'll be using the period in many locations
  localparam time PER1    = 10.000*ONE_NS;
  localparam time PER1_1  = PER1/2;
  localparam time PER1_2  = PER1 - PER1/2;

  // Declare the input clock signals
  reg         clk_in1     = 1;

  // The high bit of the sampling counter
  wire        COUNT;
  // Status and control signals
  reg         resetn     = 0;
  wire        locked;
  reg         COUNTER_RESET = 0;
  reg [13:0]  timeout_counter = 14'b00000000000000;
  wire [1:1]   CLK_OUT;



//Freq Check using the M & D values setting and actual Frequency generated
  real period1;
  localparam ref_period1_clkin1 = (10.000*5*17.750*1000/43.625);
  time prev_rise1;

  // Input clock generation
  //------------------------------------
  always begin
    clk_in1 = #PER1_1 ~clk_in1;
    clk_in1 = #PER1_2 ~clk_in1;
  end

  // Test sequence
  reg [15*8-1:0] test_phase = "";
  initial begin
    // Set up any display statements using time to be readable
    $timeformat(-12, 2, "ps", 10);
    $display ("Timing checks are not valid");
    COUNTER_RESET = 0;
    test_phase = "reset";
    resetn = 0;
    #(PER1*200);
    resetn = 1;
    test_phase = "wait lock";
    `wait_lock;
    #(PER1*20);
    COUNTER_RESET = 1;
    #(PER1*19.2)
    COUNTER_RESET = 0;
    #(PER1*0.3)
    #(PER1*1)
    $display ("Timing checks are valid");
    test_phase = "counting";
    #(PER1*COUNT_PHASE);
    if ((period1 -ref_period1_clkin1) <= 100 && (period1 -ref_period1_clkin1) >= -100) begin
    $display("Freq of CLK_OUT[1] ( in MHz ) : %0f\n", 1000000/period1);
    end else 
    begin
    $display("ERROR: Freq of CLK_OUT[1] is not correct"); 
    $finish;
    end 
    $display("SIMULATION PASSED");
    $display("Test Completed Successfully");
    $display("SYSTEM_CLOCK_COUNTER : %0d\n",$time/PER1);
    $finish;
  end


   always@(posedge clk_in1) begin
      timeout_counter <= timeout_counter + 1'b1;
      if (timeout_counter == 16'b1100000000000000) begin
         if (locked != 1'b1) begin
            $display("ERROR : NO LOCK signal");
            $display("SYSTEM_CLOCK_COUNTER : %0d\n",$time/PER1);
            $finish;
         end
      end
   end

  // Instantiation of the example design containing the clock
  //    network and sampling counters
  //---------------------------------------------------------
  clk_wiz_0_exdes 
    dut
   (// Clock in ports
    // Reset for logic in example design
    .COUNTER_RESET      (COUNTER_RESET),
    .CLK_OUT            (CLK_OUT),
    // High bits of the counters
    .COUNT              (COUNT),
    // Status and control signals
    .resetn             (resetn),
    .locked             (locked),
    .clk_in1            (clk_in1)
);

// Freq Check 
initial
  prev_rise1 = 0;

always @(posedge CLK_OUT[1])
begin
  if (prev_rise1 != 0)
    period1 = $time - prev_rise1;
  prev_rise1 = $time;
end

endmodule

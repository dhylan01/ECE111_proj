module ACS_tb;

   // Inputs
   logic path_0_valid;
   logic path_1_valid;
   logic [1:0] path_0_bmc;
   logic [1:0] path_1_bmc;
   logic [7:0] path_0_pmc;
   logic [7:0] path_1_pmc;

   // Outputs
   logic selection;
   logic valid_o;
   logic [7:0] path_cost;

   // Instantiate the ACS module
   ACS ACS_inst (
      .path_0_valid(path_0_valid),
      .path_1_valid(path_1_valid),
      .path_0_bmc(path_0_bmc),
      .path_1_bmc(path_1_bmc),
      .path_0_pmc(path_0_pmc),
      .path_1_pmc(path_1_pmc),
      .selection(selection),
      .valid_o(valid_o),
      .path_cost(path_cost)
   );

   // Testbench stimulus
   initial begin
      // Test case 1: Neither path is valid
      path_0_valid = 0;
      path_1_valid = 0;
      #10;
      if (valid_o == 0 && selection == 0 && path_cost == 8'h00)
         $display("Test case 1 passed");
      else
         $display("Test case 1 failed");

      // Test case 2: Only path 1 is valid
      path_0_valid = 0;
      path_1_valid = 1;
      path_0_bmc = 2'b00;
      path_1_bmc = 2'b01;
      path_0_pmc = 8'b00000000;
      path_1_pmc = 8'b11111111; // More 1s in path_1_pmc
      #10;
      if (valid_o == 1 && selection == 1 && path_cost == 8'b11111110)
         $display("Test case 2 passed");
      else
         $display("Test case 2 failed");

      // Test case 3: Only path 0 is valid
      path_0_valid = 1;
      path_1_valid = 0;
      path_0_bmc = 2'b01;
      path_1_bmc = 2'b00;
      path_0_pmc = 8'b11111111; // More 1s in path_0_pmc
      path_1_pmc = 8'b00000000;
      #10;
      if (valid_o == 1 && selection == 0 && path_cost == 8'b11111110)
         $display("Test case 3 passed");
      else
         $display("Test case 3 failed");

      // Test case 4: Both paths are valid, path 0 has lower cost
      path_0_valid = 1;
      path_1_valid = 1;
      path_0_bmc = 2'b00;
      path_1_bmc = 2'b01;
      path_0_pmc = 8'b11111110; // More 1s in path_0_pmc
      path_1_pmc = 8'b00000001;
      #10;
      if (valid_o == 1 && selection == 1 && path_cost == 8'b00000000)
         $display("Test case 4 passed");
      else
         $display("Test case 4 failed");

      // Test case 5: Both paths are valid, path 1 has lower cost
      path_0_valid = 1;
      path_1_valid = 1;
      path_0_bmc = 2'b01;
      path_1_bmc = 2'b00;
      path_0_pmc = 8'b00000001;
      path_1_pmc = 8'b11111110; // More 1s in path_1_pmc
      #10;
      if (valid_o == 1 && selection == 0 && path_cost == 8'b00000000)
         $display("Test case 5 passed");
      else
         $display("Test case 5 failed");

      // Add more test cases as needed

      // Finish simulation
      $finish;
   end

endmodule

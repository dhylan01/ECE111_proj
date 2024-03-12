module ACS (
   input       path_0_valid,
   input       path_1_valid,
   input [1:0] path_0_bmc,
   input [1:0] path_1_bmc,
   input [7:0] path_0_pmc,
   input [7:0] path_1_pmc,
   output logic selection,
   output logic valid_o,
   output logic [7:0] path_cost
);

   logic [7:0] path_cost_0;
   logic [7:0] path_cost_1;

   // Calculate path costs
   always_comb begin
      path_cost_0[0] = path_0_bmc[0] + path_0_pmc[0]; 
      path_cost_1[0] = path_1_bmc[0] + path_1_pmc[0]; 
      path_cost_0[1] = path_0_bmc[1] + path_0_pmc[1]; 
      path_cost_1[1] = path_1_bmc[1] + path_1_pmc[1]; 
      path_cost_0[7:2] = path_0_pmc[7:2];
      path_cost_1[7:2] = path_1_pmc[7:2];
   end

   // Generate selection
   always_comb begin
      if (!path_0_valid && !path_1_valid)
         selection = 0;
      else if (!path_0_valid && path_1_valid)
         selection = 1;
      else if (path_0_valid && !path_1_valid)
         selection = 0; 
      else
         selection = (path_cost_0 > path_cost_1) ? 1 : 0;
   end

   // Generate valid_o
   always_comb begin
      valid_o = (path_0_valid || path_1_valid) ? 1 : 0;
   end

   // Assign path_cost based on selection
   always_comb begin
      if (!valid_o)
         path_cost = 0;
      else if (selection == 0)
         path_cost = path_cost_0;
      else
         path_cost = path_cost_1;
   end

endmodule

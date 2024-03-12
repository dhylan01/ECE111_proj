module ACS		                        // add-compare-select
(
   input       path_0_valid,
   input       path_1_valid,
   input [1:0] path_0_bmc,	            // branch metric computation
   input [1:0] path_1_bmc,				
   input [7:0] path_0_pmc,				// path metric computation
   input [7:0] path_1_pmc,

   output logic        selection,
   output logic        valid_o,
   output      [7:0] path_cost);  

   wire  [7:0] path_cost_0;			   // branch metric + path metric
   wire  [7:0] path_cost_1;
   logic [2:0] index; 
/* Fill in the guts per ACS instructions
*/
always_comb begin

// generate path costs
if (index < 2) begin
path_cost_0[index] <= path_0_bmc[index] + path_0_pmc[index]; 
path_cost_1[index] <= path_1_bmc[index] + path_1_pmc[index]; 
index <= index+1; 
end else begin
path_cost_0[7:2] <= path_0_pmc[7:2];
path_cost_1[7:2] <= path_1_pmc[7:2];
index <= 0;
end

//generate selection 
if (!path_0_valid & !path_1_valid)
      selection <= 0;
else if (!path_0_valid & path_1_valid)
      selection <= 1;
else if (path_0_valid & !path_1_valid)
      selection <= 0; 
else begin
   if(path_cost_0 > path_cost_1)
      selection <= 1;
   else selection <= 0; 
end

//valid_o generation

if(!path_0_valid & !path_1_valid) begin
   valid_o <= 0;
end
   else begin
   valid_o <= 1; 
   end
// choosing path cost

if(valid_o == 0) begin
   path_cost <= 0;
end else if(selection == 0) begin
   path_cost <= path_cost_0;
end
   else begin
   path_cost <= path_cost_1; 
end


end


endmodule

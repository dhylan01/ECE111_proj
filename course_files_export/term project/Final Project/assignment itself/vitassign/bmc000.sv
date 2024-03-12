module bmc000				  // branch metric computation
(
   input    [1:0] rx_pair,
   output   [1:0] path_0_bmc,
   output   [1:0] path_1_bmc);

logic[0:0] tmp00, tmp01, tmp10, tmp11; 
// same code for modules bmc011,bmc100,bmc111 (just instantiate this module multiple times instead of using more files)
assign tmp00 = rx_pair[0];
assign tmp01 = rx_pair[1];

assign tmp10 = !tmp00;
assign tmp11 = !tmp01; 

assign path_0_bmc[1] = tmp00 & tmp01; 
assign path_0_bmc[0] = tmp00^tmp01; 

assign path_1_bmc[1] = tmp10 & tmp11; 
assign path_1_bmc[0] = tmp10^tmp11; 




endmodule

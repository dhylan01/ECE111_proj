module tbu
(
   input       clk,
   input       rst,
   input       enable,
   input       selection,
   input [7:0] d_in_0,
   input [7:0] d_in_1,
   output logic  d_o,
   output logic  wr_en);

   logic         d_o_reg;
   logic         wr_en_reg;
   
   logic   [2:0] pstate;
   logic   [2:0] nstate;

   logic         selection_buf;

   always @(posedge clk)    begin
      selection_buf  <= selection;
      wr_en          <= wr_en_reg;
      d_o            <= d_o_reg;
   end
   always @(posedge clk, negedge rst) begin
      if(!rst)
         pstate   <= 3'b000;
      else if(!enable)
         pstate   <= 3'b000;
      else if(selection_buf && !selection)
         pstate   <= 3'b000;
      else
         pstate   <= nstate;
   end

/*  combinational logic drives:
wr_en_reg, d_o_reg, nstate (next state)
from selection, d_in_1[pstate], d_in_0[pstate]
See assignment text for details
*/

//updateding pstate based on transition table
always_comb begin
   // selectin = 0 half of the table
   if(!selection_buf) begin
      case (pstate)
         3'b000: begin : pstate_0
            if (!d_in_0[0])
               nstate <= 3'b000; 
            else 
               nstate <= 3'b001; 
         end
         3'b001: begin : pstate_1
            if (!d_in_0[1])
               nstate <= 3'b011; 
            else 
               nstate <= 3'b010;             
         end
         3'b010: begin : pstate_2
            if (!d_in_0[2])
               nstate <= 3'b100; 
            else 
               nstate <= 3'b101; 
         end
         3'b011: begin : pstate_3
            if (!d_in_0[3])
               nstate <= 3'b111; 
            else 
               nstate <= 3'b110; 
         end
         3'b100: begin : pstate_4
            if (!d_in_0[4])
               nstate <= 3'b001; 
            else 
               nstate <= 3'b000; 
         end
         3'b101: begin : pstate_5
            if (!d_in_0[5])
               nstate <= 3'b010; 
            else 
               nstate <= 3'b011; 
         end   
         3'b110: begin : pstate_6
            if (!d_in_0[6])
               nstate <= 3'b101; 
            else 
               nstate <= 3'b100; 
         end
         3'b111: begin : pstate_7
            if (!d_in_0[7])
               nstate <= 3'b110; 
            else 
               nstate <= 3'b111; 
         end                   

      endcase
   end else begin  // selection == 1 cases
      case (pstate)
         3'b000: begin : pstate1_0
            if (!d_in_1[0])
               nstate <= 3'b000; 
            else 
               nstate <= 3'b001; 
         end
         3'b001: begin : pstate1_1
            if (!d_in_1[1])
               nstate <= 3'b011; 
            else 
               nstate <= 3'b010;             
         end
         3'b010: begin : pstate1_2
            if (!d_in_1[2])
               nstate <= 3'b100; 
            else 
               nstate <= 3'b101; 
         end
         3'b011: begin : pstate1_3
            if (!d_in_1[3])
               nstate <= 3'b111; 
            else 
               nstate <= 3'b110; 
         end
         3'b100: begin : pstate1_4
            if (!d_in_1[4])
               nstate <= 3'b001; 
            else 
               nstate <= 3'b000; 
         end
         3'b101: begin : pstate1_5
            if (!d_in_1[5])
               nstate <= 3'b010; 
            else 
               nstate <= 3'b011; 
         end   
         3'b110: begin : pstate1_6
            if (!d_in_1[6])
               nstate <= 3'b101; 
            else 
               nstate <= 3'b100; 
         end
         3'b111: begin : pstate1_7
            if (!d_in_1[7])
               nstate <= 3'b110; 
            else 
               nstate <= 3'b111; 
         end                   

      endcase
   end
   //wr_en_reg
   wr_en_reg <= selection_buf;
   // d_o_reg
   if(selection_buf)
      d_o_reg <= d_in_1[pstate];
      else d_o_reg = 0; 


end





endmodule

module encoder1                    // use this one
(  input             clk,
   input             rst,
   input             enable_i,
   input             d_in,
   output logic      valid_o,
   output logic [1:0] d_out);
   
   logic         [2:0] cstate;
   logic         [2:0] nstate;
   logic               valid_oQ;   
   logic         [1:0] d_out_reg;

   always_comb begin
      valid_oQ  =   enable_i;
      case (cstate)
         3'b000: if(!d_in)  begin
               nstate    =  3'b000;
               d_out_reg =  2'b00;
            end
            else begin
               nstate    =  3'b100;
               d_out_reg =  2'b11;
            end
         3'b001: if(!d_in)  begin
               nstate    =  3'b100;
               d_out_reg =  2'b00;
            end
            else begin
               nstate    =  3'b000;
               d_out_reg =  2'b11;
            end
         3'b010: if(!d_in)  begin
               nstate    =  3'b101;
               d_out_reg =  2'b10;
            end
            else begin
               nstate    =  3'b001;
               d_out_reg =  2'b01;
            end
         3'b011:  if(!d_in) begin
               nstate    =  3'b001;
               d_out_reg =  2'b10;
            end
            else begin
               nstate    =  3'b101;
               d_out_reg =  2'b01;
            end
         3'b100:  if(!d_in)   begin
               nstate    =  3'b010;
               d_out_reg =  2'b10;
            end
            else              begin
               nstate    =  3'b110;
               d_out_reg =  2'b01;
            end
         3'b101:  if(!d_in)  begin
               nstate    =  3'b110;
               d_out_reg =  2'b10;
            end
            else       begin
               nstate    =  3'b010;
               d_out_reg =  2'b01;
            end
         3'b110:  if(!d_in)   begin
               nstate    =  3'b111;
               d_out_reg =  2'b00;
            end
            else     begin
               nstate    =  3'b011;
               d_out_reg =  2'b11;
            end
         3'b111:  if(!d_in)   begin
               nstate    =  3'b011;
               d_out_reg =  2'b00;
            end
            else      begin
               nstate    =  3'b111;
               d_out_reg =  2'b11;
            end
      endcase
   end								   

   always @ (posedge clk, negedge rst)   
     if(!rst)
       cstate   <= 'b0;
     else 
       cstate   <= enable_i? nstate : 'b0;
   always @ (posedge clk) begin
     d_out      <= enable_i? d_out_reg : 'b0;
     valid_o    <= valid_oQ;
   end

endmodule

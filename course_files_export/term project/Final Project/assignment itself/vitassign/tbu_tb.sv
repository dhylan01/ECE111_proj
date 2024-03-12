module tbu_tb;

   // Declare signals for testbench
   logic clk, rst, enable, selection;
   logic [7:0] d_in_0, d_in_1;
   logic d_o, wr_en;

   // Instantiate tbu module
   tbu tbu_inst (
      .clk(clk),
      .rst(rst),
      .enable(enable),
      .selection(selection),
      .d_in_0(d_in_0),
      .d_in_1(d_in_1),
      .d_o(d_o),
      .wr_en(wr_en)
   );

   // Clock generation
   always #5 clk = ~clk;

   // Reset generation
   initial begin
      rst = 0;
      enable = 1;
      d_in_0 = 8'h00;
      d_in_1 = 8'h00;
      clk = 0;

      #10 rst = 1;
      #100 $finish;
   end

   // Test all possible cases
   initial begin
      // Case where selection is 0 and d_in_0 is all 0s
      enable = 1;
      selection = 0;
      d_in_0 = 8'h00;
      d_in_1 = 8'hFF;
      #20;

      // Case where selection is 0 and d_in_0 is all 1s
      d_in_0 = 8'hFF;
      #20;

      // Case where selection is 1 and d_in_1 is all 0s
      selection = 1;
      d_in_1 = 8'h00;
      #20;

      // Case where selection is 1 and d_in_1 is all 1s
      d_in_1 = 8'hFF;
      #20;

      // Add more test cases as needed

      // End simulation
      $finish;
   end

endmodule

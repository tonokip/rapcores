`default_nettype none

module StepperVref
 #(parameter currentbits = 4
  ) (
    input clk,
    input wire [currentbits-1:0] current,
    output vref
);

reg [currentbits-1:0] currentaccum = 0;

// PWM module fusing current limit and microsteps
// TODO: Microsteps

assign vref = (currentaccum < current);

always @(posedge clk) begin
  currentaccum <= currentaccum + 1'b1;
end

endmodule

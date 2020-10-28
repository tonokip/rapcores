`default_nettype none

/*
Selecting current bits:
Total bit space
  log2(<clock freq>/30000)
e.g. for 16 mhz
log2(16_000_000/30_000) ~= 9

30khz is supra-audible (for most people)

The idea is to combine current and microstep values into a
single PWM value that reflects both without truncation of the
waveform.

_-_-_-_-_
----_____

*/
module StepperVref
 #(parameter currentbits = 3,
   parameter microstepbits = 6
  ) (
    input clk,
    input [currentbits-1:0] current,
    input [microstepbits-1:0] microstep,
    output vref
);

reg [currentbits-1:0] currentaccum = 0;
reg [currentbits-1:0] microstepaccum = 0;
reg [currentbits+microstepbits-1:0] periodaccum = 0;

// PWM module fusing current limit and microsteps
// TODO: Microsteps

assign vref = (currentaccum <= current);

always @(posedge clk) begin
  microstepaccum <= microstepaccum + 1'b1;
  if (microstepaccum >= microstep) begin
    currentaccum <= currentaccum + 1'b1;
    microstepaccum <= 0;
  end
end

endmodule

//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module add
(
  input  [3:0] a, b,
  output [3:0] sum
);

  assign sum = a + b;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module signed_add_with_saturation
(
  input  [3:0] a, b,
  output [3:0] sum
);

  // Task:
  //
  // Implement a module that adds two signed numbers with saturation.
  //
  // "Adding with saturation" means:
  //
  // When the result does not fit into 4 bits,
  // and the arguments are positive,
  // the sum should be set to the maximum positive number.
  //
  // When the result does not fit into 4 bits,
  // and the arguments are negative,
  // the sum should be set to the minimum negative number.

  wire  [3:0] tmp_sum;
  logic [3:0] sum_r;

  assign sum = sum_r;

  add adder
  (
    .a   (a),
    .b   (b),
    .sum (tmp_sum)
  );

  always_comb begin
    if (a[3] & b[3] & ~tmp_sum[3])
      sum_r = {'1, {3{'0}}};
    else if (~a[3] & ~b[3] & tmp_sum[3])
      sum_r = {'0, {3{'1}}};
    else
      sum_r = tmp_sum;
  end

  /*
  wire        overflow;
  assign overflow = (a[3] == b[3]) & (a[3] != tmp_sum[3]);

  always_comb begin
    if (overflow & a[3])
      sum_r = {'1, {3{'0}}};
    else if (overflow & ~a[3])
      sum_r = {'0, {3{'1}}};
    else
      sum_r = tmp_sum;
  end
  */

endmodule

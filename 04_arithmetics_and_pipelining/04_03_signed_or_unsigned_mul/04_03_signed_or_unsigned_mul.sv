//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

// A non-parameterized module
// that implements the signed multiplication of 4-bit numbers
// which produces 8-bit result

module signed_mul_4
(
  input  signed [3:0] a, b,
  output signed [7:0] res
);

  assign res = a * b;

endmodule

// A parameterized module
// that implements the unsigned multiplication of N-bit numbers
// which produces 2N-bit result

module unsigned_mul
# (
  parameter n = 8
)
(
  input  [    n - 1:0] a, b,
  output [2 * n - 1:0] res
);

  assign res = a * b;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

// Task:
//
// Implement a parameterized module
// that produces either signed or unsigned result
// of the multiplication depending on the 'signed_mul' input bit.

module signed_or_unsigned_mul
# (
  parameter n = 8
)
(
  input  [    n - 1:0] a, b,
  input                signed_mul,
  output [2 * n - 1:0] res
);

  logic  [    n - 1:0] tmp_a, tmp_b;
  logic  [2 * n - 1:0] tmp_res;
  logic  [2 * n - 1:0] res_r;

  assign res = res_r;

  unsigned_mul unsigned_mul
  (
    .a   (tmp_a  ),
    .b   (tmp_b  ),
    .res (tmp_res)
  );

  always_comb begin
    if (signed_mul & a[3]) begin
      tmp_a = {n{1'b0}} - a;
    end
    else begin
      tmp_a = a;
    end
  end

  always_comb begin
    if (signed_mul & b[3]) begin
      tmp_b = {n{1'b0}} - b;
    end
    else begin
      tmp_b = b;
    end
  end

  always_comb begin
    if (signed_mul & (a[3] != b[3])) begin
      res_r = {(2 * n){1'b0}} - tmp_res;
    end
    else begin
      res_r = tmp_res;
    end
  end

endmodule

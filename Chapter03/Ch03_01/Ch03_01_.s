//------------------------------------------------
//               Ch03_01_.s  (ARM64 / macOS)
//------------------------------------------------

// extern "C" int SumSquares_(int a, int b, int c, int d, int e,
//                            int f, int g);

        .equ ARG_E, 0              // stack offset for e
        .equ ARG_F, 8              // stack offset for f (aligned to 8)
        .equ ARG_G, 16             // stack offset for g

        .text
        .p2align 2
        .globl _SumSquares_
_SumSquares_:
        // x0–x3 = a, b, c, d
        // x4–x7 = e, f, g would be used if more args passed
        // In practice, args beyond x3 go on the stack if more than 8 total args (including floats)

        // Calculate a² + b²
        mul     w0, w0, w0              // w0 = a * a
        mul     w1, w1, w1              // w1 = b * b
        add     w0, w0, w1              // w0 = a² + b²

        // Add c² + d²
        mul     w2, w2, w2              // w2 = c * c
        mul     w3, w3, w3              // w3 = d * d
        add     w2, w2, w3              // w2 = c² + d²
        add     w0, w0, w2              // w0 += c² + d²

        // Load e from stack and add e²
        ldr     w1, [sp, #ARG_E]
        mul     w1, w1, w1
        add     w0, w0, w1

        // Load f from stack and add f²
        ldr     w1, [sp, #ARG_F]
        mul     w1, w1, w1
        add     w0, w0, w1

        // Load g from stack and add g²
        ldr     w1, [sp, #ARG_G]
        mul     w1, w1, w1
        add     w0, w0, w1

        ret

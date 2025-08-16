//------------------------------------------------
//               Ch03_02_.s  (ARM64 / macOS)
//------------------------------------------------

// extern "C" int SumCubes_(unsigned char a, short b, int c, int d,
//     signed char e, short f, unsigned char g, unsigned short h, int i);

        .text
        .p2align 2
        .globl _SumCubes_
_SumCubes_:
        // x0 = a, x1 = b, x2 = c, x3 = d
        // x4 = e, x5 = f, x6 = g, x7 = h
        // [sp] = i

        stp     x19, x20, [sp, #-16]!      // Save temp regs

        // a * a * a (unsigned)
        mul     w19, w0, w0
        mul     w0, w19, w0

        // b * b * b (signed short)
        mul     w19, w1, w1
        mul     w19, w19, w1
        add     w0, w0, w19

        // c * c * c
        mul     w19, w2, w2
        mul     w19, w19, w2
        add     w0, w0, w19

        // d * d * d
        mul     w19, w3, w3
        mul     w19, w19, w3
        add     w0, w0, w19

        // e * e * e (signed char)
        sxtb    w1, w4                    // Sign-extend 8-bit
        mul     w19, w1, w1
        mul     w19, w19, w1
        add     w0, w0, w19

        // f * f * f (signed short)
        sxth    w1, w5                    // Sign-extend 16-bit
        mul     w19, w1, w1
        mul     w19, w19, w1
        add     w0, w0, w19

        // g * g * g (unsigned char)
        uxth    w1, w6                    // Zero-extend
        mul     w19, w1, w1
        mul     w19, w19, w1
        add     w0, w0, w19

        // h * h * h (unsigned short)
        uxth    w1, w7                    // Zero-extend
        mul     w19, w1, w1
        mul     w19, w19, w1
        add     w0, w0, w19

        // i * i * i (int, from stack)
        ldr     w1, [sp, #16]             // i is 9th arg, after stp
        mul     w19, w1, w1
        mul     w19, w19, w1
        add     w0, w0, w19

        ldp     x19, x20, [sp], #16
        ret

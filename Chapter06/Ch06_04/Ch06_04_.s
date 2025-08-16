//-------------------------------------------------
//               Ch06_04_.s (ARM64/macOS)
//-------------------------------------------------

// extern "C" void CompareF32_(bool* results, float a, float b);

        .text
        .align 2
        .globl _CompareF32_
_CompareF32_:
        // x0 = results (bool[7])
        // s0 = a
        // s1 = b

        // Clear x2 (used for false = 0)
        mov     w2, #0

        // Compare a and b
        fcmp    s0, s1

        // Unordered (a or b is NaN)
        cset    w3, vs                       // unordered
        strb    w3, [x0, #0]

        // a < b
        cset    w3, lo
        strb    w3, [x0, #1]

        // a <= b
        cset    w3, ls
        strb    w3, [x0, #2]

        // a == b
        cset    w3, eq
        strb    w3, [x0, #3]

        // a != b
        cset    w3, ne
        strb    w3, [x0, #4]

        // a > b
        cset    w3, hi
        strb    w3, [x0, #5]

        // a >= b
        cset    w3, hs
        strb    w3, [x0, #6]

        ret

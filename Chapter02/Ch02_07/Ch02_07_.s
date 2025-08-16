//------------------------------------------------
//               Ch02_07_.s  (ARM64 / macOS)
//------------------------------------------------

// extern "C" void TestBitOpsA_(unsigned int a, unsigned int b, unsigned int* c);

        .text
        .p2align 2
        .globl _TestBitOpsA_
_TestBitOpsA_:
        // x0 = a, x1 = b, x2 = c (output array)

        stp     x19, x20, [sp, #-16]!

        and     w3, w0, w1             // w3 = a & b
        str     w3, [x2]               // c[0]

        orr     w4, w0, w1             // w4 = a | b
        str     w4, [x2, #4]           // c[1]

        eor     w5, w0, w1             // w5 = a ^ b
        str     w5, [x2, #8]           // c[2]

        ldp     x19, x20, [sp], #16
        ret

// extern "C" void TestBitOpsB_(unsigned int a, unsigned int* b);

        .p2align 2
        .globl _TestBitOpsB_
_TestBitOpsB_:
        // x0 = a, x1 = b (output array)

        stp     x19, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!

        and     w2, w0, #0x0000ff00     // a & 0x0000ff00
        str     w2, [x1]                // b[0]

        orr     w3, w0, #0x00ff0000     // a | 0x00ff0000
        str     w3, [x1, #4]            // b[1]

        eor     w4, w0, #0xff000000     // a ^ 0xff000000
        str     w4, [x1, #8]            // b[2]

        // Cannot do: and w5, w0, #0x00ffff00  (invalid constant)
        // Instead, construct 0x00ffff00 manually in a register
        movz    w5, #0xff00
        movk    w5, #0x00ff, lsl #16    // w5 = 0x00ffff00
        and     w6, w0, w5              // a & 0x00ffff00
        str     w6, [x1, #12]           // b[3]

        ldp     x21, x22, [sp], #16
        ldp     x19, x20, [sp], #16
        ret

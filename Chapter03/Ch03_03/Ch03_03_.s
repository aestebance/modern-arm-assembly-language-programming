//------------------------------------------------
//               Ch03_03_.s  (ARM64 / macOS)
//------------------------------------------------

        .equ TEMP0,  0       // temp0 (local var)
        .equ TEMP1,  4
        .equ TEMP2,  8
        .equ TEMP3, 12

        .text
        .p2align 2
        .globl _LocalVarsA_
_LocalVarsA_:
        // x0–x5 = a–f
        // x6 = g
        // x7 = h

        // Prologue
        stp     x19, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        sub     sp, sp, #16        // espacio para temp0–temp3

        // temp0 = a + b + c
        add     w12, w0, w1
        add     w12, w12, w2
        str     w12, [sp, #TEMP0]

        // temp1 = d + e + f
        add     w12, w3, w4
        add     w12, w12, w5
        str     w12, [sp, #TEMP1]

        // temp2 = a + c + e
        add     w12, w0, w2
        add     w12, w12, w4
        str     w12, [sp, #TEMP2]

        // temp3 = b + d + f
        add     w12, w1, w3
        add     w12, w12, w5
        str     w12, [sp, #TEMP3]

        // *g = temp0 * temp1
        ldr     w0, [sp, #TEMP0]
        ldr     w1, [sp, #TEMP1]
        mul     w0, w0, w1
        str     w0, [x6]

        // *h = temp2 * temp3
        ldr     w0, [sp, #TEMP2]
        ldr     w1, [sp, #TEMP3]
        mul     w0, w0, w1
        str     w0, [x7]

        // Epilogue
        add     sp, sp, #16
        ldp     x21, x22, [sp], #16
        ldp     x19, x20, [sp], #16
        ret

//------------------------------------------------
//               Ch03_04_.s  (ARM64 / macOS)
//------------------------------------------------

// extern "C" void LocalVarsB_(int a, int b, int c, int d,
//                             int e, int f, int* g, int* h)

// Stack frame layout:
// [sp, #0]    = temp0 (4 bytes)
// [sp, #4]    = temp1
// [sp, #8]    = temp2
// [sp, #12]   = temp3
// (16 bytes total)

        .equ TEMP0, -16
        .equ TEMP1, -12
        .equ TEMP2, -8
        .equ TEMP3, -4

        .text
        .p2align 2
        .globl _LocalVarsB_
_LocalVarsB_:
        // Prologue
        stp     x29, x30, [sp, #-16]!       // Save fp and lr
        mov     x29, sp                     // Set fp (frame pointer)
        sub     sp, sp, #16                 // Allocate 16 bytes for locals

        // Use w0–w5 for a–f, x6 = g*, x7 = h*
        // Calculate temp0 = a + b + c
        add     w9, w0, w1
        add     w9, w9, w2
        str     w9, [x29, #TEMP0]

        // temp1 = d + e + f
        add     w9, w3, w4
        add     w9, w9, w5
        str     w9, [x29, #TEMP1]

        // temp2 = a + c + e
        add     w9, w0, w2
        add     w9, w9, w4
        str     w9, [x29, #TEMP2]

        // temp3 = b + d + f
        add     w9, w1, w3
        add     w9, w9, w5
        str     w9, [x29, #TEMP3]

        // *g = temp0 * temp1
        ldr     w10, [x29, #TEMP0]
        ldr     w11, [x29, #TEMP1]
        mul     w10, w10, w11
        str     w10, [x6]

        // *h = temp2 * temp3
        ldr     w10, [x29, #TEMP2]
        ldr     w11, [x29, #TEMP3]
        mul     w10, w10, w11
        str     w10, [x7]

        // Epilogue
        add     sp, sp, #16
        ldp     x29, x30, [sp], #16
        ret

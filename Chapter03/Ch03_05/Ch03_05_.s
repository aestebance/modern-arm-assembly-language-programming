//------------------------------------------------
//               Ch03_05_.s  (ARM64 / macOS)
//------------------------------------------------

// extern "C" bool CompareSumA_(int a, int b, int c, int* sum)

        .text
        .p2align 2
        .globl _CompareSumA_
_CompareSumA_:
        // x0 = a, x1 = b, x2 = c, x3 = sum (int*)

        add     w0, w0, w1              // w0 = a + b
        add     w0, w0, w2              // w0 = a + b + c
        str     w0, [x3]                // store sum

        cmp     w0, #100
        b.ge    1f                      // if sum >= 100, return true
        mov     w0, #0                  // false
        ret
1:      mov     w0, #1                  // true
        ret

// extern "C" bool CompareSumB_(int a, int b, int c, int* sum)

        .p2align 2
        .globl _CompareSumB_
_CompareSumB_:
        add     w0, w0, w1              // w0 = a + b
        adds    w0, w0, w2              // w0 = a + b + c, update flags
        str     w0, [x3]                // store sum

        b.gt    1f                      // if sum > 0, return true
        mov     w0, #0                  // false
        ret
1:      mov     w0, #1                  // true
        ret

// extern "C" bool CompareSumC_(int a, int b, int c, int* sum)

        .p2align 2
        .globl _CompareSumC_
_CompareSumC_:
        // Save temporary registers
        stp     x19, x20, [sp, #-16]!

        mov     w19, w0                 // w19 = a
        mov     w0, #0                  // return = 0 (no overflow yet)

        adds    w19, w19, w1            // w19 = a + b
        orr     w0, w0, #1
        b.vs    1f                      // if overflow, set w0 = 1
        mov     w0, #0                  // no overflow so far

1:      adds    w20, w19, w2            // w20 = a + b + c
        b.vs    2f                      // if overflow, set w0 = 1
        str     w20, [x3]               // store sum
        ldp     x19, x20, [sp], #16
        ret

2:      mov     w0, #1                  // overflow occurred
        str     w20, [x3]
        ldp     x19, x20, [sp], #16
        ret

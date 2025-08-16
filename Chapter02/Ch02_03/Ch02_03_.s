//------------------------------------------------
//               Ch02_03_.s  (arm64 / macOS)
//------------------------------------------------

// extern "C" void CalcQuoRem_(const int* a, const int* b, int* quo, int* rem);

        .text
        .p2align 2
        .globl _CalcQuoRem_
_CalcQuoRem_:
        // Argumentos en arm64:
        // x0 = a (int*)
        // x1 = b (int*)
        // x2 = quo (int*)
        // x3 = rem (int*)

        // Save non-volatile registers (we'll use x19, x20)
        stp     x19, x20, [sp, #-16]!     // push x19 and x20

        ldr     w19, [x0]                 // w19 = *a (dividend)
        ldr     w20, [x1]                 // w20 = *b (divisor)

        // Quotient
        sdiv    w4, w19, w20              // w4 = w19 / w20
        str     w4, [x2]                  // *quo = quotient

        // Remainder
        mul     w5, w4, w20               // w5 = quotient * b
        sub     w6, w19, w5               // w6 = a - (quotient * b)
        str     w6, [x3]                  // *rem = remainder

        // Restore registers and return
        ldp     x19, x20, [sp], #16       // pop x19 and x20
        ret

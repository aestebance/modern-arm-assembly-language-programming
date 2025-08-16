//------------------------------------------------
//               Ch03_06_.s (ARM64 / macOS)
//------------------------------------------------

// extern "C" void CalcSum_(int n, int* sum1, int* sum2);

        .text
        .p2align 2
        .globl _CalcSum_
_CalcSum_:
        // x0 = n, x1 = sum1*, x2 = sum2*

        stp     x29, x30, [sp, #-16]!      // save frame pointer and lr
        stp     x19, x20, [sp, #-16]!      // save x19 (sum1 ptr), x20 (sum2 ptr)
        mov     x29, sp

        mov     x19, x1                   // x19 = sum1*
        mov     x20, x2                   // x20 = sum2*

        // Reset *sum1 and *sum2 to 0
        mov     w3, wzr
        str     w3, [x19]
        str     w3, [x20]

        // if (n < 1 || n > 1023) return;
        cmp     w0, #1
        blt     .Ldone
        cmp     w0, #1023
        bgt     .Ldone

        mov     w21, w0                  // Save n in w21

        // call CalcSum1_(n)
        bl      _CalcSum1_
        str     w0, [x19]                // store result in *sum1

        mov     w0, w21                  // restore n
        bl      _CalcSum2_
        str     w0, [x20]                // store result in *sum2

.Ldone:
        ldp     x19, x20, [sp], #16
        ldp     x29, x30, [sp], #16
        ret


//------------------------------------------------
//               static int CalcSum1_(int n);
//------------------------------------------------

        .globl _CalcSum1_
_CalcSum1_:
        // w0 = n
        mov     w1, #1                  // i = 1
        mov     w2, #0                  // sum = 0

.Lloop1:
        mul     w3, w1, w1              // w3 = i * i
        add     w2, w2, w3              // sum += i * i
        add     w1, w1, #1              // i++
        cmp     w1, w0
        ble     .Lloop1

        mov     w0, w2                  // return sum
        ret


//------------------------------------------------
//               static int CalcSum2_(int n);
//------------------------------------------------

        .globl _CalcSum2_
_CalcSum2_:
        // w0 = n
        add     w1, w0, #1              // w1 = n + 1
        mul     w2, w0, w1              // w2 = n * (n + 1)

        lsl     w3, w0, #1              // w3 = 2 * n
        add     w3, w3, #1              // w3 = 2n + 1

        mul     w3, w3, w2              // w3 = n*(n+1)*(2n+1)
        mov     w1, #6
        sdiv    w0, w3, w1              // w0 = result

        ret

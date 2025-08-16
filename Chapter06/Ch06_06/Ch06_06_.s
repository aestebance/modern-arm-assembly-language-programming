//-------------------------------------------------
//               Ch06_06_.s (ARM64 / macOS)
//-------------------------------------------------

        .text
        .p2align 2

r8_zero:   .double 0.0

// extern "C" bool CalcMeanStdev_(double* mean, double* stdev, const double* x, int n);
        .globl _CalcMeanStdev_
_CalcMeanStdev_:
        // x0 = mean*, x1 = stdev*, x2 = x[], x3 = n

        // Check if n < 2
        cmp     w3, #2
        blt     .LInvalidArg

        // sum1 = 0.0, sum2 = 0.0
        ldr     d0, r8_zero            // d0 = sum1
        fmov    d4, d0                 // d4 = sum2

        mov     w4, #0                 // i = 0
        mov     x5, x2                 // ptr to x

.Lloop1:
        ldr     d1, [x5], #8           // d1 = x[i], x5 += 8
        fadd    d0, d0, d1             // sum1 += x[i]
        add     w4, w4, #1
        cmp     w4, w3
        blt     .Lloop1

        // mean = sum1 / n
        scvtf   d2, w3                 // d2 = (double)n
        fdiv    d2, d0, d2             // d2 = mean
        str     d2, [x0]               // *mean = d2

        // Recalculate sum2 = Σ(x[i] - mean)^2
        mov     w4, #0
        mov     x5, x2                 // ptr to x

.Lloop2:
        ldr     d1, [x5], #8
        fsub    d3, d1, d2             // d3 = x[i] - mean
        fmul    d3, d3, d3             // d3 = (x[i] - mean)^2
        fadd    d4, d4, d3             // sum2 += ...
        add     w4, w4, #1
        cmp     w4, w3
        blt     .Lloop2

        sub     w3, w3, #1
        scvtf   d1, w3                 // d1 = (double)(n - 1)
        fdiv    d2, d4, d1             // d2 = variance
        fsqrt   d3, d2                 // d3 = stdev
        str     d3, [x1]               // *stdev = d3

        mov     w0, #1                 // return true
        ret

.LInvalidArg:
        mov     w0, #0                 // return false
        ret

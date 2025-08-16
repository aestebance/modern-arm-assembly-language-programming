//-------------------------------------------------
//               Ch06_07_.s (ARM64 / macOS)
//-------------------------------------------------

        .text
        .p2align 2

r8_zero:    .double 0.0

// extern "C" bool CalcTrace_(double* trace, const double* x, int nrows, int ncols);

        .globl _CalcTrace_
_CalcTrace_:
        // x0 = trace*
        // x1 = x[] (matrix base)
        // w2 = nrows
        // w3 = ncols

        cmp     w2, w3
        b.ne    .LInvalidArg        // if nrows != ncols -> error
        cmp     w2, #0
        b.le    .LInvalidArg        // if nrows <= 0 -> error

        ldr     d0, r8_zero         // d0 = 0.0 (sum)
        mov     w4, #0              // i = 0

.Lloop:
        mul     w5, w4, w3          // w5 = i * ncols
        add     w5, w5, w4          // w5 = i * ncols + i
        lsl     x5, x5, #3          // x5 = offset in bytes (8 bytes per double)
        add     x5, x1, x5          // x5 = &x[i][i]

        ldr     d1, [x5]            // d1 = x[i][i]
        fadd    d0, d0, d1          // sum += x[i][i]

        add     w4, w4, #1
        cmp     w4, w2
        b.lt    .Lloop

        str     d0, [x0]            // *trace = sum
        mov     w0, #1              // return true
        ret

.LInvalidArg:
        mov     w0, #0              // return false
        ret

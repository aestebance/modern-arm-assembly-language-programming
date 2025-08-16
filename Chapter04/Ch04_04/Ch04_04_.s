//-------------------------------------------------
//               Ch04_04_.s (ARM64 / macOS)
//-------------------------------------------------

// extern "C" bool CalcMatrixRowColSums_(int* row_sums, int* col_sums, const int* x, int nrows, int ncols);

        .text
        .p2align 2
        .globl _CalcMatrixRowColSums_
_CalcMatrixRowColSums_:
        // x0 = row_sums
        // x1 = col_sums
        // x2 = x (input matrix)
        // w3 = nrows
        // w4 = ncols

        stp     x19, x20, [sp, #-16]!     // Save callee-saved regs
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!

        // Check nrows > 0
        cmp     w3, #0
        ble     .Lfail

        // Check ncols > 0
        cmp     w4, #0
        ble     .Lfail

        // Zero-out col_sums
        mov     w19, #0                   // j = 0
.LzeroCols:
        str     wzr, [x1, w19, SXTW #2]
        add     w19, w19, #1
        cmp     w19, w4
        blt     .LzeroCols

        // Main processing loops
        mov     w19, #0                   // i = 0
.LrowLoop:
        mov     w20, #0                   // j = 0
        mov     w21, #0                   // row_sum_temp = 0

        // row offset = i * ncols
        mul     w22, w19, w4

.LcolLoop:
        add     w23, w22, w20             // index = i*ncols + j
        ldr     w24, [x2, w23, SXTW #2]   // x[i][j]

        add     w21, w21, w24             // row_sum_temp += x[i][j]

        // col_sums[j] += x[i][j]
        ldr     w25, [x1, w20, SXTW #2]
        add     w25, w25, w24
        str     w25, [x1, w20, SXTW #2]

        add     w20, w20, #1              // j++
        cmp     w20, w4
        blt     .LcolLoop

        // Store row_sum_temp
        str     w21, [x0, w19, SXTW #2]

        add     w19, w19, #1              // i++
        cmp     w19, w3
        blt     .LrowLoop

        mov     w0, #1                    // success
        b       .Ldone

.Lfail:
        mov     w0, #0                    // failure

.Ldone:
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x19, x20, [sp], #16
        ret

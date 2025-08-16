//-------------------------------------------------
//               Ch04_03_.s (ARM64 / macOS)
//-------------------------------------------------

// extern "C" void CalcMatrixSquares_(int* y, const int* x, int m, int n);
// Transforma una matriz x[n][m] en su traspuesta con elementos al cuadrado y la guarda en y[m][n]

        .text
        .p2align 2
        .globl _CalcMatrixSquares_
_CalcMatrixSquares_:
        // x0 = y (int*)
        // x1 = x (const int*)
        // w2 = m
        // w3 = n

        stp     x19, x20, [sp, #-16]!      // Save callee-saved
        stp     x21, x22, [sp, #-16]!      // More registers

        cmp     w2, #0
        ble     .Ldone                     // if m <= 0 return

        cmp     w3, #0
        ble     .Ldone                     // if n <= 0 return

        mov     w19, #0                    // i = 0

.Louter:                                    // Loop1: for i in 0..m-1
        mov     w20, #0                    // j = 0

.Linner:                                    // Loop2: for j in 0..n-1
        mul     w21, w20, w2               // w21 = j * m
        add     w21, w21, w19              // w21 = kx = j * m + i
        ldr     w22, [x1, w21, SXTW #2]    // w22 = x[kx] = x[j][i]

        mul     w22, w22, w22              // square: w22 = x[j][i]²

        mul     w21, w19, w3               // w21 = i * n
        add     w21, w21, w20              // w21 = ky = i * n + j
        str     w22, [x0, w21, SXTW #2]    // y[ky] = square

        add     w20, w20, #1
        cmp     w20, w3
        blt     .Linner

        add     w19, w19, #1
        cmp     w19, w2
        blt     .Louter

.Ldone:
        ldp     x21, x22, [sp], #16
        ldp     x19, x20, [sp], #16
        ret

//-------------------------------------------------
//               Ch04_02_.s (ARM64 / macOS)
//-------------------------------------------------

// extern "C" int32_t CalcZ_(int32_t* z, const int8_t* x, const int16_t* y, int32_t n);

        .text
        .p2align 2
        .globl _CalcZ_
_CalcZ_:
        // x0 = z (int32_t*)
        // x1 = x (int8_t*)
        // x2 = y (int16_t*)
        // w3 = n

        stp     x19, x20, [sp, #-16]!      // Save callee-saved regs
        stp     x21, x22, [sp, #-16]!      // Additional regs

        mov     w19, wzr                   // w19 = sum = 0
        cmp     w3, #0
        ble     .Ldone

        // Load g_Val1 and g_Val2
        adrp    x20, _g_Val1@PAGE
        ldr     w20, [x20, _g_Val1@PAGEOFF]    // w20 = g_Val1

        adrp    x21, _g_Val2@PAGE
        ldr     w21, [x21, _g_Val2@PAGEOFF]    // w21 = g_Val2

.Lloop:
        ldrsb   w4, [x1], #1               // w4 = x[i]; x++
        ldrsh   w5, [x2], #2               // w5 = y[i]; y++

        cmp     w4, #0
        csel    w6, w20, w21, lt           // w6 = (x[i] < 0) ? g_Val1 : g_Val2
        mul     w7, w5, w6                 // w7 = y[i] * val

        str     w7, [x0], #4               // z[i] = w7; z++
        add     w19, w19, w7               // sum += w7

        subs    w3, w3, #1
        b.ne    .Lloop

.Ldone:
        mov     w0, w19                    // return sum

        ldp     x21, x22, [sp], #16
        ldp     x19, x20, [sp], #16
        ret

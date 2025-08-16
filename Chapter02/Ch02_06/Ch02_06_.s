//------------------------------------------------
//               Ch02_06_.s (arm64 / macOS)
//------------------------------------------------

// extern "C" void MoveRegA_(unsigned int a, unsigned int* b);

        .text
        .p2align 2
        .globl _MoveRegA_
_MoveRegA_:
        // x0 = a
        // x1 = b (uint32_t*)

        // Guardar w19–w22 (equivalentes temporales a r4–r7)
        stp     x19, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!

        mov     x22, x1              // x22 = b

        // Shift/rotate operations
        asr     w2, w0, #2           // w2 = a >> 2 (arithmetic)
        lsl     w3, w0, #4           // w3 = a << 4
        lsr     w4, w0, #5           // w4 = a >> 5 (logical)
        ror     w5, w0, #3           // w5 = rotate right by 3

        // No RRX in ARM64 — emulate or skip
        // For now, we'll store 0 in w6 as placeholder
        mov     w6, wzr              // zero register (placeholder)

        // Store results to b[0] to b[4]
        str     w2, [x22]            // b[0]
        str     w3, [x22, #4]        // b[1]
        str     w4, [x22, #8]        // b[2]
        str     w5, [x22, #12]       // b[3]
        str     w6, [x22, #16]       // b[4] (rrx placeholder)

        // Restaurar registros
        ldp     x21, x22, [sp], #16
        ldp     x19, x20, [sp], #16
        ret

// extern "C" void MoveRegB_(unsigned int a, unsigned int* b, unsigned int count);

        .p2align 2
        .globl _MoveRegB_
_MoveRegB_:
        // x0 = a
        // x1 = b
        // x2 = count

        stp     x19, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!

        // Shift/rotate operations with register shift
        asr     w3, w0, w2           // arithmetic shift right
        lsl     w4, w0, w2           // logical shift left
        lsr     w5, w0, w2           // logical shift right
        ror     w6, w0, w2           // rotate right

        // Store results
        str     w3, [x1]             // b[0]
        str     w4, [x1, #4]         // b[1]
        str     w5, [x1, #8]         // b[2]
        str     w6, [x1, #12]        // b[3]

        ldp     x21, x22, [sp], #16
        ldp     x19, x20, [sp], #16
        ret

//------------------------------------------------
//               Ch02_05_.s  (arm64 / macOS)
//------------------------------------------------

// extern "C" int MoveImmA_(void);

        .text
        .p2align 2
        .globl _MoveImmA_
_MoveImmA_:
        // Move immediate examples using unsigned integers
        mov     w0, #25              // w0 = 25
        mov     w1, #1000            // w1 = 1000
        mov     w2, #1001            // w2 = 1001
        mov     w3, #50000           // w3 = 50000
        ret

// extern "C" int MoveImmB_(void);

        .p2align 2
        .globl _MoveImmB_
_MoveImmB_:
        // Valid 32-bit immediate (in range of MOVZ)
        mov     w0, #260096          // w0 = 260096

        // mov w1, #260097  -- invalid directly, so:
        // Alternative using MOVZ + MOVK
        movz    w1, #0xf801          // lower 16 bits
        movk    w1, #0x0003, lsl #16 // upper 16 bits —> 0x0003f801 = 260097

        // Same with bitwise math
        movz    w2, #(260097 & 0xffff)
        movk    w2, #(260097 >> 16), lsl #16

        // Load from literal pool (32-bit)
        adrp    x3, _lit260097@PAGE
        ldr     w3, [x3, _lit260097@PAGEOFF]
        ret

// extern "C" int MoveImmC_(void);

        .p2align 2
        .globl _MoveImmC_
_MoveImmC_:
        // Immediate signed (within range)
        mov     w0, #-57             // w0 = -57
        mov     w1, #-6401           // w1 = -6401

        // Alternative for -1000
        movz    w2, #(0xfffffc18 & 0xffff)
        movk    w2, #0xffff, lsl #16 // w2 = -1000 (0xfffffc18)

        // Literal
        adrp    x3, _litm1000@PAGE
        ldr     w3, [x3, _litm1000@PAGEOFF]

        // Alternative via two's complement
        movz    w4, #(0xfc18 & 0xFFFF)
        movk    w4, #(0xFFFF), lsl #16
        ret

// Literal data section
        .data
        .p2align 2
_lit260097:    .word 260097
_litm1000:     .word -1000

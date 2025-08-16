//-------------------------------------------------
//               Ch04_06_.s (ARM64 / macOS)
//-------------------------------------------------

// extern "C" int32_t CalcTestStructSum_(const TestStruct* ts)

// Offsets for TestStruct
        .equ S_ValA,  0    // int8_t
        .equ S_ValB,  1    // int8_t
        .equ S_ValC,  4    // int32_t
        .equ S_ValD,  8    // int16_t
        .equ S_ValE,  12   // int32_t
        .equ S_ValF,  16   // uint8_t
        .equ S_ValG,  18   // uint16_t

        .text
        .align 2
        .globl _CalcTestStructSum_
_CalcTestStructSum_:
        // x0 = pointer to TestStruct

        ldrsb   w1, [x0, #S_ValA]    // w1 = ValA (sign-extended)
        ldrsb   w2, [x0, #S_ValB]    // w2 = ValB (sign-extended)
        add     w1, w1, w2

        ldr     w2, [x0, #S_ValC]    // w2 = ValC
        add     w1, w1, w2

        ldrsh   w2, [x0, #S_ValD]    // w2 = ValD (sign-extended)
        add     w1, w1, w2

        ldr     w2, [x0, #S_ValE]    // w2 = ValE
        add     w1, w1, w2

        ldrb    w2, [x0, #S_ValF]    // w2 = ValF (zero-extended)
        add     w1, w1, w2

        ldrh    w2, [x0, #S_ValG]    // w2 = ValG (zero-extended)
        add     w0, w1, w2           // final sum in w0 (return value)

        ret

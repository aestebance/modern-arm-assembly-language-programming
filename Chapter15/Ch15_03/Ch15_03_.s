//-------------------------------------------------
//               Ch15_03_.s
//-------------------------------------------------

    .data
    .balign 8
    .global _CvtTab

_CvtTab:
    .quad F32_I32, I32_F32
    .quad F64_I64, I64_F64
    .quad F32_U32, U32_F32
    .quad F64_U64, U64_F64
    .quad F32_F64, F64_F32

    .text
    .private_extern _PackedConvert_
    .global _PackedConvert_
_PackedConvert_:
    cmp x2, #10
    b.hs LInvalidArg                         // salto a etiqueta local

    adrp x4, _CvtTab@GOTPAGE                 // carga página GOT
    ldr x4, [x4, _CvtTab@GOTPAGEOFF]         // carga dirección de CvtTab
    add x4, x4, x2, lsl #3                   // acceso a entrada en tabla
    ldr x4, [x4]                             // x4 = puntero a rutina

    mov x2, x0                               // x2 = destino
    mov w0, #1                               // return OK
    br x4                                    // salto indirecto

LInvalidArg:                                 // etiqueta local (no .global)
    mov w0, #0
    ret

// ----- Signed conversions -----

F32_I32:
    ld1 {v0.4s}, [x1]
    scvtf v1.4s, v0.4s
    st1 {v1.4s}, [x2]
    ret

I32_F32:
    ld1 {v0.4s}, [x1]
    fcvtns v1.4s, v0.4s
    st1 {v1.4s}, [x2]
    ret

F64_I64:
    ld1 {v0.2d}, [x1]
    scvtf v1.2d, v0.2d
    st1 {v1.2d}, [x2]
    ret

I64_F64:
    ld1 {v0.2d}, [x1]
    fcvtns v1.2d, v0.2d
    st1 {v1.2d}, [x2]
    ret

// ----- Unsigned conversions -----

F32_U32:
    ld1 {v0.4s}, [x1]
    ucvtf v1.4s, v0.4s
    st1 {v1.4s}, [x2]
    ret

U32_F32:
    ld1 {v0.4s}, [x1]
    fcvtnu v1.4s, v0.4s
    st1 {v1.4s}, [x2]
    ret

F64_U64:
    ld1 {v0.2d}, [x1]
    ucvtf v1.2d, v0.2d
    st1 {v1.2d}, [x2]
    ret

U64_F64:
    ld1 {v0.2d}, [x1]
    fcvtnu v1.2d, v0.2d
    st1 {v1.2d}, [x2]
    ret

// ----- FP conversions -----

F32_F64:
    ld1 {v0.2d}, [x1]
    ld1 {v2.2d}, [x3]
    fcvtn v1.2s, v0.2d
    fcvtn2 v1.4s, v2.2d
    st1 {v1.4s}, [x2]
    ret

F64_F32:
    ld1 {v0.4s}, [x1]
    fcvtl v1.2d, v0.2s
    fcvtl2 v2.2d, v0.4s
    st1 {v1.2d, v2.2d}, [x2]
    ret

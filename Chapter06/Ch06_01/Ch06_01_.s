//-------------------------------------------------
//               Ch06_01_.s (ARM64/macOS)
//-------------------------------------------------

        .section __TEXT,__const
        .align 2

r4_ScaleFtoC:   .single 0.55555556              // 5 / 9
r4_ScaleCtoF:   .single 1.8                     // 9 / 5
r4_32p0:        .single 32.0

        .text
        .align 2
        .globl _ConvertFtoC_
_ConvertFtoC_:
        // Input: s0 = deg_f
        // Output: s0 = (deg_f - 32.0) * 5/9

        adrp    x1, r4_32p0@PAGE
        ldr     s1, [x1, r4_32p0@PAGEOFF]       // s1 = 32.0

        adrp    x2, r4_ScaleFtoC@PAGE
        ldr     s2, [x2, r4_ScaleFtoC@PAGEOFF]  // s2 = 5 / 9

        fsub    s3, s0, s1                      // s3 = deg_f - 32
        fmul    s0, s3, s2                      // s0 = (deg_f - 32) * (5/9)

        ret

        .globl _ConvertCtoF_
_ConvertCtoF_:
        // Input: s0 = deg_c
        // Output: s0 = deg_c * 9/5 + 32

        adrp    x1, r4_32p0@PAGE
        ldr     s1, [x1, r4_32p0@PAGEOFF]       // s1 = 32.0

        adrp    x2, r4_ScaleCtoF@PAGE
        ldr     s2, [x2, r4_ScaleCtoF@PAGEOFF]  // s2 = 9 / 5

        fmul    s3, s0, s2                      // s3 = deg_c * 9 / 5
        fadd    s0, s3, s1                      // s0 = s3 + 32

        ret

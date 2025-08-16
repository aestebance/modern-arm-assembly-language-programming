//-------------------------------------------------
//               Ch06_02_.s (ARM64/macOS)
//-------------------------------------------------

        .section __TEXT,__const
        .align 3

r8_PI:      .double 3.14159265358979323846

        .text
        .align 2
        .globl _CalcSphereAreaVolume_
_CalcSphereAreaVolume_:
        // Inputs:
        // d0 = r
        // x0 = pointer to sa (output)
        // x1 = pointer to vol (output)

        // Load PI constant
        adrp    x2, r8_PI@PAGE
        ldr     d5, [x2, r8_PI@PAGEOFF]         // d5 = PI

        fmov    d6, #4.0                        // d6 = 4.0
        fmov    d7, #3.0                        // d7 = 3.0

        // Surface Area = 4 * PI * r^2
        fmul    d1, d0, d0                      // d1 = r * r
        fmul    d1, d1, d5                      // d1 = r^2 * PI
        fmul    d1, d1, d6                      // d1 = r^2 * PI * 4
        str     d1, [x0]                        // *sa = result

        // Volume = (4/3) * PI * r^3 = sa * r / 3
        fmul    d2, d1, d0                      // d2 = sa * r
        fdiv    d3, d2, d7                      // d3 = volume
        str     d3, [x1]                        // *vol = result

        ret

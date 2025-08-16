//-------------------------------------------------
//               Ch06_03_.s (ARM64/macOS)
//-------------------------------------------------

// extern "C" double CalcDist_(double x1, double y1, double z1,
//                              double x2, double y2, double z2);

        .text
        .align 2
        .globl _CalcDist_
_CalcDist_:
        // Registro de entrada (ARM64 calling convention):
        // d0 = x1, d1 = y1, d2 = z1
        // d3 = x2, d4 = y2, d5 = z2

        // d6 = (x2 - x1)^2
        fsub    d6, d3, d0
        fmul    d6, d6, d6

        // d7 = (y2 - y1)^2
        fsub    d7, d4, d1
        fmul    d7, d7, d7

        // d8 = (z2 - z1)^2
        fsub    d8, d5, d2
        fmul    d8, d8, d8

        // d0 = d6 + d7 + d8
        fadd    d0, d6, d7
        fadd    d0, d0, d8

        // d0 = sqrt(d0)
        fsqrt   d0, d0

        ret

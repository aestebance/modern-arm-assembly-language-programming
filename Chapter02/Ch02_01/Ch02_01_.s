// ------------------------------------------------
//               Ch02_01_.s  (arm64 / macOS)
// ------------------------------------------------

// extern "C" int IntegerAddSub_(int a, int b, int c, int d);

        .text
        .globl _IntegerAddSub_
        .p2align 2
_IntegerAddSub_:
        // a, b, c, d llegan en w0, w1, w2, w3 (ABI arm64)
        add     w0, w0, w1        // w0 = a + b
        add     w0, w0, w2        // w0 = a + b + c
        sub     w0, w0, w3        // w0 = a + b + c - d
        ret                       // volver al llamador

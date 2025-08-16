//------------------------------------------------
//               Ch02_02_.s  (arm64 / macOS)
//------------------------------------------------

// extern "C" int IntegerMulA_(int a, int b);

        .text
        .p2align 2
        .globl _IntegerMulA_
_IntegerMulA_:
        // w0 = a, w1 = b
        mul     w0, w0, w1          // (int) a * b
        ret

// extern "C" long long IntegerMulB_(int a, int b);

        .p2align 2
        .globl _IntegerMulB_
_IntegerMulB_:
        // w0 = a, w1 = b ; devuelve 64-bit en x0
        smull   x0, w0, w1          // (int64_t) a * b (signed)
        ret

// extern "C" unsigned long long IntegerMulC_(unsigned int a, unsigned int b);

        .p2align 2
        .globl _IntegerMulC_
_IntegerMulC_:
        // w0 = a, w1 = b ; devuelve 64-bit en x0
        umull   x0, w0, w1          // (uint64_t) a * b (unsigned)
        ret

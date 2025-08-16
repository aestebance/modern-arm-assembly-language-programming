//-------------------------------------------------
//               Ch06_05_.s (ARM64 / macOS)
//-------------------------------------------------

// extern "C" int GetRm_(void);
        .text
        .globl _GetRm_
_GetRm_:
        // read FPCR (Floating-point Control Register)
        mrs     x1, fpcr
        lsr     x2, x1, #22
        and     w0, w2, #3         // extract rounding mode (bits [23:22])
        ret

// extern "C" void SetRm_(int rm);
        .globl _SetRm_
_SetRm_:
        // read, update, and write FPCR
        mrs     x1, fpcr
        bfi     x1, x0, #22, #2    // insert rm into bits [23:22]
        msr     fpcr, x1
        ret

// extern "C" int ConvertA_(double a);
        .globl _ConvertA_
_ConvertA_:
        frint32z d1, d0            // convert double to int (round toward zero)
        fcvtzs w0, d1              // convert double to signed int
        ret

// extern "C" double ConvertB_(int a, unsigned int b);
        .globl _ConvertB_
_ConvertB_:
        scvtf d1, w0               // convert a (int) to double
        ucvtf d2, w1               // convert b (uint) to double
        fadd   d0, d1, d2          // d0 = a + b
        ret

// extern "C" float ConvertC_(double a, float b, double c, float d);
        .globl _ConvertC_
_ConvertC_:
        fcvt   d3, s1              // b (float) → double
        fcvt   d4, s3              // d (float) → double

        fadd   d5, d0, d3          // d5 = a + (double)b
        fsub   d6, d2, d4          // d6 = c - (double)d
        fdiv   d7, d5, d6          // d7 = result

        fcvt   s0, d7              // result (double) → float (return)
        ret


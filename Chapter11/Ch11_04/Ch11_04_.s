// clang++ -std=c++17 -O0 -g -arch arm64 Ch11_04.cpp Ch11_04_.s -o ch11_04
//-------------------------------------------------
//               Ch11_04_.s
//-------------------------------------------------

// --- Datos ---
        .data
        .p2align 2
A1:     .word 1, 2, 3, 4, 5, 6, 7, 8

        .p2align 3
A2:     .quad 10, -20, 30, -40, 50, -60, 70, -80

        .p2align 1
A3:     .short 100, 200, -300, 400, 500, -600, 700, 800

// --- Código ---
        .text

// extern "C" int TestLDR1_(unsigned int i, unsigned long j);
        .globl _TestLDR1_
        .p2align 2
_TestLDR1_:
        adrp    x2, A1@PAGE              // x2 = page base de A1
        add     x2, x2, A1@PAGEOFF       // x2 = &A1
        ldr     w3, [x2, w0, uxtw #2]    // w3 = A1[i]    (int => 4 bytes => <<2)
        ldr     w4, [x2, x1, lsl  #2]    // w4 = A1[j]
        add     w0, w3, w4               // return en w0
        ret

// extern "C" long TestLDR2_(unsigned int i, unsigned long j);
        .globl _TestLDR2_
        .p2align 2
_TestLDR2_:
        adrp    x2, A2@PAGE
        add     x2, x2, A2@PAGEOFF       // x2 = &A2
        ldr     x3, [x2, w0, uxtw #3]    // x3 = A2[i]    (long 8 bytes => <<3)
        ldr     x4, [x2, x1, lsl  #3]    // x4 = A2[j]
        add     x0, x3, x4               // return en x0
        ret

// extern "C" short TestLDR3_(unsigned int i, unsigned long j);
        .globl _TestLDR3_
        .p2align 2
_TestLDR3_:
        adrp    x2, A3@PAGE
        add     x2, x2, A3@PAGEOFF       // x2 = &A3
        ldrsh   w3, [x2, w0, uxtw #1]    // w3 = A3[i]  (short 2 bytes => <<1, con sign-extend)
        ldrsh   w4, [x2, x1, lsl  #1]    // w4 = A3[j]
        add     w0, w3, w4
        ret

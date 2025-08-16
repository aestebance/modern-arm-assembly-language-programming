//------------------------------------------------
//               Ch02_04_.s  (arm64 / macOS)
//------------------------------------------------

        .data
        .p2align 2
_Foo:   .word 100, 200, 300, 400

// extern "C" void TestLDR_(void);

        .text
        .p2align 2
        .globl _TestLDR_
_TestLDR_:
        adrp    x1, _Foo@PAGE           // x1 = page base address of _Foo
        add     x1, x1, _Foo@PAGEOFF    // x1 = full address of _Foo

        ldr     w2, [x1]                // w2 = Foo[0]
        ldr     w3, [x1, #4]            // w3 = Foo[1]

        add     w0, w2, w3              // w0 = Foo[0] + Foo[1]

        ldr     w2, [x1, #8]            // w2 = Foo[2]
        add     w0, w0, w2              // w0 += Foo[2]

        ldr     w2, [x1, #12]           // w2 = Foo[3]
        add     w0, w0, w2              // w0 += Foo[3]

        ret

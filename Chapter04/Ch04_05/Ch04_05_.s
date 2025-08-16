//-------------------------------------------------
//               Ch04_05_.s (ARM64/macOS)
//-------------------------------------------------

// extern "C" void ReverseArrayA_(int* y, const int* x, int n);

        .text
        .align 2
        .globl _ReverseArrayA_
_ReverseArrayA_:
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp

        // x0 = y, x1 = x, w2 = n
        cbz     w2, .done_a

        // x1 = x + 4 * (n - 1)
        mov     w3, w2
        subs    w3, w3, #1
        lsl     x1, x1, #0     // keep x1 as base address
        add     x1, x1, w3, SXTW #2

.loop_a:
        ldr     w4, [x1], #-4     // w4 = x[n - 1 - i]
        str     w4, [x0], #4      // store to y[i]
        subs    w2, w2, #1
        b.gt    .loop_a

.done_a:
        ldp     x29, x30, [sp], #16
        ret

//-------------------------------------------------
// extern "C" void ReverseArrayB_(int* x, int n);
//-------------------------------------------------

        .globl _ReverseArrayB_
_ReverseArrayB_:
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp

        // x0 = x, w1 = n
        cbz     w1, .done_b

        mov     w2, #0               // i = 0
        mov     w3, w1
        subs    w3, w3, #1           // j = n - 1

.loop_b:
        cmp     w2, w3
        b.ge    .done_b              // if i >= j, done

        ldr     w4, [x0, w2, SXTW #2]    // temp = x[i]
        ldr     w5, [x0, w3, SXTW #2]    // x[j]
        str     w5, [x0, w2, SXTW #2]    // x[i] = x[j]
        str     w4, [x0, w3, SXTW #2]    // x[j] = temp

        add     w2, w2, #1
        sub     w3, w3, #1
        b       .loop_b

.done_b:
        ldp     x29, x30, [sp], #16
        ret

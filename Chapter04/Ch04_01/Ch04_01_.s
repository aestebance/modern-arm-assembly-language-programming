//-------------------------------------------------
//               Ch04_01_.s (ARM64 / macOS)
//-------------------------------------------------

// extern "C" int CalcSumA_(const int* x, int n);

        .text
        .p2align 2
        .globl _CalcSumA_
_CalcSumA_:
        // x0 = x (int*)
        // w1 = n

        mov     w2, wzr                    // sum = 0

        cmp     w1, #0                     // if (n <= 0)
        ble     .LdoneA                    //     return 0

.LloopA:
        ldr     w3, [x0], #4               // w3 = *x++; x += 4
        add     w2, w2, w3                 // sum += *x
        subs    w1, w1, #1                 // n--
        b.ne    .LloopA

.LdoneA:
        mov     w0, w2                     // return sum in w0
        ret


// extern "C" uint64_t CalcSumB_(const uint32_t* x, uint32_t n);

        .globl _CalcSumB_
_CalcSumB_:
        // x0 = x (uint32_t*)
        // w1 = n

        stp     x19, x20, [sp, #-16]!      // Save x19–x20

        mov     w2, wzr                    // lo = 0
        mov     w3, wzr                    // hi = 0

        cmp     w1, #0
        beq     .LdoneB

        mov     w19, wzr                   // i = 0

.LloopB:
        ldr     w20, [x0, w19, uxtw #2]    // w20 = x[i]
        adds    w2, w2, w20                // lo += x[i]
        adc     w3, w3, wzr                // hi += carry from lo

        add     w19, w19, #1               // i++
        cmp     w19, w1                    // i < n?
        b.ne    .LloopB

.LdoneB:
        mov     w0, w2                     // return lo (w0)
        mov     w1, w3                     // return hi (w1)

        ldp     x19, x20, [sp], #16        // Restore x19–x20
        ret

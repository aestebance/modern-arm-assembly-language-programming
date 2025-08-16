// clang++ -std=c++17 -O0 -g -arch arm64 Ch11_03.cpp Ch11_03_.s -o ch11_03
//-------------------------------------------------
//               Ch11_03_.s
//-------------------------------------------------
// extern "C" void CalcQuoRemA_(int a, int b, int* quo, int* rem);
            .text
            .global _CalcQuoRemA_
_CalcQuoRemA_:
// Calculate quotient and remainder
            sdiv w4,w0,w1                           // a / b
            str w4,[x2]                             // save quotient
            mul w5,w4,w1                            // quotient * b
            sub w6,w0,w5                            // a - quotient * b
            str w6,[x3]                             // save remainder
            ret                                     // return to caller
// extern "C" void CalcQuoRemB_(long a, long b, long* quo, long* rem);
            .global _CalcQuoRemB_
_CalcQuoRemB_:
// Calculate quotient and remainder
            sdiv x4,x0,x1                           // a / b
            str x4,[x2]                             // save quotient
            mul x5,x4,x1                            // quotient * b
            sub x6,x0,x5                            // a - quotient * b
            str x6,[x3]                             // save remainder
            ret                                     // return to caller
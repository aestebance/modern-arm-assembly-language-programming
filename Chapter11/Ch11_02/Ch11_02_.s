// clang++ -std=c++17 -O0 -g -arch arm64 Ch11_02.cpp Ch11_02_.s -o ch11_02
//-------------------------------------------------
//               Ch11_02_.s
//-------------------------------------------------
// extern "C" int IntegerMulA_(int a, int b);
            .text
            .global _IntegerMulA_
_IntegerMulA_:
// Calculate a * b and save result
            mul w0,w0,w1                        // a * b (32-bit)
            ret
// extern "C" long IntegerMulB_(long a, long b);
            .global _IntegerMulB_
_IntegerMulB_:
// Calculate a * b and save result
            mul x0,x0,x1                        // a * b (64-bit)
            ret
// extern "C" long IntegerMulC_(int a, int b);
            .global _IntegerMulC_
_IntegerMulC_:
// Calculate a * b and save result
            smull x0,w0,w1                      // signed 64-bit
            ret
// extern "C" unsigned long IntegerMulD_(unsigned int a, unsigned int b);
            .global _IntegerMulD_
_IntegerMulD_:
// Calculate a * b and save result
            umull x0,w0,w1                      // unsigned signed 64-bit
            ret
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64 | FileCheck %s --check-prefix=ALL --check-prefix=SSE --check-prefix=SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -mattr=+sse3 | FileCheck %s --check-prefix=ALL --check-prefix=SSE --check-prefix=SSE3
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -mattr=+ssse3 | FileCheck %s --check-prefix=ALL --check-prefix=SSE --check-prefix=SSSE3
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -mattr=+sse4.1 | FileCheck %s --check-prefix=ALL --check-prefix=SSE --check-prefix=SSE41
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -mattr=+avx | FileCheck %s --check-prefix=ALL --check-prefix=AVX --check-prefix=AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -mattr=+avx2 | FileCheck %s --check-prefix=ALL --check-prefix=AVX --check-prefix=AVX2

target triple = "x86_64-unknown-unknown"

define <2 x i64> @testv2i64(<2 x i64> %in) {
; SSE2-LABEL: testv2i64:
; SSE2:       # BB#0:
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrlq $1, %xmm1
; SSE2-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE2-NEXT:    psubq %xmm1, %xmm0
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [3689348814741910323,3689348814741910323]
; SSE2-NEXT:    movdqa %xmm0, %xmm2
; SSE2-NEXT:    pand %xmm1, %xmm2
; SSE2-NEXT:    psrlq $2, %xmm0
; SSE2-NEXT:    pand %xmm1, %xmm0
; SSE2-NEXT:    paddq %xmm2, %xmm0
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrlq $4, %xmm1
; SSE2-NEXT:    paddq %xmm0, %xmm1
; SSE2-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE2-NEXT:    pxor %xmm0, %xmm0
; SSE2-NEXT:    psadbw %xmm0, %xmm1
; SSE2-NEXT:    movdqa %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: testv2i64:
; SSE3:       # BB#0:
; SSE3-NEXT:    movdqa %xmm0, %xmm1
; SSE3-NEXT:    psrlq $1, %xmm1
; SSE3-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE3-NEXT:    psubq %xmm1, %xmm0
; SSE3-NEXT:    movdqa {{.*#+}} xmm1 = [3689348814741910323,3689348814741910323]
; SSE3-NEXT:    movdqa %xmm0, %xmm2
; SSE3-NEXT:    pand %xmm1, %xmm2
; SSE3-NEXT:    psrlq $2, %xmm0
; SSE3-NEXT:    pand %xmm1, %xmm0
; SSE3-NEXT:    paddq %xmm2, %xmm0
; SSE3-NEXT:    movdqa %xmm0, %xmm1
; SSE3-NEXT:    psrlq $4, %xmm1
; SSE3-NEXT:    paddq %xmm0, %xmm1
; SSE3-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE3-NEXT:    pxor %xmm0, %xmm0
; SSE3-NEXT:    psadbw %xmm0, %xmm1
; SSE3-NEXT:    movdqa %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: testv2i64:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    movdqa {{.*#+}} xmm1 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
; SSSE3-NEXT:    movdqa %xmm0, %xmm2
; SSSE3-NEXT:    pand %xmm1, %xmm2
; SSSE3-NEXT:    movdqa {{.*#+}} xmm3 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
; SSSE3-NEXT:    movdqa %xmm3, %xmm4
; SSSE3-NEXT:    pshufb %xmm2, %xmm4
; SSSE3-NEXT:    psrlw $4, %xmm0
; SSSE3-NEXT:    pand %xmm1, %xmm0
; SSSE3-NEXT:    pshufb %xmm0, %xmm3
; SSSE3-NEXT:    paddb %xmm4, %xmm3
; SSSE3-NEXT:    pxor %xmm0, %xmm0
; SSSE3-NEXT:    psadbw %xmm3, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: testv2i64:
; SSE41:       # BB#0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
; SSE41-NEXT:    movdqa %xmm0, %xmm2
; SSE41-NEXT:    pand %xmm1, %xmm2
; SSE41-NEXT:    movdqa {{.*#+}} xmm3 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
; SSE41-NEXT:    movdqa %xmm3, %xmm4
; SSE41-NEXT:    pshufb %xmm2, %xmm4
; SSE41-NEXT:    psrlw $4, %xmm0
; SSE41-NEXT:    pand %xmm1, %xmm0
; SSE41-NEXT:    pshufb %xmm0, %xmm3
; SSE41-NEXT:    paddb %xmm4, %xmm3
; SSE41-NEXT:    pxor %xmm0, %xmm0
; SSE41-NEXT:    psadbw %xmm3, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: testv2i64:
; AVX:       # BB#0:
; AVX-NEXT:    vmovdqa {{.*#+}} xmm1 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
; AVX-NEXT:    vpand %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vmovdqa {{.*#+}} xmm3 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
; AVX-NEXT:    vpshufb %xmm2, %xmm3, %xmm2
; AVX-NEXT:    vpsrlw $4, %xmm0, %xmm0
; AVX-NEXT:    vpand %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpshufb %xmm0, %xmm3, %xmm0
; AVX-NEXT:    vpaddb %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpsadbw %xmm0, %xmm1, %xmm0
; AVX-NEXT:    retq
  %out = call <2 x i64> @llvm.ctpop.v2i64(<2 x i64> %in)
  ret <2 x i64> %out
}

define <4 x i32> @testv4i32(<4 x i32> %in) {
; SSE2-LABEL: testv4i32:
; SSE2:       # BB#0:
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrld $1, %xmm1
; SSE2-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE2-NEXT:    psubd %xmm1, %xmm0
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [858993459,858993459,858993459,858993459]
; SSE2-NEXT:    movdqa %xmm0, %xmm2
; SSE2-NEXT:    pand %xmm1, %xmm2
; SSE2-NEXT:    psrld $2, %xmm0
; SSE2-NEXT:    pand %xmm1, %xmm0
; SSE2-NEXT:    paddd %xmm2, %xmm0
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrld $4, %xmm1
; SSE2-NEXT:    paddd %xmm0, %xmm1
; SSE2-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE2-NEXT:    pxor %xmm0, %xmm0
; SSE2-NEXT:    movdqa %xmm1, %xmm2
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm2 = xmm2[2],xmm0[2],xmm2[3],xmm0[3]
; SSE2-NEXT:    psadbw %xmm0, %xmm2
; SSE2-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE2-NEXT:    psadbw %xmm0, %xmm1
; SSE2-NEXT:    packuswb %xmm2, %xmm1
; SSE2-NEXT:    movdqa %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: testv4i32:
; SSE3:       # BB#0:
; SSE3-NEXT:    movdqa %xmm0, %xmm1
; SSE3-NEXT:    psrld $1, %xmm1
; SSE3-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE3-NEXT:    psubd %xmm1, %xmm0
; SSE3-NEXT:    movdqa {{.*#+}} xmm1 = [858993459,858993459,858993459,858993459]
; SSE3-NEXT:    movdqa %xmm0, %xmm2
; SSE3-NEXT:    pand %xmm1, %xmm2
; SSE3-NEXT:    psrld $2, %xmm0
; SSE3-NEXT:    pand %xmm1, %xmm0
; SSE3-NEXT:    paddd %xmm2, %xmm0
; SSE3-NEXT:    movdqa %xmm0, %xmm1
; SSE3-NEXT:    psrld $4, %xmm1
; SSE3-NEXT:    paddd %xmm0, %xmm1
; SSE3-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE3-NEXT:    pxor %xmm0, %xmm0
; SSE3-NEXT:    movdqa %xmm1, %xmm2
; SSE3-NEXT:    punpckhdq {{.*#+}} xmm2 = xmm2[2],xmm0[2],xmm2[3],xmm0[3]
; SSE3-NEXT:    psadbw %xmm0, %xmm2
; SSE3-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE3-NEXT:    psadbw %xmm0, %xmm1
; SSE3-NEXT:    packuswb %xmm2, %xmm1
; SSE3-NEXT:    movdqa %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: testv4i32:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    movdqa {{.*#+}} xmm2 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
; SSSE3-NEXT:    movdqa %xmm0, %xmm3
; SSSE3-NEXT:    pand %xmm2, %xmm3
; SSSE3-NEXT:    movdqa {{.*#+}} xmm1 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
; SSSE3-NEXT:    movdqa %xmm1, %xmm4
; SSSE3-NEXT:    pshufb %xmm3, %xmm4
; SSSE3-NEXT:    psrlw $4, %xmm0
; SSSE3-NEXT:    pand %xmm2, %xmm0
; SSSE3-NEXT:    pshufb %xmm0, %xmm1
; SSSE3-NEXT:    paddb %xmm4, %xmm1
; SSSE3-NEXT:    pxor %xmm0, %xmm0
; SSSE3-NEXT:    movdqa %xmm1, %xmm2
; SSSE3-NEXT:    punpckhdq {{.*#+}} xmm2 = xmm2[2],xmm0[2],xmm2[3],xmm0[3]
; SSSE3-NEXT:    psadbw %xmm0, %xmm2
; SSSE3-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSSE3-NEXT:    psadbw %xmm0, %xmm1
; SSSE3-NEXT:    packuswb %xmm2, %xmm1
; SSSE3-NEXT:    movdqa %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: testv4i32:
; SSE41:       # BB#0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm2 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
; SSE41-NEXT:    movdqa %xmm0, %xmm3
; SSE41-NEXT:    pand %xmm2, %xmm3
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
; SSE41-NEXT:    movdqa %xmm1, %xmm4
; SSE41-NEXT:    pshufb %xmm3, %xmm4
; SSE41-NEXT:    psrlw $4, %xmm0
; SSE41-NEXT:    pand %xmm2, %xmm0
; SSE41-NEXT:    pshufb %xmm0, %xmm1
; SSE41-NEXT:    paddb %xmm4, %xmm1
; SSE41-NEXT:    pxor %xmm0, %xmm0
; SSE41-NEXT:    movdqa %xmm1, %xmm2
; SSE41-NEXT:    punpckhdq {{.*#+}} xmm2 = xmm2[2],xmm0[2],xmm2[3],xmm0[3]
; SSE41-NEXT:    psadbw %xmm0, %xmm2
; SSE41-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE41-NEXT:    psadbw %xmm0, %xmm1
; SSE41-NEXT:    packuswb %xmm2, %xmm1
; SSE41-NEXT:    movdqa %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: testv4i32:
; AVX:       # BB#0:
; AVX-NEXT:    vmovdqa {{.*#+}} xmm1 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
; AVX-NEXT:    vpand %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vmovdqa {{.*#+}} xmm3 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
; AVX-NEXT:    vpshufb %xmm2, %xmm3, %xmm2
; AVX-NEXT:    vpsrlw $4, %xmm0, %xmm0
; AVX-NEXT:    vpand %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpshufb %xmm0, %xmm3, %xmm0
; AVX-NEXT:    vpaddb %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpunpckhdq {{.*#+}} xmm2 = xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX-NEXT:    vpsadbw %xmm2, %xmm1, %xmm2
; AVX-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX-NEXT:    vpsadbw %xmm0, %xmm1, %xmm0
; AVX-NEXT:    vpackuswb %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %out = call <4 x i32> @llvm.ctpop.v4i32(<4 x i32> %in)
  ret <4 x i32> %out
}

define <8 x i16> @testv8i16(<8 x i16> %in) {
; SSE2-LABEL: testv8i16:
; SSE2:       # BB#0:
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrlw $1, %xmm1
; SSE2-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE2-NEXT:    psubw %xmm1, %xmm0
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [13107,13107,13107,13107,13107,13107,13107,13107]
; SSE2-NEXT:    movdqa %xmm0, %xmm2
; SSE2-NEXT:    pand %xmm1, %xmm2
; SSE2-NEXT:    psrlw $2, %xmm0
; SSE2-NEXT:    pand %xmm1, %xmm0
; SSE2-NEXT:    paddw %xmm2, %xmm0
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrlw $4, %xmm1
; SSE2-NEXT:    paddw %xmm0, %xmm1
; SSE2-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE2-NEXT:    movdqa %xmm1, %xmm0
; SSE2-NEXT:    psllw $8, %xmm0
; SSE2-NEXT:    paddb %xmm1, %xmm0
; SSE2-NEXT:    psrlw $8, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: testv8i16:
; SSE3:       # BB#0:
; SSE3-NEXT:    movdqa %xmm0, %xmm1
; SSE3-NEXT:    psrlw $1, %xmm1
; SSE3-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE3-NEXT:    psubw %xmm1, %xmm0
; SSE3-NEXT:    movdqa {{.*#+}} xmm1 = [13107,13107,13107,13107,13107,13107,13107,13107]
; SSE3-NEXT:    movdqa %xmm0, %xmm2
; SSE3-NEXT:    pand %xmm1, %xmm2
; SSE3-NEXT:    psrlw $2, %xmm0
; SSE3-NEXT:    pand %xmm1, %xmm0
; SSE3-NEXT:    paddw %xmm2, %xmm0
; SSE3-NEXT:    movdqa %xmm0, %xmm1
; SSE3-NEXT:    psrlw $4, %xmm1
; SSE3-NEXT:    paddw %xmm0, %xmm1
; SSE3-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE3-NEXT:    movdqa %xmm1, %xmm0
; SSE3-NEXT:    psllw $8, %xmm0
; SSE3-NEXT:    paddb %xmm1, %xmm0
; SSE3-NEXT:    psrlw $8, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: testv8i16:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    movdqa {{.*#+}} xmm1 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
; SSSE3-NEXT:    movdqa %xmm0, %xmm2
; SSSE3-NEXT:    pand %xmm1, %xmm2
; SSSE3-NEXT:    movdqa {{.*#+}} xmm3 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
; SSSE3-NEXT:    movdqa %xmm3, %xmm4
; SSSE3-NEXT:    pshufb %xmm2, %xmm4
; SSSE3-NEXT:    psrlw $4, %xmm0
; SSSE3-NEXT:    pand %xmm1, %xmm0
; SSSE3-NEXT:    pshufb %xmm0, %xmm3
; SSSE3-NEXT:    paddb %xmm4, %xmm3
; SSSE3-NEXT:    movdqa %xmm3, %xmm0
; SSSE3-NEXT:    psllw $8, %xmm0
; SSSE3-NEXT:    paddb %xmm3, %xmm0
; SSSE3-NEXT:    psrlw $8, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: testv8i16:
; SSE41:       # BB#0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
; SSE41-NEXT:    movdqa %xmm0, %xmm2
; SSE41-NEXT:    pand %xmm1, %xmm2
; SSE41-NEXT:    movdqa {{.*#+}} xmm3 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
; SSE41-NEXT:    movdqa %xmm3, %xmm4
; SSE41-NEXT:    pshufb %xmm2, %xmm4
; SSE41-NEXT:    psrlw $4, %xmm0
; SSE41-NEXT:    pand %xmm1, %xmm0
; SSE41-NEXT:    pshufb %xmm0, %xmm3
; SSE41-NEXT:    paddb %xmm4, %xmm3
; SSE41-NEXT:    movdqa %xmm3, %xmm0
; SSE41-NEXT:    psllw $8, %xmm0
; SSE41-NEXT:    paddb %xmm3, %xmm0
; SSE41-NEXT:    psrlw $8, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: testv8i16:
; AVX:       # BB#0:
; AVX-NEXT:    vmovdqa {{.*#+}} xmm1 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
; AVX-NEXT:    vpand %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vmovdqa {{.*#+}} xmm3 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
; AVX-NEXT:    vpshufb %xmm2, %xmm3, %xmm2
; AVX-NEXT:    vpsrlw $4, %xmm0, %xmm0
; AVX-NEXT:    vpand %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpshufb %xmm0, %xmm3, %xmm0
; AVX-NEXT:    vpaddb %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vpsllw $8, %xmm0, %xmm1
; AVX-NEXT:    vpaddb %xmm0, %xmm1, %xmm0
; AVX-NEXT:    vpsrlw $8, %xmm0, %xmm0
; AVX-NEXT:    retq
  %out = call <8 x i16> @llvm.ctpop.v8i16(<8 x i16> %in)
  ret <8 x i16> %out
}

define <16 x i8> @testv16i8(<16 x i8> %in) {
; SSE2-LABEL: testv16i8:
; SSE2:       # BB#0:
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrlw $1, %xmm1
; SSE2-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE2-NEXT:    psubb %xmm1, %xmm0
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51]
; SSE2-NEXT:    movdqa %xmm0, %xmm2
; SSE2-NEXT:    pand %xmm1, %xmm2
; SSE2-NEXT:    psrlw $2, %xmm0
; SSE2-NEXT:    pand %xmm1, %xmm0
; SSE2-NEXT:    paddb %xmm2, %xmm0
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrlw $4, %xmm1
; SSE2-NEXT:    paddb %xmm0, %xmm1
; SSE2-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE2-NEXT:    movdqa %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: testv16i8:
; SSE3:       # BB#0:
; SSE3-NEXT:    movdqa %xmm0, %xmm1
; SSE3-NEXT:    psrlw $1, %xmm1
; SSE3-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE3-NEXT:    psubb %xmm1, %xmm0
; SSE3-NEXT:    movdqa {{.*#+}} xmm1 = [51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51]
; SSE3-NEXT:    movdqa %xmm0, %xmm2
; SSE3-NEXT:    pand %xmm1, %xmm2
; SSE3-NEXT:    psrlw $2, %xmm0
; SSE3-NEXT:    pand %xmm1, %xmm0
; SSE3-NEXT:    paddb %xmm2, %xmm0
; SSE3-NEXT:    movdqa %xmm0, %xmm1
; SSE3-NEXT:    psrlw $4, %xmm1
; SSE3-NEXT:    paddb %xmm0, %xmm1
; SSE3-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE3-NEXT:    movdqa %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: testv16i8:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    movdqa {{.*#+}} xmm2 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
; SSSE3-NEXT:    movdqa %xmm0, %xmm3
; SSSE3-NEXT:    pand %xmm2, %xmm3
; SSSE3-NEXT:    movdqa {{.*#+}} xmm1 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
; SSSE3-NEXT:    movdqa %xmm1, %xmm4
; SSSE3-NEXT:    pshufb %xmm3, %xmm4
; SSSE3-NEXT:    psrlw $4, %xmm0
; SSSE3-NEXT:    pand %xmm2, %xmm0
; SSSE3-NEXT:    pshufb %xmm0, %xmm1
; SSSE3-NEXT:    paddb %xmm4, %xmm1
; SSSE3-NEXT:    movdqa %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: testv16i8:
; SSE41:       # BB#0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm2 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
; SSE41-NEXT:    movdqa %xmm0, %xmm3
; SSE41-NEXT:    pand %xmm2, %xmm3
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
; SSE41-NEXT:    movdqa %xmm1, %xmm4
; SSE41-NEXT:    pshufb %xmm3, %xmm4
; SSE41-NEXT:    psrlw $4, %xmm0
; SSE41-NEXT:    pand %xmm2, %xmm0
; SSE41-NEXT:    pshufb %xmm0, %xmm1
; SSE41-NEXT:    paddb %xmm4, %xmm1
; SSE41-NEXT:    movdqa %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: testv16i8:
; AVX:       # BB#0:
; AVX-NEXT:    vmovdqa {{.*#+}} xmm1 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
; AVX-NEXT:    vpand %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vmovdqa {{.*#+}} xmm3 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
; AVX-NEXT:    vpshufb %xmm2, %xmm3, %xmm2
; AVX-NEXT:    vpsrlw $4, %xmm0, %xmm0
; AVX-NEXT:    vpand %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpshufb %xmm0, %xmm3, %xmm0
; AVX-NEXT:    vpaddb %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %out = call <16 x i8> @llvm.ctpop.v16i8(<16 x i8> %in)
  ret <16 x i8> %out
}

define <2 x i64> @foldv2i64() {
; SSE-LABEL: foldv2i64:
; SSE:       # BB#0:
; SSE-NEXT:    movaps {{.*#+}} xmm0 = [1,64]
; SSE-NEXT:    retq
;
; AVX-LABEL: foldv2i64:
; AVX:       # BB#0:
; AVX-NEXT:    vmovaps {{.*#+}} xmm0 = [1,64]
; AVX-NEXT:    retq
  %out = call <2 x i64> @llvm.ctpop.v2i64(<2 x i64> <i64 256, i64 -1>)
  ret <2 x i64> %out
}

define <4 x i32> @foldv4i32() {
; SSE-LABEL: foldv4i32:
; SSE:       # BB#0:
; SSE-NEXT:    movaps {{.*#+}} xmm0 = [1,32,0,8]
; SSE-NEXT:    retq
;
; AVX-LABEL: foldv4i32:
; AVX:       # BB#0:
; AVX-NEXT:    vmovaps {{.*#+}} xmm0 = [1,32,0,8]
; AVX-NEXT:    retq
  %out = call <4 x i32> @llvm.ctpop.v4i32(<4 x i32> <i32 256, i32 -1, i32 0, i32 255>)
  ret <4 x i32> %out
}

define <8 x i16> @foldv8i16() {
; SSE-LABEL: foldv8i16:
; SSE:       # BB#0:
; SSE-NEXT:    movaps {{.*#+}} xmm0 = [1,16,0,8,0,3,2,3]
; SSE-NEXT:    retq
;
; AVX-LABEL: foldv8i16:
; AVX:       # BB#0:
; AVX-NEXT:    vmovaps {{.*#+}} xmm0 = [1,16,0,8,0,3,2,3]
; AVX-NEXT:    retq
  %out = call <8 x i16> @llvm.ctpop.v8i16(<8 x i16> <i16 256, i16 -1, i16 0, i16 255, i16 -65536, i16 7, i16 24, i16 88>)
  ret <8 x i16> %out
}

define <16 x i8> @foldv16i8() {
; SSE-LABEL: foldv16i8:
; SSE:       # BB#0:
; SSE-NEXT:    movaps {{.*#+}} xmm0 = [0,8,0,8,0,3,2,3,7,7,1,1,1,1,1,1]
; SSE-NEXT:    retq
;
; AVX-LABEL: foldv16i8:
; AVX:       # BB#0:
; AVX-NEXT:    vmovaps {{.*#+}} xmm0 = [0,8,0,8,0,3,2,3,7,7,1,1,1,1,1,1]
; AVX-NEXT:    retq
  %out = call <16 x i8> @llvm.ctpop.v16i8(<16 x i8> <i8 256, i8 -1, i8 0, i8 255, i8 -65536, i8 7, i8 24, i8 88, i8 -2, i8 254, i8 1, i8 2, i8 4, i8 8, i8 16, i8 32>)
  ret <16 x i8> %out
}

declare <2 x i64> @llvm.ctpop.v2i64(<2 x i64>)
declare <4 x i32> @llvm.ctpop.v4i32(<4 x i32>)
declare <8 x i16> @llvm.ctpop.v8i16(<8 x i16>)
declare <16 x i8> @llvm.ctpop.v16i8(<16 x i8>)

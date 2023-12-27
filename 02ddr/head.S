// Copyright (c) 2022 IotaHydrae
// 
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT
//
// Before run this program, take a look at
// Allwinner F1C200s User Manual

.text
.global _start

@ w4 0x01C20824,0x00007222
@ w4 0x01C20AC0,0x00000AAA
@ w4 0x01C20020,0x90100C00
@ w4 0x01C20060,0x01004000
@ w4 0x01C202C0,0x01000000
@ w4 0x01C202C0,0x01004000
@ w4 0x01C20AC4,0x00010501
@ w4 0x01c01004,0xB7CEEDC2
@ w4 0x01c01008,0x00A70008
@ w4 0x01C01000,0x0001318A
@ w4 0x01C0100C,0x000800c8
@ w4 0x01C0100C,0x000800c9
@ w4 0x01C01024,0x00161600
@ w4 0x01C01010,0x000004C0

@ w4 0x80000000,0xAABBCCDD
@ mem32 0x80000000, 1

_start:
             adr     r0, DDR_REGS
             adr     r1, DDR_VALS
             adr     r4, DDR_REGS_END
             mov     r5, #0x0
loop:        
             ldr     r2, [r0, r5]
             ldr     r3, [r1, r5]
             str     r3, [r2]
             add     r5, r5, #0x4
             add     r6, r5, #0x200
             cmp     r4, r6
             bne     loop

DDR_REGS:    .word     0x01C20824
             .word     0x01C20AC0
             .word     0x01C20020
             .word     0x01C20060
             .word     0x01C202C0
             .word     0x01C202C0
             .word     0x01C20AC4
             .word     0x01c01004
             .word     0x01c01008
             .word     0x01C01000
             .word     0x01C0100C
             .word     0x01C0100C
             .word     0x01C01024
             .word     0x01C01010
DDR_REGS_END: .word     0xffffffff

DDR_VALS:    .word     0x00007222
             .word     0x00000AAA
             .word     0x90100C00
             .word     0x01004000
             .word     0x01000000
             .word     0x01004000
             .word     0x00010501
             .word     0xB7CEEDC2
             .word     0x00A70008
             .word     0x0001318A
             .word     0x000800c8
             .word     0x000800c9
             .word     0x00161600
             .word     0x000004C0
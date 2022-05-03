// Copyright (c) 2022 IotaHydrae
// 
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

.text
.global _start
_start:
    ldr r0, = (0x01c20800 + 0x00)   @ 0x01c20800 is the base address of the PIO, and PA_CFG0 is the offset 0x00 from the base address
    mov r1, #0x01              @ 0x01 is the value to be written to PA_CFG0 PA3
    str r1, [r0]           @ set PA3 to output

    ldr r0, = (0x01c20800 + 0x10)   @ PA Data Register address
    mov r1, #(1<<3)
    str r1, [r0]           @ set PA3 to high

MAIN_LOOP:
    b MAIN_LOOP

// Copyright (c) 2022 IotaHydrae
// 
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT
//
// Before run this program, take a look at
// Allwinner F1C200s User Manual

.text
.global _start

_start:
    bl ddr_init

    /* copy .rodata .data to link addr */
    ldr r0, =__rodata_start /* link addr of rodata eg. 800006D4*/

    ldr r2, =_start /* link addr eg. 80000000 */
    adr r3, _start /* load addr */
    sub r2, r2, r3
    sub r1, r0, r2  /* load addr of rodata. eg. 6D4 */

    ldr r3, =__bss_start /* link addr of bss. eg. 800006E6 */
    sub r2, r3, r0  /* length of copy area. eg. 0x12 */

    mov r3, #0x0
    /*  r0: dest  r1: src  r2:len */
    b loop_copy_data

copy_data:
    ldr r4, [r1, r3]
    str r4, [r0, r3]
    adds r3, r3, #4

loop_copy_data:
    cmp  r3, r2
    bcc copy_data

    ldr sp, =(0x00000000 + 0x8000)	@ top of sram, about 32KB
    bl main
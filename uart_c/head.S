// Copyright (c) 2022 IotaHydrae
// 
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT
//
// Before run this program, take a look at
// Allwinner F1C200s User Manual

/*
 * This program use UART0 via PE0,PE1
 */

.text
.global _start

_start:
	ldr sp, =(0x00000000 + 0x8000)	@ top of sram, about 32KB
	bl main

delay:
	sub r2, r2, #1			@ do simple sub command
	cmp r2, #0			@ if r0 - 0 == 0,  set cpsr Z=1, else set Z=0
	bne delay			@ means if cpsr Z == 0, jump to delay
	mov pc, lr
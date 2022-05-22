// Copyright (c) 2022 IotaHydrae
// 
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT
//
// Before run this program, take a look at
// Allwinner F1C200s User Manual

.text
.global _start

.equ	PIO_BASE,	0x01c20800
.equ	PA_CFG0,	0x00
.equ	PE_CFG0,	0x90

.equ	UART0_BASE,	0x01c25000


_start:
	ldr r0, =(0x01c20800 + 0x00)	@ base address of the PIO, and PA_CFG0 is the offset 0x00
	ldr r1, [r0]			@ default value 0x00007777, 0x7 means this pin was disabled
	bic r1, r1, #0x00007000		@ clear the given bit
	orr r1, r1, #0x00001000		@ 0x1 means set this pin to Output mode
	str r1, [r0]

	ldr r0, =(0x01c20800 + 0x10)	@ Address of PA Data Register
	ldr r1, [r0]

	and r1, r1, #0x00000000		@ In output mode, set bit means output the value of bit
	str r1, [r0]			@ set PA3 to low

	/* UART0 init */
	ldr r0, =(PIO_BASE + PE_CFG0)	@ r0 = 0x01c20890

	/* set PE0 and PE1 to uart function */
	ldr r1, [r0]
	bic r1, r1, #0x77
	orr r1, r1, #0x55
	str r1, [r0]

@ simple uart send loop
loop:
	
	b loop

delay:
	sub r2, r2, #1			@ do simple sub command
	cmp r2, #0			@ if r0 - 0 == 0,  set cpsr Z=1, else set Z=0
	bne delay			@ means if cpsr Z == 0, jump to delay
	mov pc, lr


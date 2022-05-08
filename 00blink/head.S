// Copyright (c) 2022 IotaHydrae
// 
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

.text
.global _start



_start:
	ldr r0, =(0x01c20800 + 0x00)	@base address of the PIO, and PA_CFG0 is the offset 0x00
	ldr r1, [r0]
	and r1, r1, #0x00001000
	str r1, [r0]

loop:
	ldr r0, =(0x01c20800 + 0x10)	@ PA Data Register address
	ldr r1, [r0]
	orr r1, r1, #0x00000008
	str r1, [r0]			@ set PA3 to high

	mov r0, #0x1000000
	bl delay

	ldr r0, =(0x01c20800 + 0x10)	@ PA Data Register address
	ldr r1, [r0]
	orr r1, r1, #0x00000000
	str r1, [r0]			@ set PA3 to high

	mov r0, #0x1000000
	bl delay

	b loop


delay:
	sub r0, r0, #1
	cmp r0, #0
	bne delay
	mov pc, lr

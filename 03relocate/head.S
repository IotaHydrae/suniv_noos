// Copyright (c) 2022 IotaHydrae
// 
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT
//
// This program is used to blink the led that
// connected on the PA3
//
// Before run this program, take a look at
// Allwinner F1C200s User Manual

.text
.global _start

_start:
	/* init clk */
	bl dram_init

	/* init ddr */
	bl clock_init

relocate:
	/* copy .text .rodata .data to link addr */
	bl memcpy

	/* clear .bss */
	bl memset

	/* run a blink at ddr */
	b loop

memcpy:
	mov pc, lr

memset:
	mov pc, lr


loop:
	b loop

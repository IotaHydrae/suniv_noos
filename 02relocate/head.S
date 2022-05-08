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

	/* init ddr */

relocate:
	/* copy .text .rodata .data to link addr */

	/* clear .bss */

	/* run a blink at ddr */

loop:
	b loop

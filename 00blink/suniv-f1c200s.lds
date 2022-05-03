// Copyright (c) 2022 IotaHydrae
// 
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

MEMORY { .sram : ORIGIN = 0x00010000, LENGTH=0x000A000 }
MEMORY { .sdram : ORIGIN = 0x80000000, LENGTH=0x00400000 }

OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS
{
    .text : {
        
    }
}

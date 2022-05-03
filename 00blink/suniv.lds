// Copyright (c) 2022 IotaHydrae
// 
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

SECTIONS {
    . = 0x80100000l

    . = ALIGN(4);
    .text : {
        *(.text)
    }

    . = ALIGN(4);
    .rodata : {
        *(.rodata)
    }

    . = ALIGN(4);
    .data : {
        *(.data)
    }

    . = ALIGN(4);
    __bss_start = .;
    .bss : {
        *(.bss)
        *(.COMMON)
    }
    _bss_end  = .;
}
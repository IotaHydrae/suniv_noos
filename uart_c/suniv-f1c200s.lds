MEMORY { .sram : ORIGIN = 0x00000000, LENGTH = 0x000A000 }
MEMORY { .sdram : ORIGIN = 0x80000000, LENGTH = 0x00400000 }

OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS {
	.text      :
	{
		__start = .;
		*(.text)
	} > .sram

	. = ALIGN(4);
	.rodata : { *(.rodata) } > .sram

	. = ALIGN(4);
	.data : { 
		*(.data)
	 } > .sram

	. = ALIGN(4);
	.bss :
	{ 
		__bss_start = .;
		*(.bss)
		*(.COMMON)
		__bss_end = .;
	} > .sram
}


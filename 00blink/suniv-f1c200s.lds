MEMORY { .sram : ORIGIN = 0x00010000, LENGTH = 0x000A000 }
MEMORY { .sdram : ORIGIN = 0x80000000, LENGTH = 0x00400000 }

OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS {
	.text      :
	{
		__start = .;
		*(.text)
	} > .sdram

	. = ALIGN(4);
	.rodata : { *(.rodata) } > .sdram

	. = ALIGN(4);
	.data : { 
		*(.data)
	 } > .sdram

	. = ALIGN(4);
	.bss :
	{ 
		__bss_start = .;
		*(.bss)
		*(.COMMON)
		__bss_end = .;
	} > .sdram
}


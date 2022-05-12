.equ PIO_BASE			,0x01c208000
.equ SDRAM_PAD_MULTI_DRIVING	,0x2c0
.equ SDRAM_PAD_PULL		,0x2c4

.text
.global dram_init


dram_init:
	/* Init sdram pad drive */
	ldr r0, =(PIO_BASE + SDRAM_PAD_MULTI_DRIVING)

	/* Init sdram pad pull */
	ldr r0, =(PIO_BASE + SDRAM_PAD_PULL)

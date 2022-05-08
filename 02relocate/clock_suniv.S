.equ	CCU_BASE		,0x01c20000
.equ	PLL_CPU_CTRL_REG	,0x0000
.equ	PLL_DDR_CTRL_REG	,0x0020
.equ	CPU_CLK_SRC_REG		,0x0050
.equ	AHP_APB_HCLKC_CFG_REG	,0x0054
.equ	DRAM_GATING_REG		,0x0100

.text
.global clock_init

/* do set, enable, validate */
clock_init:
	ldr r0, =(CCU_BASE + PLL_CPU_CTRL_REG)
	ldr r1, [r0]

	ldr r0, =(CCU_BASE + PLL_DDR_CTRL_REG)
	ldr r0, =(CCU_BASE + CPU_CLK_SRC_REG)
	ldr r0, =(CCU_BASE + AHP_APB_HCLKC_CFG_REG)
	ldr r0, =(CCU_BASE + DRAM_GATING_REG)


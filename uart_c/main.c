#include "uart.h"

#define CCU_BASE    0x01c20000
#define CLK_GATE2   0x68
#define RST_GATE2   0x2d0

#define PIO_BASE	0x01c20800
#define PE_CFG0     0x90

#define UART0_BASE  0x01c25000

#define readl(a) (*(volatile unsigned int *)(a))
#define writel(v,a) (*(volatile unsigned int *)(a) = (v))

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;

static void wait_pll_stable(u32 base)
{
	u32 rval = 0;
	u32 time = 0xfff;

	do {
		rval = readl(&base);
		time--;
	} while(time && !(rval & (1 << 28)));
}

static void clk_init(void)
{
    u32 val;

    /* enable pll_cpu and set to 408MHz */
    val = readl(CCU_BASE);
    val &= ~((0x3 << 16) | (0x1f << 8) | (0x3 << 4) | (0x3 << 0));
    val |= (1U << 31) | (0 << 16) | (0x10 << 8) | (0 << 4) | 0;
    writel(val, CCU_BASE);
    wait_pll_stable(CCU_BASE);

    /* set cpu clk source to pll_cpu */
    val = readl(CCU_BASE + 0x50);
    writel((0x2 << 16), CCU_BASE + 0x50);
}

int main(int argc, char **argv)
{
    char str[] = "Hello, world!\r\n";

    clk_init();

    /* uart function test */
    uart_putc('A');
    uart_putc('B');
    uart_putc('C');
    uart_putc('\r');
    uart_putc('\n');

    uart_puts(str);

    return 0;
}

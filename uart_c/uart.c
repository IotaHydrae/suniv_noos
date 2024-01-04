#include "uart.h"

#define CCU_BASE    0x01c20000
#define CLK_GATE2   0x68
#define RST_GATE2   0x2d0

#define PIO_BASE	0x01c20800
#define PE_CFG0     0x90

#define UART0_BASE  0x01c25000

#define readl(a) (*(volatile unsigned int *)(a))
#define writel(v,a) (*(volatile unsigned int *)(a) = (v))

void uart_init(void)
{
    u32 val;

    /* set PE0 and PE1 to uart function */
    val = readl(PIO_BASE + PE_CFG0);
    val &= ~0x77;
    val |= 0x55;
    writel(val, PIO_BASE + PE_CFG0);

    /* enable uart0 clock */
    val = readl(CCU_BASE + CLK_GATE2);
    val |= (1 << 20);
    writel(val, CCU_BASE + CLK_GATE2);

    /* de-assert uart0 reset */
    val = readl(CCU_BASE + RST_GATE2);
    val |= (1 << 20);
    writel(val, CCU_BASE + RST_GATE2);

    /* uart format setup, copied from x-boot sys-uart.c */
    /* 115200-8-1-0 */
    writel(0x0, UART0_BASE + 0x04);
    writel(0xf7, UART0_BASE + 0x08);
    writel(0x0, UART0_BASE + 0x10);

    val = readl(UART0_BASE + 0x0c);
    val |= (1 << 7);
    writel(val, UART0_BASE + 0x0c);
    writel(0x36, UART0_BASE + 0x00);
    writel(0x00, UART0_BASE + 0x04);
    val = readl(UART0_BASE + 0x0c);
    val &= ~(1 << 7);
    writel(val, UART0_BASE + 0x0c);
    val = readl(UART0_BASE + 0x0c);
  	val &= ~0x1f;
	val |= (0x3 << 0) | (0 << 2) | (0x0 << 3);
    writel(val, UART0_BASE + 0x0c);
}

void uart_putc(char c)
{
    while((readl(UART0_BASE + 0x7c) & (0x1 << 1)) == 0);
    writel(c, UART0_BASE + 0x00);
}

void uart_puts(const char *str)
{
    const char *p = str;
    while (*p != '\0')
        uart_putc(*p++);
}
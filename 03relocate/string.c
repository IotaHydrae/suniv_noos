#include "uart.h"

int puts(const char *s)
{
    uart_puts(s);
    return 0;
}

void puthex(unsigned int val)
{
    int i, j;

    uart_putc('0');
    uart_putc('x');
    for (i = 7; i >= 0; i--)
    {
        j = (val >> (i * 4)) & 0xf;
        if ((j >= 0) && (j <= 9))
            uart_putc('0' + j);
        else
            uart_putc('A' + j - 0xA);
    }
    uart_putc('\r');
    uart_putc('\n');
}

void put_s_hex(const char *s, unsigned int val)
{
    puts(s);
    puthex(val);
    uart_putc('\r');
    uart_putc('\n');
}

void memcpy(void *dest, void *src, unsigned int len)
{
    volatile unsigned char *pc_dest = dest;
    volatile unsigned char *pc_src  = src;

    while (len--) {
        *pc_dest = *pc_src;
        pc_src++;
        pc_dest++;
    }
}

void memset(void *src, char c, unsigned int len)
{
    volatile unsigned int *pc_src = src;

    while (len--) {
        *pc_src = c;
        pc_src++;
    }
}
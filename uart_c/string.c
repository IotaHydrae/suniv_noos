#include "uart.h"

int puts(const char *s)
{
    uart_puts(s);
    return 0;
}

void puthex(unsigned int val)
{
    int i, j;

    puts("0x");
    for (i = 7; i >= 0; i--)
    {
        j = (val >> (i * 4)) & 0xf;
        if ((j >= 0) && (j <= 9))
            uart_putc('0' + j);
        else
            uart_putc('A' + j - 0xA);
    }
}

void put_s_hex(const char *s, unsigned int val)
{
    puts(s);
    puthex(val);
    puts("\r\n");
}
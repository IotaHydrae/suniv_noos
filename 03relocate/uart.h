#ifndef __UART_H
#define __UART_H

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;

void uart_init(void);
void uart_putc(char c);
void uart_puts(const char *str);

#endif
#ifndef __STRING_H
#define __STRING_H

int puts(const char *s);
void puthex(unsigned int val);
void put_s_hex(const char *s, unsigned int val);

void memcpy(void *dest, void *src, unsigned int len);
void memset(void *src, char c, unsigned int len);

#endif
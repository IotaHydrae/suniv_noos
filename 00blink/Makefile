# Copyright (c) 2022 IotaHydrae
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

PREFIX=arm-linux-gnueabi-
CC=$(PREFIX)gcc
LD=$(PREFIX)ld
AR=$(PREFIX)ar
OBJCOPY=$(PREFIX)objcopy
OBJDUMP=$(PREFIX)objdump

led.img : head.S
	$(CC) -nostdlib -g -c -o head.o head.S

	$(LD) -T suniv.lds -g head.o -o led.elf

	$(OBJCOPY) -O binary -S led.elf led.bin
	$(OBJDUMP) -D -m arm led.elf > led.dis

	mkimage -C none -A arm -T sunxi_egon -a 0x80100000 -e 0x80100000 -d led.bin led.img

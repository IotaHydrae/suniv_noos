# Copyright (c) 2022 IotaHydrae
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

PREFIX=arm-none-eabi-
CC=$(PREFIX)gcc
LD=$(PREFIX)ld
AR=$(PREFIX)ar
OBJCOPY=$(PREFIX)objcopy
OBJDUMP=$(PREFIX)objdump

objs:=head.o

LOAD_ADDR:=0x80000000
LINK_ADDR:=0x80000000

LINK_SCRIPT:=suniv-f1c200s.lds

led.img: clean $(objs)
	$(LD) -T $(LINK_SCRIPT) -g $(objs) -o led.elf

	$(OBJCOPY) -O binary -S led.elf led.bin
	$(OBJDUMP) -D -m arm led.elf > led.dis

	mkimage -A arm -T sunxi_egon -e $(LINK_ADDR) -d led.bin $@

%.o:%.S
	$(CC) -nostdlib -g -c -o $@ $<
%.o:%.c
	$(CC) -nostdlib -g -c -o $@ $<

.PHONY:clean

clean:
	rm -rf *.img *.dis *.elf *.o *.bin

.PHONY:write

write:led.img
	sudo sunxi-fel -p write $(LOAD_ADDR) led.img

.PHONY:exec

exec:write
	sudo sunxi-fel exec $(LOAD_ADDR)

.PHONY:ver

ver:
	sudo sunxi-fel ver

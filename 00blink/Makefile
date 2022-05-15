# Copyright (c) 2022 IotaHydrae
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT
#
# Hi, guys
# 
# If you want to run this program from spi flash or sd,
# you need to burn led.img to flash or sd like:
# `sudo sunxi-fel -p spi-flash write 0 led.img`
# and reset SoC to exectue it, the priority of `sdio` is
# higher than `spi`, for more about priority of boot,
# take a look at https://linux-sunxi.org/
#
# The `led.img` is just led.bin but add a "sunxi eGon" head,
# and it's checked by bootrom.
#
# If you want to run program from sram,
# just download the led.bin to 0x00000000
# `sudo sunxi-fel write 0x0 led.bin && sudo sunxi-fel exec 0x0`,
# or just `make exec`
#
# PS:
# I don't know why the address of sram coincides with bootrom,
# according to the manual, the address of SRAM A should be 0x00010000.
#
# My guess is this:
# The overlapped sram at 0x00000000, It's just looks overlapped.
#
# In fact, It's like this. When the cpu is powered on to
# execute the bootrom, if no executable firmware is detected
# from the spi and sdio, the SoC will enter the FEL mode,
# so the bootrom has no effect. Now, the memory controller switches
# the first address of SRAM A to 0x00000000. When we write the bin
# file to the address of 0x00000000, it is actually written to SRAM A.
#
# Of course, there is another possibility, there is indeed another sram,
# which replaces the location of the bootrom, but we don't know it.
#
# Cheers, Iota


PREFIX?=arm-none-eabi-
CC:=$(PREFIX)gcc
LD:=$(PREFIX)ld
AR:=$(PREFIX)ar
SIZE:=$(PREFIX)size
OBJCOPY:=$(PREFIX)objcopy
OBJDUMP:=$(PREFIX)objdump

LOAD_ADDR:=0x00000000
LINK_ADDR:=0x80000000

LINK_SCRIPT:=suniv-f1c200s.lds
#LINK_SCRIPT:=suniv.lds

objs:=head.o

default:led.bin

led.bin: clean $(objs)
	$(LD) -T $(LINK_SCRIPT) -g $(objs) -o led.elf

	$(OBJCOPY) -O binary -S led.elf led.bin
	$(OBJDUMP) -D -m arm led.elf > led.dis
	$(SIZE) led.elf

led.img: led.bin
	mkimage -C none -A arm -T sunxi_egon -e $(LINK_ADDR) -d led.bin $@

%.o:%.S
	$(CC) -nostdlib -g -c -o $@ $<
%.o:%.c
	$(CC) -nostdlib -g -c -o $@ $<

.PHONY:clean
clean:
	rm -rf *.img *.dis *.elf *.o *.bin

.PHONY:write
write:led.bin
	sudo sunxi-fel -p write $(LOAD_ADDR) $<

.PHONY:write-flash
write-flash:led.img
	sudo sunxi-fel -p spiflash-write 0 $

.PHONY:exec

exec:write
	sudo sunxi-fel exec $(LOAD_ADDR)

.PHONY:ver

ver:
	sudo sunxi-fel ver

# Copyright (c) 2022 IotaHydrae
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT
#
# Hi, guys
# 
# If you want to run this program from spi flash or sd,
# you need to burn $(TARGET).img to flash or sd like:
# `sudo sunxi-fel -p spi-flash write 0 $(TARGET).img`
# and reset SoC to exectue it, the priority of `sdio` is
# higher than `spi`, for more about priority of boot,
# take a look at https://linux-sunxi.org/
#
# The `$(TARGET).img` is just $(TARGET).bin but add a "sunxi eGon" head,
# and it's checked by bootrom.
#
# If you want to run program from sram,
# just download the $(TARGET).bin to 0x00000000
# `sudo sunxi-fel write 0x0 $(TARGET).bin && sudo sunxi-fel exec 0x0`,
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

TARGET:=uart

objs:=head.o main.o uart.o string.o

default:$(TARGET).bin

$(TARGET).bin: clean $(objs)
	$(LD)  --print-memory-usage -T $(LINK_SCRIPT) -g $(objs) -o $(TARGET).elf

	$(OBJCOPY) -O binary -S $(TARGET).elf $(TARGET).bin
	$(OBJDUMP) -D -m arm $(TARGET).elf > $(TARGET).dis
	$(SIZE) $(TARGET).elf

$(TARGET).img: $(TARGET).bin
	mkimage -C none -A arm -T sunxi_egon -e $(LINK_ADDR) -d $(TARGET).bin $@

%.o:%.S
	$(CC) -nostdlib -c -o $@ $<
%.o:%.c
	$(CC) -nostdlib -c -o $@ $<

.PHONY:clean
clean:
	rm -rf *.img *.dis *.elf *.o *.bin

.PHONY:write
write:$(TARGET).bin
	sudo sunxi-fel -p write $(LOAD_ADDR) $<

.PHONY:write-flash
write-flash:$(TARGET).img
	sudo sunxi-fel -p spiflash-write 0 $

.PHONY:exec

exec:write
	sudo sunxi-fel exec $(LOAD_ADDR)

.PHONY:ver

ver:
	sudo sunxi-fel ver

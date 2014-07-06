boot.img: boot.bin
	dd if=/dev/zero of=zero_fill.dat bs=1 count=$(shell expr 510 - `ls -l $< | cut -d' ' -f5`)
	./make_bsfooter.sh > bsfooter.dat
	cat $< zero_fill.dat bsfooter.dat > $@

boot.bin: boot.elf
	objcopy -O binary $< $@

boot.elf: boot.S
	as -g -o $@ $<

clean:
	@rm -f boot.elf boot.bin zero_fill.dat bsfooter.dat boot.img *~

debug:
	qemu -gdb tcp::10000 -S -fda boot.img &

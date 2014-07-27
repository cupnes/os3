os.img: boot.bin os.bin
	mformat -f 1440 -C -B $< -i $@ ::
	mcopy os.bin -i $@ ::

boot.bin: boot.o
	ld -o $@ $< -T boot.ld

os.bin: head.o bootpack.o
	ld -o head.bin $< -T head.ld
	ld -o bootpack.bin bootpack.o -T bootpack.ld
	cat head.bin bootpack.bin > $@

boot.o: boot.S
	as -o $@ $<

head.o: head.S
	as -o $@ $<

bootpack.o: bootpack.S
	as -o $@ $<

bootpack.S: bootpack.c
	gcc -S $< -nostdlib -Wl,--oformat=binary -o $@

clean:
	@rm -f *.o *.bin *.img *~ bootpack.S

run: os.img
	qemu -fda $<

debug: os.img
	qemu -gdb tcp::10000 -S -fda $< &

boot.img: boot.bin
	mformat -f 1440 -C -B $< -i $@ ::

boot.bin: boot.o
	ld -o $@ $< -T boot.ld

boot.o: boot.S
	as -o $@ $<

clean:
	@rm -f *.o *.bin *.img *~

run: boot.img
	qemu -fda $<

debug: boot.img
	qemu -gdb tcp::10000 -S -fda $< &

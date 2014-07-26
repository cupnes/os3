os.img: boot.bin os.bin
	mformat -f 1440 -C -B $< -i $@ ::
	mcopy os.bin -i $@ ::

boot.bin: boot.o
	ld -o $@ $< -T boot.ld

os.bin: os.o
	ld -o $@ $< -T os.ld

boot.o: boot.S
	as -o $@ $<

os.o: os.S
	as -o $@ $<

clean:
	@rm -f *.o *.bin *.img *~

run: os.img
	qemu -fda $<

debug: os.img
	qemu -gdb tcp::10000 -S -fda $< &

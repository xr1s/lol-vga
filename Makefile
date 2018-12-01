.DEFAULT_GOAL := qemu

boot.img: boot.o
	ld -Ttext=0x7c00 --oformat binary -e 0 -o boot.img boot.o

boot.o: boot.s # gdt.s
	as boot.s -o boot.o

qemu: boot.img
	qemu-system-i386 -drive format=raw,file=boot.img -no-reboot

debug: boot.img
	qemu-system-i386 -drive format=raw,file=boot.img -no-reboot -s -S

clean:
	-rm *.o *.img

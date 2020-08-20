include ../Makefile.inc

DOS33_RAW = ../dos33fs-utils/dos33_raw

all:	boot.dsk

boot.dsk:	BOOT
	cp empty.dsk boot.dsk
	$(DOS33_RAW) boot.dsk 0 0 BOOT

BOOT: boot_sector.o
	ld65 -o BOOT boot_sector.o -C ../linker_scripts/apple2_800.inc

boot_sector.o:	boot_sector.s stage2.s
	ca65 -o boot_sector.o boot_sector.s -l boot_sector.lst

clean:		
		rm -f *~ *.o *.lst BOOT


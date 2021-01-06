include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw

all:	boot.dsk

boot.dsk:	BOOT THE80S LS MY1 MY2 MY3
	cp empty.dsk boot.dsk
	$(DOS33_RAW) boot.dsk 0 0 BOOT 0 1
	$(DOS33_RAW) boot.dsk 0 2 BOOT 1 1
	$(DOS33_RAW) boot.dsk 0 4 BOOT 2 1
	$(DOS33_RAW) boot.dsk 3 0 THE80S 0 33
	$(DOS33_RAW) boot.dsk 8 0 LS 0 33
	$(DOS33_RAW) boot.dsk 13 0 MY1 0 33
	$(DOS33_RAW) boot.dsk 18 0 MY2 0 33
	$(DOS33_RAW) boot.dsk 23 0 MY3 0 33

BOOT: boot_sector.o
	ld65 -o BOOT boot_sector.o -C ../../linker_scripts/apple2_800.inc

boot_sector.o:	boot_sector.s stage2.s
	ca65 -o boot_sector.o boot_sector.s -l boot_sector.lst

###

LS:	ls.o
	ld65 -o LS ls.o -C ../../linker_scripts/apple2_1f00.inc

ls.o:	ls.s lsc.hgr
	ca65 -o ls.o ls.s -l ls.lst

###

MY1:	my1.o
	ld65 -o MY1 my1.o -C ../../linker_scripts/apple2_1f00.inc

my1.o:	my1.s
	ca65 -o my1.o my1.s -l my1.lst

###

MY2:	my2.o
	ld65 -o MY2 my2.o -C ../../linker_scripts/apple2_1f00.inc

my2.o:	my2.s
	ca65 -o my2.o my2.s -l my2.lst

###

MY3:	my3.o
	ld65 -o MY3 my3.o -C ../../linker_scripts/apple2_1f00.inc

my3.o:	my3.s
	ca65 -o my3.o my3.s -l my3.lst



###

THE80S:	80s.o
	ld65 -o THE80S 80s.o -C ../../linker_scripts/apple2_1f00.inc

80s.o:	80s.s new_80s.hgr
	ca65 -o 80s.o 80s.s -l 80s.lst

#new_80s.hgr:	new_80s.png
#	../hgr-utils/png2hgr new_80s.png  > new_80s.hgr

clean:		
		rm -f *~ *.o *.lst BOOT THE80S LS MY1 MY2 MY3


include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
PNG_TO_HGR = ../../utils/hgr-utils/png2hgr

all:	boot.dsk compare.dsk

compare.dsk:	THE80S LS
	cp empty.dsk compare.dsk
	$(DOS33) -y compare.dsk BSAVE -a 0x1f00 THE80S
	$(DOS33) -y compare.dsk BSAVE -a 0x1f00 LS

boot.dsk:	BOOT THE80S LS
	cp empty.dsk boot.dsk
	$(DOS33_RAW) boot.dsk 0 0 BOOT 0 1
	$(DOS33_RAW) boot.dsk 0 2 BOOT 1 1
	$(DOS33_RAW) boot.dsk 0 4 BOOT 2 1
	$(DOS33_RAW) boot.dsk 3 0 THE80S 0 33
	$(DOS33_RAW) boot.dsk 8 0 LS 0 33

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

THE80S:	80s.o
	ld65 -o THE80S 80s.o -C ../../linker_scripts/apple2_1f00.inc

80s.o:	80s.s new_80s.hgr
	ca65 -o 80s.o 80s.s -l 80s.lst

new_80s.hgr:	new_80s.png
	$(PNG_TO_HGR) new_80s.png  > new_80s.hgr

clean:		
		rm -f *~ *.o *.lst BOOT THE80S


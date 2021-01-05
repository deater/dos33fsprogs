include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
DOS33_RAW = ../dos33fs-utils/dos33_raw
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
PNG2RLE = ../gr-utils/png2rle
B2D = ../bmp2dhr/b2d

all:	disk_test1.dsk

disk_test1.dsk:	QBOOT TEST
	cp extra_empty.dsk disk_test1.dsk
	$(DOS33_RAW) disk_test1.dsk  0  0 QBOOT      0   1
	$(DOS33_RAW) disk_test1.dsk  0  2 QBOOT      1   1
	$(DOS33_RAW) disk_test1.dsk  0  4 QBOOT      2   1
	$(DOS33_RAW) disk_test1.dsk  1  0 TEST       0  13


###

TEST:	test.o
	ld65 -o TEST test.o -C ../linker_scripts/apple2_1200.inc

test.o:	test.s
	ca65 -o test.o test.s -l test.lst

###

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C ../linker_scripts/apple2_800.inc

qboot_sector.o:	qboot_sector.s qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst

####

clean:		
	rm -f *~ *.o *.lst QBOOT TEST



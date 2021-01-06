include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
PNG2RLE = ../../utils/gr-utils/png2rle
B2D = ../../utils/bmp2dhr/b2d

all:	test_write.dsk

test_write.dsk:	WRITE
	cp empty.dsk test_write.dsk
	$(DOS33) -y test_write.dsk BSAVE -a 0x800 WRITE

###

WRITE:	test_write.o
	ld65 -o WRITE test_write.o -C ../../linker_scripts/apple2_800.inc

test_write.o:	test_write.s qkumba_popwr.s
	ca65 -o test_write.o test_write.s -l test_write.lst

####

clean:		
	rm -f *~ *.o *.lst WRITE

include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
B2D = ../bmp2dhr/b2d
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_RLE = ../gr-utils/png2rle

all:	xmas2018.dsk

xmas2018.dsk:	XMAS2018 wreath.img
	$(DOS33) -y xmas2018.dsk BSAVE -a 0x4000 XMAS2018
	$(DOS33) -y xmas2018.dsk BSAVE -a 0x2000 wreath.img WREATH.IMG

####

XMAS2018:	xmas2018.o
	ld65 -o XMAS2018 xmas2018.o -C ../linker_scripts/apple2_4000.inc

xmas2018.o:	xmas2018.s \
	zp.inc hardware.inc \
	vapor_lock.s delay_a.s wait_keypress.s \
	mockingboard.s \
	wreath.img.lz4
	ca65 -o xmas2018.o xmas2018.s -l xmas2018.lst


####

#c64.img.lz4:	c64.img
#	lz4 -f -16 c64.img
#
#c64.img:	c64_updated.png
#	../hgr-utils/png2hgr c64_updated.png > c64.img

####

#D_HGRC.BIN:	d_hgr.bmp
#	$(B2D) d_hgr.bmp HGR -d

wreath.img.lz4:	wreath.img
	lz4 -f -16 wreath.img

wreath.img:	WREATHC.BIN
	cp WREATHC.BIN wreath.img

WREATHC.BIN:	wreath.bmp
	$(B2D) wreath.bmp HGR -d

clean:
		rm -f *~ *.o *.lst XMAS2018 wreath.img WREATHC.BIN


include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
B2D = ../bmp2dhr/b2d
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_RLE = ../gr-utils/png2rle

all:	xmas2018.dsk

xmas2018.dsk:	HELLO XMAS2018 wreath.img ball.img
	$(DOS33) -y xmas2018.dsk SAVE A HELLO
	$(DOS33) -y xmas2018.dsk BSAVE -a 0x4000 XMAS2018
	$(DOS33) -y xmas2018.dsk BSAVE -a 0x2000 wreath.img WREATH.IMG
	$(DOS33) -y xmas2018.dsk BSAVE -a 0x2000 ball.img BALL.IMG

####

XMAS2018:	xmas2018.o
	ld65 -o XMAS2018 xmas2018.o -C ../linker_scripts/apple2_4000.inc

xmas2018.o:	xmas2018.s \
	zp.inc hardware.inc \
	vapor_lock.s delay_a.s wait_keypress.s \
	mockingboard.s \
	wreath.s wreath.img.lz4 \
	ball.s ball.img.lz4 \
	merry.s merry.img.lz4
	ca65 -o xmas2018.o xmas2018.s -l xmas2018.lst


####

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

####

merry.img.lz4:	merry.img
	lz4 -f -16 merry.img

merry.img:	merry_christmas.png
	../hgr-utils/png2hgr merry_christmas.png > merry.img

####

wreath.img.lz4:	wreath.img
	lz4 -f -16 wreath.img

wreath.img:	WREATHC.BIN
	cp WREATHC.BIN wreath.img

WREATHC.BIN:	wreath.bmp
	$(B2D) wreath.bmp HGR -d

#

ball.img.lz4:	ball.img
	lz4 -f -16 ball.img

ball.img:	BALLC.BIN
	cp BALLC.BIN ball.img

BALLC.BIN:	ball.bmp
	$(B2D) ball.bmp HGR -d

clean:
		rm -f *~ *.o *.lst XMAS2018 wreath.img ball.img BALLC.BIN WREATHC.BIN


include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
B2D = ../../utils/bmp2dhr/b2d
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_RLE = ../../utils/gr-utils/png2rle

all:	xmas2018.dsk

xmas2018.dsk:	HELLO XMAS2018 wreath.img.lz4t ball.img.lz4 merry.img.lz4t MUSIC.lz4t
	$(DOS33) -y xmas2018.dsk SAVE A HELLO
	$(DOS33) -y xmas2018.dsk BSAVE -a 0x0c00 XMAS2018
	$(DOS33) -y xmas2018.dsk BSAVE -a 0xa000 wreath.img.lz4t WREATH.LZ4
	$(DOS33) -y xmas2018.dsk BSAVE -a 0xa000 ball.img.lz4 BALL.LZ4
	$(DOS33) -y xmas2018.dsk BSAVE -a 0x4000 merry.img.lz4t MERRY.LZ4
	$(DOS33) -y xmas2018.dsk BSAVE -a 0x4000 MUSIC.lz4t MUSIC.LZ4
#	$(DOS33) -y xmas2018.dsk BSAVE -a 0x2000 wreath.img WREATH.IMG
	$(DOS33) -y xmas2018.dsk BSAVE -a 0x4000 ball.img BALL.IMG

####

XMAS2018:	xmas2018.o
	ld65 -o XMAS2018 xmas2018.o -C ../../linker_scripts/apple2_c00.inc

xmas2018.o:	xmas2018.s \
	zp.inc hardware.inc \
	vapor_lock.s delay_a.s wait_keypress.s gr_putsprite.s \
	play_music.s mockingboard.s rts.s \
	wreath.s wreath.img.lz4 sprites.inc \
	ball.s ball.img.lz4 greets.raw.lz4t gr_scroll.s reflection.s \
	merry.s merry.img.lz4
	ca65 -o xmas2018.o xmas2018.s -l xmas2018.lst

#####

greets.raw.lz4t:	greets.raw.lz4
	dd if=greets.raw.lz4 of=greets.raw.lz4t bs=1 skip=11
	truncate greets.raw.lz4t -s -8


####

MUSIC.lz4t:	MUSIC.lz4
	dd if=MUSIC.lz4 of=MUSIC.lz4t bs=1 skip=11
	truncate MUSIC.lz4t -s -8

MUSIC.lz4:	MUSIC
	lz4 -16 -f MUSIC

MUSIC:	music.o
	ld65 -o MUSIC music.o -C ../../linker_scripts/apple2_1000.inc

music.o:	music.s
	ca65 -o music.o music.s -l music.lst

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

merry.img.lz4t:	merry.img.lz4
	dd if=merry.img.lz4 of=merry.img.lz4t bs=1 skip=11
	truncate merry.img.lz4t -s -8

merry.img.lz4:	merry.img
	lz4 -f -16 merry.img

merry.img:	merry_christmas.png
	../hgr-utils/png2hgr merry_christmas.png > merry.img

####

wreath.img.lz4t:	wreath.img.lz4
	dd if=wreath.img.lz4 of=wreath.img.lz4t bs=1 skip=11
	truncate wreath.img.lz4t -s -8

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
		rm -f *~ *.o *.lst XMAS2018 wreath.img ball.img BALLC.BIN WREATHC.BIN HELLO


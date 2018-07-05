include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
TOKENIZE = ../asoft_basic-utils/tokenize_asoft

all:	split.dsk

split.dsk:	BISHOP BISHOP.BAS RAINBOW.BAS RAINBOW KATC.BIN CREDITS
	$(DOS33) -y split.dsk BSAVE -a 0x0300 BISHOP
	$(DOS33) -y split.dsk SAVE A BISHOP.BAS
	$(DOS33) -y split.dsk SAVE A RAINBOW.BAS
	$(DOS33) -y split.dsk BSAVE -a 0x0c00 RAINBOW
	$(DOS33) -y split.dsk BSAVE -a 0x1000 CREDITS
#	$(DOS33) -y split.dsk BSAVE -a 0x2000 LENNA.BIN
	$(DOS33) -y split.dsk BSAVE -a 0x2000 KATC.BIN

BISHOP:	bishop.o
	ld65 -o BISHOP bishop.o -C ../linker_scripts/apple2_300.inc

bishop.o:	bishop.s
	ca65 -o bishop.o bishop.s -l bishop.lst

BISHOP.BAS:	bishop.bas
	$(TOKENIZE) < bishop.bas > BISHOP.BAS

rainbow.o:	rainbow.s
	ca65 -o rainbow.o rainbow.s -l rainbow.lst

RAINBOW:	rainbow.o
	ld65 -o RAINBOW rainbow.o -C ../linker_scripts/apple2_c00.inc

RAINBOW.BAS:	rainbow.bas
	$(TOKENIZE) < rainbow.bas > RAINBOW.BAS

credits.o:	credits.s tfv_sprites.inc
	ca65 -o credits.o credits.s -l credits.lst

CREDITS:	credits.o
	ld65 -o CREDITS credits.o -C ../linker_scripts/apple2_1000.inc



KATC.BIN:	kat.bmp
	../bmp2dhr/b2d kat.bmp hgr dither

clean:	
	rm -f *~ *.o *.lst BISHOP RAINBOW CREDITS

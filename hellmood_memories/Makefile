include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
PNG2RLE = ../gr-utils/png2rle
B2D = ../bmp2dhr/b2d

all:	memories.dsk

memories.dsk:	HELLO CIRCLES.BAS CIRCLES CHECKERS CHECKERS_SMALL TUNNEL
	cp empty.dsk memories.dsk
	$(DOS33) -y memories.dsk SAVE A HELLO
	$(DOS33) -y memories.dsk SAVE A CIRCLES.BAS
	$(DOS33) -y memories.dsk BSAVE -a 0x070 CIRCLES
	$(DOS33) -y memories.dsk BSAVE -a 0x070 CHECKERS
	$(DOS33) -y memories.dsk BSAVE -a 0x070 CHECKERS_SMALL
	$(DOS33) -y memories.dsk BSAVE -a 0x1000 TUNNEL

CIRCLES: circles.o
	ld65 -o CIRCLES circles.o -C ../linker_scripts/apple2_70_zp.inc

circles.o:	circles.s
	ca65 -o circles.o circles.s -l circles.lst

###

CHECKERS: checkers.o
	ld65 -o CHECKERS checkers.o -C ../linker_scripts/apple2_70_zp.inc

checkers.o:	checkers.s
	ca65 -o checkers.o checkers.s -l checkers.lst

###

TUNNEL: tunnel.o
	ld65 -o TUNNEL tunnel.o -C ../linker_scripts/apple2_1000.inc

tunnel.o:	tunnel.s
	ca65 -o tunnel.o tunnel.s -l tunnel.lst


###

CHECKERS_SMALL: checkers_small.o
	ld65 -o CHECKERS_SMALL checkers_small.o -C ../linker_scripts/apple2_70_zp.inc

checkers_small.o:	checkers_small.s
	ca65 -o checkers_small.o checkers_small.s -l checkers_small.lst

###


HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

CIRCLES.BAS:	zooming_circles.bas
	../asoft_basic-utils/tokenize_asoft < zooming_circles.bas > CIRCLES.BAS

####


clean:		
		rm -f *~ *.o *.lst HELLO CIRCLES.BAS CIRCLES CHECKERS \
			CHECKERS_SMALL TUNNEL


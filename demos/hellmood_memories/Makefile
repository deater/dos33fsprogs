include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
PNG2RLE = ../../utils/gr-utils/png2rle
B2D = ../../utils/bmp2dhr/b2d
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY = ../../empty_disk/

all:	memories.dsk

memories.dsk:	HELLO CIRCLES.BAS CIRCLES CHECKERS CHECKERS_SMALL PLANE \
		SIER TUNNEL TNM CIRCLES_NORMAL
	cp $(EMPTY)empty.dsk memories.dsk
	$(DOS33) -y memories.dsk SAVE A HELLO
	$(DOS33) -y memories.dsk SAVE A CIRCLES.BAS
	$(DOS33) -y memories.dsk BSAVE -a 0x070 CIRCLES
	$(DOS33) -y memories.dsk BSAVE -a 0x070 CHECKERS
	$(DOS33) -y memories.dsk BSAVE -a 0x070 CHECKERS_SMALL
	$(DOS33) -y memories.dsk BSAVE -a 0x1000 PLANE
	$(DOS33) -y memories.dsk BSAVE -a 0x1000 SIER
	$(DOS33) -y memories.dsk BSAVE -a 0x1000 TUNNEL
	$(DOS33) -y memories.dsk BSAVE -a 0x1000 TNM
	$(DOS33) -y memories.dsk BSAVE -a 0x300  CIRCLES_NORMAL

CIRCLES: circles.o
	ld65 -o CIRCLES circles.o -C ../../linker_scripts/apple2_70_zp.inc

circles.o:	circles.s
	ca65 -o circles.o circles.s -l circles.lst

CIRCLES_NORMAL: circles_normal.o
	ld65 -o CIRCLES_NORMAL circles_normal.o -C ../../linker_scripts/apple2_300.inc

circles_normal.o:	circles_normal.s
	ca65 -o circles_normal.o circles_normal.s -l circles_normal.lst

###

CHECKERS: checkers.o
	ld65 -o CHECKERS checkers.o -C ../../linker_scripts/apple2_70_zp.inc

checkers.o:	checkers.s
	ca65 -o checkers.o checkers.s -l checkers.lst

###

PLANE: plane.o
	ld65 -o PLANE plane.o -C ../../linker_scripts/apple2_1000.inc

plane.o:	plane.s
	ca65 -o plane.o plane.s -l plane.lst

###

SIER: sier.o
	ld65 -o SIER sier.o -C ../../linker_scripts/apple2_1000.inc

sier.o:	sier.s fast_plot.s
	ca65 -o sier.o sier.s -l sier.lst

###

TUNNEL: tunnel.o
	ld65 -o TUNNEL tunnel.o -C ../../linker_scripts/apple2_1000.inc

tunnel.o:	tunnel.s
	ca65 -o tunnel.o tunnel.s -l tunnel.lst

###

TNM: tunnel_nm.o
	ld65 -o TNM tunnel_nm.o -C ../../linker_scripts/apple2_1000.inc

tunnel_nm.o:	tunnel_nm.s
	ca65 -o tunnel_nm.o tunnel_nm.s -l tunnel_nm.lst



###

CHECKERS_SMALL: checkers_small.o
	ld65 -o CHECKERS_SMALL checkers_small.o -C ../../linker_scripts/apple2_70_zp.inc

checkers_small.o:	checkers_small.s
	ca65 -o checkers_small.o checkers_small.s -l checkers_small.lst

###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

CIRCLES.BAS:	zooming_circles.bas
	$(TOKENIZE) < zooming_circles.bas > CIRCLES.BAS

####


clean:		
		rm -f *~ *.o *.lst HELLO CIRCLES.BAS CIRCLES CHECKERS \
			CIRCLES_NORMAL CHECKERS_SMALL PLANE SIER TUNNEL TNM \
			division_table


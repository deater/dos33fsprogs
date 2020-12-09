include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
DOS33_RAW = ../dos33fs-utils/dos33_raw
B2D = ../bmp2dhr/b2d
PNG2GR = ../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	duke.dsk

duke.dsk:	HELLO DUKE
	cp empty.dsk duke.dsk
	$(DOS33) -y duke.dsk SAVE A HELLO
	$(DOS33) -y duke.dsk BSAVE -a 0x2000 DUKE

###

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

####


DUKE:	duke.o
	ld65 -o DUKE duke.o -C ../linker_scripts/apple2_2000.inc

duke.o:	duke.s zp.inc hardware.inc duke.s \
	graphics/duke_graphics.inc \
	level1_data.inc \
	status_bar.s draw_duke.s gr_putsprite_crop.s \
	draw_tilemap.s \
	keyboard.s handle_laser.s
	ca65 -o duke.o duke.s -l duke.lst

####

graphics/duke_graphics.inc:
	cd	graphics && make

####

clean:		
	rm -f *~ *.o *.lst HELLO DUKE
	cd graphics && make clean



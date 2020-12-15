include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
DOS33_RAW = ../dos33fs-utils/dos33_raw
B2D = ../bmp2dhr/b2d
PNG2GR = ../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	duke.dsk

duke.dsk:	HELLO LOADER DUKE_TITLE DUKE
	cp empty.dsk duke.dsk
	$(DOS33) -y duke.dsk SAVE A HELLO
	$(DOS33) -y duke.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y duke.dsk BSAVE -a 0x2000 DUKE
	$(DOS33) -y duke.dsk BSAVE -a 0x4000 DUKE_TITLE

###

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

####

LOADER:	loader.o
	ld65 -o LOADER loader.o -C ../linker_scripts/apple2_1000.inc

loader.o:	loader.s
	ca65 -o loader.o loader.s -l loader.lst

####

DUKE_TITLE:	duke_title.o
	ld65 -o DUKE_TITLE duke_title.o -C ../linker_scripts/apple2_4000.inc

duke_title.o:	duke_title.s zp.inc hardware.inc
	ca65 -o duke_title.o duke_title.s -l duke_title.lst

####

DUKE:	duke.o
	ld65 -o DUKE duke.o -C ../linker_scripts/apple2_2000.inc

duke.o:	duke.s zp.inc hardware.inc duke.s \
	print_help.s gr_fast_clear.s quit_yn.s text_drawbox.s \
	graphics/duke_graphics.inc \
	maps/level1_map.lzsa \
	status_bar.s draw_duke.s move_duke.s gr_putsprite_crop.s \
	draw_tilemap.s \
	sound_effects.s \
	keyboard.s handle_laser.s
	ca65 -o duke.o duke.s -l duke.lst

####

graphics/duke_graphics.inc:
	cd	graphics && make

title/new_title.lzsa:
	cd	title && make

maps/level1_map.lzsa:
	cd	maps && make

####

clean:		
	rm -f *~ *.o *.lst HELLO DUKE
	cd graphics && make clean
	cd maps && make clean
	cd title && make clean


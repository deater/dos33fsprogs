include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
B2D = ../../utils/bmp2dhr/b2d
PNG2GR = ../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	duke.dsk

duke.dsk:	HELLO LOADER DUKE_TITLE DUKE_LEVEL1 DUKE_LEVEL2
	cp $(EMPTY_DISK) duke.dsk
	$(DOS33) -y duke.dsk SAVE A HELLO
	$(DOS33) -y duke.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y duke.dsk BSAVE -a 0x4000 DUKE_TITLE
	$(DOS33) -y duke.dsk BSAVE -a 0x2000 DUKE_LEVEL1
	$(DOS33) -y duke.dsk BSAVE -a 0x2000 DUKE_LEVEL2


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

LOADER:	loader.o
	ld65 -o LOADER loader.o -C ../../linker_scripts/apple2_1000.inc

loader.o:	loader.s
	ca65 -o loader.o loader.s -l loader.lst

####

DUKE_TITLE:	duke_title.o
	ld65 -o DUKE_TITLE duke_title.o -C ../../linker_scripts/apple2_4000.inc

duke_title.o:	duke_title.s zp.inc hardware.inc init_vars.s
	ca65 -o duke_title.o duke_title.s -l duke_title.lst

####

DUKE_LEVEL1:	duke_level1.o
	ld65 -o DUKE_LEVEL1 duke_level1.o -C ../../linker_scripts/apple2_2000.inc

duke_level1.o:	duke_level1.s zp.inc hardware.inc \
	print_help.s gr_fast_clear.s quit_yn.s text_drawbox.s level_end.s \
	enemies_level1.s actions_level1.s item_level1.s \
	graphics/duke_graphics.inc sprites/duke_sprites.inc \
	maps/level1_map.lzsa \
	status_bar.s draw_duke.s move_duke.s gr_putsprite_crop.s \
	draw_tilemap.s \
	sound_effects.s speaker_tone.s \
	keyboard.s handle_laser.s
	ca65 -o duke_level1.o duke_level1.s -l duke_level1.lst

####

DUKE_LEVEL2:	duke_level2.o
	ld65 -o DUKE_LEVEL2 duke_level2.o -C ../../linker_scripts/apple2_2000.inc

duke_level2.o:	duke_level2.s zp.inc hardware.inc \
	print_help.s gr_fast_clear.s quit_yn.s text_drawbox.s level_end.s \
	enemies_level2.s actions_level2.s item_level2.s \
	graphics/duke_graphics.inc sprites/duke_sprites.inc \
	maps/level2_map.lzsa \
	status_bar.s draw_duke.s move_duke.s gr_putsprite_crop.s \
	draw_tilemap.s \
	sound_effects.s speaker_tone.s \
	keyboard.s handle_laser.s
	ca65 -o duke_level2.o duke_level2.s -l duke_level2.lst


####

sprites/duke_sprites.inc:
	cd	sprites && make

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
	cd sprites && make clean

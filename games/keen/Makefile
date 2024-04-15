include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
B2D = ../../utils/bmp2dhr/b2d
PNG2GR = ../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk


all:	keen1_lores.dsk

keen1_lores.dsk:	HELLO LOADER TITLE MARS LEVEL1 LEVEL2
	cp $(EMPTY_DISK) keen1_lores.dsk
	$(DOS33) -y keen1_lores.dsk SAVE A HELLO
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x4000 TITLE
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x2000 MARS
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x2000 LEVEL1
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x2000 LEVEL2


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

LOADER:	loader.o
	ld65 -o LOADER loader.o -C ../../linker_scripts/apple2_1000.inc

loader.o:	loader.s hardware_detect.s
	ca65 -o loader.o loader.s -l loader.lst

####

TITLE:	title.o
	ld65 -o TITLE title.o -C ../../linker_scripts/apple2_4000.inc

title.o:	title.s zp.inc hardware.inc \
		zx02_optim.s \
		graphics/keen1_title.hgr.zx02
	ca65 -o title.o title.s -l title.lst

####

MARS:	mars.o
	ld65 -o MARS mars.o -C ../../linker_scripts/apple2_2000.inc

mars.o:	mars.s zp.inc hardware.inc game_over.s \
	gr_fade.s \
	mars_keyboard.s draw_tilemap.s \
	mars_sfx.s longer_sound.s \
	text_help.s tilemap_lookup.s \
	maps/mars_map.zx02 graphics/parts.gr.zx02
	ca65 -o mars.o mars.s -l mars.lst

####

LEVEL1:	level1.o
	ld65 -o LEVEL1 level1.o -C ../../linker_scripts/apple2_2000.inc

level1.o:	level1.s zp.inc hardware.inc \
	text_help.s gr_fast_clear.s text_quit_yn.s text_drawbox.s \
	level1_enemies.s level1_items.s \
	graphics/keen_graphics.inc sprites/keen_sprites.inc \
	maps/level1_map.zx02 \
	status_bar.s draw_keen.s move_keen.s gr_putsprite_crop.s \
	draw_tilemap.s tilemap_lookup.s \
	level1_sfx.s longer_sound.s level1_data.inc \
	keyboard.s handle_laser.s
	ca65 -o level1.o level1.s -l level1.lst

####

LEVEL2:	level2.o
	ld65 -o LEVEL2 level2.o -C ../../linker_scripts/apple2_2000.inc

level2.o:	level2.s zp.inc hardware.inc \
	text_help.s gr_fast_clear.s text_quit_yn.s text_drawbox.s \
	level1_enemies.s level1_items.s \
	graphics/keen_graphics.inc sprites/keen_sprites.inc \
	maps/level2_map.zx02 \
	status_bar.s draw_keen.s move_keen.s gr_putsprite_crop.s \
	draw_tilemap.s tilemap_lookup.s \
	level1_sfx.s longer_sound.s level2_data.inc \
	keyboard.s handle_laser.s
	ca65 -o level2.o level2.s -l level2.lst

####

graphics/keen1_title.hgr.zx02:
	cd	graphics && make

graphics/keen_graphics.inc:
	cd	graphics && make

sprites/keen_sprites.inc:
	cd	sprites && make

maps/level1_map.lzsa:
	cd	maps && make

####

clean:		
	rm -f *~ *.o *.lst HELLO LOADER TITLE MARS LEVEL1 LEVEL2
	cd graphics && make clean
	cd maps && make clean
#	cd title && make clean
	cd sprites && make clean

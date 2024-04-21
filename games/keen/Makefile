include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
B2D = ../../utils/bmp2dhr/b2d
PNG2GR = ../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk


all:	keen1_lores.dsk

keen1_lores.dsk:	HELLO LOADER TITLE ENGINE MARS \
	LEVEL1 LEVEL2 LEVEL3 LEVEL4 LEVEL5
	cp $(EMPTY_DISK) keen1_lores.dsk
	$(DOS33) -y keen1_lores.dsk SAVE A HELLO
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x4000 TITLE
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x4000 ENGINE
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x4000 MARS
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL1
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL2
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL3
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL4
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL5


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
	ld65 -o MARS mars.o -C ../../linker_scripts/apple2_4000.inc

mars.o:	mars.s zp.inc hardware.inc game_over.s \
	gr_fade.s \
	mars_keyboard.s draw_tilemap.s \
	mars_sfx.s longer_sound.s \
	text_help.s tilemap_lookup.s \
	maps/mars_map.zx02 graphics/parts.gr.zx02
	ca65 -o mars.o mars.s -l mars.lst

####

LEVEL1:	level1.o
	ld65 -o LEVEL1 level1.o -C ../../linker_scripts/apple2_6000.inc

level1.o:	level1.s enemies.inc \
	maps/level1_map.zx02
	ca65 -o level1.o level1.s -l level1.lst

####

LEVEL2:	level2.o
	ld65 -o LEVEL2 level2.o -C ../../linker_scripts/apple2_6000.inc

level2.o:	level2.s enemies.inc \
	maps/level2_map.zx02
	ca65 -o level2.o level2.s -l level2.lst

####

LEVEL3:	level3.o
	ld65 -o LEVEL3 level3.o -C ../../linker_scripts/apple2_6000.inc

level3.o:	level3.s enemies.inc \
	maps/level3_map.zx02
	ca65 -o level3.o level3.s -l level3.lst

####

LEVEL4:	level4.o
	ld65 -o LEVEL4 level4.o -C ../../linker_scripts/apple2_6000.inc

level4.o:	level4.s enemies.inc \
	maps/level4_map.zx02
	ca65 -o level4.o level4.s -l level4.lst

####

LEVEL5:	level5.o
	ld65 -o LEVEL5 level5.o -C ../../linker_scripts/apple2_6000.inc

level5.o:	level5.s enemies.inc \
	maps/level5_map.zx02
	ca65 -o level5.o level5.s -l level5.lst





####

ENGINE:	engine.o
	ld65 -o ENGINE engine.o -C ../../linker_scripts/apple2_4000.inc

engine.o:	engine.s zp.inc hardware.inc \
	text_help.s gr_fast_clear.s text_quit_yn.s text_drawbox.s \
	level1_enemies.s level1_items.s \
	graphics/keen_graphics.inc sprites/keen_sprites.inc \
	status_bar.s draw_keen.s move_keen.s gr_putsprite_crop.s \
	draw_tilemap.s tilemap_lookup.s \
	level1_sfx.s longer_sound.s \
	keyboard.s handle_laser.s
	ca65 -o engine.o engine.s -l engine.lst


####

#LEVEL2:	level2.o
#	ld65 -o LEVEL2 level2.o -C ../../linker_scripts/apple2_2000.inc
#
#level2.o:	level2.s zp.inc hardware.inc \
#	text_help.s gr_fast_clear.s text_quit_yn.s text_drawbox.s \
#	level1_enemies.s level1_items.s \
#	graphics/keen_graphics.inc sprites/keen_sprites.inc \
#	maps/level2_map.zx02 \
#	status_bar.s draw_keen.s move_keen.s gr_putsprite_crop.s \
#	draw_tilemap.s tilemap_lookup.s \
#	level1_sfx.s longer_sound.s level2_data.inc \
#	keyboard.s handle_laser.s
#	ca65 -o level2.o level2.s -l level2.lst

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
	rm -f *~ *.o *.lst HELLO LOADER TITLE ENGINE MARS LEVEL1 LEVEL2
	cd graphics && make clean
	cd maps && make clean
#	cd title && make clean
	cd sprites && make clean

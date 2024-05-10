include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
B2D = ../../utils/bmp2dhr/b2d
PNG2GR = ../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk


all:	keen1_lores.dsk

keen1_lores.dsk:	HELLO LOADER TITLE STORY ENGINE MARS \
	LEVEL1 LEVEL2 LEVEL3 LEVEL4 \
	LEVEL5 LEVEL6 LEVEL7 LEVEL8 \
	LEVEL9 LEVEL10 LEVEL11 LEVEL12 \
	LEVEL13 LEVEL14 LEVEL15 LEVEL16
	cp $(EMPTY_DISK) keen1_lores.dsk
	$(DOS33) -y keen1_lores.dsk SAVE A HELLO
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x4000 TITLE
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x4000 STORY
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x4000 ENGINE
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x4000 MARS
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL1
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL2
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL3
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL4
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL5
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL6
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL7
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL8
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL9
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL10
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL11
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL12
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL13
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL14
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL15
	$(DOS33) -y keen1_lores.dsk BSAVE -a 0x6000 LEVEL16

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
		hgr_sprite.s hgr_tables.s \
		graphics/keen1_title.hgr.zx02 \
		graphics/title_sprites.inc
	ca65 -o title.o title.s -l title.lst

####

STORY:	story.o
	ld65 -o STORY story.o -C ../../linker_scripts/apple2_4000.inc

story.o:	story.s zp.inc hardware.inc \
		zx02_optim.s \
		graphics/keen1_story.hgr.zx02 \
		story/story_data.zx02
	ca65 -o story.o story.s -l story.lst


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

LEVEL6:	level6.o
	ld65 -o LEVEL6 level6.o -C ../../linker_scripts/apple2_6000.inc

level6.o:	level6.s enemies.inc \
	maps/level6_map.zx02
	ca65 -o level6.o level6.s -l level6.lst

####

LEVEL7:	level7.o
	ld65 -o LEVEL7 level7.o -C ../../linker_scripts/apple2_6000.inc

level7.o:	level7.s enemies.inc \
	maps/level7_map.zx02
	ca65 -o level7.o level7.s -l level7.lst

####

LEVEL8:	level8.o
	ld65 -o LEVEL8 level8.o -C ../../linker_scripts/apple2_6000.inc

level8.o:	level8.s enemies.inc \
	maps/level8_map.zx02
	ca65 -o level8.o level8.s -l level8.lst

####

LEVEL9:	level9.o
	ld65 -o LEVEL9 level9.o -C ../../linker_scripts/apple2_6000.inc

level9.o:	level9.s enemies.inc \
	maps/level9_map.zx02
	ca65 -o level9.o level9.s -l level9.lst

####

LEVEL10:	level10.o
	ld65 -o LEVEL10 level10.o -C ../../linker_scripts/apple2_6000.inc

level10.o:	level10.s enemies.inc \
	maps/level10_map.zx02
	ca65 -o level10.o level10.s -l level10.lst

####

LEVEL11:	level11.o
	ld65 -o LEVEL11 level11.o -C ../../linker_scripts/apple2_6000.inc

level11.o:	level11.s enemies.inc \
	maps/level11_map.zx02
	ca65 -o level11.o level11.s -l level11.lst

####

LEVEL12:	level12.o
	ld65 -o LEVEL12 level12.o -C ../../linker_scripts/apple2_6000.inc

level12.o:	level12.s enemies.inc \
	maps/level12_map.zx02
	ca65 -o level12.o level12.s -l level12.lst

####

LEVEL13:	level13.o
	ld65 -o LEVEL13 level13.o -C ../../linker_scripts/apple2_6000.inc

level13.o:	level13.s enemies.inc \
	maps/level13_map.zx02
	ca65 -o level13.o level13.s -l level13.lst

####

LEVEL14:	level14.o
	ld65 -o LEVEL14 level14.o -C ../../linker_scripts/apple2_6000.inc

level14.o:	level14.s enemies.inc \
	maps/level14_map.zx02
	ca65 -o level14.o level14.s -l level14.lst

####

LEVEL15:	level15.o
	ld65 -o LEVEL15 level15.o -C ../../linker_scripts/apple2_6000.inc

level15.o:	level15.s enemies.inc \
	maps/level15_map.zx02
	ca65 -o level15.o level15.s -l level15.lst

####

LEVEL16:	level16.o
	ld65 -o LEVEL16 level16.o -C ../../linker_scripts/apple2_6000.inc

level16.o:	level16.s enemies.inc \
	maps/level16_map.zx02
	ca65 -o level16.o level16.s -l level16.lst

####

ENGINE:	engine.o
	ld65 -o ENGINE engine.o -C ../../linker_scripts/apple2_4000.inc

engine.o:	engine.s zp.inc hardware.inc \
	text_help.s gr_fast_clear.s text_quit_yn.s text_drawbox.s \
	engine_enemies.s engine_items.s \
	graphics/keen_graphics.inc sprites/keen_sprites.inc \
	status_bar.s draw_keen.s move_keen.s gr_putsprite_crop.s \
	draw_tilemap.s tilemap_lookup.s \
	level1_sfx.s longer_sound.s \
	keyboard.s handle_laser.s
	ca65 -o engine.o engine.s -l engine.lst


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
	rm -f *~ *.o *.lst HELLO LOADER TITLE ENGINE MARS STORY \
	LEVEL1 LEVEL2 LEVEL3 LEVEL4 LEVEL5 LEVEL6 LEVEL7 LEVEL8 \
	LEVEL9 LEVEL10 LEVEL11 LEVEL12 LEVEL13 LEVEL14 LEVEL15 LEVEL16
	cd graphics && make clean
	cd maps && make clean
#	cd title && make clean
	cd sprites && make clean

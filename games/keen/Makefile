include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
B2D = ../../utils/bmp2dhr/b2d
PNG2GR = ../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk


all:	keen.dsk

keen.dsk:	HELLO LOADER KEEN_TITLE KEEN_MARS KEEN_LEVEL1
#KEEN_LEVEL2
	cp $(EMPTY_DISK) keen.dsk
	$(DOS33) -y keen.dsk SAVE A HELLO
	$(DOS33) -y keen.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y keen.dsk BSAVE -a 0x4000 KEEN_TITLE
	$(DOS33) -y keen.dsk BSAVE -a 0x2000 KEEN_MARS
	$(DOS33) -y keen.dsk BSAVE -a 0x2000 KEEN_LEVEL1
#	$(DOS33) -y keen.dsk BSAVE -a 0x2000 KEEN_LEVEL2


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

LOADER:	loader.o
	ld65 -o LOADER loader.o -C ../../linker_scripts/apple2_1000.inc

loader.o:	loader.s
	ca65 -o loader.o loader.s -l loader.lst

####

KEEN_TITLE:	keen_title.o
	ld65 -o KEEN_TITLE keen_title.o -C ../../linker_scripts/apple2_4000.inc

keen_title.o:	keen_title.s zp.inc hardware.inc \
		zx02_optim.s \
		graphics/keen1_title.hgr.zx02
	ca65 -o keen_title.o keen_title.s -l keen_title.lst

####

KEEN_MARS:	keen_mars.o
	ld65 -o KEEN_MARS keen_mars.o -C ../../linker_scripts/apple2_2000.inc

keen_mars.o:	keen_mars.s zp.inc hardware.inc game_over.s \
	sound_effects.s speaker_tone.s print_help.s \
	maps/mars_map.gr.zx02 graphics/parts.gr.zx02
	ca65 -o keen_mars.o keen_mars.s -l keen_mars.lst

####

KEEN_LEVEL1:	keen_level1.o
	ld65 -o KEEN_LEVEL1 keen_level1.o -C ../../linker_scripts/apple2_2000.inc

keen_level1.o:	keen_level1.s zp.inc hardware.inc \
	print_help.s gr_fast_clear.s quit_yn.s text_drawbox.s \
	enemies_level1.s item_level1.s \
	graphics/keen_graphics.inc sprites/keen_sprites.inc \
	maps/level1_map.lzsa \
	status_bar.s draw_keen.s move_keen.s gr_putsprite_crop.s \
	draw_tilemap.s \
	sound_effects.s speaker_tone.s \
	keyboard.s handle_laser.s
	ca65 -o keen_level1.o keen_level1.s -l keen_level1.lst

####

KEEN_LEVEL2:	keen_level2.o
	ld65 -o KEEN_LEVEL2 keen_level2.o -C ../../linker_scripts/apple2_2000.inc

keen_level2.o:	keen_level2.s zp.inc hardware.inc \
	print_help.s gr_fast_clear.s quit_yn.s text_drawbox.s \
	enemies_level2.s actions_level2.s item_level2.s \
	graphics/keen_graphics.inc keen_sprites.inc \
	maps/level2_map.lzsa \
	status_bar.s draw_keen.s move_keen.s gr_putsprite_crop.s \
	draw_tilemap.s \
	sound_effects.s speaker_tone.s \
	keyboard.s handle_laser.s
	ca65 -o keen_level2.o keen_level2.s -l keen_level2.lst


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
	rm -f *~ *.o *.lst HELLO KEEN_TITLE KEEN_MARS KEEN_LEVEL1
	cd graphics && make clean
	cd maps && make clean
#	cd title && make clean
	cd sprites && make clean

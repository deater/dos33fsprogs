include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
B2D = ../../utils/bmp2dhr/b2d
PNG2GR = ../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk


all:	riven_hgr.dsk

riven_hgr.dsk:	HELLO LOADER MAIN
	cp $(EMPTY_DISK) riven_hgr.dsk
	$(DOS33) -y riven_hgr.dsk SAVE A HELLO
	$(DOS33) -y riven_hgr.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y riven_hgr.dsk BSAVE -a 0x4000 MAIN
#	$(DOS33) -y riven_hgr.dsk BSAVE -a 0x4000 MARS

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

LOADER:	loader.o
	ld65 -o LOADER loader.o -C ../../linker_scripts/apple2_1000.inc

loader.o:	loader.s hardware_detect.s
	ca65 -o loader.o loader.s -l loader.lst

####

MAIN:	main.o
	ld65 -o MAIN main.o -C ../../linker_scripts/apple2_4000.inc

main.o:	main.s zp.inc hardware.inc \
		zx02_optim.s \
		hgr_sprite.s hgr_tables.s \
		keyboard.s \
		hgr_14x14_sprite.s \
		graphics/maglev1.hgr.zx02
	ca65 -o main.o main.s -l main.lst

####

#MARS:	mars.o
#	ld65 -o MARS mars.o -C ../../linker_scripts/apple2_4000.inc

#mars.o:	mars.s zp.inc hardware.inc game_over.s \
#	gr_fade.s \
#	mars_keyboard.s draw_tilemap.s \
#	mars_sfx.s longer_sound.s \
#	text_help.s tilemap_lookup.s \
#	maps/mars_map.zx02 graphics/parts.gr.zx02
#	ca65 -o mars.o mars.s -l mars.lst

####

clean:		
	rm -f *~ *.o *.lst HELLO LOADER MAIN
#	cd graphics && make clean
#	cd maps && make clean
#	cd title && make clean
#	cd sprites && make clean

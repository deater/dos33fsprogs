include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
B2D = ../../utils/bmp2dhr/b2d
PNG2GR = ../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk


all:	riven_hgr.dsk

riven_hgr.dsk:	HELLO LOADER TITLE \
		LEVEL_PROJECTOR LEVEL_MAGSTEPS DOME
	cp $(EMPTY_DISK) riven_hgr.dsk
	$(DOS33) -y riven_hgr.dsk SAVE A HELLO
	$(DOS33) -y riven_hgr.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y riven_hgr.dsk BSAVE -a 0x4000 TITLE
	$(DOS33) -y riven_hgr.dsk BSAVE -a 0x4000 LEVEL_PROJECTOR
	$(DOS33) -y riven_hgr.dsk BSAVE -a 0x4000 LEVEL_MAGSTEPS
	$(DOS33) -y riven_hgr.dsk BSAVE -a 0x4000 DOME

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
		zx02_optim.s wait_a_bit.s \
		hgr_sprite.s hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title.o title.s -l title.lst

####

DOME:	dome.o
	ld65 -o DOME dome.o -C ../../linker_scripts/apple2_4000.inc

dome.o:	dome.s zp.inc hardware.inc \
		zx02_optim.s \
		hgr_sprite.s hgr_tables.s \
		keyboard.s \
		hgr_14x14_sprite.s \
		leveldata_dome.inc \
		graphics_sprites/pointer_sprites.inc \
		graphics_dome/dome_graphics.inc
	ca65 -o dome.o dome.s -l dome.lst

####

LEVEL_PROJECTOR:	level_projector.o
	ld65 -o LEVEL_PROJECTOR level_projector.o -C ../../linker_scripts/apple2_4000.inc

level_projector.o:	level_projector.s zp.inc hardware.inc \
		zx02_optim.s \
		hgr_sprite.s hgr_tables.s \
		keyboard.s \
		hgr_14x14_sprite.s \
		leveldata_projector.inc \
		graphics_sprites/pointer_sprites.inc \
		graphics_projector/projector_graphics.inc
	ca65 -o level_projector.o level_projector.s -l level_projector.lst

####

LEVEL_MAGSTEPS:	level_magsteps.o
	ld65 -o LEVEL_MAGSTEPS level_magsteps.o -C ../../linker_scripts/apple2_4000.inc

level_magsteps.o:	level_magsteps.s zp.inc hardware.inc \
		zx02_optim.s \
		hgr_sprite.s hgr_tables.s \
		keyboard.s \
		hgr_14x14_sprite.s \
		leveldata_magsteps.inc \
		graphics_sprites/pointer_sprites.inc \
		graphics_magsteps/magsteps_graphics.inc
	ca65 -o level_magsteps.o level_magsteps.s -l level_magsteps.lst



####

clean:		
	rm -f *~ *.o *.lst HELLO LOADER TITLE \
		LEVEL_PROJECTOR LEVEL_MAGSTEPS DOME
#	cd graphics && make clean
#	cd maps && make clean
#	cd title && make clean
#	cd sprites && make clean

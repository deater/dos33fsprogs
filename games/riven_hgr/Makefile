include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/
LINKER_SCRIPTS = ../../linker_scripts/


all:	riven_hgr.dsk

riven_hgr.dsk:	QBOOT QLOAD TITLE \
	LEVEL_PROJECTOR LEVEL_MAGSTEPS LEVEL_MAGLEV LEVEL_OUTSIDE \
	MOVIE1 MOVIE2
	cp $(EMPTY_DISK)/empty.dsk riven_hgr.dsk
	$(DOS33_RAW) riven_hgr.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_hgr.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_hgr.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_hgr.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_hgr.dsk  2  0 TITLE		      0   0
	$(DOS33_RAW) riven_hgr.dsk  3  0 LEVEL_PROJECTOR      0   0
	$(DOS33_RAW) riven_hgr.dsk  9  0 LEVEL_OUTSIDE        0   0
	$(DOS33_RAW) riven_hgr.dsk  17 0 LEVEL_MAGSTEPS       0   0
	$(DOS33_RAW) riven_hgr.dsk  21 0 LEVEL_MAGLEV         0   0
	$(DOS33_RAW) riven_hgr.dsk  25 0 MOVIE1               0   0
	$(DOS33_RAW) riven_hgr.dsk  27 0 MOVIE2               0   0

#riven_hgr.dsk:	HELLO LOADER TITLE \
#		LEVEL_PROJECTOR LEVEL_MAGSTEPS LEVEL_MAGLEV LEVEL_OUTSIDE \
#		MOVIE1 MOVIE2
#	cp $(EMPTY_DISK) riven_hgr.dsk
#	$(DOS33) -y riven_hgr.dsk SAVE A HELLO
#	$(DOS33) -y riven_hgr.dsk BSAVE -a 0x1000 LOADER
#	$(DOS33) -y riven_hgr.dsk BSAVE -a 0x4000 TITLE
#	$(DOS33) -y riven_hgr.dsk BSAVE -a 0x4000 LEVEL_PROJECTOR
#	$(DOS33) -y riven_hgr.dsk BSAVE -a 0x4000 LEVEL_MAGSTEPS
#	$(DOS33) -y riven_hgr.dsk BSAVE -a 0x4000 LEVEL_MAGLEV
#	$(DOS33) -y riven_hgr.dsk BSAVE -a 0x4000 LEVEL_OUTSIDE
#	$(DOS33) -y riven_hgr.dsk BSAVE -a 0x4000 MOVIE1
#	$(DOS33) -y riven_hgr.dsk BSAVE -a 0x4000 MOVIE2


###

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s  qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst

###

###

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1800.inc

qload.o:	qload.s qboot.inc
	ca65 -o qload.o qload.s -l qload.lst


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

LOADER:	loader.o
	ld65 -o LOADER loader.o -C $(LINKER_SCRIPTS)/apple2_1000.inc

loader.o:	loader.s hardware_detect.s
	ca65 -o loader.o loader.s -l loader.lst

####

TITLE:	title.o
	ld65 -o TITLE title.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title.o:	title.s zp.inc hardware.inc \
		zx02_optim.s wait_a_bit.s \
		hgr_sprite.s hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title.o title.s -l title.lst

####

LEVEL_OUTSIDE:	level_outside.o
	ld65 -o LEVEL_OUTSIDE level_outside.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_outside.o:	level_outside.s zp.inc hardware.inc \
		zx02_optim.s \
		hgr_sprite.s hgr_tables.s \
		keyboard.s \
		hgr_14x14_sprite.s \
		leveldata_outside.inc \
		graphics_sprites/pointer_sprites.inc \
		graphics_outside/outside_graphics.inc
	ca65 -o level_outside.o level_outside.s -l level_outside.lst

####

LEVEL_PROJECTOR:	level_projector.o
	ld65 -o LEVEL_PROJECTOR level_projector.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

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
	ld65 -o LEVEL_MAGSTEPS level_magsteps.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

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

LEVEL_MAGLEV:	level_maglev.o
	ld65 -o LEVEL_MAGLEV level_maglev.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_maglev.o:	level_maglev.s zp.inc hardware.inc \
		zx02_optim.s \
		hgr_sprite.s hgr_tables.s \
		keyboard.s \
		hgr_14x14_sprite.s \
		leveldata_maglev.inc \
		graphics_sprites/pointer_sprites.inc \
		graphics_maglev/maglev_graphics.inc
	ca65 -o level_maglev.o level_maglev.s -l level_maglev.lst

####

MOVIE1:	movie1.o
	ld65 -o MOVIE1 movie1.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

movie1.o:	movie1.s \
	zp.inc hardware.inc \
	movie1/movie1.inc
	ca65 -o movie1.o movie1.s -l movie1.lst

####

MOVIE2:	movie2.o
	ld65 -o MOVIE2 movie2.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

movie2.o:	movie2.s \
	zp.inc hardware.inc \
	end_message/end_message.gr.zx02 \
	movie2/movie2.inc
	ca65 -o movie2.o movie2.s -l movie2.lst



####

graphics_sprites/pointer_sprites.inc:
	cd graphics_sprites && make

graphics_title/riven_title.hgr.zx02:	
	cd graphics_title && make

graphics_maglev/maglev_graphics.inc:
	cd graphics_maglev && make

graphics_magsteps/magsteps_graphics.inc:
	cd graphics_magsteps && make

graphics_outside/outside_graphics.inc:
	cd graphics_outside && make

graphics_projector/projector_graphics.inc:
	cd graphics_projector && make

movie1/movie1.inc:	
	cd movie1 && make

####

clean:		
	rm -f *~ *.o *.lst HELLO LOADER TITLE \
		LEVEL_PROJECTOR LEVEL_MAGSTEPS LEVEL_MAGLEV LEVEL_OUTSIDE \
		MOVIE1 MOVIE2

####

distclean:
	rm -f *~ *.o *.lst HELLO LOADER TITLE \
		LEVEL_PROJECTOR LEVEL_MAGSTEPS LEVEL_MAGLEV LEVEL_OUTSIDE \
		MOVIE1 MOVIE2
	cd graphics_title && make clean
	cd graphics_projector && make clean
	cd graphics_outside && make clean
	cd graphics_magsteps && make clean
	cd graphics_maglev && make clean
	cd graphics_sprites && make clean
	cd movie1 && make clean
#	cd movie2 && make clean


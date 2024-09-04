include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../..utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	cliff.dsk

####

cliff.dsk:	HELLO CLIFF CLIMB
	cp $(EMPTY_DISK) cliff.dsk
	$(DOS33) -y cliff.dsk SAVE A HELLO
	$(DOS33) -y cliff.dsk BSAVE -a 0x6000 CLIFF
	$(DOS33) -y cliff.dsk BSAVE -a 0x6000 CLIMB

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


####

CLIFF:	cliff.o
	ld65 -o CLIFF cliff.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

cliff.o:	cliff.s zx02_optim.s \
		move_peasant.s draw_peasant.s \
		hgr_copy.s hgr_partial_restore.s \
		hgr_sprite.s hgr_sprite_bg_mask.s \
		random16.s \
		cliff_graphics/cliff_base.hgr.zx02 \
		sprites/enemy_sprites.inc \
		zp.inc hardware.inc \
		walking_sprites.zx02
	ca65 -o cliff.o cliff.s -l cliff.lst

####

CLIMB:	climb.o
	ld65 -o CLIMB climb.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

climb.o:	climb.s zx02_optim.s \
		move_peasant.s draw_peasant.s \
		hgr_copy.s hgr_partial_restore.s \
		hgr_sprite.s hgr_sprite_bg_mask.s \
		random16.s \
		cliff_graphics/cliff_base.hgr.zx02 \
		sprites/enemy_sprites.inc \
		zp.inc hardware.inc \
		climbing_sprites.zx02
	ca65 -o climb.o climb.s -l climb.lst

####

walking_sprites.zx02:	walking_sprites
	$(ZX02) -f walking_sprites walking_sprites.zx02

walking_sprites:	walking_sprites.o
	ld65 -o walking_sprites walking_sprites.o -C $(LINKER_SCRIPTS)/apple2_a000.inc

walking_sprites.o:	walking_sprites.s \
	sprites/flame_sprites.inc \
	sprites/walk_sprites.inc
	ca65 -o walking_sprites.o walking_sprites.s -l walking_sprites.lst


####

climbing_sprites.zx02:	climbing_sprites
	$(ZX02) -f climbing_sprites climbing_sprites.zx02

climbing_sprites:	climbing_sprites.o
	ld65 -o climbing_sprites climbing_sprites.o -C $(LINKER_SCRIPTS)/apple2_a000.inc

climbing_sprites.o:	climbing_sprites.s \
	sprites/flame_sprites.inc \
	sprites/walk_sprites.inc
	ca65 -o climbing_sprites.o climbing_sprites.s -l climbing_sprites.lst



####

cliff_graphics/cliff_base.hgr.zx02:	
	cd cliff_graphics && make

sprites/enemy_sprites.inc:	
	cd sprites && make


####

clean:	
	rm -f *.lst *.o CLIFF CLIMB HELLO \
		walking_sprites climbing_sprites *.zx02
	cd cliff_graphics && make clean
	cd sprites && make clean

include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../..utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	target.dsk

####

target.dsk:	HELLO TARGET
	cp $(EMPTY_DISK) target.dsk
	$(DOS33) -y target.dsk SAVE A HELLO
	$(DOS33) -y target.dsk BSAVE -a 0x6000 TARGET

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


####

TARGET:	target.o
	ld65 -o TARGET target.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

target.o:	target.s zx02_optim.s \
		target_graphics/target_base.hgr.zx02
	ca65 -o target.o target.s -l target.lst


#		move_peasant_target.s draw_peasant_target.s \
#		keyboard_target.s \
#		hgr_copy.s hgr_partial_restore.s \
#		hgr_sprite.s hgr_sprite_bg_mask.s \
#		random16.s \

#		target_graphics/target2.hgr.zx02 \
#		target_graphics/target3.hgr.zx02 \
#		target_graphics/target_base_priority.zx02 \
#		target_graphics/target2_priority.zx02 \
#		target_graphics/target3_priority.zx02 \
#		sprites/enemy_sprites.inc \
#		zp.inc hardware.inc \
#		targeting_sprites.zx02


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
	sprites/climb_flame_sprites.inc \
	sprites/climb_sprites.inc
	ca65 -o climbing_sprites.o climbing_sprites.s -l climbing_sprites.lst



####

target_graphics/target_base.hgr.zx02:	
	cd target_graphics && make

sprites/enemy_sprites.inc:	
	cd sprites && make


####

clean:	
	rm -f *.lst *.o *~ TARGET TARGET HELLO \
		walking_sprites climbing_sprites *.zx02
	cd target_graphics && make clean
#	cd sprites && make clean

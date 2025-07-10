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
		keyboard_target.s \
		target_graphics/target_base.hgr.zx02 \
		target_sprites/bow_sprites.inc
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

###

target_graphics/target_base.hgr.zx02:	
	cd target_graphics && make

target_sprites/bow_sprites.inc:	
	cd target_sprites && make


####

clean:	
	rm -f *.lst *.o *~ TARGET TARGET HELLO \
		walking_sprites climbing_sprites *.zx02
	cd target_graphics && make clean
	cd target_sprites && make clean

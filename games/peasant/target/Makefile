include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	TARGET

####

TARGET:	target.o
	ld65 -o TARGET target.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

target.o:	target.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		keyboard_target.s \
		draw_bow.s draw_flag.s \
		move_meter.s move_arrows.s \
		target_graphics/target_base.hgr.zx02 \
		target_sprites/bow_sprites.inc \
		target_sprites/flag_sprites.inc \
		target_sprites/arrow_sprites.inc
	ca65 -o target.o target.s -l target.lst

###

target_graphics/target_base.hgr.zx02:	
	cd target_graphics && make

target_sprites/bow_sprites.inc:	
	cd target_sprites && make


####

distclean:
	make clean
	cd target_graphics && make clean
	cd target_sprites && make clean

clean:	
	rm -f *.lst *.o *~ TARGET

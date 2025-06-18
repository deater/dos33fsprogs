include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../..utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts


all:	CLIMB

####

CLIMB:	climb.o
	ld65 -o CLIMB climb.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

climb.o:	climb.s \
		../zp.inc ../hardware.inc ../qload.inc \
		draw_peasant_climb.s move_peasant_climb.s \
		../hgr_routines/hgr_sprite_save.s \
		../text/DIALOG_CLIMB.ZX02 \
		keyboard_climb.s \
		sprites/enemy_sprites.inc \
		../location_cliff_base/graphics_cliff/cliff_base.hgr.zx02 \
		graphics_cliff/cliff2.hgr.zx02 \
		graphics_cliff/cliff3.hgr.zx02 \
		rock_code.s bird_code.s
	ca65 -o climb.o climb.s -l climb.lst

####

../location_cliff_base/graphics_cliff/cliff_base.hgr.zx02:	
	cd ../location_cliff_base/graphics_cliff && make

graphics_cliff/cliff2.hgr.zx02:	
	cd graphics_cliff && make

sprites/enemy_sprites.inc:	
	cd sprites && make


####

clean:	
	rm -f *.lst *.o *~ CLIFF CLIMB HELLO *.zx02
	cd graphics_cliff && make clean
	cd sprites && make clean

####

distclean:	clean


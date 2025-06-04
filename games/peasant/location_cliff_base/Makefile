include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
LINKER_SCRIPTS = ../../../linker_scripts

all:	CLIFF_BASE

####

CLIFF_BASE:	cliff_base.o
	ld65 -o CLIFF_BASE cliff_base.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

cliff_base.o:	cliff_base.s \
		../zp.inc ../hardware.inc ../qload.inc ../version.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		cliff_base_actions.s \
		../text/DIALOG_CLIFF_BASE.ZX02 ../text/dialog_cliff_base.inc \
		graphics_cliff/cliff_graphics.inc \
		graphics_cliff/priority_cliff.inc \
		../sprites_peasant/robe_sprites.zx02 \
		../draw_peasant_new.s ../move_peasant_new.s \
		../gr_copy.s ../hgr_routines/hgr_copy.s \
		../new_map_location.s \
		../keyboard.s \
		../wait.s ../wait_a_bit.s
	ca65 -o cliff_base.o cliff_base.s -l cliff_base.lst

###

graphics_cliff/cliff_graphics.inc:
	cd graphics_cliff && make

###

distclean:
	make clean
	cd graphics_cliff && make clean

###

clean:	
	rm -f *~ *.o *.lst CLIFF_BASE


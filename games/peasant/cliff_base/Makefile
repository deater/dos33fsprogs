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
		cliff_base_actions.s \
		../text/DIALOG_CLIFF_BASE.ZX02 ../text/dialog_cliff_base.inc \
		graphics_cliff/cliff_graphics.inc \
		graphics_cliff/priority_cliff.inc \
		../sprites/peasant_sprites.inc \
		../draw_peasant.s ../move_peasant.s \
		../gr_copy.s ../hgr_copy.s \
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


include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	CLIFF_HEIGHTS

####

CLIFF_HEIGHTS:	cliff_heights.o
	ld65 -o CLIFF_HEIGHTS cliff_heights.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

cliff_heights.o:	cliff_heights.s \
		../zp.inc ../hardware.inc ../qload.inc ../version.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		heights_actions.s draw_lightning.s \
		../text/DIALOG_CLIFF_HEIGHTS.ZX02 ../text/dialog_cliff_heights.inc \
		graphics_heights/ciff_heights_graphics.inc \
		graphics_heights/priority_cliff_heights.inc \
		sprites_heights/ron_sprites.inc \
		sprites_heights/lightning_sprites.inc \
		../sprites_peasant/robe_sprites.zx02 \
		../draw_peasant.s ../move_peasant.s \
		../gr_copy.s ../hgr_copy.s \
		../new_map_location.s \
		../keyboard.s \
		../wait.s ../wait_a_bit.s
	ca65 -o cliff_heights.o cliff_heights.s -l cliff_heights.lst

###

graphics_heights/ciff_heights_graphics.inc:
	cd graphics_heights && make

###

sprites_heights/ron_sprites.inc:
	cd sprites_heights && make

sprites_heights/lightning_sprites.inc:
	cd sprites_heights && make

###

distclean:
	make clean
	cd graphics_heights && make clean
	cd sprites_heights && make clean

###

clean:	
	rm -f *~ *.o *.lst CLIFF_HEIGHTS

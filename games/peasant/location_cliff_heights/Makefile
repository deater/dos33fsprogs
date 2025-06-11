include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	CLIFF_HEIGHTS_LOADER


####

CLIFF_HEIGHTS_LOADER:	cliff_heights_loader.o
	ld65 -o CLIFF_HEIGHTS_LOADER cliff_heights_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

cliff_heights_loader.o:	cliff_heights_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_CLIFF_HEIGHTS.ZX02 \
		graphics_heights/cliff_heights_graphics.inc \
		graphics_heights/cliff_heights_priority.inc \
		../location_common/loader_common.s \
		CLIFF_HEIGHTS_CORE.zx02
	ca65 -o cliff_heights_loader.o cliff_heights_loader.s -l cliff_heights_loader.lst

####

CLIFF_HEIGHTS_CORE.zx02:	CLIFF_HEIGHTS_CORE
	$(ZX02) -f CLIFF_HEIGHTS_CORE CLIFF_HEIGHTS_CORE.zx02

CLIFF_HEIGHTS_CORE:	cliff_heights_core.o
	ld65 -o CLIFF_HEIGHTS_CORE cliff_heights_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

cliff_heights_core.o:	cliff_heights_core.s \
		../zp.inc ../hardware.inc ../qload.inc ../version.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		heights_actions.s draw_lightning.s \
		../text/DIALOG_CLIFF_HEIGHTS.ZX02 ../text/dialog_cliff_heights.inc \
		sprites_heights/lightning_sprites.inc \
		../sprites_peasant/robe_sprites.zx02 \
		../draw_peasant_new.s ../move_peasant_new.s \
		../gr_copy.s \
		../new_map_location.s \
		../keyboard.s \
		../wait_a_bit.s
	ca65 -o cliff_heights_core.o cliff_heights_core.s -l cliff_heights_core.lst

###

graphics_heights/cliff_heights_graphics.inc:
	cd graphics_heights && make

graphics_heights/cliff_heights_priority.inc:
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
	rm -f *~ *.o *.lst CLIFF_HEIGHTS_LOADER CLIFF_HEIGHTS_CORE

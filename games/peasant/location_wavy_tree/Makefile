include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	WAVY_TREE_LOADER

###

WAVY_TREE_LOADER:	wavy_tree_loader.o
	ld65 -o WAVY_TREE_LOADER wavy_tree_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

wavy_tree_loader.o:	wavy_tree_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_WAVY_TREE.ZX02 \
		graphics_wavy_tree/ned_graphics.inc \
		graphics_wavy_tree/ned_priority.inc \
		../location_common/loader_common.s \
		WAVY_TREE_CORE.zx02
	ca65 -o wavy_tree_loader.o wavy_tree_loader.s -l wavy_tree_loader.lst

###

WAVY_TREE_CORE.zx02:	WAVY_TREE_CORE
	$(ZX02) -f WAVY_TREE_CORE WAVY_TREE_CORE.zx02

WAVY_TREE_CORE:	wavy_tree_core.o
	ld65 -o WAVY_TREE_CORE wavy_tree_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

wavy_tree_core.o:	wavy_tree_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../gr_copy.s ../hgr_routines/hgr_copy.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s \
		sprites_wavy_tree/ned_sprites.inc \
		wavy_tree_actions.s
	ca65 -o wavy_tree_core.o wavy_tree_core.s -l wavy_tree_core.lst


###

graphics_wavy_tree/ned_graphics.inc:
	cd graphics_wavy_tree && make

sprites_wavy_tree/ned_sprites.inc:
	cd sprites_wavy_tree && make

###

distclean:
	make clean
	cd graphics_wavy_tree && make clean
	cd sprites_wavy_tree && make clean

###

clean:	
	rm -f *~ *.o *.lst WAVY_TREE_LOADER WAVY_TREE_CORE *.zx02

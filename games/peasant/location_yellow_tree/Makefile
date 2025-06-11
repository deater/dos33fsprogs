include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	YELLOW_TREE_LOADER

###

YELLOW_TREE_LOADER:	yellow_tree_loader.o
	ld65 -o YELLOW_TREE_LOADER yellow_tree_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

yellow_tree_loader.o:	yellow_tree_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_YELLOW_TREE.ZX02 \
		graphics_yellow_tree/yellow_tree_graphics.inc \
		graphics_yellow_tree/yellow_tree_priority.inc\
		../location_common/loader_common.s \
		YELLOW_TREE_CORE.zx02
	ca65 -o yellow_tree_loader.o yellow_tree_loader.s -l yellow_tree_loader.lst

###

YELLOW_TREE_CORE.zx02:	YELLOW_TREE_CORE
	$(ZX02) -f YELLOW_TREE_CORE YELLOW_TREE_CORE.zx02

YELLOW_TREE_CORE:	yellow_tree_core.o
	ld65 -o YELLOW_TREE_CORE yellow_tree_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

yellow_tree_core.o:	yellow_tree_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../gr_copy.s ../hgr_routines/hgr_copy.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s \
		yellow_tree_actions.s
	ca65 -o yellow_tree_core.o yellow_tree_core.s -l yellow_tree_core.lst


###

graphics_yellow_tree/yellow_tree_graphics.inc:
	cd graphics_yellow_tree && make

sprites_yellow_tree/yellow_tree_sprites.inc:
	cd sprites_yellow_tree && make

###

distclean:
	make clean
	cd graphics_yellow_tree && make clean
#	cd sprites && make clean

###

clean:	
	rm -f *~ *.o *.lst YELLOW_TREE_LOADER YELLOW_TREE_CORE *.zx02

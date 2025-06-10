include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	BURNINATED_LOADER

###

BURNINATED_LOADER:	burninated_loader.o
	ld65 -o BURNINATED_LOADER burninated_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

burninated_loader.o:	burninated_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_BURNINATED_TREE.ZX02 \
		graphics_burninated/crooked_tree_graphics.inc \
		graphics_burninated/crooked_tree_priority.inc\
		../location_common/loader_common.s \
		BURNINATED_CORE.zx02
	ca65 -o burninated_loader.o burninated_loader.s -l burninated_loader.lst

###

BURNINATED_CORE.zx02:	BURNINATED_CORE
	$(ZX02) -f BURNINATED_CORE BURNINATED_CORE.zx02

BURNINATED_CORE:	burninated_core.o
	ld65 -o BURNINATED_CORE burninated_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

burninated_core.o:	burninated_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../gr_copy.s ../hgr_routines/hgr_copy.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s \
		burninated_actions.s
	ca65 -o burninated_core.o burninated_core.s -l burninated_core.lst


###

graphics_burninated/crooked_tree_graphics.inc:
	cd graphics_burninated && make

sprites_burninated/crooked_tree_sprites.inc:
	cd sprites_burninated && make

###

distclean:
	make clean
	cd graphics_burninated && make clean
	cd sprites && make clean

###

clean:	
	rm -f *~ *.o *.lst BURNINATED_LOADER BURNINATED_CORE *.zx02

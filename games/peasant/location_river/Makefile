include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	RIVER_LOADER

###

RIVER_LOADER:	river_loader.o
	ld65 -o RIVER_LOADER river_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

river_loader.o:	river_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_RIVER.ZX02 \
		graphics_river/river_graphics.inc \
		graphics_river/river_night_graphics.inc \
		graphics_river/river_priority.inc\
		../location_common/loader_common.s \
		RIVER_CORE.zx02
	ca65 -o river_loader.o river_loader.s -l river_loader.lst

###

RIVER_CORE.zx02:	RIVER_CORE
	$(ZX02) -f RIVER_CORE RIVER_CORE.zx02

RIVER_CORE:	river_core.o
	ld65 -o RIVER_CORE river_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

river_core.o:	river_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s borders.s \
		animate_river.s \
		sprites_river/river_current_sprites.inc \
		sprites_river/river_night_sprites.inc \
		river_actions.s
	ca65 -o river_core.o river_core.s -l river_core.lst


###

graphics_river/river_graphics.inc:
	cd graphics_river && make

sprites_river/river_current_sprites.inc:
	cd sprites_river && make

###

distclean:
	make clean
	cd graphics_river && make clean
	cd sprites_river && make clean

###

clean:	
	rm -f *~ *.o *.lst RIVER_LOADER RIVER_CORE *.zx02

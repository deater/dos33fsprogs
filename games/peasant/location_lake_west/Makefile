include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	LAKE_WEST_LOADER

###

LAKE_WEST_LOADER:	lake_west_loader.o
	ld65 -o LAKE_WEST_LOADER lake_west_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

lake_west_loader.o:	lake_west_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_LAKE_WEST.ZX02 \
		graphics_lake_west/lake_west_graphics.inc \
		graphics_lake_west/lake_west_priority.inc\
		../location_common/loader_common.s \
		LAKE_WEST_CORE.zx02
	ca65 -o lake_west_loader.o lake_west_loader.s -l lake_west_loader.lst

###

LAKE_WEST_CORE.zx02:	LAKE_WEST_CORE
	$(ZX02) -f LAKE_WEST_CORE LAKE_WEST_CORE.zx02

LAKE_WEST_CORE:	lake_west_core.o
	ld65 -o LAKE_WEST_CORE lake_west_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

lake_west_core.o:	lake_west_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		sprites_lake_west/lake_west_sprites.inc \
		sprites_lake_west/pebbles_sprites.inc \
		sprites_lake_west/throw_sprites.inc \
		../wait_a_bit.s borders.s \
		lake_west_actions.s
	ca65 -o lake_west_core.o lake_west_core.s -l lake_west_core.lst


###

graphics_lake_west/lake_west_graphics.inc:
	cd graphics_lake_west && make

graphics_lake_west/lake_west_priority.inc:
	cd graphics_lake_west && make

sprites_lake_west/lake_west_sprites.inc:
	cd sprites_lake_west && make

###

distclean:
	make clean
	cd graphics_lake_west && make clean
	cd sprites_lake_west && make clean

###

clean:	
	rm -f *~ *.o *.lst LAKE_WEST_LOADER LAKE_WEST_CORE *.zx02

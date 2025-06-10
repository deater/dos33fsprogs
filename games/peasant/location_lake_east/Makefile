include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	LAKE_EAST_LOADER

###

LAKE_EAST_LOADER:	lake_east_loader.o
	ld65 -o LAKE_EAST_LOADER lake_east_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

lake_east_loader.o:	lake_east_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_LAKE_EAST.ZX02 \
		graphics_lake_east/lake_east_graphics.inc \
		graphics_lake_east/lake_east_priority.inc\
		../location_common/loader_common.s \
		LAKE_EAST_CORE.zx02
	ca65 -o lake_east_loader.o lake_east_loader.s -l lake_east_loader.lst

###

LAKE_EAST_CORE.zx02:	LAKE_EAST_CORE
	$(ZX02) -f LAKE_EAST_CORE LAKE_EAST_CORE.zx02

LAKE_EAST_CORE:	lake_east_core.o
	ld65 -o LAKE_EAST_CORE lake_east_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

lake_east_core.o:	lake_east_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../gr_copy.s ../hgr_routines/hgr_copy.s \
		../new_map_location.s ../keyboard.s \
		sprites_lake_east/lake_east_sprites.inc \
		../wait_a_bit.s \
		lake_east_actions.s
	ca65 -o lake_east_core.o lake_east_core.s -l lake_east_core.lst


###

graphics_lake_east/lake_east_graphics.inc:
	cd graphics_lake_east && make

graphics_lake_east/lake_east_priority.inc:
	cd graphics_lake_east && make

sprites_lake_east/lake_east_sprites.inc:
	cd sprites_lake_east && make

###

distclean:
	make clean
	cd graphics_lake_east && make clean
	cd sprites && make clean

###

clean:	
	rm -f *~ *.o *.lst LAKE_EAST_LOADER LAKE_EAST_CORE *.zx02

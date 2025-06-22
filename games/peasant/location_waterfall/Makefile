include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	WATERFALL_LOADER

###

WATERFALL_LOADER:	waterfall_loader.o
	ld65 -o WATERFALL_LOADER waterfall_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

waterfall_loader.o:	waterfall_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_WATERFALL.ZX02 \
		graphics_waterfall/waterfall_graphics.inc \
		graphics_waterfall/waterfall_priority.inc\
		../location_common/loader_common.s \
		WATERFALL_CORE.zx02
	ca65 -o waterfall_loader.o waterfall_loader.s -l waterfall_loader.lst

###

WATERFALL_CORE.zx02:	WATERFALL_CORE
	$(ZX02) -f WATERFALL_CORE WATERFALL_CORE.zx02

WATERFALL_CORE:	waterfall_core.o
	ld65 -o WATERFALL_CORE waterfall_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

waterfall_core.o:	waterfall_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s borders.s \
		sprites_waterfall/waterfall_sprites.inc\
		waterfall_actions.s draw_waterfall.s
	ca65 -o waterfall_core.o waterfall_core.s -l waterfall_core.lst


###

graphics_waterfall/waterfall_graphics.inc:
	cd graphics_waterfall && make

sprites_waterfall/waterfall_sprites.inc:
	cd sprites_waterfall && make


###

distclean:
	make clean
	cd graphics_waterfall && make clean
	cd sprites_waterfall && make clean

###

clean:	
	rm -f *~ *.o *.lst WATERFALL_LOADER WATERFALL_CORE *.zx02

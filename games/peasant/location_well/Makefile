include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	WELL_LOADER

###

WELL_LOADER:	well_loader.o
	ld65 -o WELL_LOADER well_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

well_loader.o:	well_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_WELL.ZX02 \
		graphics_well/well_graphics.inc \
		graphics_well/well_priority.inc\
		../location_common/loader_common.s \
		WELL_CORE.zx02
	ca65 -o well_loader.o well_loader.s -l well_loader.lst

###

WELL_CORE.zx02:	WELL_CORE
	$(ZX02) -f WELL_CORE WELL_CORE.zx02

WELL_CORE:	well_core.o
	ld65 -o WELL_CORE well_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

well_core.o:	well_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s borders.s \
		sprites_well/well_sprites.inc \
		draw_well.s well_actions.s
	ca65 -o well_core.o well_core.s -l well_core.lst


###

graphics_well/well_graphics.inc:
	cd graphics_well && make

sprites_well/well_sprites.inc:
	cd sprites_well && make

###

distclean:
	make clean
	cd graphics_well && make clean
	cd sprites_well && make clean

###

clean:	
	rm -f *~ *.o *.lst WELL_LOADER WELL_CORE *.zx02

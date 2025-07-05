include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	OUTER_LOADER

###

OUTER_LOADER:	outer_loader.o
	ld65 -o OUTER_LOADER outer_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

outer_loader.o:	outer_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_OUTER.ZX02 \
		graphics_outer/outer_graphics.inc \
		graphics_outer/outer_priority.inc\
		../location_common/loader_common.s \
		OUTER_CORE.zx02
	ca65 -o outer_loader.o outer_loader.s -l outer_loader.lst

###

OUTER_CORE.zx02:  OUTER_CORE
	$(ZX02) -f OUTER_CORE OUTER_CORE.zx02

OUTER_CORE:	outer_core.o
	ld65 -o OUTER_CORE outer_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

outer_core.o:	outer_core.s \
		../zp.inc ../hardware.inc ../qload.inc ../version.inc \
		../inventory/inventory.inc \
		../parse_input.inc ../common_defines.inc \
		outer_actions.s \
		../text/DIALOG_OUTER.ZX02 ../text/dialog_outer.inc \
		graphics_outer/outer_graphics.inc \
		graphics_outer/outer_priority.inc \
		sprites_outer/ron_sprites.inc \
		sprites_outer/keeper1_sprites.inc \
		sprites_outer/keeper2_sprites.inc \
		sprites_outer/guitar_sprites.inc \
		keeper1.s quiz1.s \
		../new_map_location.s \
		../keyboard.s \
		../wait_a_bit.s borders.s
	ca65 -o outer_core.o outer_core.s -l outer_core.lst

###

graphics_outer/outer_graphics.inc:
	cd graphics_outer && make

###

sprites_outer/ron_sprites.inc:
	cd sprites_outer && make

###

distclean:
	make clean
	cd graphics_outer && make clean
	cd sprites_outer && make clean

###

clean:	
	rm -f *~ *.o *.lst OUTER_CORE OUTER_LOADER *.zx02

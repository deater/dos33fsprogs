include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	OUTER2_LOADER

###

OUTER2_LOADER:	outer2_loader.o
	ld65 -o OUTER2_LOADER outer2_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

outer2_loader.o:	outer2_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_OUTER2.ZX02 \
		../location_outer/graphics_outer/outer_graphics.inc \
		../location_outer/graphics_outer/outer_priority.inc\
		../location_common/loader_common.s \
		OUTER2_CORE.zx02
	ca65 -o outer2_loader.o outer2_loader.s -l outer2_loader.lst

###

OUTER2_CORE.zx02:  OUTER2_CORE
	$(ZX02) -f OUTER2_CORE OUTER2_CORE.zx02

OUTER2_CORE:	outer2_core.o
	ld65 -o OUTER2_CORE outer2_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

outer2_core.o:	outer2_core.s \
		../zp.inc ../hardware.inc ../qload.inc ../version.inc \
		../inventory/inventory.inc \
		../parse_input.inc ../common_defines.inc \
		../location_outer/outer_actions_common.s outer2_actions.s \
		../text/DIALOG_OUTER2.ZX02 ../text/dialog_outer2.inc \
		sprites_outer2/keeper2_sprites.inc \
		sprites_outer2/guitar_sprites.inc \
		keeper2.s quiz2.s ../location_outer/quiz_keyboard.s \
		../new_map_location.s \
		../keyboard.s \
		../wait_a_bit.s borders.s
	ca65 -o outer2_core.o outer2_core.s -l outer2_core.lst

###

../location_outer/graphics_outer/outer_graphics.inc:
	cd ../location_outer/graphics_outer && make

###

sprites_outer2/keeper2_sprites.inc:
	cd sprites_outer2 && make

###

distclean:
	make clean
	cd sprites_outer2 && make clean

###

clean:	
	rm -f *~ *.o *.lst OUTER2_CORE OUTER2_LOADER *.zx02

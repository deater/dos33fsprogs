include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	OUTER3_LOADER

###

OUTER3_LOADER:	outer3_loader.o
	ld65 -o OUTER3_LOADER outer3_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

outer3_loader.o:	outer3_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_OUTER3.ZX02 \
		../location_outer/graphics_outer/outer_graphics.inc \
		../location_outer/graphics_outer/outer_priority.inc\
		../location_common/loader_common.s \
		OUTER3_CORE.zx02
	ca65 -o outer3_loader.o outer3_loader.s -l outer3_loader.lst

###

OUTER3_CORE.zx02:  OUTER3_CORE
	$(ZX02) -f OUTER3_CORE OUTER3_CORE.zx02

OUTER3_CORE:	outer3_core.o
	ld65 -o OUTER3_CORE outer3_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

outer3_core.o:	outer3_core.s \
		../zp.inc ../hardware.inc ../qload.inc ../version.inc \
		../inventory/inventory.inc \
		../parse_input.inc ../common_defines.inc \
		../location_outer/outer_actions_common.s outer3_actions.s \
		../text/DIALOG_OUTER3.ZX02 ../text/dialog_outer3.inc \
		sprites_outer3/keeper3_sprites.inc \
		sprites_outer3/skeleton_sprites.inc \
		sprites_outer3/curtain_sprites.inc \
		sprites_outer3/sword_sprites.inc \
		keeper3.s quiz3.s ../location_outer/quiz_keyboard.s \
		get_sword.s \
		../new_map_location.s \
		../keyboard.s \
		../wait_a_bit.s borders.s
	ca65 -o outer3_core.o outer3_core.s -l outer3_core.lst

###

../location_outer/graphics_outer/outer_graphics.inc:
	cd ../location_outer/graphics_outer && make

###

sprites_outer3/keeper3_sprites.inc:
	cd sprites_outer3 && make

###

distclean:
	make clean
	cd sprites_outer3 && make clean

###

clean:	
	rm -f *~ *.o *.lst OUTER3_CORE OUTER3_LOADER *.zx02

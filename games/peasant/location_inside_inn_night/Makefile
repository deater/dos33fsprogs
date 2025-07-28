include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	INSIDE_INN_NIGHT_LOADER

###

INSIDE_INN_NIGHT_LOADER:	inside_inn_night_loader.o
	ld65 -o INSIDE_INN_NIGHT_LOADER inside_inn_night_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

inside_inn_night_loader.o:	inside_inn_night_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_INSIDE_INN_NIGHT.ZX02 \
		graphics_inside_inn_night/inside_inn_night_graphics.inc \
		graphics_inside_inn_night/inside_inn_night_priority.inc \
		../location_common/loader_common.s \
		INSIDE_INN_NIGHT_CORE.zx02
	ca65 -o inside_inn_night_loader.o inside_inn_night_loader.s -l inside_inn_night_loader.lst

###

INSIDE_INN_NIGHT_CORE.zx02:	INSIDE_INN_NIGHT_CORE
	$(ZX02) -f INSIDE_INN_NIGHT_CORE INSIDE_INN_NIGHT_CORE.zx02

INSIDE_INN_NIGHT_CORE:	inside_inn_night_core.o
	ld65 -o INSIDE_INN_NIGHT_CORE inside_inn_night_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

inside_inn_night_core.o:	inside_inn_night_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		inside_inn_night_actions.s wipe_center.s \
		peasant_animations.s \
		../text/DIALOG_INSIDE_INN_NIGHT.ZX02 ../text/dialog_inside_inn.inc \
		graphics_inside_inn_night/inside_inn_night_graphics.inc \
		graphics_inside_inn_night/inside_inn_night_priority.inc \
		sprites_inside_inn_night/sleep_sprites.inc \
		sprites_inside_inn_night/pantry_sprites.inc
	ca65 -o inside_inn_night_core.o inside_inn_night_core.s -l inside_inn_night_core.lst

####

graphics_inside_inn_night/inside_inn_night_graphics.inc:
	cd graphics_inside_inn_night && make

sprites_inside_inn_night/sleep_sprites.inc:
	cd sprites_inside_inn_night && make

###

distclean:
	make clean
	cd graphics_inside_inn_night && make clean
	cd sprites_inside_inn_night && make clean

###

clean:	
	rm -f *~ *.o *.lst INSIDE_INN_NIGHT_LOADER INSIDE_INN_NIGHT_CORE *.zx02

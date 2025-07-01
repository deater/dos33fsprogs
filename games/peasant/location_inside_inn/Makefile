include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	INSIDE_INN_LOADER

###

INSIDE_INN_LOADER:	inside_inn_loader.o
	ld65 -o INSIDE_INN_LOADER inside_inn_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

inside_inn_loader.o:	inside_inn_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_INSIDE_INN.ZX02 \
		graphics_inside_inn/inside_inn_graphics.inc \
		graphics_inside_inn/inside_inn_priority.inc \
		../location_common/loader_common.s \
		INSIDE_INN_CORE.zx02
	ca65 -o inside_inn_loader.o inside_inn_loader.s -l inside_inn_loader.lst

###

INSIDE_INN_CORE.zx02:	INSIDE_INN_CORE
	$(ZX02) -f INSIDE_INN_CORE INSIDE_INN_CORE.zx02

INSIDE_INN_CORE:	inside_inn_core.o
	ld65 -o INSIDE_INN_CORE inside_inn_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

inside_inn_core.o:	inside_inn_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		inside_inn_actions.s \
		../text/DIALOG_INSIDE_INN.ZX02 ../text/dialog_inside_inn.inc \
		graphics_inside_inn/inside_inn_graphics.inc \
		graphics_inside_inn/inside_inn_priority.inc \
		sprites_inside_inn/keeper_sprites.inc
	ca65 -o inside_inn_core.o inside_inn_core.s -l inside_inn_core.lst

####

graphics_inside_inn/inside_inn_graphics.inc:
	cd graphics_inside_inn && make

sprites_inside_inn/keeper_sprites.inc:
	cd sprites_inside_inn && make

###

distclean:
	make clean
	cd graphics_inside_inn && make clean
	cd sprites_inside_inn && make clean

###

clean:	
	rm -f *~ *.o *.lst INSIDE_INN_LOADER INSIDE_INN_CORE

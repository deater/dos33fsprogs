include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	KNIGHT_LOADER

###

KNIGHT_LOADER:	knight_loader.o
	ld65 -o KNIGHT_LOADER knight_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

knight_loader.o:	knight_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_KNIGHT.ZX02 \
		graphics_knight/knight_graphics.inc \
		graphics_knight/knight_priority.inc\
		../location_common/loader_common.s \
		KNIGHT_CORE.zx02
	ca65 -o knight_loader.o knight_loader.s -l knight_loader.lst

###

KNIGHT_CORE.zx02:	KNIGHT_CORE
	$(ZX02) -f KNIGHT_CORE KNIGHT_CORE.zx02

KNIGHT_CORE:	knight_core.o
	ld65 -o KNIGHT_CORE knight_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

knight_core.o:	knight_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../gr_copy.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s \
		knight_actions.s
	ca65 -o knight_core.o knight_core.s -l knight_core.lst


###

graphics_knight/knight_graphics.inc:
	cd graphics_knight && make

sprites_knight/knight_sprites.inc:
	cd sprites_knight && make

###

distclean:
	make clean
	cd graphics_knight && make clean
	cd sprites_knight && make clean

###

clean:	
	rm -f *~ *.o *.lst KNIGHT_LOADER KNIGHT_CORE *.zx02

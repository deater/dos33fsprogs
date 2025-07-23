include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	INSIDE_LADY_LOADER

###

INSIDE_LADY_LOADER:	inside_lady_loader.o
	ld65 -o INSIDE_LADY_LOADER inside_lady_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

inside_lady_loader.o:	inside_lady_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_INSIDE_LADY.ZX02 \
		graphics_inside_lady/inside_lady_graphics.inc \
		graphics_inside_lady/inside_lady_priority.inc\
		../location_common/loader_common.s \
		INSIDE_LADY_CORE.zx02
	ca65 -o inside_lady_loader.o inside_lady_loader.s -l inside_lady_loader.lst

###

INSIDE_LADY_CORE.zx02:	INSIDE_LADY_CORE
	$(ZX02) -f INSIDE_LADY_CORE INSIDE_LADY_CORE.zx02

INSIDE_LADY_CORE:	inside_lady_core.o
	ld65 -o INSIDE_LADY_CORE inside_lady_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

inside_lady_core.o:	inside_lady_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s borders.s \
		inside_lady_actions.s draw_lady.s \
		sprites_inside_lady/lady_cottage_sprites.inc
	ca65 -o inside_lady_core.o inside_lady_core.s -l inside_lady_core.lst


###

graphics_inside_lady/inside_lady_graphics.inc:
	cd graphics_inside_lady && make

graphics_inside_lady/inside_lady_priority.inc:
	cd graphics_inside_lady && make

sprites_inside_lady/lady_cottage_sprites.inc:
	cd sprites_inside_lady && make

###

distclean:
	make clean
	cd graphics_inside_lady && make clean
	cd sprites_inside_lady && make clean

###

clean:	
	rm -f *~ *.o *.lst INSIDE_LADY_LOADER INSIDE_LADY_CORE *.zx02

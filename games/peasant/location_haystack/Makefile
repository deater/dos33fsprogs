include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	HAYSTACK_LOADER

###

HAYSTACK_LOADER:	haystack_loader.o
	ld65 -o HAYSTACK_LOADER haystack_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

haystack_loader.o:	haystack_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../location_common/init_common.s \
		graphics_haystack/haystack_graphics.inc \
		HAYSTACK_CORE.zx02
	ca65 -o haystack_loader.o haystack_loader.s -l haystack_loader.lst

###

HAYSTACK_CORE.zx02:	HAYSTACK_CORE
	$(ZX02) -f HAYSTACK_CORE HAYSTACK_CORE.zx02

HAYSTACK_CORE:	haystack_core.o
	ld65 -o HAYSTACK_CORE haystack_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

haystack_core.o:	haystack_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s borders.s \
		sprites_haystack/haystack_gone_sprite.inc \
		haystack_actions.s haystack_gone.s
	ca65 -o haystack_core.o haystack_core.s -l haystack_core.lst


####

graphics_haystack/haystack_graphics.inc:
	cd graphics_haystack && make

sprites_haystack/haystack_gone_sprite.inc:
	cd sprites_haystack && make

###

distclean:
	make clean
	cd graphics_haystack && make clean
	cd sprites_haystack && make clean

###

clean:	
	rm -f *~ *.o *.lst HAYSTACK_LOADER HAYSTACK_CORE *.zx02

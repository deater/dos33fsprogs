include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	JHONKA_LOADER

###

JHONKA_LOADER:	jhonka_loader.o
	ld65 -o JHONKA_LOADER jhonka_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

jhonka_loader.o:	jhonka_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_JHONKA.ZX02 \
		graphics_jhonka/jhonka_graphics.inc \
		graphics_jhonka/jhonka_priority.inc\
		../location_common/loader_common.s \
		JHONKA_CORE.zx02
	ca65 -o jhonka_loader.o jhonka_loader.s -l jhonka_loader.lst

###

JHONKA_CORE.zx02:	JHONKA_CORE
	$(ZX02) -f JHONKA_CORE JHONKA_CORE.zx02

JHONKA_CORE:	jhonka_core.o
	ld65 -o JHONKA_CORE jhonka_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

jhonka_core.o:	jhonka_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		sprites_jhonka/sprites_jhonka.inc \
		sprites_jhonka/sprites_riches.inc \
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s borders.s \
		jhonka_actions.s draw_jhonka.s update_bg.s
	ca65 -o jhonka_core.o jhonka_core.s -l jhonka_core.lst


###

graphics_jhonka/jhonka_graphics.inc:
	cd graphics_jhonka && make

graphics_jhonka/jhonka_priority.inc:
	cd graphics_jhonka && make

sprites_jhonka/jhonka_sprites.inc:
	cd sprites_jhonka && make

###

distclean:
	make clean
	cd graphics_jhonka && make clean
	cd sprites_jhonka && make clean

###

clean:	
	rm -f *~ *.o *.lst JHONKA_LOADER JHONKA_CORE *.zx02

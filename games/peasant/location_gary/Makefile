include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	GARY_LOADER

###

GARY_LOADER:	gary_loader.o
	ld65 -o GARY_LOADER gary_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

gary_loader.o:	gary_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_GARY.ZX02 \
		graphics_gary/gary_graphics.inc \
		graphics_gary/gary_priority.inc\
		../location_common/loader_common.s \
		GARY_CORE.zx02
	ca65 -o gary_loader.o gary_loader.s -l gary_loader.lst

###

GARY_CORE.zx02:	GARY_CORE
	$(ZX02) -f GARY_CORE GARY_CORE.zx02

GARY_CORE:	gary_core.o
	ld65 -o GARY_CORE gary_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

gary_core.o:	gary_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s borders.s \
		gary_actions.s gary_update_bg.s draw_gary.s \
		graphics_gary/gary_graphics.inc \
		sprites_gary/gary_sprites.inc \
		sprites_gary/gary_bg.inc
	ca65 -o gary_core.o gary_core.s -l gary_core.lst


###

graphics_gary/gary_graphics.inc:
	cd graphics_gary && make

sprites_gary/gary_sprites.inc:
	cd sprites_gary && make

###

distclean:
	make clean
	cd graphics_gary && make clean
	cd sprites_gary && make clean

###

clean:	
	rm -f *~ *.o *.lst GARY_LOADER GARY_CORE *.zx02

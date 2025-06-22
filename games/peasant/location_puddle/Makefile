include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	PUDDLE_LOADER

###

PUDDLE_LOADER:	puddle_loader.o
	ld65 -o PUDDLE_LOADER puddle_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

puddle_loader.o:	puddle_loader.s ../zp.inc ../hardware.inc ../qload.inc \
		../location_common/init_common.s \
		graphics_puddle/puddle_graphics.inc \
		graphics_puddle/puddle_priority.inc \
		PUDDLE_CORE.zx02
	ca65 -o puddle_loader.o puddle_loader.s -l puddle_loader.lst

###

PUDDLE_CORE.zx02:	PUDDLE_CORE
	$(ZX02) -f PUDDLE_CORE PUDDLE_CORE.zx02

PUDDLE_CORE:	puddle_core.o
	ld65 -o PUDDLE_CORE puddle_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

puddle_core.o:	puddle_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s borders.s \
		puddle_actions.s \
		../text/DIALOG_PUDDLE.ZX02 ../text/dialog_puddle.inc \
		graphics_puddle/puddle_graphics.inc \
		graphics_puddle/puddle_priority.inc
	ca65 -o puddle_core.o puddle_core.s -l puddle_core.lst



####

graphics_puddle/puddle_graphics.inc:
	cd graphics_puddle && make

graphics_puddle/puddle_priority.inc:
	cd graphics_puddle && make

###

distclean:
	make clean
	cd graphics_puddle && make clean

###

clean:	
	rm -f *~ *.o *.lst PUDDLE_LOADER PUDDLE_CORE *.zx02

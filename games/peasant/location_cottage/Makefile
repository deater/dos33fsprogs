include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	COTTAGE_LOADER

###

COTTAGE_LOADER:	cottage_loader.o
	ld65 -o COTTAGE_LOADER cottage_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

cottage_loader.o:	cottage_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_COTTAGE.ZX02 \
		graphics_cottage/cottage_graphics.inc \
		graphics_cottage/cottage_priority.inc\
		../location_common/loader_common.s \
		COTTAGE_CORE.zx02
	ca65 -o cottage_loader.o cottage_loader.s -l cottage_loader.lst

###

COTTAGE_CORE.zx02:	COTTAGE_CORE
	$(ZX02) -f COTTAGE_CORE COTTAGE_CORE.zx02

COTTAGE_CORE:	cottage_core.o
	ld65 -o COTTAGE_CORE cottage_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

cottage_core.o:	cottage_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s borders.s \
		cottage_actions.s
	ca65 -o cottage_core.o cottage_core.s -l cottage_core.lst


###

graphics_cottage/cottage_graphics.inc:
	cd graphics_cottage && make

graphics_cottage/cottage_priority.inc:
	cd graphics_cottage && make

sprites_cottage/cottage_sprites.inc:
	cd sprites_cottage && make

###

distclean:
	make clean
	cd graphics_cottage && make clean
#	cd sprites && make clean

###

clean:	
	rm -f *~ *.o *.lst COTTAGE_LOADER COTTAGE_CORE *.zx02

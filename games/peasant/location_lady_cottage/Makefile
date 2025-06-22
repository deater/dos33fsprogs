include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	LADY_COTTAGE_LOADER

###

LADY_COTTAGE_LOADER:	lady_cottage_loader.o
	ld65 -o LADY_COTTAGE_LOADER lady_cottage_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

lady_cottage_loader.o:	lady_cottage_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_LADY_COTTAGE.ZX02 \
		graphics_lady_cottage/lady_cottage_graphics.inc \
		graphics_lady_cottage/lady_cottage_priority.inc \
		../location_common/loader_common.s \
		LADY_COTTAGE_CORE.zx02
	ca65 -o lady_cottage_loader.o lady_cottage_loader.s -l lady_cottage_loader.lst

###

LADY_COTTAGE_CORE.zx02:	LADY_COTTAGE_CORE
	$(ZX02) -f LADY_COTTAGE_CORE LADY_COTTAGE_CORE.zx02

LADY_COTTAGE_CORE:	lady_cottage_core.o
	ld65 -o LADY_COTTAGE_CORE lady_cottage_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

lady_cottage_core.o:	lady_cottage_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s borders.s \
		lady_cottage_actions.s
	ca65 -o lady_cottage_core.o lady_cottage_core.s -l lady_cottage_core.lst


###


graphics_lady_cottage/lady_cottage_graphics.inc:
	cd graphics_lady_cottage && make

sprites_lady_cottage/lady_cottage_sprites.inc:
	cd sprites_lady_cottage && make

###

distclean:
	make clean
	cd graphics_lady_cottage && make clean
#	cd sprites && make clean

###

clean:	
	rm -f *~ *.o *.lst LADY_COTTAGE_LOADER LADY_COTTAGE_CORE *.zx02

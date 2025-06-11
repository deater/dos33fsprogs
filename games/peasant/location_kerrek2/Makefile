include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	KERREK2_LOADER

###

KERREK2_LOADER:	kerrek2_loader.o
	ld65 -o KERREK2_LOADER kerrek2_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

kerrek2_loader.o:	kerrek2_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_KERREK2.ZX02 \
		graphics_kerrek2/bottom_prints_graphics.inc \
		graphics_kerrek2/bottom_prints_priority.inc\
		../location_common/loader_common.s \
		KERREK2_CORE.zx02
	ca65 -o kerrek2_loader.o kerrek2_loader.s -l kerrek2_loader.lst

###

KERREK2_CORE.zx02:	KERREK2_CORE
	$(ZX02) -f KERREK2_CORE KERREK2_CORE.zx02

KERREK2_CORE:	kerrek2_core.o
	ld65 -o KERREK2_CORE kerrek2_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

kerrek2_core.o:	kerrek2_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../gr_copy.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s \
		../location_kerrek1/kerrek_actions.s \
		../location_kerrek1/sprites_kerrek1/kerrek_sprites.inc
	ca65 -o kerrek2_core.o kerrek2_core.s -l kerrek2_core.lst


###

graphics_kerrek2/bottom_prints_graphics.inc:
	cd graphics_kerrek2 && make

sprites_kerrek2/kerrek2_sprites.inc:
	cd sprites_kerrek2 && make

###

distclean:
	make clean
	cd graphics_kerrek2 && make clean
#	cd sprites && make clean

###

clean:	
	rm -f *~ *.o *.lst KERREK2_LOADER KERREK2_CORE *.zx02

include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	KERREK1_LOADER

###

KERREK1_LOADER:	kerrek1_loader.o
	ld65 -o KERREK1_LOADER kerrek1_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

kerrek1_loader.o:	kerrek1_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_KERREK1.ZX02 \
		graphics_kerrek1/kerrek1_graphics.inc \
		graphics_kerrek1/kerrek1_priority.inc\
		../location_common/loader_common.s \
		KERREK1_CORE.zx02
	ca65 -o kerrek1_loader.o kerrek1_loader.s -l kerrek1_loader.lst

###

KERREK1_CORE.zx02:	KERREK1_CORE
	$(ZX02) -f KERREK1_CORE KERREK1_CORE.zx02

KERREK1_CORE:	kerrek1_core.o
	ld65 -o KERREK1_CORE kerrek1_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

kerrek1_core.o:	kerrek1_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../gr_copy.s ../hgr_routines/hgr_copy.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s \
		kerrek1_actions.s
	ca65 -o kerrek1_core.o kerrek1_core.s -l kerrek1_core.lst


###

graphics_kerrek1/kerrek1_graphics.inc:
	cd graphics_kerrek1 && make

sprites_kerrek1/kerrek1_sprites.inc:
	cd sprites_kerrek1 && make

###

distclean:
	make clean
	cd graphics_kerrek1 && make clean
	cd sprites && make clean

###

clean:	
	rm -f *~ *.o *.lst KERREK1_LOADER KERREK1_CORE *.zx02

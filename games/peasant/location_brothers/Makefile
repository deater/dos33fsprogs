include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	BROTHERS_LOADER

###

BROTHERS_LOADER:	brothers_loader.o
	ld65 -o BROTHERS_LOADER brothers_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

brothers_loader.o:	brothers_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../gr_copy.s \
		../new_map_location.s ../keyboard.s \
		../text/DIALOG_BROTHERS.ZX02 \
		../text/dialog_brothers.inc \
		graphics_brothers/brothers_graphics.inc \
		sprites_brothers/archery_sprites.inc \
		BROTHERS_CORE.zx02
	ca65 -o brothers_loader.o brothers_loader.s -l brothers_loader.lst

###

BROTHERS_CORE.zx02:	BROTHERS_CORE
	$(ZX02) -f BROTHERS_CORE BROTHERS_CORE.zx02

BROTHERS_CORE:	brothers_core.o
	ld65 -o BROTHERS_CORE brothers_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

brothers_core.o:	brothers_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s borders.s \
		brothers_actions.s \
		../text/DIALOG_BROTHERS.ZX02 ../text/dialog_brothers.inc \
		graphics_brothers/brothers_graphics.inc \
		sprites_brothers/archery_sprites.inc
	ca65 -o brothers_core.o brothers_core.s -l brothers_core.lst


####

graphics_brothers/brothers_graphics.inc:
	cd graphics_brothers && make

sprites_brothers/archery_sprites.inc:
	cd sprites_brothers && make

###

distclean:
	make clean
	cd graphics_brothers && make clean
	cd sprites_brothers && make clean

###

clean:	
	rm -f *~ *.o *.lst BROTHERS_CORE BROTHERS_LOADER

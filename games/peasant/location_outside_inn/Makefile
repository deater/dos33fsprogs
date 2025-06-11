include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	OUTSIDE_INN_LOADER

###

OUTSIDE_INN_LOADER:	outside_inn_loader.o
	ld65 -o OUTSIDE_INN_LOADER outside_inn_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

outside_inn_loader.o:	outside_inn_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_OUTSIDE_INN.ZX02 \
		graphics_outside_inn/outside_inn_graphics.inc \
		graphics_outside_inn/outside_inn_priority.inc\
		../location_common/loader_common.s \
		OUTSIDE_INN_CORE.zx02
	ca65 -o outside_inn_loader.o outside_inn_loader.s -l outside_inn_loader.lst

###

OUTSIDE_INN_CORE.zx02:	OUTSIDE_INN_CORE
	$(ZX02) -f OUTSIDE_INN_CORE OUTSIDE_INN_CORE.zx02

OUTSIDE_INN_CORE:	outside_inn_core.o
	ld65 -o OUTSIDE_INN_CORE outside_inn_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

outside_inn_core.o:	outside_inn_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../gr_copy.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s \
		outside_inn_actions.s
	ca65 -o outside_inn_core.o outside_inn_core.s -l outside_inn_core.lst


###

graphics_outside_inn/outside_inn_graphics.inc:
	cd graphics_outside_inn && make

graphics_outside_inn/outside_inn_priority.inc:
	cd graphics_outside_inn && make

sprites_outside_inn/outside_inn_sprites.inc:
	cd sprites_outside_inn && make

###

distclean:
	make clean
	cd graphics_outside_inn && make clean
#	cd sprites && make clean

###

clean:	
	rm -f *~ *.o *.lst OUTSIDE_INN_LOADER OUTSIDE_INN_CORE *.zx02

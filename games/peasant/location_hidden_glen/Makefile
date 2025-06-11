include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	HIDDEN_GLEN_LOADER

###

HIDDEN_GLEN_LOADER:	hidden_glen_loader.o
	ld65 -o HIDDEN_GLEN_LOADER hidden_glen_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

hidden_glen_loader.o:	hidden_glen_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_HIDDEN_GLEN.ZX02 \
		graphics_hidden_glen/hidden_glen_graphics.inc \
		graphics_hidden_glen/hidden_glen_priority.inc\
		../location_common/loader_common.s \
		HIDDEN_GLEN_CORE.zx02
	ca65 -o hidden_glen_loader.o hidden_glen_loader.s -l hidden_glen_loader.lst

###

HIDDEN_GLEN_CORE.zx02:	HIDDEN_GLEN_CORE
	$(ZX02) -f HIDDEN_GLEN_CORE HIDDEN_GLEN_CORE.zx02

HIDDEN_GLEN_CORE:	hidden_glen_core.o
	ld65 -o HIDDEN_GLEN_CORE hidden_glen_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

hidden_glen_core.o:	hidden_glen_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../gr_copy.s ../hgr_routines/hgr_copy.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s \
		hidden_glen_actions.s
	ca65 -o hidden_glen_core.o hidden_glen_core.s -l hidden_glen_core.lst


###

graphics_hidden_glen/hidden_glen_graphics.inc:
	cd graphics_hidden_glen && make

graphics_hidden_glen/hidden_glen_priority.inc:
	cd graphics_hidden_glen && make

sprites_hidden_glen/hidden_glen_sprites.inc:
	cd sprites_hidden_glen && make

###

distclean:
	make clean
	cd graphics_hidden_glen && make clean
#	cd sprites && make clean

###

clean:	
	rm -f *~ *.o *.lst HIDDEN_GLEN_LOADER HIDDEN_GLEN_CORE *.zx02

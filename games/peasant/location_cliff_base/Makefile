include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	CLIFF_BASE_LOADER

###

CLIFF_BASE_LOADER:	cliff_base_loader.o
	ld65 -o CLIFF_BASE_LOADER cliff_base_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

cliff_base_loader.o:	cliff_base_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_CLIFF_BASE.ZX02 \
		graphics_cliff/cliff_graphics.inc \
		graphics_cliff/cliff_priority.inc\
		../location_common/loader_common.s \
		CLIFF_BASE_CORE.zx02
	ca65 -o cliff_base_loader.o cliff_base_loader.s -l cliff_base_loader.lst

###

CLIFF_BASE_CORE.zx02:	CLIFF_BASE_CORE
	$(ZX02) -f CLIFF_BASE_CORE CLIFF_BASE_CORE.zx02

CLIFF_BASE_CORE:	cliff_base_core.o
	ld65 -o CLIFF_BASE_CORE cliff_base_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

cliff_base_core.o:	cliff_base_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../gr_copy.s ../hgr_routines/hgr_copy.s \
		../new_map_location.s ../keyboard.s \
		../wait.s ../wait_a_bit.s \
		cliff_base_actions.s \
		../text/DIALOG_CLIFF_BASE.ZX02 ../text/dialog_cliff_base.inc \
		graphics_cliff/cliff_base_graphics.inc

	ca65 -o cliff_base_core.o cliff_base_core.s -l cliff_base_core.lst


###

graphics_cliff/cliff_base_graphics.inc:
	cd graphics_cliff && make

###

distclean:
	make clean
	cd graphics_cliff && make clean

###

clean:	
	rm -f *~ *.o *.lst CLIFF_BASE_LOADER CLIFF_BASE_CORE *.zx02

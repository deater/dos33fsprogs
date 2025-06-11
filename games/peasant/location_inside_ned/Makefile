include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	INSIDE_NED_LOADER

###

INSIDE_NED_LOADER:	inside_ned_loader.o
	ld65 -o INSIDE_NED_LOADER inside_ned_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

inside_ned_loader.o:	inside_ned_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_INSIDE_NED.ZX02 \
		graphics_inside_ned/inside_ned_graphics.inc \
		graphics_inside_ned/inside_ned_priority.inc\
		../location_common/loader_common.s \
		INSIDE_NED_CORE.zx02
	ca65 -o inside_ned_loader.o inside_ned_loader.s -l inside_ned_loader.lst

###

INSIDE_NED_CORE.zx02:	INSIDE_NED_CORE
	$(ZX02) -f INSIDE_NED_CORE INSIDE_NED_CORE.zx02

INSIDE_NED_CORE:	inside_ned_core.o
	ld65 -o INSIDE_NED_CORE inside_ned_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

inside_ned_core.o:	inside_ned_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../gr_copy.s ../hgr_routines/hgr_copy.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s \
		inside_ned_actions.s
	ca65 -o inside_ned_core.o inside_ned_core.s -l inside_ned_core.lst


###

graphics_inside_ned/inside_ned_graphics.inc:
	cd graphics_inside_ned && make

graphics_inside_ned/inside_ned_priority.inc:
	cd graphics_inside_ned && make

sprites_inside_ned/inside_ned_sprites.inc:
	cd sprites_inside_ned && make

###

distclean:
	make clean
	cd graphics_inside_ned && make clean
	cd sprites && make clean

###

clean:	
	rm -f *~ *.o *.lst INSIDE_NED_LOADER INSIDE_NED_CORE *.zx02

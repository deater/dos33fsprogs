include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	RIVER

###

RIVER:	river.o
	ld65 -o RIVER river.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

river.o:	river.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../gr_copy.s ../hgr_routines/hgr_copy.s \
		../new_map_location.s ../keyboard.s \
		../wait.s ../wait_a_bit.s \
		river_actions.s \
		../text/DIALOG_RIVER.ZX02 ../text/dialog_river.inc \
		graphics_river/river_graphics.inc \
		../sprites/peasant_sprites.inc
	ca65 -o river.o river.s -l river.lst

####

graphics_river/river_graphics.inc:
	cd graphics_river && make

###

distclean:
	make clean
	cd graphics_river && make clean

###

clean:	
	rm -f *~ *.o *.lst RIVER

include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	NED_COTTAGE_LOADER

###

NED_COTTAGE_LOADER:	ned_cottage_loader.o
	ld65 -o NED_COTTAGE_LOADER ned_cottage_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

ned_cottage_loader.o:	ned_cottage_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_NED_COTTAGE.ZX02 \
		graphics_ned_cottage/empty_hut_graphics.inc \
		graphics_ned_cottage/empty_hut_priority.inc \
		../location_common/loader_common.s \
		NED_COTTAGE_CORE.zx02
	ca65 -o ned_cottage_loader.o ned_cottage_loader.s -l ned_cottage_loader.lst

###

NED_COTTAGE_CORE.zx02:	NED_COTTAGE_CORE
	$(ZX02) -f NED_COTTAGE_CORE NED_COTTAGE_CORE.zx02

NED_COTTAGE_CORE:	ned_cottage_core.o
	ld65 -o NED_COTTAGE_CORE ned_cottage_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

ned_cottage_core.o:	ned_cottage_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s borders.s \
		../location_haystack/check_haystack.s \
		sprites_ned_cottage/ned_sprites.inc \
		sprites_ned_cottage/baby_sprites.inc \
		../location_haystack/check_haystack.s \
		../location_haystack/sprites_haystack/blown_away_sprite.inc \
		draw_door.s deploy_baby.s \
		ned_cottage_actions.s haystack_data.s
	ca65 -o ned_cottage_core.o ned_cottage_core.s -l ned_cottage_core.lst


###

graphics_ned_cottage/empty_hut_graphics.inc:
	cd graphics_ned_cottage && make

sprites_ned_cottage/ned_sprites.inc:
	cd sprites_ned_cottage && make

sprites_ned_cottage/baby_sprites.inc:
	cd sprites_ned_cottage && make

###

distclean:
	make clean
	cd graphics_ned_cottage && make clean
	cd sprites_ned_cottage && make clean

###

clean:	
	rm -f *~ *.o *.lst NED_COTTAGE_LOADER NED_COTTAGE_CORE *.zx02

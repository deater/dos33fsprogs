include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	KERREK_FALL_LOADER

###

KERREK_FALL_LOADER:	kerrek_fall_loader.o
	ld65 -o KERREK_FALL_LOADER kerrek_fall_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

kerrek_fall_loader.o:	kerrek_fall_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../location_common/loader_common.s \
		KERREK_FALL_CORE.zx02
	ca65 -o kerrek_fall_loader.o kerrek_fall_loader.s -l kerrek_fall_loader.lst

###

KERREK_FALL_CORE.zx02:	KERREK_FALL_CORE
	$(ZX02) -f KERREK_FALL_CORE KERREK_FALL_CORE.zx02

KERREK_FALL_CORE:	kerrek_fall_core.o
	ld65 -o KERREK_FALL_CORE kerrek_fall_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

kerrek_fall_core.o:	kerrek_fall_core.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s \
		../sound/kerrek_appear.s \
		draw_bow.s \
		kerrek_fall_actions.s \
		kerrek_sprite_list.s \
		draw_kerrek.s \
		move_kerrek.s \
		sprites_kerrek_fall/kerrek_walk_sprites.inc \
		sprites_kerrek_fall/peasant_shoot_sprites_left.inc \
		sprites_kerrek_fall/peasant_shoot_sprites_right.inc
	ca65 -o kerrek_fall_core.o kerrek_fall_core.s -l kerrek_fall_core.lst


###

sprites_kerrek_fall/kerrek_fall_sprites.inc:
	cd sprites_kerrek_fall && make

###

distclean:
	make clean
	cd sprites_kerrek_fall && make clean

###

clean:	
	rm -f *~ *.o *.lst KERREK_FALL_LOADER KERREK_FALL_CORE *.zx02

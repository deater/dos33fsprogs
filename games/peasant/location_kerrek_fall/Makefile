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
		KERREK_FALL_CORE.zx02 \
		shoot_left_sprites.zx02 shoot_right_sprites.zx02
	ca65 -o kerrek_fall_loader.o kerrek_fall_loader.s -l kerrek_fall_loader.lst

###

kerrek_hit_left_sprites.zx02:	kerrek_hit_left_sprites
	$(ZX02) -f kerrek_hit_left_sprites kerrek_hit_left_sprites.zx02

kerrek_hit_left_sprites:	kerrek_hit_left_sprites.o
	ld65 -o kerrek_hit_left_sprites kerrek_hit_left_sprites.o -C $(LINKER_SCRIPTS)/apple2_9200.inc

kerrek_hit_left_sprites.o:	kerrek_hit_left_sprites.s
	ca65 -o kerrek_hit_left_sprites.o kerrek_hit_left_sprites.s -l kerrek_hit_left_sprites.lst


###

kerrek_hit_right_sprites.zx02:	kerrek_hit_right_sprites
	$(ZX02) -f kerrek_hit_right_sprites kerrek_hit_right_sprites.zx02

kerrek_hit_right_sprites:	kerrek_hit_right_sprites.o
	ld65 -o kerrek_hit_right_sprites kerrek_hit_right_sprites.o -C $(LINKER_SCRIPTS)/apple2_9200.inc

kerrek_hit_right_sprites.o:	kerrek_hit_right_sprites.s
	ca65 -o kerrek_hit_right_sprites.o kerrek_hit_right_sprites.s -l kerrek_hit_right_sprites.lst

###

kerrek_walk_left_sprites.zx02:	kerrek_walk_left_sprites
	$(ZX02) -f kerrek_walk_left_sprites kerrek_walk_left_sprites.zx02

kerrek_walk_left_sprites:	kerrek_walk_left_sprites.o
	ld65 -o kerrek_walk_left_sprites kerrek_walk_left_sprites.o -C $(LINKER_SCRIPTS)/apple2_9e00.inc

kerrek_walk_left_sprites.o:	kerrek_walk_left_sprites.s
	ca65 -o kerrek_walk_left_sprites.o kerrek_walk_left_sprites.s -l kerrek_walk_left_sprites.lst


###

kerrek_walk_right_sprites.zx02:	kerrek_walk_right_sprites
	$(ZX02) -f kerrek_walk_right_sprites kerrek_walk_right_sprites.zx02

kerrek_walk_right_sprites:	kerrek_walk_right_sprites.o
	ld65 -o kerrek_walk_right_sprites kerrek_walk_right_sprites.o -C $(LINKER_SCRIPTS)/apple2_9e00.inc

kerrek_walk_right_sprites.o:	kerrek_walk_right_sprites.s
	ca65 -o kerrek_walk_right_sprites.o kerrek_walk_right_sprites.s -l kerrek_walk_right_sprites.lst



###

shoot_left_sprites.zx02:	shoot_left_sprites
	$(ZX02) -f shoot_left_sprites shoot_left_sprites.zx02

shoot_left_sprites:	shoot_left_sprites.o
	ld65 -o shoot_left_sprites shoot_left_sprites.o -C $(LINKER_SCRIPTS)/apple2_a800.inc

shoot_left_sprites.o:	shoot_left_sprites.s
	ca65 -o shoot_left_sprites.o shoot_left_sprites.s -l shoot_left_sprites.lst


###

shoot_right_sprites.zx02:	shoot_right_sprites
	$(ZX02) -f shoot_right_sprites shoot_right_sprites.zx02

shoot_right_sprites:	shoot_right_sprites.o
	ld65 -o shoot_right_sprites shoot_right_sprites.o -C $(LINKER_SCRIPTS)/apple2_a800.inc

shoot_right_sprites.o:	shoot_right_sprites.s
	ca65 -o shoot_right_sprites.o shoot_right_sprites.s -l shoot_right_sprites.lst


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
		draw_peasant_bow.s \
		load_shooting_sprites.s \
		kerrek_fall_actions.s \
		kerrek_sprite_list.s \
		draw_kerrek.s \
		move_kerrek.s \
		sprites_kerrek_fall/kerrek_walk_sprites_left.inc \
		sprites_kerrek_fall/kerrek_walk_sprites_right.inc \
		sprites_kerrek_fall/peasant_shoot_sprites_left.inc \
		sprites_kerrek_fall/peasant_shoot_sprites_right.inc \
		shoot_left_sprites.zx02 shoot_right_sprites.zx02 \
		kerrek_walk_left_sprites.zx02 kerrek_walk_right_sprites.zx02 \
		kerrek_hit_left_sprites.zx02 kerrek_hit_right_sprites.zx02
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

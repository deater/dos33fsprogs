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
		KERREK1_CORE.zx02 \
		peasant_belt_sprites.zx02 \
		peasant_belt_robe_sprites.zx02 \
		kerrek_body_left_sprites.zx02 kerrek_body_right_sprites.zx02
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
		../move_peasant_new.s ../draw_peasant_new.s \
		../new_map_location.s ../keyboard.s \
		../wait_a_bit.s borders.s \
		../sound/kerrek_appear.s \
		peasant_animations.s \
		kerrek_sprite_list.s \
		kerrek1_actions.s kerrek_actions.s \
		init_kerrek.s draw_kerrek.s draw_kerrek_body.s \
		move_kerrek.s draw_kerrek_smash.s \
		graphics_kerrek1/kerrek1_graphics.inc \
		sprites_kerrek1/kerrek_walk_sprites.inc
	ca65 -o kerrek1_core.o kerrek1_core.s -l kerrek1_core.lst


###

peasant_belt_sprites.zx02:	peasant_belt_sprites
	$(ZX02) -f peasant_belt_sprites peasant_belt_sprites.zx02

peasant_belt_sprites:	peasant_belt_sprites.o
	ld65 -o peasant_belt_sprites peasant_belt_sprites.o -C $(LINKER_SCRIPTS)/apple2_ab00.inc

peasant_belt_sprites.o:	peasant_belt_sprites.s sprites_kerrek1/peasant_belt.inc
	ca65 -o peasant_belt_sprites.o peasant_belt_sprites.s -l peasant_belt_sprites.lst

###

peasant_belt_robe_sprites.zx02:	peasant_belt_robe_sprites
	$(ZX02) -f peasant_belt_robe_sprites peasant_belt_robe_sprites.zx02

peasant_belt_robe_sprites:	peasant_belt_robe_sprites.o
	ld65 -o peasant_belt_robe_sprites peasant_belt_robe_sprites.o -C $(LINKER_SCRIPTS)/apple2_ab00.inc

peasant_belt_robe_sprites.o:	peasant_belt_robe_sprites.s sprites_kerrek1/peasant_belt.inc
	ca65 -o peasant_belt_robe_sprites.o peasant_belt_robe_sprites.s -l peasant_belt_robe_sprites.lst

###

kerrek_body_left_sprites.zx02:	kerrek_body_left_sprites
	$(ZX02) -f kerrek_body_left_sprites kerrek_body_left_sprites.zx02

kerrek_body_left_sprites:	kerrek_body_left_sprites.o
	ld65 -o kerrek_body_left_sprites kerrek_body_left_sprites.o -C $(LINKER_SCRIPTS)/apple2_e400.inc

kerrek_body_left_sprites.o:	kerrek_body_left_sprites.s sprites_kerrek1/peasant_belt.inc
	ca65 -o kerrek_body_left_sprites.o kerrek_body_left_sprites.s -l kerrek_body_left_sprites.lst


###

kerrek_body_right_sprites.zx02:	kerrek_body_right_sprites
	$(ZX02) -f kerrek_body_right_sprites kerrek_body_right_sprites.zx02

kerrek_body_right_sprites:	kerrek_body_right_sprites.o
	ld65 -o kerrek_body_right_sprites kerrek_body_right_sprites.o -C $(LINKER_SCRIPTS)/apple2_e400.inc

kerrek_body_right_sprites.o:	kerrek_body_right_sprites.s sprites_kerrek1/peasant_belt.inc
	ca65 -o kerrek_body_right_sprites.o kerrek_body_right_sprites.s -l kerrek_body_right_sprites.lst



###

graphics_kerrek1/kerrek1_graphics.inc:
	cd graphics_kerrek1 && make

sprites_kerrek1/kerrek1_sprites.inc:
	cd sprites_kerrek1 && make

###

distclean:
	make clean
	cd graphics_kerrek1 && make clean
	cd sprites_kerrek1 && make clean

###

clean:	
	rm -f *~ *.o *.lst KERREK1_LOADER KERREK1_CORE *.zx02

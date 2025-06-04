include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	INTRO

###

../graphics_peasantry/cottage.zx02:	
	cd ../graphics_peasantry && make

../sprites/peasant_sprites.inc:	
	cd ../sprites && make


../sprites_peasant/walking_sprites.zx02:	
	cd ../sprites_peasant && make

###


INTRO:	intro.o
	ld65 -o INTRO intro.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

intro.o:	intro.s ../zp.inc ../qload.inc ../music/music.inc \
		../peasant_sprite.inc \
		../graphics_peasantry/cottage.zx02 \
		../graphics_peasantry/lake_w.zx02 \
		../graphics_peasantry/lake_e.zx02 \
		../location_river/graphics_river/river.zx02 \
		../location_knight/graphics_knight/knight.zx02 \
		../graphics_peasantry/cottage_priority.zx02 \
		../graphics_peasantry/lake_w_priority.zx02 \
		../graphics_peasantry/lake_e_priority.zx02 \
		../location_river/graphics_river/river_priority.zx02 \
		../location_knight/graphics_knight/knight_priority.zx02 \
		../sprites_peasant/walking_sprites.zx02 \
		../sprites/peasant_sprites.inc \
		../sprites/bubble_sprites_e.inc \
		../sprites/bubble_sprites_w.inc \
		../sprites/river_bubble_sprites.inc \
		../text/intro.inc \
		../animate_river.s \
		../animate_bubbles.s \
		../draw_box.s ../hgr_routines/hgr_rectangle.s ../hgr_routines/hgr_font.s ../hgr_routines/hgr_input.s \
		../hgr_routines/hgr_save_restore.s \
		../hgr_routines/hgr_partial_save.s \
		../hgr_routines/hgr_sprite_bg_mask.s \
		../wait_a_bit.s ../draw_peasant_new.s ../hgr_routines/hgr_text_box.s \
		intro_cottage.s intro_lake_w.s intro_lake_e.s \
		intro_river.s intro_knight.s \
		new_game.s
	ca65 -o intro.o intro.s -l intro.lst

###

distclean:	
	make clean

#####

clean:	
	rm -f *~ *.o *.lst INTRO


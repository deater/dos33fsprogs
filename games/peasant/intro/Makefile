include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	INTRO

###

INTRO:	intro.o
	ld65 -o INTRO intro.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

intro.o:	intro.s ../zp.inc ../qload.inc ../music/music.inc \
		../graphics_peasantry/cottage.zx02 \
		../graphics_peasantry/lake_w.zx02 \
		../graphics_peasantry/lake_e.zx02 \
		../graphics_peasantry/river.zx02 \
		../graphics_peasantry/knight.zx02 \
		../graphics_peasantry/cottage_priority.zx02 \
		../graphics_peasantry/lake_w_priority.zx02 \
		../graphics_peasantry/lake_e_priority.zx02 \
		../graphics_peasantry/river_priority.zx02 \
		../graphics_peasantry/knight_priority.zx02 \
		../sprites/peasant_sprites.inc \
		../sprites/bubble_sprites_e.inc \
		../sprites/bubble_sprites_w.inc \
		../sprites/river_bubble_sprites.inc \
		../text/intro.inc \
		../animate_river.s \
		../animate_bubbles.s \
		../draw_box.s ../hgr_rectangle.s ../hgr_font.s ../hgr_input.s \
		../hgr_save_restore.s \
		../hgr_partial_save.s \
		../hgr_sprite_bg_mask.s \
		../wait_a_bit.s ../draw_peasant_new.s ../hgr_text_box.s \
		intro_cottage.s intro_lake_w.s intro_lake_e.s \
		intro_river.s intro_knight.s \
		new_game.s
	ca65 -o intro.o intro.s -l intro.lst

###

clean:	
	rm -f *~ *.o *.lst INTRO


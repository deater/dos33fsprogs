include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	INTRO

###

INTRO:	intro.o
	ld65 -o INTRO intro.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

intro.o:	intro.s ../zp.inc ../qload.inc ../music.inc \
		../graphics_peasantry/graphics_intro.inc \
		../graphics_peasantry/priority_intro.inc \
		../sprites/peasant_sprites.inc \
		../sprites/bubble_sprites_e.inc \
		../sprites/bubble_sprites_w.inc \
		../sprites/river_bubble_sprites.inc \
		../text/intro.inc \
		../animate_river.s \
		../animate_bubbles.s \
		../draw_box.s ../hgr_rectangle.s ../hgr_font.s ../hgr_input.s \
		../hgr_1x28_sprite_mask.s ../hgr_save_restore.s \
		../hgr_partial_save.s \
		../wait_a_bit.s ../draw_peasant.s ../hgr_text_box.s \
		../title.s ../directions.s \
		intro_cottage.s intro_lake_w.s intro_lake_e.s \
		intro_river.s intro_knight.s \
		new_game.s
	ca65 -o intro.o intro.s -l intro.lst

###

clean:	
	rm -f *~ *.o *.lst INTRO


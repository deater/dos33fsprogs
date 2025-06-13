include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	ENDING

###

sprites/ending_sprites.inc:	
	cd sprites && make

###


ENDING:	ending.o
	ld65 -o ENDING ending.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

ending.o:	ending.s \
		../zp.inc ../qload.inc ../music/music.inc \
		graphics_end/ending_graphics.inc \
		../sprites/peasant_sprites.inc \
		sprites/ending_sprites.inc \
		../hgr_routines/hgr_draw_box.s \
		../hgr_routines/hgr_rectangle.s \
		../hgr_routines/hgr_font.s \
		../hgr_routines/hgr_input.s \
		../hgr_routines/hgr_2x14_sprite_mask.s \
		../hgr_routines/hgr_sprite.s ../hgr_routines/hgr_save_restore.s \
		../wait_a_bit.s ../hgr_routines/hgr_text_box.s \
		../keyboard.s ../new_map_location.s \
		../score.s ../inventory/inventory.inc

	ca65 -o ending.o ending.s -l ending.lst


###

graphics_end/ending_graphics.inc:
	cd graphics_end && make

###

distclean:
	make clean
	cd sprites && make clean
	cd graphics_end && make clean

###

clean:	
	rm -f *~ *.o *.lst ENDING


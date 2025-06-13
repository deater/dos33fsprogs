include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	TROGDOR

###

TROGDOR:	trogdor.o
	ld65 -o TROGDOR trogdor.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

trogdor.o:	trogdor.s ../zp.inc \
		graphics_trogdor/trogdor_graphics.inc sprites/trogdor_sprites.inc \
		../text/DIALOG_TROGDOR.ZX02 ../text/dialog_trogdor.inc \
		../ssi263/ssi263_simple_speech.s \
		../draw_box.s ../hgr_routines/hgr_rectangle.s ../hgr_routines/hgr_font.s ../hgr_routines/hgr_input.s \
		../hgr_routines/hgr_save_restore.s \
		../wait_a_bit.s ../hgr_routines/hgr_text_box.s \
		draw_peasant_tiny.s \
		../keyboard.s ../new_map_location.s \
		move_peasant_tiny.s ../score.s ../inventory/inventory.inc \
		trogdor_actions.s

	ca65 -o trogdor.o trogdor.s -l trogdor.lst


####

graphics_trogdor/trogdor_graphics.inc:
	cd graphics_trogdor && make

sprites/trogdor_sprites.inc:
	cd sprites && make

#####

distclean:
	make clean
	cd graphics_trogdor && make clean
	cd sprites && make clean
###

clean:	
	rm -f *~ *.o *.lst TROGDOR

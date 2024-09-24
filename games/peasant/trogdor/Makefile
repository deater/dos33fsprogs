include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	TROGDOR

###

TROGDOR:	trogdor.o
	ld65 -o TROGDOR trogdor.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

trogdor.o:	trogdor.s ../zp.inc \
		graphics_trogdor/trogdor_graphics.inc sprites/trogdor_sprites.inc \
		DIALOG_TROGDOR.ZX02 ../dialog_trogdor.inc \
		../ssi263/ssi263_simple_speech.s \
		../draw_box.s ../hgr_rectangle.s ../hgr_font.s ../hgr_input.s \
		../hgr_save_restore.s \
		../wait_a_bit.s ../draw_peasant.s ../hgr_text_box.s \
		draw_peasant_tiny.s \
		../keyboard.s ../new_map_location.s \
		move_peasant_tiny.s ../score.s ../inventory/inventory.inc \
		trogdor_actions.s

	ca65 -o trogdor.o trogdor.s -l trogdor.lst


####

DIALOG_TROGDOR.ZX02:	dialog_trogdor
	$(ZX02) -f  dialog_trogdor DIALOG_TROGDOR.ZX02

dialog_trogdor:	dialog_trogdor.o
	ld65 -o dialog_trogdor dialog_trogdor.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_trogdor.o:	dialog_trogdor.s ../text/trogdor.inc
	ca65 -o dialog_trogdor.o dialog_trogdor.s -l dialog_trogdor.lst

###

dialog_trogdor.inc:	../generate_all_symbols dialog_trogdor
	../generate_all_symbols -a 0xd000 dialog_trogdor.lst > dialog_trogdor.inc

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
	rm -f *~ *.o *.lst TROGDOR *.ZX02 dialog_trogdor.inc

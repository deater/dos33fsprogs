include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	MAP

###

MAP:	map.o
	ld65 -o MAP map.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

map.o:	map.s ../zp.inc ../inventory/inventory.inc \
		../parse_input.inc \
		graphics_map/map_graphics.inc \
		../draw_box.s ../hgr_rectangle.s ../hgr_font.s ../hgr_input.s \
		../hgr_1x28_sprite_mask.s ../hgr_save_restore.s \
		../wait_a_bit.s ../draw_peasant.s ../hgr_text_box.s \
		../keyboard.s ../new_map_location.s \
		../move_peasant.s ../score.s
	ca65 -o map.o map.s -l map.lst

###

graphics_map/map_graphics.inc:
	cd graphics_map && make

###

distclean:
	make clean
	cd graphics_archery && make clean
	cd graphics_map && make clean

###

clean:	
	rm -f *~ *.o *.lst MAP


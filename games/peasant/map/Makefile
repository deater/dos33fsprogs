include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	MAP

###

MAP:	map.o
	ld65 -o MAP map.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

#		../hgr_routines/hgr_1x28_sprite_mask.s 

map.o:	map.s ../zp.inc ../inventory/inventory.inc \
		../parse_input.inc \
		graphics_map/map_graphics.inc \
		../hgr_routines/hgr_draw_box.s \
		../hgr_routines/hgr_rectangle.s \
		../hgr_routines/hgr_font.s \
		../hgr_routines/hgr_input.s \
		../wait_a_bit.s ../hgr_routines/hgr_text_box.s \
		../keyboard.s ../new_map_location.s \
		sprites_map/map_sprites.inc
	ca65 -o map.o map.s -l map.lst

###

graphics_map/map_graphics.inc:
	cd graphics_map && make

sprites_map/map_sprites.inc:
	cd sprites_map && make

###

distclean:
	make clean
	cd graphics_map && make clean
	cd sprites_map && make clean

###

clean:	
	rm -f *~ *.o *.lst MAP


include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	OUTER

####

OUTER:	outer.o
	ld65 -o OUTER outer.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

outer.o:	outer.s \
		../zp.inc ../hardware.inc ../qload.inc ../version.inc \
		../inventory/inventory.inc \
		../parse_input.inc ../common_defines.inc \
		outer_actions.s \
		../text/DIALOG_OUTER.ZX02 ../text/dialog_outer.inc \
		graphics_outer/outer_graphics.inc \
		graphics_outer/outer_priority.inc \
		sprites_outer/ron_sprites.inc \
		sprites_outer/keeper1_sprites.inc \
		sprites_outer/keeper2_sprites.inc \
		sprites_outer/guitar_sprites.inc \
		../sprites_peasant/robe_sprites.zx02 \
		../draw_peasant.s ../move_peasant.s \
		../gr_copy.s ../hgr_routines/hgr_copy.s \
		../new_map_location.s \
		../keyboard.s \
		../wait.s ../wait_a_bit.s
	ca65 -o outer.o outer.s -l outer.lst

###

graphics_outer/outer_graphics.inc:
	cd graphics_outer && make

###

sprites_outer/ron_sprites.inc:
	cd sprites_outer && make

###

distclean:
	make clean
	cd graphics_outer && make clean
	cd sprites_outer && make clean

###

clean:	
	rm -f *~ *.o *.lst OUTER

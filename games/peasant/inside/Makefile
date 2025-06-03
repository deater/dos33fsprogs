include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	INSIDE

###

INSIDE:	inside.o
	ld65 -o INSIDE inside.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

inside.o:	inside.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		inside_actions.s \
		../text/DIALOG_INSIDE.ZX02 ../text/dialog_inside.inc \
		graphics_inside/graphics_inside.inc \
		graphics_inside/priority_inside.inc \
		../sprites/peasant_sprites.inc \
		../move_peasant.s ../draw_peasant.s \
		../gr_copy.s ../hgr_routines/hgr_copy.s \
		../new_map_location.s \
		../keyboard.s \
		../wait.s ../wait_a_bit.s
	ca65 -o inside.o inside.s -l inside.lst

####

graphics_inside/graphics_inside.inc:
	cd graphics_inside && make
###

distclean:
	make clean
	cd graphics_inside && make clean

###

clean:	
	rm -f *~ *.o *.lst INSIDE

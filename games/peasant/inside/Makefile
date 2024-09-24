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
		inside_actions.s DIALOG_INSIDE.ZX02 dialog_inside.inc \
		graphics_inside/graphics_inside.inc \
		graphics_inside/priority_inside.inc \
		../sprites/peasant_sprites.inc \
		../move_peasant.s ../draw_peasant.s \
		../gr_copy.s ../hgr_copy.s \
		../new_map_location.s \
		../keyboard.s \
		../wait.s ../wait_a_bit.s
	ca65 -o inside.o inside.s -l inside.lst

###

DIALOG_INSIDE.ZX02:	dialog_inside
	$(ZX02) -f  dialog_inside DIALOG_INSIDE.ZX02

dialog_inside:	dialog_inside.o
	ld65 -o dialog_inside dialog_inside.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_inside.o:	dialog_inside.s ../text/inside.inc.lookup
	ca65 -o dialog_inside.o dialog_inside.s -l dialog_inside.lst

###

dialog_inside.inc:	../generate_all_symbols dialog_inside
	../generate_all_symbols -a 0xd000 dialog_inside.lst > dialog_inside.inc

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

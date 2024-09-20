include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	CLIFF

####

CLIFF:	cliff.o
	ld65 -o CLIFF cliff.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

cliff.o:	cliff.s \
		../zp.inc ../hardware.inc ../qload.inc ../version.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		cliff_actions.s \
		../DIALOG_CLIFF.ZX02 ../dialog_cliff.inc \
		graphics_cliff/cliff_graphics.inc \
		graphics_cliff/priority_cliff.inc \
		../sprites/peasant_sprites.inc \
		../draw_peasant.s ../move_peasant.s \
		../gr_copy.s ../hgr_copy.s \
		../new_map_location.s \
		../keyboard.s \
		../wait.s ../wait_a_bit.s
	ca65 -o cliff.o cliff.s -l cliff.lst

###

graphics_cliff/cliff_graphics.inc:
	cd graphics_cliff && make

###

distclean:
	make clean
	cd graphics_cliff && make clean

###

clean:	
	rm -f *~ *.o *.lst CLIFF


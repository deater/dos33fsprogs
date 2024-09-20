include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	ARCHERY

###

ARCHERY:	archery.o
	ld65 -o ARCHERY archery.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

archery.o:	archery.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		graphics_archery/archery_graphics.inc \
		../new_map_location.s \
		../wait.s ../wait_a_bit.s
	ca65 -o archery.o archery.s -l archery.lst


####

graphics_archery/archery_graphics.inc:
	cd graphics_archery && make

###

distclean:
	make clean
	cd graphics_archery && make clean
###

clean:	
	rm -f *~ *.o *.lst ARCHERY


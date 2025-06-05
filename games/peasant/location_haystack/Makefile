include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	HAYSTACK

###

HAYSTACK:	haystack.o
	ld65 -o HAYSTACK haystack.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

haystack.o:	haystack.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../gr_copy.s ../hgr_routines/hgr_copy.s \
		../new_map_location.s ../keyboard.s \
		../wait.s ../wait_a_bit.s \
		haystack_actions.s \
		../text/DIALOG_HAYSTACK.ZX02 ../text/dialog_haystack.inc \
		graphics_haystack/haystack_graphics.inc
	ca65 -o haystack.o haystack.s -l haystack.lst

####

graphics_haystack/haystack_graphics.inc:
	cd graphics_haystack && make

###

distclean:
	make clean
	cd graphics_haystack && make clean

###

clean:	
	rm -f *~ *.o *.lst HAYSTACK

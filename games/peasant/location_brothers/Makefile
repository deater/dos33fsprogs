include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	BROTHERS

###

BROTHERS:	brothers.o
	ld65 -o BROTHERS brothers.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

brothers.o:	brothers.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../location_common/flame_common.s \
		../location_common/include_common.s \
		../location_common/init_common.s \
		../move_peasant_new.s ../draw_peasant_new.s \
		../gr_copy.s ../hgr_routines/hgr_copy.s \
		../new_map_location.s ../keyboard.s \
		../wait.s ../wait_a_bit.s \
		brothers_actions.s \
		../text/DIALOG_BROTHERS.ZX02 ../text/dialog_brothers.inc \
		graphics_brothers/brothers_graphics.inc \
		sprites/archery_sprites.inc
	ca65 -o brothers.o brothers.s -l brothers.lst

####

graphics_brothers/brothers_graphics.inc:
	cd graphics_brothers && make

###

distclean:
	make clean
	cd graphics_brothers && make clean

###

clean:	
	rm -f *~ *.o *.lst BROTHERS

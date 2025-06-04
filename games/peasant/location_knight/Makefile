include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	KNIGHT

###

KNIGHT:	knight.o
	ld65 -o KNIGHT knight.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

knight.o:	knight.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../move_peasant.s ../draw_peasant.s \
		../gr_copy.s ../hgr_routines/hgr_copy.s \
		../new_map_location.s ../keyboard.s \
		../wait.s ../wait_a_bit.s \
		knight_actions.s \
		../text/DIALOG_KNIGHT.ZX02 ../text/dialog_knight.inc \
		graphics_knight/knight_graphics.inc \
		../sprites/peasant_sprites.inc
	ca65 -o knight.o knight.s -l knight.lst

####

knight_graphics/knight_graphics.inc:
	cd knight_graphcis && make

###

distclean:
	make clean
	cd graphics_knight && make clean

###

clean:	
	rm -f *~ *.o *.lst KNIGHT

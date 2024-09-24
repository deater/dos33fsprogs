include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
LINKER_SCRIPTS = ../../../linker_scripts

all:	CLIFF_BASE

####

CLIFF_BASE:	cliff_base.o
	ld65 -o CLIFF_BASE cliff_base.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

cliff_base.o:	cliff_base.s \
		../zp.inc ../hardware.inc ../qload.inc ../version.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		cliff_actions.s \
		DIALOG_CLIFF_BASE.ZX02 dialog_cliff_base.inc \
		graphics_cliff/cliff_graphics.inc \
		graphics_cliff/priority_cliff.inc \
		../sprites/peasant_sprites.inc \
		../draw_peasant.s ../move_peasant.s \
		../gr_copy.s ../hgr_copy.s \
		../new_map_location.s \
		../keyboard.s \
		../wait.s ../wait_a_bit.s
	ca65 -o cliff_base.o cliff_base.s -l cliff_base.lst

###

DIALOG_CLIFF_BASE.ZX02:	dialog_cliff_base
	$(ZX02) -f  dialog_cliff_base DIALOG_CLIFF_BASE.ZX02

dialog_cliff_base:   dialog_cliff_base.o
	ld65 -o dialog_cliff_base dialog_cliff_base.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_cliff_base.o:	dialog_cliff_base.s ../text/cliff.inc
	ca65 -o dialog_cliff_base.o dialog_cliff_base.s -l dialog_cliff_base.lst

###

dialog_cliff_base.inc:	../generate_all_symbols dialog_cliff_base
	../generate_all_symbols -a 0xd000 dialog_cliff_base.lst > dialog_cliff_base.inc

###

graphics_cliff/cliff_graphics.inc:
	cd graphics_cliff && make

###

distclean:
	make clean
	cd graphics_cliff && make clean

###

clean:	
	rm -f *~ *.o *.lst CLIFF_BASE


include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	INN

###

INN:	inn.o
	ld65 -o INN inn.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

inn.o:	inn.s ../zp.inc ../hardware.inc ../qload.inc \
		../inventory/inventory.inc \
		../parse_input.inc \
		../move_peasant.s ../draw_peasant.s \
		../gr_copy.s ../hgr_copy.s \
		../new_map_location.s ../keyboard.s \
		../wait.s ../wait_a_bit.s \
		inn_actions.s DIALOG_INN.ZX02 dialog_inn.inc \
		graphics_inn/graphics_inn.inc ../sprites/peasant_sprites.inc \
		graphics_inn/priority_inn.inc
	ca65 -o inn.o inn.s -l inn.lst

###

DIALOG_INN.ZX02:	dialog_inn
	$(ZX02) -f  dialog_inn DIALOG_INN.ZX02

dialog_inn:	dialog_inn.o
	ld65 -o dialog_inn dialog_inn.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_inn.o:	dialog_inn.s ../text/inn.inc.lookup
	ca65 -o dialog_inn.o dialog_inn.s -l dialog_inn.lst

###

dialog_inn.inc:	../generate_all_symbols dialog_inn
	../generate_all_symbols -a 0xd000 dialog_inn.lst > dialog_inn.inc

####

graphics_inn/graphics_inn.inc:
	cd graphics_inn && make

###

distclean:
	make clean
	cd graphics_inn && make clean

###

clean:	
	rm -f *~ *.o *.lst INN

include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	inventory.inc

###

inventory.inc:	../generate_common INVENTORY
	../generate_common -a 0xd000 -s show_inventory inventory.lst > inventory.inc

###

INVENTORY:	inventory.o
	ld65 -o INVENTORY inventory.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

inventory.o:	inventory.s \
		../text/invenory.inc.lookup \
		sprites/inventory_sprites.inc \
		../hgr_routines/hgr_2x16_sprite.s
	ca65 -o inventory.o inventory.s -l inventory.lst


###

../text/invenory.inc.lookup:
	cd ../text && make

###

sprites/inventory_sprites.inc:
	cd sprites && make

###

distclean:
	make clean
	cd sprites && make clean

###

clean:	
	rm -f *~ *.o *.lst INVENTORY inventory.inc

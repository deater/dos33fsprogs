include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	TROGDOR2_LOADER

###

TROGDOR2_LOADER:	trogdor2_loader.o
	ld65 -o TROGDOR2_LOADER trogdor2_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

trogdor2_loader.o:	trogdor2_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_TROGDOR2.ZX02 \
		graphics_trogdor2/trogdor2_bg.inc \
		sprites_trogdor2/trogdor2_sprites.inc \
		TROGDOR2_CORE.zx02
	ca65 -o trogdor2_loader.o trogdor2_loader.s -l trogdor2_loader.lst

####

TROGDOR2_CORE.zx02:	TROGDOR2_CORE
	$(ZX02) -f TROGDOR2_CORE TROGDOR2_CORE.zx02

TROGDOR2_CORE:	trogdor2_core.o
	ld65 -o TROGDOR2_CORE trogdor2_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

trogdor2_core.o:	trogdor2_core.s \
		../zp.inc ../hardware.inc ../qload.inc ../version.inc \
		../inventory/inventory.inc \
		../parse_input.inc ../common_defines.inc \
		trogdor2_actions.s \
		graphics_trogdor2/trogdor2_graphics.inc \
		../text/DIALOG_TROGDOR2.ZX02 ../text/dialog_trogdor2.inc \
                ../wait_a_bit.s borders.s
	ca65 -o trogdor2_core.o trogdor2_core.s -l trogdor2_core.lst

####

graphics_trogdor2/trogdor2_bg.inc:
	cd graphics_trogdor2 && make

graphics_trogdor2/trogdor2_graphics.inc:
	cd graphics_trogdor2 && make

sprites_trogdor2/trogdor2_sprites.inc:
	cd sprites_trogdor2 && make

#####

distclean:
	make clean
	cd graphics_trogdor2 && make clean
	cd sprites_trogdor2 && make clean
###

clean:	
	rm -f *~ *.o *.lst TROGDOR2_CORE TROGDOR2_LOADER *.zx02

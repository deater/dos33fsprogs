include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	TROGDOR_LOADER

###

TROGDOR_LOADER:	trogdor_loader.o
	ld65 -o TROGDOR_LOADER trogdor_loader.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

trogdor_loader.o:	trogdor_loader.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../priority_copy.s \
		../text/DIALOG_TROGDOR.ZX02 \
		graphics_trogdor/trogdor_bg.inc \
		sprites/trogdor_sprites.inc \
		TROGDOR_CORE.zx02
	ca65 -o trogdor_loader.o trogdor_loader.s -l trogdor_loader.lst

####

TROGDOR_CORE.zx02:	TROGDOR_CORE
	$(ZX02) -f TROGDOR_CORE TROGDOR_CORE.zx02

TROGDOR_CORE:	trogdor_core.o
	ld65 -o TROGDOR_CORE trogdor_core.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

trogdor_core.o:	trogdor_core.s \
		../zp.inc ../hardware.inc ../qload.inc ../version.inc \
		../inventory/inventory.inc \
		../parse_input.inc ../common_defines.inc \
		trogdor_actions.s \
		graphics_trogdor/trogdor_graphics.inc \
		../text/DIALOG_TROGDOR.ZX02 ../text/dialog_trogdor.inc \
                ../wait_a_bit.s borders.s
	ca65 -o trogdor_core.o trogdor_core.s -l trogdor_core.lst

####

graphics_trogdor/trogdor_bg.inc:
	cd graphics_trogdor && make

graphics_trogdor/trogdor_graphics.inc:
	cd graphics_trogdor && make

sprites/trogdor_sprites.inc:
	cd sprites && make

#####

distclean:
	make clean
	cd graphics_trogdor && make clean
	cd sprites && make clean
###

clean:	
	rm -f *~ *.o *.lst TROGDOR_CORE TROGDOR_LOADER *.zx02

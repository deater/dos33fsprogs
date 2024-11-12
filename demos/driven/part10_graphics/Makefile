include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/

all:	GRAPHICS

###

GRAPHICS:	graphics.o
	ld65 -o GRAPHICS graphics.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

graphics.o:	graphics.s \
	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc \
	graphics/floater_wide_steffest.hgr.zx02 \
	graphics/atrus_light_iipix.hgr.zx02 \
	graphics/a2_atrus.hgr.zx02 \
	graphics/riven_233.aux.zx02 \
	graphics/riven_233.bin.zx02 \
	wipes/fx.hgr.center.by.pixel.s \
	wipes/fx.hgr.fizzle.s
	ca65 -o graphics.o graphics.s -l graphics.lst

###

graphics/a2_atrus.hgr.zx02:	
	cd graphics && make

graphics/atrus_light_iipix.hgr.zx02:
	cd graphics && make

graphics/floater_wide_steffest.hgr.zx02:	
	cd graphics && make

###

clean:
	rm -f *~ *.o *.lst GRAPHICS


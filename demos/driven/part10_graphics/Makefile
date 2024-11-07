include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/

all:	GRAPHICS

###

GRAPHICS:	graphics.o
	ld65 -o GRAPHICS graphics.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

graphics.o:	graphics.s \
	../zp.inc ../hardware.inc ../qload.inc \
	graphics/floater_wide_steffest.hgr.zx02
	ca65 -o graphics.o graphics.s -l graphics.lst

###

graphics/floater_wide_steffest.hgr.zx02:	
	cd graphics && make

###

clean:
	rm -f *~ *.o *.lst GRAPHICS


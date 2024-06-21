include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK40 LEVEL_MAGLEV LEVEL_OUTSIDE

###

DISK40:	disk40.o
	ld65 -o DISK40 disk40.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk40.o:	disk40.s ../zp.inc
	ca65 -o disk40.o disk40.s -l disk40.lst

####

LEVEL_MAGLEV:	level_maglev.o
	ld65 -o LEVEL_MAGLEV level_maglev.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_maglev.o:	level_maglev.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk40_defines.inc \
		leveldata_maglev.inc \
		graphics_maglev/maglev_graphics.inc
	ca65 -o level_maglev.o level_maglev.s -l level_maglev.lst


####

LEVEL_OUTSIDE:	level_outside.o
	ld65 -o LEVEL_OUTSIDE level_outside.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_outside.o:	level_outside.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk40_defines.inc \
		leveldata_outside.inc \
		graphics_outside/outside_graphics.inc
	ca65 -o level_outside.o level_outside.s -l level_outside.lst


####

graphics_maglev/maglev_graphics.inc:
	cd graphics_maglev && make

graphics_outside/outside_graphics.inc:
	cd graphics_outside && make
####

clean:		
	rm -f *~ *.o *.lst \
		LEVEL_MAGLEV LEVEL_OUTSIDE


####

distclean:
	rm -f *~ *.o *.lst \
		LEVEL_MAGLEV LEVEL_OUTSIDE
	cd graphics_maglev && make clean
	cd graphics_outside && make clean



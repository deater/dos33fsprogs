include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK03 LEVEL_DOWNSTEPS LEVEL_OUTSIDE

####

DISK03:	disk03.o
	ld65 -o DISK03 disk03.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk03.o:	disk03.s ../zp.inc
	ca65 -o disk03.o disk03.s -l disk03.lst

####

LEVEL_OUTSIDE:	level_outside.o
	ld65 -o LEVEL_OUTSIDE level_outside.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_outside.o:	level_outside.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk03_defines.inc \
		leveldata_outside.inc \
		graphics_outside/outside_graphics.inc
	ca65 -o level_outside.o level_outside.s -l level_outside.lst

####

LEVEL_DOWNSTEPS:	level_downsteps.o
	ld65 -o LEVEL_DOWNSTEPS level_downsteps.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_downsteps.o:	level_downsteps.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk03_defines.inc \
		leveldata_downsteps.inc \
		graphics_downsteps/downsteps_graphics.inc
	ca65 -o level_downsteps.o level_downsteps.s -l level_downsteps.lst

####

graphics_outside/outside_graphics.inc:
	cd graphics_outside && make

graphics_downsteps/downsteps_graphics.inc:
	cd graphics_downsteps && make

####

clean:		
	rm -f *~ *.o *.lst DISK03 \
		LEVEL_OUTSIDE LEVEL_DOWNSTEPS

####

distclean:
	rm -f *~ *.o *.lst DISK03 \
		LEVEL_OUTSIDE LEVEL_DOWNSTEPS
	cd graphics_outside && make clean
	cd graphics_downsteps && make clean




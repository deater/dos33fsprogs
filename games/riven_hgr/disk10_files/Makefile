include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK10 LEVEL_INSIDE

####

DISK10:	disk10.o
	ld65 -o DISK10 disk10.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk10.o:	disk10.s ../zp.inc
	ca65 -o disk10.o disk10.s -l disk10.lst

####

LEVEL_INSIDE:	level_inside.o
	ld65 -o LEVEL_INSIDE level_inside.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_inside.o:	level_inside.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk10_defines.inc \
		leveldata_inside.inc \
		graphics_inside/inside_graphics.inc \
		graphics_stained/stained_graphics.inc
	ca65 -o level_inside.o level_inside.s -l level_inside.lst

####

graphics_inside/inside_graphics.inc:
	cd graphics_inside && make

graphics_stained/stained_graphics.inc:
	cd graphics_stained && make

####

clean:		
	rm -f *~ *.o *.lst DISK10 \
		LEVEL_INSIDE


####

distclean:
	rm -f *~ *.o *.lst DISK10 \
		LEVEL_INSIDE
	cd graphics_inside && make clean

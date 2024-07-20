include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK50 LEVEL_START

####

DISK50:	disk50.o
	ld65 -o DISK50 disk50.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk50.o:	disk50.s ../zp.inc
	ca65 -o disk50.o disk50.s -l disk50.lst

####

LEVEL_START:	level_start.o
	ld65 -o LEVEL_START level_start.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_start.o:	level_start.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk50_defines.inc \
		leveldata_start.inc \
		graphics_start/start_graphics.inc
	ca65 -o level_start.o level_start.s -l level_start.lst

####

graphics_start/start_graphics.inc:
	cd graphics_start && make

####

clean:		
	rm -f *~ *.o *.lst \
		LEVEL_START

####

distclean:
	rm -f *~ *.o *.lst \
		LEVEL_START
	cd graphics_start && make clean




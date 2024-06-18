include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	LEVEL_ARRIVAL


LEVEL_ARRIVAL:	level_arrival.o
	ld65 -o LEVEL_ARRIVAL level_arrival.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_arrival.o:	level_arrival.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk01_defines.inc \
		leveldata_arrival.inc \
		graphics_arrival/arrival_graphics.inc
	ca65 -o level_arrival.o level_arrival.s -l level_arrival.lst

####

graphics_arrival/arrival_graphics.inc:
	cd graphics_arrival && make

####

clean:		
	rm -f *~ *.o *.lst \
		LEVEL_ARRIVAL

####

distclean:
	rm -f *~ *.o *.lst \
		LEVEL_ARRIVAL
	cd graphics_arrival && make clean


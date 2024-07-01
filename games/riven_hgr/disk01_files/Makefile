include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK01 LEVEL_ARRIVAL LEVEL_TELESCOPE

####

DISK01:	disk01.o
	ld65 -o DISK01 disk01.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk01.o:	disk01.s ../zp.inc
	ca65 -o disk01.o disk01.s -l disk01.lst

####

LEVEL_ARRIVAL:	level_arrival.o
	ld65 -o LEVEL_ARRIVAL level_arrival.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_arrival.o:	level_arrival.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk01_defines.inc \
		leveldata_arrival.inc \
		graphics_arrival/arrival_graphics.inc
	ca65 -o level_arrival.o level_arrival.s -l level_arrival.lst

####

LEVEL_TELESCOPE:	level_telescope.o
	ld65 -o LEVEL_TELESCOPE level_telescope.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_telescope.o:	level_telescope.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk01_defines.inc \
		leveldata_telescope.inc \
		graphics_telescope/telescope_graphics.inc
	ca65 -o level_telescope.o level_telescope.s -l level_telescope.lst


####

graphics_arrival/arrival_graphics.inc:
	cd graphics_arrival && make

graphics_telescope/telescope_graphics.inc:
	cd graphics_telescope && make

####

clean:		
	rm -f *~ *.o *.lst \
		DISK01 LEVEL_ARRIVAL LEVEL_TELESCOPE

####

distclean:
	rm -f *~ *.o *.lst \
		DISK01 LEVEL_ARRIVAL LEVEL_TELESCOPE
	cd graphics_arrival && make clean
	cd graphics_telescope && make clean


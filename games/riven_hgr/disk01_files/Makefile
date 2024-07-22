include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK01 LEVEL_ARRIVAL LEVEL_ARRIVAL2 LEVEL_TELESCOPE LEVEL_ARRIVAL3

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

LEVEL_ARRIVAL2:	level_arrival2.o
	ld65 -o LEVEL_ARRIVAL2 level_arrival2.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_arrival2.o:	level_arrival2.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk01_defines.inc \
		leveldata_arrival2.inc \
		graphics_arrival2/arrival2_graphics.inc
	ca65 -o level_arrival2.o level_arrival2.s -l level_arrival2.lst


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


LEVEL_ARRIVAL3:	level_arrival3.o
	ld65 -o LEVEL_ARRIVAL3 level_arrival3.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_arrival3.o:	level_arrival3.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk01_defines.inc \
		leveldata_arrival3.inc \
		graphics_arrival3/arrival3_graphics.inc
	ca65 -o level_arrival3.o level_arrival3.s -l level_arrival3.lst

####

graphics_arrival/arrival_graphics.inc:
	cd graphics_arrival && make

graphics_arrival2/arrival2_graphics.inc:
	cd graphics_arrival2 && make

graphics_telescope/telescope_graphics.inc:
	cd graphics_telescope && make

graphics_arrival3/arrival3_graphics.inc:
	cd graphics_arrival3 && make

####

clean:		
	rm -f *~ *.o *.lst \
		DISK01 LEVEL_ARRIVAL LEVEL_ARRIVAL2 LEVEL_TELESCOPE LEVEL_ARRIVAL3

####

distclean:
	rm -f *~ *.o *.lst \
		DISK01 LEVEL_ARRIVAL LEVEL_ARRIVAL2 LEVEL_TELESCOPE LEVEL_ARRIVAL3
	cd graphics_arrival && make clean
	cd graphics_arrival2 && make clean
	cd graphics_telescope && make clean
	cd graphics_arrival3 && make clean


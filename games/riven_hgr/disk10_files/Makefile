include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK10 LEVEL_CENTER LEVEL_PILLARS LEVEL_15

####

DISK10:	disk10.o
	ld65 -o DISK10 disk10.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk10.o:	disk10.s ../zp.inc
	ca65 -o disk10.o disk10.s -l disk10.lst


####

LEVEL_CENTER:	level_center.o
	ld65 -o LEVEL_CENTER level_center.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_center.o:	level_center.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk10_defines.inc \
		leveldata_center.inc \
		graphics_center/center_graphics.inc
	ca65 -o level_center.o level_center.s -l level_center.lst

####

LEVEL_15:	level_15.o
	ld65 -o LEVEL_15 level_15.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_15.o:	level_15.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk10_defines.inc \
		leveldata_15.inc \
		graphics_15/15_graphics.inc
	ca65 -o level_15.o level_15.s -l level_15.lst

####

LEVEL_PILLARS:	level_pillars.o
	ld65 -o LEVEL_PILLARS level_pillars.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_pillars.o:	level_pillars.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk10_defines.inc \
		leveldata_pillars.inc \
		graphics_pillars/pillars_graphics.inc
	ca65 -o level_pillars.o level_pillars.s -l level_pillars.lst


####

LEVEL_23:	level_23.o
	ld65 -o LEVEL_23 level_23.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_23.o:	level_23.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk10_defines.inc \
		leveldata_23.inc \
		graphics_23/23_graphics.inc
	ca65 -o level_23.o level_23.s -l level_23.lst


####

graphics_center/center_graphics.inc:
	cd graphics_center && make

graphics_pillars/pillars_graphics.inc:
	cd graphics_pillars && make

graphics_15/15_graphics.inc:
	cd graphics_15 && make

graphics_23/23_graphics.inc:
	cd graphics_23 && make

####

clean:		
	rm -f *~ *.o *.lst DISK10 \
		LEVEL_CENTER LEVEL_PILLARS \
		LEVEL_15


####

distclean:
	rm -f *~ *.o *.lst DISK10 \
		LEVEL_CENTER LEVEL_PILLARS LEVEL_15
	cd graphics_center && make clean
	cd graphics_pillars && make clean
	cd graphics_15 && make clean



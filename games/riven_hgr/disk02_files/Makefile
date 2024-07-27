include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/

all:	DISK02 LEVEL_STEPS1 LEVEL_STEPS3 LEVEL_TOP

####

DISK02:	disk02.o
	ld65 -o DISK02 disk02.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk02.o:	disk02.s ../zp.inc
	ca65 -o disk02.o disk02.s -l disk02.lst

####

LEVEL_STEPS1:	level_steps1.o
	ld65 -o LEVEL_STEPS1 level_steps1.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_steps1.o:	level_steps1.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk02_defines.inc \
		leveldata_steps1.inc \
		graphics_steps1/steps1_graphics.inc
	ca65 -o level_steps1.o level_steps1.s -l level_steps1.lst

####

LEVEL_STEPS3:	level_steps3.o
	ld65 -o LEVEL_STEPS3 level_steps3.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_steps3.o:	level_steps3.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk02_defines.inc \
		leveldata_steps3.inc \
		graphics_steps3/steps3_graphics.inc
	ca65 -o level_steps3.o level_steps3.s -l level_steps3.lst


####

LEVEL_TOP:	level_top.o
	ld65 -o LEVEL_TOP level_top.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_top.o:	level_top.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk02_defines.inc \
		leveldata_top.inc \
		graphics_top/top_graphics.inc
	ca65 -o level_top.o level_top.s -l level_top.lst

####

graphics_steps1/steps1_graphics.inc:
	cd graphics_steps1 && make

graphics_steps3/steps3_graphics.inc:
	cd graphics_steps3 && make

graphics_top/top_graphics.inc:
	cd graphics_top && make

####

clean:		
	rm -f *~ *.o *.lst \
		LEVEL_STEPS1 LEVEL_STEPS3 LEVEL_TOP

####

distclean:
	rm -f *~ *.o *.lst \
		LEVEL_STEPS1 LEVEL_STEPS3 LEVEL_TOP
	cd graphics_steps1 && make clean
	cd graphics_steps3 && make clean
	cd graphics_top && make clean




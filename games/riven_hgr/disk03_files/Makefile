include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK03 LEVEL_DOWNSTEPS LEVEL_DOWNSTEPS3 LEVEL_OUTSIDE LEVEL_CAVE \
	LEVEL_DOORWAY

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
		graphics_outside/outside_graphics.inc \
		audio/gate_creak.btc.zx02
	ca65 -o level_outside.o level_outside.s -l level_outside.lst

####

LEVEL_CAVE:	level_cave.o
	ld65 -o LEVEL_CAVE level_cave.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_cave.o:	level_cave.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk03_defines.inc \
		leveldata_cave.inc \
		graphics_cave/cave_graphics.inc \
		audio/gate_creak.btc.zx02
	ca65 -o level_cave.o level_cave.s -l level_cave.lst

####

LEVEL_DOORWAY:	level_doorway.o
	ld65 -o LEVEL_DOORWAY level_doorway.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_doorway.o:	level_doorway.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk03_defines.inc \
		leveldata_doorway.inc \
		graphics_doorway/doorway_graphics.inc
	ca65 -o level_doorway.o level_doorway.s -l level_doorway.lst



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

LEVEL_DOWNSTEPS3:	level_downsteps3.o
	ld65 -o LEVEL_DOWNSTEPS3 level_downsteps3.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_downsteps3.o:	level_downsteps3.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk03_defines.inc \
		leveldata_downsteps3.inc \
		graphics_downsteps3/downsteps3_graphics.inc
	ca65 -o level_downsteps3.o level_downsteps3.s -l level_downsteps3.lst


####

audio/gate_creak.btc.zx02:
	cd audio && make

graphics_outside/outside_graphics.inc:
	cd graphics_outside && make

graphics_cave/cave_graphics.inc:
	cd graphics_cave && make

graphics_doorway/doorway_graphics.inc:
	cd graphics_doorway && make

graphics_downsteps/downsteps_graphics.inc:
	cd graphics_downsteps && make

graphics_downsteps4/downsteps4_graphics.inc:
	cd graphics_downsteps4 && make

####

clean:		
	rm -f *~ *.o *.lst DISK03 \
		LEVEL_OUTSIDE LEVEL_DOWNSTEPS LEVEL_DOWNSTEPS3 LEVEL_CAVE \
		LEVEL_DOORWAY

####

distclean:
	rm -f *~ *.o *.lst DISK03 \
		LEVEL_OUTSIDE LEVEL_DOWNSTEPS LEVEL_DOWNSTEPS3 LEVEL_CAVE \
		LEVEL_DOORWAY
	cd graphics_outside && make clean
	cd graphics_downsteps && make clean
	cd graphics_downsteps3 && make clean
	cd graphics_cave && make clean
	cd graphics_doorway && make clean
	cd audio && make clean

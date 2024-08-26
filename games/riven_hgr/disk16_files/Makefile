include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK16 LEVEL_BRIDGE LEVEL_BRIDGE2 LEVEL_DOME

####

DISK16:	disk16.o
	ld65 -o DISK16 disk16.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk16.o:	disk16.s ../zp.inc
	ca65 -o disk16.o disk16.s -l disk16.lst

####

LEVEL_BRIDGE:	level_bridge.o
	ld65 -o LEVEL_BRIDGE level_bridge.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_bridge.o:	level_bridge.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk16_defines.inc \
		leveldata_bridge.inc \
		graphics_bridge/bridge_graphics.inc \
		../audio.s ../disk02_files/audio/rotate.btc.zx02
	ca65 -o level_bridge.o level_bridge.s -l level_bridge.lst

####

LEVEL_BRIDGE2:	level_bridge2.o
	ld65 -o LEVEL_BRIDGE2 level_bridge2.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_bridge2.o:	level_bridge2.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk16_defines.inc \
		leveldata_bridge2.inc \
		graphics_bridge2/bridge2_graphics.inc
	ca65 -o level_bridge2.o level_bridge2.s -l level_bridge2.lst

####

LEVEL_DOME:	level_dome.o
	ld65 -o LEVEL_DOME level_dome.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_dome.o:	level_dome.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk16_defines.inc \
		leveldata_dome.inc \
		graphics_dome/dome_graphics.inc
	ca65 -o level_dome.o level_dome.s -l level_dome.lst


####

graphics_bridge/bridge_graphics.inc:
	cd graphics_bridge && make

graphics_bridge2/bridge2_graphics.inc:
	cd graphics_bridge2 && make

graphics_dome/dome_graphics.inc:
	cd graphics_dome && make

####

clean:		
	rm -f *~ *.o *.lst DISK16 \
		LEVEL_BRIDGE LEVEL_BRIDGE2 LEVEL_DOME

####

distclean:
	rm -f *~ *.o *.lst DISK16 \
		LEVEL_BRIDGE LEVEL_BRIDGE2 LEVEL_DOME
	cd graphics_bridge && make clean
	cd graphics_bridge2 && make clean
	cd graphics_dome && make clean



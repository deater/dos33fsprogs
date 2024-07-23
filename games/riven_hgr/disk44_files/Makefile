include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK44 LEVEL_FISH

####

DISK44:	disk44.o
	ld65 -o DISK44 disk44.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk44.o:	disk44.s ../zp.inc
	ca65 -o disk44.o disk44.s -l disk44.lst

####

LEVEL_FISH:	level_fish.o
	ld65 -o LEVEL_FISH level_fish.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_fish.o:	level_fish.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk44_defines.inc \
		leveldata_fish.inc \
		graphics_fish/fish_graphics.inc
	ca65 -o level_fish.o level_fish.s -l level_fish.lst

####

graphics_fish/fish_graphics.inc:
	cd graphics_fish && make

####

clean:		
	rm -f *~ *.o *.lst \
		LEVEL_FISH

####

distclean:
	rm -f *~ *.o *.lst \
		LEVEL_FISH
	cd graphics_fish && make clean




include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK44 LEVEL_PATH LEVEL_FISH

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

LEVEL_PATH:	level_path.o
	ld65 -o LEVEL_PATH level_path.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_path.o:	level_path.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk44_defines.inc \
		leveldata_path.inc \
		graphics_path/path_graphics.inc
	ca65 -o level_path.o level_path.s -l level_path.lst


####

graphics_fish/fish_graphics.inc:
	cd graphics_fish && make

graphics_path/path_graphics.inc:
	cd graphics_path && make

####

clean:		
	rm -f *~ *.o *.lst \
		LEVEL_PATH LEVEL_FISH

####

distclean:
	rm -f *~ *.o *.lst \
		LEVEL_PATH LEVEL_FISH
	cd graphics_path && make clean
	cd graphics_fish && make clean




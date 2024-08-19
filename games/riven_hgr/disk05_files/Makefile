include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK05 LEVEL_CHAIR LEVEL_CHAIR2 MOVIE_CHAIR

####

DISK05:	disk05.o
	ld65 -o DISK05 disk05.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk05.o:	disk05.s ../zp.inc
	ca65 -o disk05.o disk05.s -l disk05.lst

####

LEVEL_CHAIR:	level_chair.o
	ld65 -o LEVEL_CHAIR level_chair.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_chair.o:	level_chair.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk05_defines.inc \
		leveldata_chair.inc \
		graphics_chair/chair_graphics.inc
	ca65 -o level_chair.o level_chair.s -l level_chair.lst

####

LEVEL_CHAIR2:	level_chair2.o
	ld65 -o LEVEL_CHAIR2 level_chair2.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_chair2.o:	level_chair2.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk05_defines.inc \
		leveldata_chair2.inc \
		graphics_chair2/chair2_graphics.inc
	ca65 -o level_chair2.o level_chair2.s -l level_chair2.lst

####

MOVIE_CHAIR:	movie_chair.o
	ld65 -o MOVIE_CHAIR movie_chair.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

movie_chair.o:	movie_chair.s \
	../flip_pages.s ../disk00_files/draw_scene.s \
	../zp.inc ../hardware.inc ../qload.inc \
	../common_defines.inc disk05_defines.inc \
	movie_chair/movie_chair.inc
	ca65 -o movie_chair.o movie_chair.s -l movie_chair.lst

####

graphics_chair/chair_graphics.inc:
	cd graphics_chair && make

graphics_chair2/chair2_graphics.inc:
	cd graphics_chair2 && make

movie_chair/movie_chair.inc:
	cd movie_chair && make


####

clean:		
	rm -f *~ *.o *.lst DISK05 \
		LEVEL_CHAIR LEVEL_CHAIR2

####

distclean:
	rm -f *~ *.o *.lst DISK05 \
		LEVEL_CHAIR LEVEL_CHAIR2
	cd graphics_chair && make clean
	cd graphics_chair2 && make clean




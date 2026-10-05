include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/

####

all:	LEVEL3_EARTH

####

LEVEL3_EARTH:	level3_earth.o
	ld65 -o LEVEL3_EARTH level3_earth.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

level3_earth.o:	level3_earth.s \
	../hardware.inc ../zp.inc ../qload.inc \
	sprites_screen.s sprites_table.s \
	../gr_copy.s ../gr_putsprite_fast.s \
	graphics/earth_high.zx02 graphics/earth_low.zx02 \
	sprites/asteroid.inc
	ca65 -o level3_earth.o level3_earth.s -l level3_earth.lst

####

graphics/earth_high.zx02:	
	cd graphics && make

####

clean:	
		rm -f *~ *.o *.lst LEVEL3_EARTH
		cd graphics && make clean


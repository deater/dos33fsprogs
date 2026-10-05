include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/

#####

all:	LEVEL4_CITY

#####

LEVEL4_CITY:	level4_city.o
	ld65 -o LEVEL4_CITY level4_city.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

level4_city.o:	level4_city.s \
	../zp.inc ../hardware.inc ../qload.inc \
	../gr_copy.s \
	screen_split.s \
	graphics/car.zx02
	ca65 -o level4_city.o level4_city.s -l level4_city.lst

###

graphics/car.zx02:	
	cd graphics && make

###

clean:	
	rm -f *~ *.o *.lst LEVEL4_CITY
	cd graphics && make clean



include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/

#####

all:	LEVEL6_SATURN

#####

LEVEL6_SATURN:	level6_saturn.o
	ld65 -o LEVEL6_SATURN level6_saturn.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

level6_saturn.o:	level6_saturn.s \
	../zp.inc ../hardware.inc ../qload.inc \
	../gr_copy.s ../gr_putsprite.s \
	screen_split.s \
	sprites/mode7_sprites.inc \
	graphics/sb_background.zx02
	ca65 -o level6_saturn.o level6_saturn.s -l level6_saturn.lst

###

graphics/sb_background.zx02:	
	cd graphics && make

###

clean:	
	rm -f *~ *.o *.lst LEVEL6_SATURN
	cd graphics && make clean



include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK60 LEVEL_SPIRES

####

DISK60:	disk60.o
	ld65 -o DISK60 disk60.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk60.o:	disk60.s ../zp.inc
	ca65 -o disk60.o disk60.s -l disk60.lst

####

LEVEL_SPIRES:	level_spires.o
	ld65 -o LEVEL_SPIRES level_spires.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_spires.o:	level_spires.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk60_defines.inc \
		leveldata_spires.inc \
		graphics_spires/spires_graphics.inc
	ca65 -o level_spires.o level_spires.s -l level_spires.lst

####

graphics_spires/spires_graphics.inc:
	cd graphics_spires && make

####

clean:		
	rm -f *~ *.o *.lst DISK60 \
		LEVEL_SPIRES

####

distclean:
	rm -f *~ *.o *.lst DISK60 \
		LEVEL_SPIRES
	cd graphics_spires && make clean



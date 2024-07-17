include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK38 \
	LEVEL_PROJECTOR

####

DISK38:	disk38.o
	ld65 -o DISK38 disk38.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk38.o:	disk38.s ../zp.inc
	ca65 -o disk38.o disk38.s -l disk38.lst


####

LEVEL_PROJECTOR:	level_projector.o
	ld65 -o LEVEL_PROJECTOR level_projector.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_projector.o:	level_projector.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk38_defines.inc \
		leveldata_projector.inc \
		graphics_projector/projector_graphics.inc
	ca65 -o level_projector.o level_projector.s -l level_projector.lst

####

graphics_projector/projector_graphics.inc:
	cd graphics_projector && make

####

clean:		
	rm -f *~ *.o *.lst DISK38 \
		LEVEL_PROJECTOR

####

distclean:
	rm -f *~ *.o *.lst DISK38 \
		LEVEL_PROJECTOR
	cd graphics_projector && make clean



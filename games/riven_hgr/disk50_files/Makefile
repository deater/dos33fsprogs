include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK50 LEVEL_CHIPPER

####

DISK50:	disk50.o
	ld65 -o DISK50 disk50.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk50.o:	disk50.s ../zp.inc
	ca65 -o disk50.o disk50.s -l disk50.lst

####

LEVEL_CHIPPER:	level_chipper.o
	ld65 -o LEVEL_CHIPPER level_chipper.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_chipper.o:	level_chipper.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk50_defines.inc \
		leveldata_chipper.inc \
		graphics_chipper/chipper_graphics.inc
	ca65 -o level_chipper.o level_chipper.s -l level_chipper.lst

####

graphics_chipper/start_graphics.inc:
	cd graphics_chipper && make

####

clean:		
	rm -f *~ *.o *.lst \
		LEVEL_CHIPPER

####

distclean:
	rm -f *~ *.o *.lst \
		LEVEL_CHIPPER
	cd graphics_chipper && make clean




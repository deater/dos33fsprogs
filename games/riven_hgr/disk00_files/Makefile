include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK00 ATRUS

####

DISK00:	disk00.o
	ld65 -o DISK00 disk00.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk00.o:	disk00.s ../zp.inc
	ca65 -o disk00.o disk00.s -l disk00.lst

####

ATRUS:	atrus.o
	ld65 -o ATRUS atrus.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

atrus.o:	atrus.s \
		../zp.inc ../hardware.inc ../qload.inc \
		graphics_atrus/atrus_graphics.inc
	ca65 -o atrus.o atrus.s -l atrus.lst

####

graphics_atrus/atrus_graphics.inc:
	cd graphics_atrus && make

####

clean:		
	rm -f *~ *.o *.lst \
		DISK00 ATRUS

####

distclean:
	rm -f *~ *.o *.lst \
		DISK00 ATRUS
	cd graphics_atrus && make clean


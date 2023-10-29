include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/


all:	PLASMACUBE

####

PLASMACUBE:	plasmacube.o
	ld65 -o PLASMACUBE plasmacube.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

plasmacube.o:	plasmacube.s \
	../zp.inc ../hardware.inc ../qload.inc
	ca65 -o plasmacube.o plasmacube.s -l plasmacube.lst


###


clean:
	rm -f *~ *.o *.lst PLASMACUBE
#	cd graphics && make clean

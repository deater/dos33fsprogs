include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/


all:	PLASMA

####

PLASMA:	plasma.o
	ld65 -o PLASMA plasma.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

plasma.o:	plasma.s \
	do_plasma.s init_plasma.s \
	../zp.inc ../hardware.inc ../qload.inc
	ca65 -o plasma.o plasma.s -l plasma.lst


###


clean:
	rm -f *~ *.o *.lst PLASMA
#	cd graphics && make clean

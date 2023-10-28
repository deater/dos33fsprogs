include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/


all:	DOTS

####

DOTS:	dots.o
	ld65 -o DOTS dots.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

dots.o:	dots.s \
	../zp.inc ../hardware.inc ../qload.inc
	ca65 -o dots.o dots.s -l dots.lst


###


clean:
	rm -f *~ *.o *.lst DOTS
	cd graphics && make clean

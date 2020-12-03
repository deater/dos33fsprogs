include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
TOKENIZE = ../asoft_basic-utils/tokenize_asoft

all:	hgr.dsk

hgr.dsk:	SNOW
	cp empty.dsk hgr.dsk
	$(DOS33) -y hgr.dsk BSAVE -a 0x0300 SNOW

###

SNOW:	snow.o
	ld65 -o SNOW snow.o -C ../linker_scripts/apple2_300.inc

snow.o:	snow.s
	ca65 -o snow.o snow.s -l snow.lst

###

clean:	
	rm -f *~ *.o *.lst SNOW

include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
TOKENIZE = ../asoft_basic-utils/tokenize_asoft

all:	hgr.dsk

hgr.dsk:	SNOW SNOW2
	cp empty.dsk hgr.dsk
	$(DOS33) -y hgr.dsk BSAVE -a 0x0300 SNOW
	$(DOS33) -y hgr.dsk BSAVE -a 0x0300 SNOW2

###

SNOW:	snow.o
	ld65 -o SNOW snow.o -C ../linker_scripts/apple2_300.inc

snow.o:	snow.s
	ca65 -o snow.o snow.s -l snow.lst

###

SNOW2:	snow2.o
	ld65 -o SNOW2 snow2.o -C ../linker_scripts/apple2_300.inc

snow2.o:	snow2.s
	ca65 -o snow2.o snow2.s -l snow2.lst


###

clean:	
	rm -f *~ *.o *.lst SNOW SNOW2

include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
TOKENIZE = ../asoft_basic-utils/tokenize_asoft

all:	hgr.dsk

hgr.dsk:	SNOW SNOW2 SNOW3 STARS FASTAR
	cp empty.dsk hgr.dsk
	$(DOS33) -y hgr.dsk BSAVE -a 0x0300 SNOW
	$(DOS33) -y hgr.dsk BSAVE -a 0x0300 SNOW2
	$(DOS33) -y hgr.dsk BSAVE -a 0x0367 SNOW3
	$(DOS33) -y hgr.dsk BSAVE -a 0x0300 STARS
	$(DOS33) -y hgr.dsk BSAVE -a 0x0C00 FASTAR

###

FASTAR:	fastar.o
	ld65 -o FASTAR fastar.o -C ../linker_scripts/apple2_c00.inc

fastar.o:	fastar.s
	ca65 -o fastar.o fastar.s -l fastar.lst


###

STARS:	stars.o
	ld65 -o STARS stars.o -C ../linker_scripts/apple2_300.inc

stars.o:	stars.s
	ca65 -o stars.o stars.s -l stars.lst

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

SNOW3:	snow3.o
	ld65 -o SNOW3 snow3.o -C ./apple2_custom.inc

snow3.o:	snow3.s
	ca65 -o snow3.o snow3.s -l snow3.lst


###

clean:	
	rm -f *~ *.o *.lst SNOW SNOW2 SNOW3

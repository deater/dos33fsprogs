include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts

all:	starfield.dsk

starfield.dsk:	STARS FASTAR
	cp empty.dsk starfield.dsk
	$(DOS33) -y starfield.dsk BSAVE -a 0x0300 STARS
	$(DOS33) -y starfield.dsk BSAVE -a 0x0C00 FASTAR

###

FASTAR:	fastar.o
	ld65 -o FASTAR fastar.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

fastar.o:	fastar.s
	ca65 -o fastar.o fastar.s -l fastar.lst


###

STARS:	stars.o
	ld65 -o STARS stars.o -C $(LINKER_SCRIPTS)/apple2_300.inc

stars.o:	stars.s
	ca65 -o stars.o stars.s -l stars.lst

###

clean:	
	rm -f *~ *.o *.lst STARS FASTAR

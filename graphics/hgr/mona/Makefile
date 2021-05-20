include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	mona.dsk

mona.dsk:	HELLO MONA
	cp $(EMPTY_DISK)/empty.dsk mona.dsk
	$(DOS33) -y mona.dsk SAVE A HELLO
	$(DOS33) -y mona.dsk BSAVE -a 0x6000 MONA
###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

MONA:	mona.o
	ld65 -o MONA mona.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

mona.o:	mona.s graphics/graphics.inc
	ca65 -o mona.o mona.s -l mona.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO MONA


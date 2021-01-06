include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	small.dsk

small.dsk:	SMALL HELLO
	cp empty.dsk small.dsk
	$(DOS33) -y small.dsk SAVE A HELLO
	$(DOS33) -y small.dsk BSAVE -a 0x1000 SMALL

###

SMALL:	small.o
	ld65 -o SMALL small.o -C ../../linker_scripts/apple2_1000.inc

small.o:	small.s
	ca65 -o small.o small.s -l small.lst

###

HELLO:  hello.bas
	$(TOKENIZE) < hello.bas > HELLO


clean:	
	rm -f *~ *.o SMALL

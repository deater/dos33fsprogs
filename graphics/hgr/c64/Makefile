include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts

all:	c64.dsk

c64.dsk:	HELLO C64.BAS C64_TINY.BAS C64
	cp empty.dsk c64.dsk
	$(DOS33) -y c64.dsk SAVE A HELLO
	$(DOS33) -y c64.dsk SAVE A C64.BAS
	$(DOS33) -y c64.dsk SAVE A C64_TINY.BAS
	$(DOS33) -y c64.dsk SAVE A C64_TINY.BAS
	$(DOS33) -y c64.dsk BSAVE -a 0x3F5 C64


###

HELLO:  hello.bas
	$(TOKENIZE) < hello.bas > HELLO


###

C64:	c64.o
	ld65 -o C64 c64.o -C $(LINKER_SCRIPTS)/apple2_3f5.inc

c64.o:	c64.s
	ca65 -o c64.o c64.s -l c64.lst

###

C64.BAS:  c64.bas
	$(TOKENIZE) < c64.bas > C64.BAS

###

C64_TINY.BAS:  c64_tiny.bas
	$(TOKENIZE) < c64_tiny.bas > C64_TINY.BAS

###

clean:	
	rm -f *~ *.o *.lst C64.BAS C64_TINY.BAS

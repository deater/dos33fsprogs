include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts

all:	mousetext.dsk

mousetext.dsk:	HELLO MT.BAS SW.BAS
	cp empty.dsk mousetext.dsk
	$(DOS33) -y mousetext.dsk SAVE A HELLO
	$(DOS33) -y mousetext.dsk SAVE A MT.BAS
	$(DOS33) -y mousetext.dsk SAVE A SW.BAS

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

MT.BAS:	mt.bas
	$(TOKENIZE) < mt.bas > MT.BAS

###

SW.BAS:	sw.bas
	$(TOKENIZE) < sw.bas > SW.BAS

###

clean:	
	rm -f *~ *.o *.lst HELLO MT.BAS SW.BAS

include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	bubble.dsk

bubble.dsk:	HELLO BUBBLE.BAS
	cp $(EMPTY_DISK)/empty.dsk bubble.dsk
	$(DOS33) -y bubble.dsk SAVE A HELLO
	$(DOS33) -y bubble.dsk SAVE A BUBBLE.BAS

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

BUBBLE.BAS:	bubble.bas
	$(TOKENIZE) < bubble.bas > BUBBLE.BAS


###

clean:	
	rm -f *~ *.o *.lst BUBBLE.BAS HELLO


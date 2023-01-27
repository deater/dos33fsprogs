include ../../../Makefile.inc

LINKER_DIR = ../../../linker_scripts/

EMPTY_DISK = ../../../empty_disk/empty.dsk
DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	rotate.dsk

rotate.dsk:	HELLO ROTATE.BAS
	cp $(EMPTY_DISK) rotate.dsk
	$(DOS33) -y rotate.dsk SAVE A HELLO
	$(DOS33) -y rotate.dsk SAVE A ROTATE.BAS

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

ROTATE.BAS:	rotate.bas
	$(TOKENIZE) < rotate.bas > ROTATE.BAS

####


clean:		
		rm -f *~ *.o *.lst HELLO ROTATE.BAS


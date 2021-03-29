include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	cube.dsk

cube.dsk:	HELLO CUBE.BAS
	cp $(EMPTY_DISK) cube.dsk
	$(DOS33) -y cube.dsk SAVE A HELLO
	$(DOS33) -y cube.dsk SAVE A CUBE.BAS

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

CUBE.BAS:	cube.bas
	$(TOKENIZE) < cube.bas > CUBE.BAS

####

clean:
	rm -f *~ *.o *.lst HELLO CUBE.BAS


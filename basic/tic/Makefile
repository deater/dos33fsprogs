include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	tic.dsk

tic.dsk:	HELLO PLASMA.BAS ROTOZOOM.BAS
	cp $(EMPTY_DISK) tic.dsk
	$(DOS33) -y tic.dsk SAVE A HELLO
	$(DOS33) -y tic.dsk SAVE A PLASMA.BAS
	$(DOS33) -y tic.dsk SAVE A ROTOZOOM.BAS

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

PLASMA.BAS:	plasma.bas
	$(TOKENIZE) < plasma.bas > PLASMA.BAS

####

ROTOZOOM.BAS:	rotozoom.bas
	$(TOKENIZE) < rotozoom.bas > ROTOZOOM.BAS

####

clean:
	rm -f *~ *.o *.lst HELLO PLASMA.BAS


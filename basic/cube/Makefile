include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	cube.dsk

cube.dsk:	HELLO CUBE.BAS CHEAT.BAS
	cp $(EMPTY_DISK) cube.dsk
	$(DOS33) -y cube.dsk SAVE A HELLO
	$(DOS33) -y cube.dsk SAVE A CUBE.BAS
	$(DOS33) -y cube.dsk SAVE A CHEAT.BAS

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

CUBE.BAS:	cube.bas
	$(TOKENIZE) < cube.bas > CUBE.BAS

####

CHEAT.BAS:	cheat.bas
	$(TOKENIZE) < cheat.bas > CHEAT.BAS

####

clean:
	rm -f *~ *.o *.lst HELLO CUBE.BAS CHEAT.BAS


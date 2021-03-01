include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts
EMPTYDISK = ../../empty_disk/empty.dsk

all:	notamoon.dsk

notamoon.dsk:	HELLO NOTAMOON
	cp $(EMPTYDISK) notamoon.dsk
	$(DOS33) -y notamoon.dsk SAVE A HELLO
	$(DOS33) -y notamoon.dsk BSAVE -a 0x70 NOTAMOON

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

NOTAMOON:	notamoon.o
	ld65 -o NOTAMOON notamoon.o -C ./apple2_70_zp.inc

notamoon.o:	notamoon.s
	ca65 -o notamoon.o notamoon.s -l notamoon.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO NOTAMOON notamoon.dsk

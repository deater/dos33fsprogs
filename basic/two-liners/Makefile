include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../empty_disk/empty.dsk

all:	entropy.dsk

entropy.dsk:	HELLO ENTROPY.BAS ENTROPY ENTROPY_TINY
	cp $(EMPTYDISK) entropy.dsk
	$(DOS33) -y entropy.dsk SAVE A HELLO
	$(DOS33) -y entropy.dsk SAVE A ENTROPY.BAS
	$(DOS33) -y entropy.dsk BSAVE -a 0x0C00 ENTROPY
	$(DOS33) -y entropy.dsk BSAVE -a 0x0C00 ENTROPY_TINY

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

ENTROPY:	entropy.o
	ld65 -o ENTROPY entropy.o -C ../../linker_scripts/apple2_c00.inc

entropy.o:	entropy.s
	ca65 -o entropy.o entropy.s -l entropy.lst


###

ENTROPY_TINY:	entropy_tiny.o
	ld65 -o ENTROPY_TINY entropy_tiny.o -C ../../linker_scripts/apple2_c00.inc

entropy_tiny.o:	entropy_tiny.s
	ca65 -o entropy_tiny.o entropy_tiny.s -l entropy_tiny.lst


####

ENTROPY.BAS:	entropy.bas
	$(TOKENIZE) < entropy.bas > ENTROPY.BAS

####

clean:	
	rm -f *~ *.o *.lst ENTROPY ENTROPY.BAS HELLO ENTROPY_TINY

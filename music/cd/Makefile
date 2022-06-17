include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts
EMPTYDISK = ../../empty_disk/empty.dsk

all:	cd.dsk

cd.dsk:	HELLO HORIZ
	cp $(EMPTYDISK) cd.dsk
	$(DOS33) -y cd.dsk SAVE A HELLO
	$(DOS33) -y cd.dsk BSAVE -a 0xC00 HORIZ

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

HORIZ:	horiz.o
	ld65 -o HORIZ horiz.o -C $(LINKERSCRIPTS)/apple2_c00.inc

horiz.o:	horiz.s
	ca65 -o horiz.o horiz.s -l horiz.lst

####

clean:	
	rm -f *~ *.o *.lst HORIZ

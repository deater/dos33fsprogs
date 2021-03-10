include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/

all:	tiny_pastel.dsk

tiny_pastel.dsk:	HELLO TINY_PASTEL PASTEL PASTEL.BAS
	cp $(EMPTYDISK) tiny_pastel.dsk
	$(DOS33) -y tiny_pastel.dsk SAVE A HELLO
	$(DOS33) -y tiny_pastel.dsk SAVE A PASTEL.BAS
	$(DOS33) -y tiny_pastel.dsk BSAVE -a 0x70 TINY_PASTEL
	$(DOS33) -y tiny_pastel.dsk BSAVE -a 0x810 PASTEL

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PASTEL.BAS:	pastel.bas
	$(TOKENIZE) < pastel.bas > PASTEL.BAS

###

TINY_PASTEL:	tiny_pastel.o
	ld65 -o TINY_PASTEL tiny_pastel.o -C ./apple2_70_zp.inc

tiny_pastel.o:	tiny_pastel.s
	ca65 -o tiny_pastel.o tiny_pastel.s -l tiny_pastel.lst

###

PASTEL:	pastel.o
	ld65 -o PASTEL pastel.o -C apple2_810.inc

pastel.o:	pastel.s
	ca65 -o pastel.o pastel.s -l pastel.lst


####

clean:	
	rm -f *~ *.o *.lst HELLO TINY_PASTEL PASTEL.BAS

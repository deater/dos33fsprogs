include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts

all:	plain.dsk

plain.dsk:	PLAIN
	cp empty.dsk plain.dsk
	$(DOS33) -y plain.dsk BSAVE -a 0x0800 PLAIN


###

PLAIN:	plain.o
	ld65 -o PLAIN plain.o -C $(LINKERSCRIPTS)/apple2_800.inc

plain.o:	plain.s
	ca65 -o plain.o plain.s -l plain.lst

####

clean:	
	rm -f *~ *.o *.lst PLAIN

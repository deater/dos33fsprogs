include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	bitmap.dsk make_bitmap

bitmap.dsk:	HELLO EYE EYE.BAS
	cp $(EMPTYDISK) bitmap.dsk
	$(DOS33) -y bitmap.dsk SAVE A HELLO
	$(DOS33) -y bitmap.dsk SAVE A EYE.BAS
	$(DOS33) -y bitmap.dsk BSAVE -a 0xC00 EYE

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

EYE.BAS:	eye.bas
	$(TOKENIZE) < eye.bas > EYE.BAS

###

EYE:	eye.o
	ld65 -o EYE eye.o -C $(LINKERSCRIPTS)/apple2_c00.inc

eye.o:	eye.s
	ca65 -o eye.o eye.s -l eye.lst

###

make_bitmap:	make_bitmap.o
	$(CC) -o make_bitmap make_bitmap.o $(LFLAGS)

make_bitmap.o:	make_bitmap.c
	$(CC) $(CFLAGS) -c make_bitmap.c


###

clean:	
	rm -f *~ *.o *.lst HELLO EYE EYE.BAS make_bitmap

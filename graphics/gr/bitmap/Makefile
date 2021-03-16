include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	bitmap.dsk make_bitmap make_bitmap_small

bitmap.dsk:	HELLO EYE EYE.BAS EYE_NEW.BAS
	cp $(EMPTYDISK) bitmap.dsk
	$(DOS33) -y bitmap.dsk SAVE A HELLO
	$(DOS33) -y bitmap.dsk SAVE A EYE.BAS
	$(DOS33) -y bitmap.dsk SAVE A EYE_NEW.BAS
	$(DOS33) -y bitmap.dsk BSAVE -a 0xC00 EYE

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

EYE.BAS:	eye.bas
	$(TOKENIZE) < eye.bas > EYE.BAS

###

EYE_NEW.BAS:	eye_new.bas
	$(TOKENIZE) < eye_new.bas > EYE_NEW.BAS

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

make_bitmap_small:	make_bitmap_small.o
	$(CC) -o make_bitmap_small make_bitmap_small.o $(LFLAGS)

make_bitmap_small.o:	make_bitmap_small.c
	$(CC) $(CFLAGS) -c make_bitmap_small.c


###

clean:	
	rm -f *~ *.o *.lst HELLO EYE EYE.BAS EYE_NEW.BAS make_bitmap make_bitmap_small

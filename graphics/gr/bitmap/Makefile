include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	bitmap.dsk make_bitmap make_bitmap_small

bitmap.dsk:	HELLO EYE EYE.BAS EYE_NEW.BAS EYE_DROP.BAS POTION.BAS SMOLLY.BAS SPHERE.BAS
	cp $(EMPTYDISK) bitmap.dsk
	$(DOS33) -y bitmap.dsk SAVE A HELLO
	$(DOS33) -y bitmap.dsk SAVE A EYE.BAS
	$(DOS33) -y bitmap.dsk SAVE A EYE_NEW.BAS
	$(DOS33) -y bitmap.dsk SAVE A EYE_DROP.BAS
	$(DOS33) -y bitmap.dsk SAVE A POTION.BAS
	$(DOS33) -y bitmap.dsk SAVE A SMOLLY.BAS
	$(DOS33) -y bitmap.dsk SAVE A SPHERE.BAS
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

EYE_DROP.BAS:	eye_drop.bas
	$(TOKENIZE) < eye_drop.bas > EYE_DROP.BAS

###

POTION.BAS:	potion.bas
	$(TOKENIZE) < potion.bas > POTION.BAS

###

SMOLLY.BAS:	smolly.bas
	$(TOKENIZE) < smolly.bas > SMOLLY.BAS

###

SPHERE.BAS:	sphere.bas
	$(TOKENIZE) < sphere.bas > SPHERE.BAS


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
	rm -f *~ *.o *.lst HELLO EYE EYE.BAS EYE_NEW.BAS EYE_DROP.BAS POTION.BAS SMOLLY.BAS SPHERE.BAS make_bitmap make_bitmap_small

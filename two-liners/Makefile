include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
TOKENIZE = ../asoft_basic-utils/tokenize_asoft

all:	entropy.dsk convert_to convert_back

entropy.dsk:	ENTROPY ENTROPY.BAS E2.BAS FLAME.BAS FLAME2.BAS \
	CIRCLES.BAS AUTUMN.BAS LOAD
	$(DOS33) -y entropy.dsk BSAVE -a 0x0C00 ENTROPY
	$(DOS33) -y entropy.dsk BSAVE -a 0x0300 LOAD
	$(DOS33) -y entropy.dsk SAVE A ENTROPY.BAS
	$(DOS33) -y entropy.dsk SAVE A E2.BAS
	$(DOS33) -y entropy.dsk SAVE A FLAME.BAS
	$(DOS33) -y entropy.dsk SAVE A FLAME2.BAS
	$(DOS33) -y entropy.dsk SAVE A AUTUMN.BAS
	$(DOS33) -y entropy.dsk SAVE A CIRCLES.BAS

###

convert_to:	convert_to.o
	$(CC) $(LFLAGS) -o convert_to convert_to.o

convert_to.o:	convert_to.c
	$(CC) $(CFLAGS) -c convert_to.c

###

convert_back:	convert_back.o
	$(CC) $(LFLAGS) -o convert_back convert_back.o

convert_back.o:	convert_back.c
	$(CC) $(CFLAGS) -c convert_back.c


###

ENTROPY:	entropy.o
	ld65 -o ENTROPY entropy.o -C ../linker_scripts/apple2_c00.inc

entropy.o:	entropy.s
	ca65 -o entropy.o entropy.s -l entropy.lst

###

LOAD:	load.o
	ld65 -o LOAD load.o -C ../linker_scripts/apple2_300.inc

load.o:	load.s
	ca65 -o load.o load.s -l load.lst


####

ENTROPY.BAS:	entropy.bas
	$(TOKENIZE) < entropy.bas > ENTROPY.BAS

####

E2.BAS:	entropy_small.bas
	$(TOKENIZE) < entropy_small.bas > E2.BAS


####

FLAME2.BAS:	flame2.bas
	$(TOKENIZE) < flame2.bas > FLAME2.BAS


####

FLAME.BAS:	flame.bas
	$(TOKENIZE) < flame.bas > FLAME.BAS

####

AUTUMN.BAS:	autumn.bas
	$(TOKENIZE) < autumn.bas > AUTUMN.BAS

####

CIRCLES.BAS:	circles.bas
	$(TOKENIZE) < circles.bas > CIRCLES.BAS


####

clean:	
	rm -f *~ *.o *.lst ENTROPY LOAD

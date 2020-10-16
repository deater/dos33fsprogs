include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
TOKENIZE = ../asoft_basic-utils/tokenize_asoft

all:	appleiibot.dsk convert_to convert_back convert_qkumba

appleiibot.dsk:	E2.BAS FLAME.BAS FLAME2.BAS \
	CIRCLES.BAS AUTUMN.BAS QKUMBA.BAS ASTEROID.BAS PERSON.BAS SHIP.BAS \
	CONCERT.BAS NYAN.BAS RASTER.BAS RASTER2.BAS RASTER3.BAS LOTS.BAS LOAD \
	RASTER4.BAS RASTER5.BAS PUMPKIN.BAS
	cp empty.dsk appleiibot.dsk
	$(DOS33) -y appleiibot.dsk BSAVE -a 0x0300 LOAD
	$(DOS33) -y appleiibot.dsk SAVE A E2.BAS
	$(DOS33) -y appleiibot.dsk SAVE A FLAME.BAS
	$(DOS33) -y appleiibot.dsk SAVE A FLAME2.BAS
	$(DOS33) -y appleiibot.dsk SAVE A AUTUMN.BAS
	$(DOS33) -y appleiibot.dsk SAVE A CIRCLES.BAS
	$(DOS33) -y appleiibot.dsk SAVE A QKUMBA.BAS
	$(DOS33) -y appleiibot.dsk SAVE A ASTEROID.BAS
	$(DOS33) -y appleiibot.dsk SAVE A PERSON.BAS
	$(DOS33) -y appleiibot.dsk SAVE A SHIP.BAS
	$(DOS33) -y appleiibot.dsk SAVE A NYAN.BAS
	$(DOS33) -y appleiibot.dsk SAVE A CONCERT.BAS
	$(DOS33) -y appleiibot.dsk SAVE A RASTER.BAS
	$(DOS33) -y appleiibot.dsk SAVE A RASTER2.BAS
	$(DOS33) -y appleiibot.dsk SAVE A RASTER3.BAS
	$(DOS33) -y appleiibot.dsk SAVE A RASTER4.BAS
	$(DOS33) -y appleiibot.dsk SAVE A RASTER5.BAS
	$(DOS33) -y appleiibot.dsk SAVE A LOTS.BAS
	$(DOS33) -y appleiibot.dsk SAVE A PUMPKIN.BAS

###

convert_to:	convert_to.o
	$(CC) $(LFLAGS) -o convert_to convert_to.o

convert_to.o:	convert_to.c
	$(CC) $(CFLAGS) -c convert_to.c

###

convert_qkumba:	convert_qkumba.o
	$(CC) $(LFLAGS) -o convert_qkumba convert_qkumba.o

convert_qkumba.o:	convert_qkumba.c
	$(CC) $(CFLAGS) -c convert_qkumba.c

###

convert_back:	convert_back.o
	$(CC) $(LFLAGS) -o convert_back convert_back.o

convert_back.o:	convert_back.c
	$(CC) $(CFLAGS) -c convert_back.c


###

LOAD:	load.o
	ld65 -o LOAD load.o -C ../linker_scripts/apple2_300.inc

load.o:	load.s
	ca65 -o load.o load.s -l load.lst

####

QKUMBA2.BAS:	qkumba_seasons.bas
	$(TOKENIZE) < qkumba_seasons.bas > QKUMBA2.BAS

####

QKUMBA.BAS:	qkumba_autumn.bas
	$(TOKENIZE) < qkumba_autumn.bas > QKUMBA.BAS

####

CONCERT.BAS:	concert.bas
	$(TOKENIZE) < concert.bas > CONCERT.BAS

####

NYAN.BAS:	nyan.bas
	$(TOKENIZE) < nyan.bas > NYAN.BAS

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

ASTEROID.BAS:	asteroid.bas
	$(TOKENIZE) < asteroid.bas > ASTEROID.BAS

####

PERSON.BAS:	person.bas
	$(TOKENIZE) < person.bas > PERSON.BAS

####

SHIP.BAS:	ship.bas
	$(TOKENIZE) < ship.bas > SHIP.BAS

####

RASTER.BAS:	raster.bas
	$(TOKENIZE) < raster.bas > RASTER.BAS

####

RASTER2.BAS:	raster2.bas
	$(TOKENIZE) < raster2.bas > RASTER2.BAS

####

RASTER3.BAS:	raster3.bas
	$(TOKENIZE) < raster3.bas > RASTER3.BAS

####

RASTER4.BAS:	raster4.bas
	$(TOKENIZE) < raster4.bas > RASTER4.BAS


####

RASTER5.BAS:	raster5.bas
	$(TOKENIZE) < raster5.bas > RASTER5.BAS

####

PUMPKIN.BAS:	pumpkin.bas
	$(TOKENIZE) < pumpkin.bas > PUMPKIN.BAS

####

LOTS.BAS:	lots.bas
	$(TOKENIZE) < lots.bas > LOTS.BAS

####

clean:
	rm -f *~ *.o *.lst convert_to convert_from convert_qkumba convert_back LOAD *.BAS

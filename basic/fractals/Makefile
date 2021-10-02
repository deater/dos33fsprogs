include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	fractal.dsk

fractal.dsk:	HELLO DRAGON.BAS DRAGON_SMALL.BAS
	cp $(EMPTY_DISK) fractal.dsk
	$(DOS33) -y fractal.dsk SAVE A HELLO
	$(DOS33) -y fractal.dsk SAVE A DRAGON.BAS
	$(DOS33) -y fractal.dsk SAVE A DRAGON_SMALL.BAS

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

DRAGON.BAS:	dragon.bas
	$(TOKENIZE) < dragon.bas > DRAGON.BAS

####

DRAGON_SMALL.BAS:	dragon_small.bas
	$(TOKENIZE) < dragon_small.bas > DRAGON_SMALL.BAS


####

clean:
	rm -f *~ *.o *.lst HELLO CUBE.BAS CHEAT.BAS


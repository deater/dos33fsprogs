include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	twister.dsk

twister.dsk:	$(DOS33) HELLO TWISTER.BAS LORES.BAS TINY.BAS
	cp $(EMPTY_DISK)/empty.dsk twister.dsk
	$(DOS33) -y twister.dsk SAVE A HELLO
	$(DOS33) -y twister.dsk SAVE A TWISTER.BAS
	$(DOS33) -y twister.dsk SAVE A LORES.BAS
	$(DOS33) -y twister.dsk SAVE A TINY.BAS

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TWISTER.BAS:	twister.bas
	$(TOKENIZE) < twister.bas > TWISTER.BAS

###

LORES.BAS:	lores.bas
	$(TOKENIZE) < lores.bas > LORES.BAS

###

TINY.BAS:	tiny.bas
	$(TOKENIZE) < tiny.bas > TINY.BAS




###

clean:	
	rm -f *~ *.o HELLO TWISTER.BAS LORES.BAS *.lst


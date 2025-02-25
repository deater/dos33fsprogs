include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk

all:	starpath.dsk

$(DOS33):	
	cd ../../utils/dos33fs-utils && make

starpath.dsk:	$(DOS33) HELLO STARPATH.BAS
	cp $(EMPTYDISK)/empty.dsk starpath.dsk
	$(DOS33) -y starpath.dsk SAVE A HELLO
	$(DOS33) -y starpath.dsk SAVE A STARPATH.BAS



###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

STARPATH.BAS:	starpath.bas
	$(TOKENIZE) < starpath.bas > STARPATH.BAS


###


clean:	
	rm -f *~ *.o HELLO STARPATH.BAS *.lst


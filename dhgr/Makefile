include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
TOKENIZE = ../asoft_basic-utils/tokenize_asoft

all:	dhgr.dsk

dhgr.dsk:	RASTER BITS LOTS
	$(DOS33) -y dhgr.dsk BSAVE -a 0x0300 RASTER
	$(DOS33) -y dhgr.dsk BSAVE -a 0x0300 BITS
	$(DOS33) -y dhgr.dsk BSAVE -a 0x0300 LOTS

###

RASTER:	raster.o
	ld65 -o RASTER raster.o -C ../linker_scripts/apple2_300.inc

raster.o:	raster.s
	ca65 -o raster.o raster.s -l raster.lst

###

LOTS:	lots.o
	ld65 -o LOTS lots.o -C ../linker_scripts/apple2_300.inc

lots.o:	lots.s
	ca65 -o lots.o lots.s -l lots.lst


###

BITS:	bits.o
	ld65 -o BITS bits.o -C ../linker_scripts/apple2_300.inc

bits.o:	bits.s
	ca65 -o bits.o bits.s -l bits.lst

####

clean:	
	rm -f *~ *.o *.lst RASTER BITS LOTS

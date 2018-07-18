include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
TOKENIZE = ../asoft_basic-utils/tokenize_asoft

all:	kfest18.dsk

kfest18.dsk:	RASTER
	$(DOS33) -y kfest18.dsk BSAVE -a 0x1000 RASTER

raster.o:	raster.s
	ca65 -o raster.o raster.s -l raster.lst

RASTER:	raster.o
	ld65 -o RASTER raster.o -C ../linker_scripts/apple2_1000.inc

clean:	
	rm -f *~ *.o *.lst RASTER

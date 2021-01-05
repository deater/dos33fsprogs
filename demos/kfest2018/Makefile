include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
TOKENIZE = ../asoft_basic-utils/tokenize_asoft

all:	kfest18.dsk

kfest18.dsk:	RASTER RASTER_C
	$(DOS33) -y kfest18.dsk BSAVE -a 0x2000 RASTER
	$(DOS33) -y kfest18.dsk BSAVE -a 0x1000 RASTER_C

raster.o:	raster.s vapor_lock.s
	ca65 -o raster.o raster.s -l raster.lst

RASTER.lz4: RASTER
	lz4 -f -16 RASTER

RASTER:	raster.o
	ld65 -o RASTER raster.o -C ../linker_scripts/apple2_2000.inc

raster_decompress.o:	raster_decompress.s RASTER.lz4
	ca65 -o raster_decompress.o raster_decompress.s

RASTER_C:	raster_decompress.o
	ld65 -o RASTER_C raster_decompress.o -C ../linker_scripts/apple2_1000.inc




raster2.o:	raster2.s
	ca65 -o raster2.o raster2.s -l raster2.lst

RASTER2:	raster2.o
	ld65 -o RASTER2 raster2.o -C ../linker_scripts/apple2_1000.inc


clean:	
	rm -f *~ *.o *.lst RASTER RASTER2 RASTER.lz4

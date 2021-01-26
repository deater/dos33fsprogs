include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
B2D = ../../utils/bmp2dhr/b2d
LZSA = ~/research/lzsa/lzsa/lzsa

all:	dhgr.dsk


dhgr.dsk:	HELLO RASTER RASTER2 RASTER3 RASTER4 BITS LOTS DHR_LOAD
	cp empty.dsk dhgr.dsk
	$(DOS33) -y dhgr.dsk SAVE A HELLO
	$(DOS33) -y dhgr.dsk BSAVE -a 0x0300 RASTER
	$(DOS33) -y dhgr.dsk BSAVE -a 0x0300 RASTER2
	$(DOS33) -y dhgr.dsk BSAVE -a 0x0300 RASTER3
	$(DOS33) -y dhgr.dsk BSAVE -a 0x0300 RASTER4
	$(DOS33) -y dhgr.dsk BSAVE -a 0x1000 DHR_LOAD
	$(DOS33) -y dhgr.dsk BSAVE -a 0x0300 BITS
	$(DOS33) -y dhgr.dsk BSAVE -a 0x0300 LOTS

###

HELLO:  hello.bas
	$(TOKENIZE) < hello.bas > HELLO


###

C64.AUX.lzsa:	C64.AUX
	$(LZSA) -r -f2 C64.AUX C64.AUX.lzsa

C64.BIN.lzsa:	C64.BIN
	$(LZSA) -r -f2 C64.BIN C64.BIN.lzsa

###

C64.AUX:	c64.bmp
	$(B2D) c64.bmp A

###

RASTER:	raster.o
	ld65 -o RASTER raster.o -C ../../linker_scripts/apple2_300.inc

raster.o:	raster.s
	ca65 -o raster.o raster.s -l raster.lst


###

RASTER2:	raster2.o
	ld65 -o RASTER2 raster2.o -C ../../linker_scripts/apple2_300.inc

raster2.o:	raster2.s
	ca65 -o raster2.o raster2.s -l raster2.lst


###

RASTER3:	raster3.o
	ld65 -o RASTER3 raster3.o -C ../../linker_scripts/apple2_300.inc

raster3.o:	raster3.s
	ca65 -o raster3.o raster3.s -l raster3.lst

###

RASTER4:	raster4.o
	ld65 -o RASTER4 raster4.o -C ../../linker_scripts/apple2_300.inc

raster4.o:	raster4.s
	ca65 -o raster4.o raster4.s -l raster4.lst

###

DHR_LOAD:	dhr_load.o
	ld65 -o DHR_LOAD dhr_load.o -C ../../linker_scripts/apple2_1000.inc

dhr_load.o:	dhr_load.s C64.AUX.lzsa C64.BIN.lzsa
	ca65 -o dhr_load.o dhr_load.s -l dhr_load.lst



###

LOTS:	lots.o
	ld65 -o LOTS lots.o -C ../../linker_scripts/apple2_300.inc

lots.o:	lots.s
	ca65 -o lots.o lots.s -l lots.lst


###

BITS:	bits.o
	ld65 -o BITS bits.o -C ../../linker_scripts/apple2_300.inc

bits.o:	bits.s
	ca65 -o bits.o bits.s -l bits.lst

####

clean:	
	rm -f *~ *.o *.lst RASTER RASTER2 RASTER3 RASTER4 BITS LOTS encode6

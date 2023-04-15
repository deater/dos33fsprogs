include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
B2D = ../../../utils/bmp2dhr/b2d
LZSA = ~/research/lzsa/lzsa/lzsa
LINKER_SCRIPTS = ../../../linker_scripts/

EMPTY_DISK = ../../../empty_disk/empty.dsk

all:	c64.dsk


c64.dsk:	HELLO DHR_LOAD
	cp $(EMPTY_DISK) c64.dsk
	$(DOS33) -y c64.dsk SAVE A HELLO
	$(DOS33) -y c64.dsk BSAVE -a 0x1000 DHR_LOAD

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

DHR_LOAD:	dhr_load.o
	ld65 -o DHR_LOAD dhr_load.o -C $(LINKER_SCRIPTS)/apple2_1000.inc

dhr_load.o:	dhr_load.s C64.AUX.lzsa C64.BIN.lzsa
	ca65 -o dhr_load.o dhr_load.s -l dhr_load.lst


####

clean:	
	rm -f *~ *.o *.lst HELLO DHR_LOAD

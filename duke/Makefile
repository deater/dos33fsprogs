include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
DOS33_RAW = ../dos33fs-utils/dos33_raw
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
PNG2RLE = ../gr-utils/png2rle
B2D = ../bmp2dhr/b2d
PNG2GR = ../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	duke.dsk

duke.dsk:	HELLO DUKE
	cp empty.dsk duke.dsk
	$(DOS33) -y duke.dsk SAVE A HELLO
	$(DOS33) -y duke.dsk BSAVE -a 0x2000 DUKE

###

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

####


DUKE:	duke.o
	ld65 -o DUKE duke.o -C ../linker_scripts/apple2_2000.inc

duke.o:	duke.s zp.inc hardware.inc duke.s duke.inc
	ca65 -o duke.o duke.s -l duke.lst

####

duke.inc:	duke.lzsa
	echo "duke_lzsa: .incbin \"duke.lzsa\"" > duke.inc

####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
	rm -f *~ *.o *.lst HELLO DUKE




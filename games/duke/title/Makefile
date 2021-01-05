#include ../Makefile.inc

B2D = ../../bmp2dhr/b2d
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa


all:	new_title.lzsa

####

duke_title.lzsa:	DUKE_TITLEC.BIN
	$(LZSA) -r -f2 DUKE_TITLEC.BIN duke_title.lzsa

DUKE_TITLEC.BIN:	duke_title.bmp
	$(B2D) duke_title.bmp HGR -d

####

new_title.lzsa:	NEW_TITLEC.BIN
	$(LZSA) -r -f2 NEW_TITLEC.BIN new_title.lzsa

NEW_TITLEC.BIN:	new_title.bmp
	$(B2D) new_title.bmp HGR


####

clean:		
		rm -f *~ *.o *.lst

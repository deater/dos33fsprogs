#include ../Makefile.inc

B2D = ../../bmp2dhr/b2d
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa


all:	mist_title.lzsa

####

mist_title.lzsa:	MIST_TITLEC.BIN
	$(LZSA) -r -f2 MIST_TITLEC.BIN mist_title.lzsa

MIST_TITLEC.BIN:	mist_title.bmp
	$(B2D) mist_title.bmp HGR -d

####

%.gr:	%.png
	 $(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@


####

clean:		
		rm -f *~ *.o *.lst

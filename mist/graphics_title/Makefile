#include ../Makefile.inc

B2D = ../../bmp2dhr/b2d
LZSA = ~/research/lzsa/lzsa/lzsa

all:	mist_title.lzsa

####

mist_title.lzsa:	MIST_TITLEC.BIN
	$(LZSA) -r -f2 MIST_TITLEC.BIN mist_title.lzsa

MIST_TITLEC.BIN:	mist_title.bmp
	$(B2D) mist_title.bmp HGR -d

####

clean:		
		rm -f *~ *.o *.lst

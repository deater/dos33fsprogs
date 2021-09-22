#include ../Makefile.inc

B2D = ../../../utils/bmp2dhr/b2d
PNG2GR = ../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa
MAKE_VGI = ../../../graphics/hgr/vgi/make_vgi_asm

all:	cyan.pt3.lzsa theme.pt3.lzsa

####

cyan.pt3.lzsa:	cyan.pt3
	$(LZSA) -r -f2 cyan.pt3 cyan.pt3.lzsa

####

theme.pt3.lzsa:	theme.pt3
	$(LZSA) -r -f2 theme.pt3 theme.pt3.lzsa


####

clean:		
		rm -f *~ *.o *.lzsa

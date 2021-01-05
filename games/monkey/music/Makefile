#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	music.inc

####

music.inc:	\
	theme.lzsa
	echo "theme_lzsa: .incbin \"theme.lzsa\"" > music.inc

%.lzsa: %.krg
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa music.inc

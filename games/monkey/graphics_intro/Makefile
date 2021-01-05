#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	title_graphics.inc

####

title_graphics.inc:	\
	logo.lzsa monkey.lzsa title.lzsa
	echo "logo_lzsa: .incbin \"logo.lzsa\"" > title_graphics.inc
	echo "monkey_lzsa: .incbin \"monkey.lzsa\"" >> title_graphics.inc
	echo "title_lzsa: .incbin \"title.lzsa\"" >> title_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa title_graphics.inc

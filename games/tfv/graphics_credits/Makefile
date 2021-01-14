include ../../../Makefile.inc

PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	KATC.lzsa

%.lzsa:	%.BIN
	$(LZSA) -r -f2 $< $@

clean:	
	rm -f *~ KATC.LZSA


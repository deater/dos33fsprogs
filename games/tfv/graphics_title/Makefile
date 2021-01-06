include ../../../Makefile.inc

PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

tfv_title.inc:	\
	title.lzsa
	echo "title_lzsa: .incbin \"title.lzsa\"" > tfv_title.inc

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

clean:	
	rm -f *~ tfv_title.inc


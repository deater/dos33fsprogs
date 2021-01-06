
PNG2GR = ../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	level1_graphics.inc level2_graphics.inc

####

level1_graphics.inc:	level1_bg.lzsa
	echo "level1_bg_lzsa: .incbin \"level1_bg.lzsa\"" > level1_graphics.inc

####

level2_graphics.inc:	level2_bg.lzsa
	echo "level2_bg_lzsa: .incbin \"level2_bg.lzsa\"" > level2_graphics.inc

####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
	rm -f *~ *.o *.lst *.lzsa level1_graphics.inc level2_graphics.inc

#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	graphics.inc

####

graphics.inc:	\
	lookout.lzsa poster.lzsa dock.lzsa bar.lzsa town.lzsa map.lzsa
	echo "lookout_lzsa: .incbin \"lookout.lzsa\"" > graphics.inc
	echo "poster_lzsa: .incbin \"poster.lzsa\"" >> graphics.inc
	echo "dock_lzsa: .incbin \"dock.lzsa\"" >> graphics.inc
	echo "bar_lzsa: .incbin \"bar.lzsa\"" >> graphics.inc
	echo "town_lzsa: .incbin \"town.lzsa\"" >> graphics.inc
	echo "map_lzsa: .incbin \"map.lzsa\"" >> graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa graphics.inc

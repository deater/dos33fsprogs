#include ../Makefile.inc

PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	battle_music.inc


####

battle_music.inc:	\
	fighting.lzsa victory.lzsa
	echo "fighting_lzsa: .incbin \"fighting.lzsa\"" > battle_music.inc
	echo "victory_lzsa: .incbin \"victory.lzsa\"" >> battle_music.inc



%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.pt3
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa battle_music.inc

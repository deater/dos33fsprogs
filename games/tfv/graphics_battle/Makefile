#include ../Makefile.inc

PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	battle_graphics.inc


####

battle_graphics.inc:	\
	plains_battle.lzsa \
	plains_anim01.lzsa plains_anim02.lzsa plains_anim03.lzsa \
	plains_anim04.lzsa plains_anim05.lzsa plains_anim06.lzsa \
	plains_anim07.lzsa plains_anim08.lzsa plains_anim09.lzsa \
	plains_anim10.lzsa
	echo "plains_battle: .incbin \"plains_battle.lzsa\"" > battle_graphics.inc
	echo "plains_anim01: .incbin \"plains_anim01.lzsa\"" >> battle_graphics.inc
	echo "plains_anim02: .incbin \"plains_anim02.lzsa\"" >> battle_graphics.inc
	echo "plains_anim03: .incbin \"plains_anim03.lzsa\"" >> battle_graphics.inc
	echo "plains_anim04: .incbin \"plains_anim04.lzsa\"" >> battle_graphics.inc
	echo "plains_anim05: .incbin \"plains_anim05.lzsa\"" >> battle_graphics.inc
	echo "plains_anim06: .incbin \"plains_anim06.lzsa\"" >> battle_graphics.inc
	echo "plains_anim07: .incbin \"plains_anim07.lzsa\"" >> battle_graphics.inc
	echo "plains_anim08: .incbin \"plains_anim08.lzsa\"" >> battle_graphics.inc
	echo "plains_anim09: .incbin \"plains_anim09.lzsa\"" >> battle_graphics.inc
	echo "plains_anim10: .incbin \"plains_anim10.lzsa\"" >> battle_graphics.inc



%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa battle_graphics.inc

#include ../Makefile.inc

PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ship_graphics.inc

####

ship_graphics.inc:	\
	ship_entry_n.lzsa ship_entry_s.lzsa \
	ship_bow_s.lzsa ship_bow_go_n.lzsa \
	ship_door_open_s.lzsa ship_door_closed_s.lzsa \
	book_chair_s.lzsa book_chair_n.lzsa \
	book_chair_open_s.lzsa book_chair_closed_s.lzsa
	echo "ship_entry_n_lzsa: .incbin \"ship_entry_n.lzsa\"" > ship_graphics.inc
	echo "ship_entry_s_lzsa: .incbin \"ship_entry_s.lzsa\"" >> ship_graphics.inc
	echo "ship_bow_s_lzsa: .incbin \"ship_bow_s.lzsa\"" >> ship_graphics.inc
	echo "ship_bow_go_n_lzsa: .incbin \"ship_bow_go_n.lzsa\"" >> ship_graphics.inc
	echo "ship_door_open_s_lzsa: .incbin \"ship_door_open_s.lzsa\"" >> ship_graphics.inc
	echo "ship_door_closed_s_lzsa: .incbin \"ship_door_closed_s.lzsa\"" >> ship_graphics.inc
	echo "book_chair_s_lzsa: .incbin \"book_chair_s.lzsa\"" >> ship_graphics.inc
	echo "book_chair_n_lzsa: .incbin \"book_chair_n.lzsa\"" >> ship_graphics.inc
	echo "book_chair_open_s_lzsa: .incbin \"book_chair_open_s.lzsa\"" >> ship_graphics.inc
	echo "book_chair_closed_s_lzsa: .incbin \"book_chair_closed_s.lzsa\"" >> ship_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa ship_graphics.inc

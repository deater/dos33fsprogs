#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	meche_graphics.inc


####

meche_graphics.inc:	\
	departure_e.lzsa \
	arrival_w.lzsa \
	entrance_e.lzsa entrance_s.lzsa entrance_n.lzsa entrance_w.lzsa \
	meche_book_closed.lzsa meche_book_open.lzsa
	echo "departure_e_lzsa: .incbin \"departure_e.lzsa\"" > meche_graphics.inc
	echo "arrival_w_lzsa: .incbin \"arrival_w.lzsa\"" >> meche_graphics.inc
	echo "entrance_e_lzsa: .incbin \"entrance_e.lzsa\"" >> meche_graphics.inc
	echo "entrance_s_lzsa: .incbin \"entrance_s.lzsa\"" >> meche_graphics.inc
	echo "entrance_n_lzsa: .incbin \"entrance_n.lzsa\"" >> meche_graphics.inc
	echo "entrance_w_lzsa: .incbin \"entrance_w.lzsa\"" >> meche_graphics.inc
	echo "meche_book_closed_lzsa: .incbin \"meche_book_closed.lzsa\"" >> meche_graphics.inc
	echo "meche_book_open_lzsa: .incbin \"meche_book_open.lzsa\"" >> meche_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr meche_graphics.inc

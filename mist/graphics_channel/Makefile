#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	channel_graphics.inc

####

channel_graphics.inc:	\
	arrival_n.lzsa arrival_s.lzsa \
	tree_basement_n.lzsa tree_basement_s.lzsa \
	tree_basement_book_s.lzsa \
	tree_elevator_basement_s.lzsa
	echo "arrival_n_lzsa: .incbin \"arrival_n.lzsa\"" > channel_graphics.inc
	echo "arrival_s_lzsa: .incbin \"arrival_s.lzsa\"" >> channel_graphics.inc
	echo "tree_basement_s_lzsa: .incbin \"tree_basement_s.lzsa\"" >> channel_graphics.inc
	echo "tree_basement_n_lzsa: .incbin \"tree_basement_n.lzsa\"" >> channel_graphics.inc
	echo "tree_basement_book_s_lzsa: .incbin \"tree_basement_book_s.lzsa\"" >> channel_graphics.inc
	echo "tree_elevator_basement_s_lzsa: .incbin \"tree_elevator_basement_s.lzsa\"" >> channel_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa channel_graphics.inc

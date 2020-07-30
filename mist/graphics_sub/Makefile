#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	sub_graphics.inc


####

sub_graphics.inc:	\
	subroom_s.lzsa subroom_n.lzsa \
	book_table_n.lzsa book_table_s.lzsa \
	book_mist_open_s.lzsa book_mist_closed_s.lzsa \
	book_hallway_n.lzsa book_hallway_s.lzsa \
	inside_sub_e.lzsa inside_sub_w.lzsa \
	bunker_entry_e.lzsa bunker_entry_w.lzsa \
	sub_hallway_e.lzsa sub_hallway_w.lzsa
	echo "subroom_s_lzsa: .incbin \"subroom_s.lzsa\"" > sub_graphics.inc
	echo "subroom_n_lzsa: .incbin \"subroom_n.lzsa\"" >> sub_graphics.inc
	echo "book_table_s_lzsa: .incbin \"book_table_s.lzsa\"" >> sub_graphics.inc
	echo "book_table_n_lzsa: .incbin \"book_table_n.lzsa\"" >> sub_graphics.inc
	echo "book_mist_open_s_lzsa: .incbin \"book_mist_open_s.lzsa\"" >> sub_graphics.inc
	echo "book_mist_closed_s_lzsa: .incbin \"book_mist_closed_s.lzsa\"" >> sub_graphics.inc
	echo "inside_sub_e_lzsa: .incbin \"inside_sub_e.lzsa\"" >> sub_graphics.inc
	echo "inside_sub_w_lzsa: .incbin \"inside_sub_w.lzsa\"" >> sub_graphics.inc
	echo "bunker_entry_e_lzsa: .incbin \"bunker_entry_e.lzsa\"" >> sub_graphics.inc
	echo "bunker_entry_w_lzsa: .incbin \"bunker_entry_w.lzsa\"" >> sub_graphics.inc
	echo "sub_hallway_e_lzsa: .incbin \"sub_hallway_e.lzsa\"" >> sub_graphics.inc
	echo "sub_hallway_w_lzsa: .incbin \"sub_hallway_w.lzsa\"" >> sub_graphics.inc
	echo "book_hallway_n_lzsa: .incbin \"book_hallway_n.lzsa\"" >> sub_graphics.inc
	echo "book_hallway_s_lzsa: .incbin \"book_hallway_s.lzsa\"" >> sub_graphics.inc


%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa sub_graphics.inc

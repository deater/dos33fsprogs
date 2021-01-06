#include ../Makefile.inc

B2D = ../../../utils/bmp2dhr/b2d
PNG2GR = ../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa


all:	title_graphics.inc

####

title_graphics.inc:	m_link_book.lzsa \
	m_title_m.lzsa m_title_y.lzsa m_title_s.lzsa m_title_t.lzsa \
	fissure.lzsa fissure_book_small.lzsa fissure_book_big.lzsa \
	falling_right.lzsa falling_left.lzsa \
	book_air.lzsa book_sparks.lzsa book_glow.lzsa \
	book_ground.lzsa book_ground_n.lzsa \
	book_closed_n.lzsa
	echo "m_link_book_lzsa: .incbin \"m_link_book.lzsa\"" > title_graphics.inc
	echo "m_title_m_lzsa: .incbin \"m_title_m.lzsa\"" >> title_graphics.inc
	echo "m_title_y_lzsa: .incbin \"m_title_y.lzsa\"" >> title_graphics.inc
	echo "m_title_s_lzsa: .incbin \"m_title_s.lzsa\"" >> title_graphics.inc
	echo "m_title_t_lzsa: .incbin \"m_title_t.lzsa\"" >> title_graphics.inc
	echo "fissure_lzsa: .incbin \"fissure.lzsa\"" >> title_graphics.inc
	echo "fissure_book_small_lzsa: .incbin \"fissure_book_small.lzsa\"" >> title_graphics.inc
	echo "fissure_book_big_lzsa: .incbin \"fissure_book_big.lzsa\"" >> title_graphics.inc
	echo "falling_right_lzsa: .incbin \"falling_right.lzsa\"" >> title_graphics.inc
	echo "falling_left_lzsa: .incbin \"falling_left.lzsa\"" >> title_graphics.inc
	echo "book_air_lzsa: .incbin \"book_air.lzsa\"" >> title_graphics.inc
	echo "book_sparks_lzsa: .incbin \"book_sparks.lzsa\"" >> title_graphics.inc
	echo "book_glow_lzsa: .incbin \"book_glow.lzsa\"" >> title_graphics.inc
	echo "book_ground_lzsa: .incbin \"book_ground.lzsa\"" >> title_graphics.inc
	echo "book_ground_n_lzsa: .incbin \"book_ground_n.lzsa\"" >> title_graphics.inc
	echo "book_closed_n_lzsa: .incbin \"book_closed_n.lzsa\"" >> title_graphics.inc














%.gr:	%.png
	 $(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@


####

clean:		
		rm -f *~ *.o *.lst

#include ../Makefile.inc

B2D = ../../../utils/bmp2dhr/b2d
PNG2GR = ../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa
MAKE_VGI = ../../../graphics/hgr/vgi/make_vgi_asm

all:	title_graphics.inc

####

title_graphics.inc:	\
	cyan1.lzsa cyan2.lzsa \
	m_title_m.lzsa m_title_y.lzsa m_title_s.lzsa m_title_t.lzsa \
	fissure_stars.lzsa fissure_crescent.lzsa fissure.lzsa fissure2.lzsa \
	fissure_book_small.lzsa fissure_book_big.lzsa \
	m_link_book.lzsa book_closed_n.lzsa book_ground_n.lzsa \
	starfield.lzsa \
	falling_left_top.lzsa falling_left_center.lzsa falling_left_bottom.lzsa \
	falling_right_top.lzsa falling_right_bottom.lzsa \
	erase_left_bottom.lzsa erase_right_bottom.lzsa \
	book_ground_stars.lzsa book_air.lzsa book_air2.lzsa book_air3.lzsa \
	book_sparks.lzsa book_glow.lzsa book_ground.lzsa
	echo "cyan1_lzsa: .incbin \"cyan1.lzsa\"" > title_graphics.inc
	echo "cyan2_lzsa: .incbin \"cyan2.lzsa\"" >> title_graphics.inc
	echo "m_link_book_lzsa: .incbin \"m_link_book.lzsa\"" >> title_graphics.inc
	echo "m_title_m_lzsa: .incbin \"m_title_m.lzsa\"" >> title_graphics.inc
	echo "m_title_y_lzsa: .incbin \"m_title_y.lzsa\"" >> title_graphics.inc
	echo "m_title_s_lzsa: .incbin \"m_title_s.lzsa\"" >> title_graphics.inc
	echo "m_title_t_lzsa: .incbin \"m_title_t.lzsa\"" >> title_graphics.inc
	echo "fissure_stars_lzsa: .incbin \"fissure_stars.lzsa\"" >> title_graphics.inc
	echo "fissure_crescent_lzsa: .incbin \"fissure_crescent.lzsa\"" >> title_graphics.inc
	echo "fissure_lzsa: .incbin \"fissure.lzsa\"" >> title_graphics.inc
	echo "fissure2_lzsa: .incbin \"fissure2.lzsa\"" >> title_graphics.inc
	echo "fissure_book_small_lzsa: .incbin \"fissure_book_small.lzsa\"" >> title_graphics.inc
	echo "fissure_book_big_lzsa: .incbin \"fissure_book_big.lzsa\"" >> title_graphics.inc
	echo "book_air_lzsa: .incbin \"book_air.lzsa\"" >> title_graphics.inc
	echo "book_air2_lzsa: .incbin \"book_air2.lzsa\"" >> title_graphics.inc
	echo "book_air3_lzsa: .incbin \"book_air3.lzsa\"" >> title_graphics.inc
	echo "book_sparks_lzsa: .incbin \"book_sparks.lzsa\"" >> title_graphics.inc
	echo "book_glow_lzsa: .incbin \"book_glow.lzsa\"" >> title_graphics.inc
	echo "book_ground_lzsa: .incbin \"book_ground.lzsa\"" >> title_graphics.inc
	echo "book_ground_n_lzsa: .incbin \"book_ground_n.lzsa\"" >> title_graphics.inc
	echo "book_closed_n_lzsa: .incbin \"book_closed_n.lzsa\"" >> title_graphics.inc
	echo "starfield_lzsa: .incbin \"starfield.lzsa\"" >> title_graphics.inc
	echo "falling_left_top_lzsa: .incbin \"falling_left_top.lzsa\"" >> title_graphics.inc
	echo "falling_left_center_lzsa: .incbin \"falling_left_center.lzsa\"" >> title_graphics.inc
	echo "falling_left_bottom_lzsa: .incbin \"falling_left_bottom.lzsa\"" >> title_graphics.inc
	echo "erase_left_bottom_lzsa: .incbin \"erase_left_bottom.lzsa\"" >> title_graphics.inc
	echo "falling_right_top_lzsa: .incbin \"falling_right_top.lzsa\"" >> title_graphics.inc
	echo "falling_right_bottom_lzsa: .incbin \"falling_right_bottom.lzsa\"" >> title_graphics.inc
	echo "erase_right_bottom_lzsa: .incbin \"erase_right_bottom.lzsa\"" >> title_graphics.inc
	echo "book_ground_stars_lzsa: .incbin \"book_ground_stars.lzsa\"" >> title_graphics.inc

####

%.data:	%.vgi
	 $(MAKE_VGI) -b < $< > $@

%.lzsa:	%.data
	$(LZSA) -r -f2 $< $@


####

clean:		
		rm -f *~ *.o *.lst *.data *.lzsa title_graphics.inc

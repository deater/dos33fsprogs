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
	fissure_book_small.lzsa fissure_book_big.lzsa
	echo "cyan1_lzsa: .incbin \"cyan1.lzsa\"" > title_graphics.inc
	echo "cyan2_lzsa: .incbin \"cyan2.lzsa\"" >> title_graphics.inc
	echo "m_link_book_lzsa: .incbin \"fissure_stars.lzsa\"" >> title_graphics.inc
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
	echo "falling_right_lzsa: .incbin \"fissure_stars.lzsa\"" >> title_graphics.inc
	echo "falling_left_lzsa: .incbin \"fissure_stars.lzsa\"" >> title_graphics.inc
	echo "book_air_lzsa: .incbin \"fissure_stars.lzsa\"" >> title_graphics.inc
	echo "book_sparks_lzsa: .incbin \"fissure_stars.lzsa\"" >> title_graphics.inc
	echo "book_glow_lzsa: .incbin \"fissure_stars.lzsa\"" >> title_graphics.inc
	echo "book_ground_lzsa: .incbin \"fissure_stars.lzsa\"" >> title_graphics.inc
	echo "book_ground_n_lzsa: .incbin \"fissure_stars.lzsa\"" >> title_graphics.inc
	echo "book_closed_n_lzsa: .incbin \"fissure_stars.lzsa\"" >> title_graphics.inc

####

%.data:	%.vgi
	 $(MAKE_VGI) -b < $< > $@

%.lzsa:	%.data
	$(LZSA) -r -f2 $< $@


####

clean:		
		rm -f *~ *.o *.lst *.data *.lzsa title_graphics.inc

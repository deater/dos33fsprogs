#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	dni_graphics.inc


####

dni_graphics.inc:	\
	dni_n.lzsa dni_s.lzsa dni_e.lzsa dni_w.lzsa \
	dni_desk_n.lzsa dni_desk_s.lzsa \
	dni_desk_book_open_n.lzsa dni_desk_book_closed_n.lzsa
	echo "dni_n_lzsa: .incbin \"dni_n.lzsa\"" > dni_graphics.inc
	echo "dni_s_lzsa: .incbin \"dni_s.lzsa\"" >> dni_graphics.inc
	echo "dni_e_lzsa: .incbin \"dni_e.lzsa\"" >> dni_graphics.inc
	echo "dni_w_lzsa: .incbin \"dni_w.lzsa\"" >> dni_graphics.inc
	echo "dni_desk_n_lzsa: .incbin \"dni_desk_n.lzsa\"" >> dni_graphics.inc
	echo "dni_desk_book_closed_n_lzsa: .incbin \"dni_desk_book_closed_n.lzsa\"" >> dni_graphics.inc
	echo "dni_desk_book_open_n_lzsa: .incbin \"dni_desk_book_open_n.lzsa\"" >> dni_graphics.inc
	echo "dni_desk_s_lzsa: .incbin \"dni_desk_s.lzsa\"" >> dni_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa dni_graphics.inc

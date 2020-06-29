#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	nibel_graphics.inc

####

nibel_graphics.inc:	\
	elevator2_open_top.lzsa elevator2_closed_top.lzsa \
	outside_elevator2_e.lzsa outside_elevator2_open_w.lzsa outside_elevator2_closed_w.lzsa \
	blue_path1_n.lzsa blue_path1_s.lzsa \
	blue_path2_n.lzsa blue_path2_s.lzsa
	echo "elevator2_open_top_lzsa: .incbin \"elevator2_open_top.lzsa\"" > nibel_graphics.inc
	echo "elevator2_closed_top_lzsa: .incbin \"elevator2_closed_top.lzsa\"" >> nibel_graphics.inc
	echo "outside_elevator2_e_lzsa: .incbin \"outside_elevator2_e.lzsa\"" >> nibel_graphics.inc
	echo "outside_elevator2_open_w_lzsa: .incbin \"outside_elevator2_open_w.lzsa\"" >> nibel_graphics.inc
	echo "outside_elevator2_closed_w_lzsa: .incbin \"outside_elevator2_closed_w.lzsa\"" >> nibel_graphics.inc
	echo "blue_path1_n_lzsa: .incbin \"blue_path1_n.lzsa\"" >> nibel_graphics.inc
	echo "blue_path1_s_lzsa: .incbin \"blue_path1_s.lzsa\"" >> nibel_graphics.inc
	echo "blue_path2_n_lzsa: .incbin \"blue_path2_n.lzsa\"" >> nibel_graphics.inc
	echo "blue_path2_s_lzsa: .incbin \"blue_path2_s.lzsa\"" >> nibel_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa nibel_graphics.inc

#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	arbor_graphics.inc

####

arbor_graphics.inc:	\
	arrival_e.lzsa arrival_w.lzsa arrival_open_e.lzsa \
	inside_elevator1_closed_w.lzsa inside_elevator1_open_w.lzsa
	echo "arrival_e_lzsa: .incbin \"arrival_e.lzsa\"" > arbor_graphics.inc
	echo "arrival_open_e_lzsa: .incbin \"arrival_open_e.lzsa\"" >> arbor_graphics.inc
	echo "arrival_w_lzsa: .incbin \"arrival_w.lzsa\"" >> arbor_graphics.inc
	echo "inside_elevator1_open_w_lzsa: .incbin \"inside_elevator1_open_w.lzsa\"" >> arbor_graphics.inc
	echo "inside_elevator1_closed_w_lzsa: .incbin \"inside_elevator1_closed_w.lzsa\"" >> arbor_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa channel_graphics.inc

#include ../Makefile.inc

PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	viewer_graphics.inc

####

viewer_graphics.inc:	\
	viewer_e.lzsa viewer_w.lzsa \
	viewer_far_w.lzsa \
	viewer_stairs_e.lzsa viewer_stairs_w.lzsa \
	viewer_stairs_ship_e.lzsa \
	viewer_controls_e.lzsa \
	viewer_entrance_e.lzsa viewer_entrance_ship_e.lzsa \
	viewer_entrance_w.lzsa
	echo "viewer_e_lzsa: .incbin \"viewer_e.lzsa\"" > viewer_graphics.inc
	echo "viewer_far_w_lzsa: .incbin \"viewer_far_w.lzsa\"" >> viewer_graphics.inc
	echo "viewer_w_lzsa: .incbin \"viewer_w.lzsa\"" >> viewer_graphics.inc
	echo "viewer_stairs_e_lzsa: .incbin \"viewer_stairs_e.lzsa\"" >> viewer_graphics.inc
	echo "viewer_stairs_ship_e_lzsa: .incbin \"viewer_stairs_ship_e.lzsa\"" >> viewer_graphics.inc
	echo "viewer_stairs_w_lzsa: .incbin \"viewer_stairs_w.lzsa\"" >> viewer_graphics.inc
	echo "viewer_controls_e_lzsa: .incbin \"viewer_controls_e.lzsa\"" >> viewer_graphics.inc
	echo "viewer_entrance_e_lzsa: .incbin \"viewer_entrance_e.lzsa\"" >> viewer_graphics.inc
	echo "viewer_entrance_ship_e_lzsa: .incbin \"viewer_entrance_ship_e.lzsa\"" >> viewer_graphics.inc
	echo "viewer_entrance_w_lzsa: .incbin \"viewer_entrance_w.lzsa\"" >> viewer_graphics.inc



%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa viewer_graphics.inc

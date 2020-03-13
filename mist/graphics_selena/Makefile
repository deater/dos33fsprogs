#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	selena_graphics.inc


####

selena_graphics.inc:	\
	controls_e.lzsa \
	organ_w.lzsa \
	spaceship_inside_w.lzsa \
	spaceship_inside_selena_n.lzsa \
	walkway1_n.lzsa
	echo "controls_e_lzsa: .incbin \"controls_e.lzsa\"" > selena_graphics.inc
	echo "organ_w_lzsa: .incbin \"organ_w.lzsa\"" >> selena_graphics.inc
	echo "spaceship_inside_w_lzsa: .incbin \"spaceship_inside_w.lzsa\"" >> selena_graphics.inc
	echo "spaceship_inside_selena_n_lzsa: .incbin \"spaceship_inside_selena_n.lzsa\"" >> selena_graphics.inc
	echo "walkway1_n_lzsa: .incbin \"walkway1_n.lzsa\"" >> selena_graphics.inc


%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr selena_graphics.inc

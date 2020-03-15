#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	selena_graphics.inc


####

selena_graphics.inc:	\
	controls_e.lzsa \
	organ_w.lzsa \
	spaceship_inside_w.lzsa spaceship_inside_e.lzsa \
	spaceship_inside_selena_n.lzsa spaceship_inside_mist_n.lzsa \
	walkway1_n.lzsa walkway1_s.lzsa \
	spaceship_door_s.lzsa \
	walkway4_n.lzsa walkway4_s.lzsa \
	bunker_n.lzsa bunker_s.lzsa bunker_e.lzsa
	echo "controls_e_lzsa: .incbin \"controls_e.lzsa\"" > selena_graphics.inc
	echo "organ_w_lzsa: .incbin \"organ_w.lzsa\"" >> selena_graphics.inc
	echo "spaceship_inside_w_lzsa: .incbin \"spaceship_inside_w.lzsa\"" >> selena_graphics.inc
	echo "spaceship_inside_e_lzsa: .incbin \"spaceship_inside_e.lzsa\"" >> selena_graphics.inc
	echo "spaceship_inside_selena_n_lzsa: .incbin \"spaceship_inside_selena_n.lzsa\"" >> selena_graphics.inc
	echo "spaceship_inside_mist_n_lzsa: .incbin \"spaceship_inside_mist_n.lzsa\"" >> selena_graphics.inc
	echo "walkway1_n_lzsa: .incbin \"walkway1_n.lzsa\"" >> selena_graphics.inc
	echo "walkway1_s_lzsa: .incbin \"walkway1_s.lzsa\"" >> selena_graphics.inc
	echo "spaceship_door_s_lzsa: .incbin \"spaceship_door_s.lzsa\"" >> selena_graphics.inc
	echo "walkway4_n_lzsa: .incbin \"walkway4_n.lzsa\"" >> selena_graphics.inc
	echo "walkway4_s_lzsa: .incbin \"walkway4_s.lzsa\"" >> selena_graphics.inc
	echo "bunker_n_lzsa: .incbin \"bunker_n.lzsa\"" >> selena_graphics.inc
	echo "bunker_s_lzsa: .incbin \"bunker_s.lzsa\"" >> selena_graphics.inc
	echo "bunker_e_lzsa: .incbin \"bunker_e.lzsa\"" >> selena_graphics.inc


%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr selena_graphics.inc

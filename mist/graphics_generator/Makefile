#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	generator_graphics.inc


####

generator_graphics.inc:	\
	generator_n.lzsa generator_s.lzsa \
	green_house_w.lzsa green_house_e.lzsa \
	green_steps1_n.lzsa green_steps1_s.lzsa \
	gen_door_closed_n.lzsa gen_door_open_n.lzsa gen_door_s.lzsa \
	green_steps6_n.lzsa green_steps6_w.lzsa \
	tower1_trail_w.lzsa tower1_trail_e.lzsa \
	tower1_trail2_n.lzsa tower1_trail2_s.lzsa tower1_trail2_w.lzsa \
	tower1_base_e.lzsa \
	tower1_top_e.lzsa
	echo "generator_n_lzsa: .incbin \"generator_n.lzsa\"" > generator_graphics.inc
	echo "generator_s_lzsa: .incbin \"generator_s.lzsa\"" >> generator_graphics.inc
	echo "green_house_w_lzsa: .incbin \"green_house_w.lzsa\"" >> generator_graphics.inc
	echo "green_house_e_lzsa: .incbin \"green_house_e.lzsa\"" >> generator_graphics.inc
	echo "green_steps1_n_lzsa: .incbin \"green_steps1_n.lzsa\"" >> generator_graphics.inc
	echo "green_steps1_s_lzsa: .incbin \"green_steps1_s.lzsa\"" >> generator_graphics.inc
	echo "gen_door_closed_n_lzsa: .incbin \"gen_door_closed_n.lzsa\"" >> generator_graphics.inc
	echo "gen_door_open_n_lzsa: .incbin \"gen_door_open_n.lzsa\"" >> generator_graphics.inc
	echo "gen_door_s_lzsa: .incbin \"gen_door_s.lzsa\"" >> generator_graphics.inc
	echo "green_steps6_n_lzsa: .incbin \"green_steps6_n.lzsa\"" >> generator_graphics.inc
	echo "green_steps6_w_lzsa: .incbin \"green_steps6_w.lzsa\"" >> generator_graphics.inc
	echo "tower1_trail_w_lzsa: .incbin \"tower1_trail_w.lzsa\"" >> generator_graphics.inc
	echo "tower1_trail_e_lzsa: .incbin \"tower1_trail_e.lzsa\"" >> generator_graphics.inc
	echo "tower1_trail2_n_lzsa: .incbin \"tower1_trail2_n.lzsa\"" >> generator_graphics.inc
	echo "tower1_trail2_w_lzsa: .incbin \"tower1_trail2_w.lzsa\"" >> generator_graphics.inc
	echo "tower1_trail2_s_lzsa: .incbin \"tower1_trail2_s.lzsa\"" >> generator_graphics.inc
	echo "tower1_base_e_lzsa: .incbin \"tower1_base_e.lzsa\"" >> generator_graphics.inc
	echo "tower1_top_e_lzsa: .incbin \"tower1_top_e.lzsa\"" >> generator_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa generator_graphics.inc

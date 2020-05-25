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
	bunker_n.lzsa bunker_s.lzsa bunker_e.lzsa \
	subroom_s.lzsa \
	book_table_s.lzsa \
	book_mist_open_s.lzsa book_mist_closed_s.lzsa \
	water_turn_n.lzsa water_turn_s.lzsa water_turn_w.lzsa \
	water_path_e.lzsa water_path_w.lzsa \
	water_note_e.lzsa water_note_w.lzsa water_note_s.lzsa \
	tower_view_n.lzsa tower_view_s.lzsa tower_view_e.lzsa tower_view_w.lzsa \
	chasm_path_e.lzsa chasm_path_w.lzsa \
	chasm_e.lzsa chasm_s.lzsa chasm_n.lzsa
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
	echo "subroom_s_lzsa: .incbin \"subroom_s.lzsa\"" >> selena_graphics.inc
	echo "book_table_s_lzsa: .incbin \"book_table_s.lzsa\"" >> selena_graphics.inc
	echo "book_mist_open_s_lzsa: .incbin \"book_mist_open_s.lzsa\"" >> selena_graphics.inc
	echo "book_mist_closed_s_lzsa: .incbin \"book_mist_closed_s.lzsa\"" >> selena_graphics.inc
	echo "water_turn_n_lzsa: .incbin \"water_turn_n.lzsa\"" >> selena_graphics.inc
	echo "water_turn_s_lzsa: .incbin \"water_turn_s.lzsa\"" >> selena_graphics.inc
	echo "water_turn_w_lzsa: .incbin \"water_turn_w.lzsa\"" >> selena_graphics.inc
	echo "water_path_w_lzsa: .incbin \"water_path_w.lzsa\"" >> selena_graphics.inc
	echo "water_path_e_lzsa: .incbin \"water_path_e.lzsa\"" >> selena_graphics.inc
	echo "water_note_e_lzsa: .incbin \"water_note_e.lzsa\"" >> selena_graphics.inc
	echo "water_note_w_lzsa: .incbin \"water_note_w.lzsa\"" >> selena_graphics.inc
	echo "water_note_s_lzsa: .incbin \"water_note_s.lzsa\"" >> selena_graphics.inc
	echo "tower_view_n_lzsa: .incbin \"tower_view_n.lzsa\"" >> selena_graphics.inc
	echo "tower_view_s_lzsa: .incbin \"tower_view_s.lzsa\"" >> selena_graphics.inc
	echo "tower_view_e_lzsa: .incbin \"tower_view_e.lzsa\"" >> selena_graphics.inc
	echo "tower_view_w_lzsa: .incbin \"tower_view_w.lzsa\"" >> selena_graphics.inc
	echo "chasm_path_e_lzsa: .incbin \"chasm_path_e.lzsa\"" >> selena_graphics.inc
	echo "chasm_path_w_lzsa: .incbin \"chasm_path_w.lzsa\"" >> selena_graphics.inc
	echo "chasm_e_lzsa: .incbin \"chasm_e.lzsa\"" >> selena_graphics.inc
	echo "chasm_n_lzsa: .incbin \"chasm_n.lzsa\"" >> selena_graphics.inc
	echo "chasm_s_lzsa: .incbin \"chasm_s.lzsa\"" >> selena_graphics.inc



%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr selena_graphics.inc

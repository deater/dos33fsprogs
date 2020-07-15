#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	cabin_graphics.inc

####

cabin_graphics.inc:	\
	clearing_e.lzsa clearing_s.lzsa clearing_w.lzsa \
	clearing_e_open.lzsa \
	boiler_room_e.lzsa \
	boiler_e.lzsa boiler_w.lzsa \
	safe_w.lzsa safe_open_w.lzsa \
	clock_path_n.lzsa clock_path_s.lzsa \
	tree_path_e.lzsa tree_path_w.lzsa \
	tree_base_n.lzsa tree_base_s.lzsa \
	tree_basement_n.lzsa tree_basement_s.lzsa \
	tree_basement_book_s.lzsa \
	tree_basement_book_open_s.lzsa \
	tree_basement_book_closed_s.lzsa \
	tree_elevator_basement_s.lzsa \
	tree_elevator_l2.lzsa tree_elevator_l4.lzsa tree_elevator_l6.lzsa \
	tree_elevator_l8.lzsa tree_elevator_l10.lzsa tree_elevator_l12.lzsa \
	tree_elevator_top_down.lzsa \
	tree_base_l4_n.lzsa tree_base_l6_n.lzsa \
	tree_base_up.lzsa \
	tree_base_up_l2.lzsa tree_base_up_l4.lzsa tree_base_up_l6.lzsa\
	tree_base_up_l8.lzsa tree_base_up_l10.lzsa tree_base_up_l12.lzsa
	echo "clearing_e_lzsa: .incbin \"clearing_e.lzsa\"" > cabin_graphics.inc
	echo "clearing_s_lzsa: .incbin \"clearing_s.lzsa\"" >> cabin_graphics.inc
	echo "clearing_w_lzsa: .incbin \"clearing_w.lzsa\"" >> cabin_graphics.inc
	echo "clearing_e_open_lzsa: .incbin \"clearing_e_open.lzsa\"" >> cabin_graphics.inc
	echo "boiler_room_e_lzsa: .incbin \"boiler_room_e.lzsa\"" >> cabin_graphics.inc
	echo "boiler_e_lzsa: .incbin \"boiler_e.lzsa\"" >> cabin_graphics.inc
	echo "boiler_w_lzsa: .incbin \"boiler_w.lzsa\"" >> cabin_graphics.inc
	echo "safe_w_lzsa: .incbin \"safe_w.lzsa\"" >> cabin_graphics.inc
	echo "safe_open_w_lzsa: .incbin \"safe_open_w.lzsa\"" >> cabin_graphics.inc
	echo "clock_path_n_lzsa: .incbin \"clock_path_n.lzsa\"" >> cabin_graphics.inc
	echo "clock_path_s_lzsa: .incbin \"clock_path_s.lzsa\"" >> cabin_graphics.inc
	echo "tree_path_e_lzsa: .incbin \"tree_path_e.lzsa\"" >> cabin_graphics.inc
	echo "tree_path_w_lzsa: .incbin \"tree_path_w.lzsa\"" >> cabin_graphics.inc
	echo "tree_base_n_lzsa: .incbin \"tree_base_n.lzsa\"" >> cabin_graphics.inc
	echo "tree_base_s_lzsa: .incbin \"tree_base_s.lzsa\"" >> cabin_graphics.inc
	echo "tree_basement_s_lzsa: .incbin \"tree_basement_s.lzsa\"" >> cabin_graphics.inc
	echo "tree_basement_n_lzsa: .incbin \"tree_basement_n.lzsa\"" >> cabin_graphics.inc
	echo "tree_basement_book_s_lzsa: .incbin \"tree_basement_book_s.lzsa\"" >> cabin_graphics.inc
	echo "tree_basement_book_open_s_lzsa: .incbin \"tree_basement_book_open_s.lzsa\"" >> cabin_graphics.inc
	echo "tree_basement_book_closed_s_lzsa: .incbin \"tree_basement_book_closed_s.lzsa\"" >> cabin_graphics.inc
	echo "tree_elevator_basement_s_lzsa: .incbin \"tree_elevator_basement_s.lzsa\"" >> cabin_graphics.inc
	echo "tree_elevator_l2_lzsa: .incbin \"tree_elevator_l2.lzsa\"" >> cabin_graphics.inc
	echo "tree_elevator_l4_lzsa: .incbin \"tree_elevator_l4.lzsa\"" >> cabin_graphics.inc
	echo "tree_elevator_l6_lzsa: .incbin \"tree_elevator_l6.lzsa\"" >> cabin_graphics.inc
	echo "tree_elevator_l8_lzsa: .incbin \"tree_elevator_l8.lzsa\"" >> cabin_graphics.inc
	echo "tree_elevator_l10_lzsa: .incbin \"tree_elevator_l10.lzsa\"" >> cabin_graphics.inc
	echo "tree_elevator_l12_lzsa: .incbin \"tree_elevator_l12.lzsa\"" >> cabin_graphics.inc
	echo "tree_elevator_top_down_lzsa: .incbin \"tree_elevator_top_down.lzsa\"" >> cabin_graphics.inc
	echo "tree_base_l4_n_lzsa: .incbin \"tree_base_l4_n.lzsa\"" >> cabin_graphics.inc
	echo "tree_base_l6_n_lzsa: .incbin \"tree_base_l6_n.lzsa\"" >> cabin_graphics.inc
	echo "tree_base_up_lzsa: .incbin \"tree_base_up.lzsa\"" >> cabin_graphics.inc
	echo "tree_base_up_l2_lzsa: .incbin \"tree_base_up_l2.lzsa\"" >> cabin_graphics.inc
	echo "tree_base_up_l4_lzsa: .incbin \"tree_base_up_l4.lzsa\"" >> cabin_graphics.inc
	echo "tree_base_up_l6_lzsa: .incbin \"tree_base_up_l6.lzsa\"" >> cabin_graphics.inc
	echo "tree_base_up_l8_lzsa: .incbin \"tree_base_up_l8.lzsa\"" >> cabin_graphics.inc
	echo "tree_base_up_l10_lzsa: .incbin \"tree_base_up_l10.lzsa\"" >> cabin_graphics.inc
	echo "tree_base_up_l12_lzsa: .incbin \"tree_base_up_l12.lzsa\"" >> cabin_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa cabin_graphics.inc

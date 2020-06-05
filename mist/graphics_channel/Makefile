#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	channel_graphics.inc

####

channel_graphics.inc:	\
	arrival_n.lzsa arrival_s.lzsa \
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
	bridge_w.lzsa bridge_down_e.lzsa \
	path2_e.lzsa path2_s.lzsa path2_n.lzsa \
	path3_w.lzsa path3_e.lzsa path3_n.lzsa \
	path4_e.lzsa path4_w.lzsa path4_s.lzsa \
	path5_e.lzsa path5_s.lzsa path5_n.lzsa \
	path6_s.lzsa path6_w.lzsa path6_n.lzsa
	echo "arrival_n_lzsa: .incbin \"arrival_n.lzsa\"" > channel_graphics.inc
	echo "arrival_s_lzsa: .incbin \"arrival_s.lzsa\"" >> channel_graphics.inc
	echo "clearing_e_lzsa: .incbin \"clearing_e.lzsa\"" >> channel_graphics.inc
	echo "clearing_s_lzsa: .incbin \"clearing_s.lzsa\"" >> channel_graphics.inc
	echo "clearing_w_lzsa: .incbin \"clearing_w.lzsa\"" >> channel_graphics.inc
	echo "clearing_e_open_lzsa: .incbin \"clearing_e_open.lzsa\"" >> channel_graphics.inc
	echo "boiler_room_e_lzsa: .incbin \"boiler_room_e.lzsa\"" >> channel_graphics.inc
	echo "boiler_e_lzsa: .incbin \"boiler_e.lzsa\"" >> channel_graphics.inc
	echo "boiler_w_lzsa: .incbin \"boiler_w.lzsa\"" >> channel_graphics.inc
	echo "safe_w_lzsa: .incbin \"safe_w.lzsa\"" >> channel_graphics.inc
	echo "safe_open_w_lzsa: .incbin \"safe_open_w.lzsa\"" >> channel_graphics.inc
	echo "clock_path_n_lzsa: .incbin \"clock_path_n.lzsa\"" >> channel_graphics.inc
	echo "clock_path_s_lzsa: .incbin \"clock_path_s.lzsa\"" >> channel_graphics.inc
	echo "tree_path_e_lzsa: .incbin \"tree_path_e.lzsa\"" >> channel_graphics.inc
	echo "tree_path_w_lzsa: .incbin \"tree_path_w.lzsa\"" >> channel_graphics.inc
	echo "tree_base_n_lzsa: .incbin \"tree_base_n.lzsa\"" >> channel_graphics.inc
	echo "tree_base_s_lzsa: .incbin \"tree_base_s.lzsa\"" >> channel_graphics.inc
	echo "tree_basement_s_lzsa: .incbin \"tree_basement_s.lzsa\"" >> channel_graphics.inc
	echo "tree_basement_n_lzsa: .incbin \"tree_basement_n.lzsa\"" >> channel_graphics.inc
	echo "tree_basement_book_s_lzsa: .incbin \"tree_basement_book_s.lzsa\"" >> channel_graphics.inc
	echo "tree_basement_book_open_s_lzsa: .incbin \"tree_basement_book_open_s.lzsa\"" >> channel_graphics.inc
	echo "tree_basement_book_closed_s_lzsa: .incbin \"tree_basement_book_closed_s.lzsa\"" >> channel_graphics.inc
	echo "tree_elevator_basement_s_lzsa: .incbin \"tree_elevator_basement_s.lzsa\"" >> channel_graphics.inc
	echo "bridge_w_lzsa: .incbin \"bridge_w.lzsa\"" >> channel_graphics.inc
	echo "bridge_down_e_lzsa: .incbin \"bridge_down_e.lzsa\"" >> channel_graphics.inc
	echo "path2_n_lzsa: .incbin \"path2_n.lzsa\"" >> channel_graphics.inc
	echo "path2_s_lzsa: .incbin \"path2_s.lzsa\"" >> channel_graphics.inc
	echo "path2_e_lzsa: .incbin \"path2_e.lzsa\"" >> channel_graphics.inc
	echo "path3_w_lzsa: .incbin \"path3_w.lzsa\"" >> channel_graphics.inc
	echo "path3_e_lzsa: .incbin \"path3_e.lzsa\"" >> channel_graphics.inc
	echo "path3_n_lzsa: .incbin \"path3_n.lzsa\"" >> channel_graphics.inc
	echo "path4_e_lzsa: .incbin \"path4_e.lzsa\"" >> channel_graphics.inc
	echo "path4_w_lzsa: .incbin \"path4_w.lzsa\"" >> channel_graphics.inc
	echo "path4_s_lzsa: .incbin \"path4_s.lzsa\"" >> channel_graphics.inc
	echo "path5_e_lzsa: .incbin \"path5_e.lzsa\"" >> channel_graphics.inc
	echo "path5_s_lzsa: .incbin \"path5_s.lzsa\"" >> channel_graphics.inc
	echo "path5_n_lzsa: .incbin \"path5_n.lzsa\"" >> channel_graphics.inc
	echo "path6_s_lzsa: .incbin \"path6_s.lzsa\"" >> channel_graphics.inc
	echo "path6_w_lzsa: .incbin \"path6_w.lzsa\"" >> channel_graphics.inc
	echo "path6_n_lzsa: .incbin \"path6_n.lzsa\"" >> channel_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa channel_graphics.inc

#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	sub_graphics.inc


####

sub_graphics.inc:	\
	subroom_s.lzsa subroom_n.lzsa \
	book_table_n.lzsa book_table_s.lzsa \
	book_mist_open_s.lzsa book_mist_closed_s.lzsa \
	book_hallway_n.lzsa book_hallway_s.lzsa \
	book_hallway2_n.lzsa book_hallway2_s.lzsa \
	inside_sub_e.lzsa inside_sub_w.lzsa \
	bunker_entry_e.lzsa bunker_entry_w.lzsa \
	sub_hallway_e.lzsa sub_hallway_w.lzsa \
	sub_hallway2_e.lzsa sub_hallway2_w.lzsa \
	sub_close_n.lzsa sub_close_s.lzsa \
	sub_close_open_s.lzsa \
	inside_sub_back_e.lzsa inside_sub_back_closed_s.lzsa \
	inside_sub_back_selena_s.lzsa inside_sub_back_book_s.lzsa \
	inside_sub_selena_e.lzsa inside_sub_book_e.lzsa \
	outside_book_n.lzsa outside_book_s.lzsa \
	sub_med_s.lzsa sub_med_n.lzsa sub_med_e.lzsa sub_med_w.lzsa \
	walk_right_s.lzsa walk_right_e.lzsa walk_right_w.lzsa \
	walk_left_s.lzsa walk_left_e.lzsa walk_left_w.lzsa \
	bottom_stairs_e.lzsa bottom_stairs_w.lzsa
	echo "subroom_s_lzsa: .incbin \"subroom_s.lzsa\"" > sub_graphics.inc
	echo "subroom_n_lzsa: .incbin \"subroom_n.lzsa\"" >> sub_graphics.inc
	echo "book_table_s_lzsa: .incbin \"book_table_s.lzsa\"" >> sub_graphics.inc
	echo "book_table_n_lzsa: .incbin \"book_table_n.lzsa\"" >> sub_graphics.inc
	echo "book_mist_open_s_lzsa: .incbin \"book_mist_open_s.lzsa\"" >> sub_graphics.inc
	echo "book_mist_closed_s_lzsa: .incbin \"book_mist_closed_s.lzsa\"" >> sub_graphics.inc
	echo "inside_sub_e_lzsa: .incbin \"inside_sub_e.lzsa\"" >> sub_graphics.inc
	echo "inside_sub_w_lzsa: .incbin \"inside_sub_w.lzsa\"" >> sub_graphics.inc
	echo "bunker_entry_e_lzsa: .incbin \"bunker_entry_e.lzsa\"" >> sub_graphics.inc
	echo "bunker_entry_w_lzsa: .incbin \"bunker_entry_w.lzsa\"" >> sub_graphics.inc
	echo "sub_hallway_e_lzsa: .incbin \"sub_hallway_e.lzsa\"" >> sub_graphics.inc
	echo "sub_hallway_w_lzsa: .incbin \"sub_hallway_w.lzsa\"" >> sub_graphics.inc
	echo "sub_hallway2_e_lzsa: .incbin \"sub_hallway2_e.lzsa\"" >> sub_graphics.inc
	echo "sub_hallway2_w_lzsa: .incbin \"sub_hallway2_w.lzsa\"" >> sub_graphics.inc
	echo "book_hallway_n_lzsa: .incbin \"book_hallway_n.lzsa\"" >> sub_graphics.inc
	echo "book_hallway_s_lzsa: .incbin \"book_hallway_s.lzsa\"" >> sub_graphics.inc
	echo "book_hallway2_n_lzsa: .incbin \"book_hallway2_n.lzsa\"" >> sub_graphics.inc
	echo "book_hallway2_s_lzsa: .incbin \"book_hallway2_s.lzsa\"" >> sub_graphics.inc
	echo "sub_close_n_lzsa: .incbin \"sub_close_n.lzsa\"" >> sub_graphics.inc
	echo "sub_close_s_lzsa: .incbin \"sub_close_s.lzsa\"" >> sub_graphics.inc
	echo "sub_close_open_s_lzsa: .incbin \"sub_close_open_s.lzsa\"" >> sub_graphics.inc
	echo "inside_sub_back_e_lzsa: .incbin \"inside_sub_back_e.lzsa\"" >> sub_graphics.inc
	echo "inside_sub_back_closed_s_lzsa: .incbin \"inside_sub_back_closed_s.lzsa\"" >> sub_graphics.inc
	echo "inside_sub_back_selena_s_lzsa: .incbin \"inside_sub_back_selena_s.lzsa\"" >> sub_graphics.inc
	echo "inside_sub_back_book_s_lzsa: .incbin \"inside_sub_back_book_s.lzsa\"" >> sub_graphics.inc
	echo "inside_sub_selena_e_lzsa: .incbin \"inside_sub_selena_e.lzsa\"" >> sub_graphics.inc
	echo "inside_sub_book_e_lzsa: .incbin \"inside_sub_book_e.lzsa\"" >> sub_graphics.inc
	echo "outside_book_n_lzsa: .incbin \"outside_book_n.lzsa\"" >> sub_graphics.inc
	echo "outside_book_s_lzsa: .incbin \"outside_book_s.lzsa\"" >> sub_graphics.inc
	echo "sub_med_n_lzsa: .incbin \"sub_med_n.lzsa\"" >> sub_graphics.inc
	echo "sub_med_s_lzsa: .incbin \"sub_med_s.lzsa\"" >> sub_graphics.inc
	echo "sub_med_e_lzsa: .incbin \"sub_med_e.lzsa\"" >> sub_graphics.inc
	echo "sub_med_w_lzsa: .incbin \"sub_med_w.lzsa\"" >> sub_graphics.inc
	echo "walk_right_s_lzsa: .incbin \"walk_right_s.lzsa\"" >> sub_graphics.inc
	echo "walk_right_e_lzsa: .incbin \"walk_right_e.lzsa\"" >> sub_graphics.inc
	echo "walk_right_w_lzsa: .incbin \"walk_right_w.lzsa\"" >> sub_graphics.inc
	echo "walk_left_s_lzsa: .incbin \"walk_left_s.lzsa\"" >> sub_graphics.inc
	echo "walk_left_e_lzsa: .incbin \"walk_left_e.lzsa\"" >> sub_graphics.inc
	echo "walk_left_w_lzsa: .incbin \"walk_left_w.lzsa\"" >> sub_graphics.inc
	echo "bottom_stairs_e_lzsa: .incbin \"bottom_stairs_e.lzsa\"" >> sub_graphics.inc
	echo "bottom_stairs_w_lzsa: .incbin \"bottom_stairs_w.lzsa\"" >> sub_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa sub_graphics.inc

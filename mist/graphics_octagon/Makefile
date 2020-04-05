#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	octagon_graphics.inc


####

octagon_graphics.inc:	\
	temple_door_n.lzsa temple_door_s.lzsa \
	temple_door_closed_s.lzsa temple_door_closed_n.lzsa \
	temple_center_n.lzsa temple_center_s.lzsa temple_center_e.lzsa \
	temple_center_w.lzsa temple_center_up.lzsa \
	temple_center_open_n.lzsa temple_center_closed_s.lzsa \
	red_book_shelf.lzsa \
	red_book_open.lzsa red_book_closed.lzsa \
	red_book_static.lzsa red_book_static2.lzsa \
	fireplace_e.lzsa \
	in_fireplace_w.lzsa in_fireplace_door.lzsa \
	frame_door_open.lzsa \
	frame_bookcase_open.lzsa \
	blue_book_shelf.lzsa \
	bookshelf_n.lzsa bookshelf_open_n.lzsa \
	bookshelf_close_n.lzsa \
	map.lzsa tower_rotation.lzsa \
	tower_hall1_n.lzsa tower_hall1_s.lzsa \
	tower_hall2_n.lzsa tower_hall2_s.lzsa \
	elevator_far_n.lzsa \
	elevator_n.lzsa elevator_s.lzsa elevator_open_n.lzsa \
	elevator_lib_s.lzsa \
	elevator_tower_s.lzsa \
	tower_book_s.lzsa tower_book_n.lzsa tower_book_e.lzsa tower_book_w.lzsa \
	tower_book_ladder_s.lzsa tower_book_ladder_n.lzsa \
	tower_book_view_n.lzsa \
	tower_book_view_blank_s.lzsa tower_book_view_ship_s.lzsa \
	tower_key_n.lzsa tower_key_s.lzsa tower_key_e.lzsa tower_key_w.lzsa \
	tower_left_n.lzsa tower_left_s.lzsa \
	tower_right_n.lzsa tower_right_s.lzsa
	echo "temple_door_n_lzsa: .incbin \"temple_door_n.lzsa\"" > octagon_graphics.inc
	echo "temple_door_s_lzsa: .incbin \"temple_door_s.lzsa\"" >> octagon_graphics.inc
	echo "temple_door_closed_s_lzsa: .incbin \"temple_door_closed_s.lzsa\"" >> octagon_graphics.inc
	echo "temple_door_closed_n_lzsa: .incbin \"temple_door_closed_n.lzsa\"" >> octagon_graphics.inc
	echo "temple_center_n_lzsa: .incbin \"temple_center_n.lzsa\"" >> octagon_graphics.inc
	echo "temple_center_s_lzsa: .incbin \"temple_center_s.lzsa\"" >> octagon_graphics.inc
	echo "temple_center_e_lzsa: .incbin \"temple_center_e.lzsa\"" >> octagon_graphics.inc
	echo "temple_center_w_lzsa: .incbin \"temple_center_w.lzsa\"" >> octagon_graphics.inc
	echo "temple_center_open_n_lzsa: .incbin \"temple_center_open_n.lzsa\"" >> octagon_graphics.inc
	echo "temple_center_closed_s_lzsa: .incbin \"temple_center_closed_s.lzsa\"" >> octagon_graphics.inc
	echo "temple_center_up_lzsa: .incbin \"temple_center_up.lzsa\"" >> octagon_graphics.inc
	echo "red_book_open_lzsa: .incbin \"red_book_open.lzsa\"" >> octagon_graphics.inc
	echo "red_book_closed_lzsa: .incbin \"red_book_closed.lzsa\"" >> octagon_graphics.inc
	echo "red_book_shelf_lzsa: .incbin \"red_book_shelf.lzsa\"" >> octagon_graphics.inc
	echo "red_book_static_lzsa: .incbin \"red_book_static.lzsa\"" >> octagon_graphics.inc
	echo "red_book_static2_lzsa: .incbin \"red_book_static2.lzsa\"" >> octagon_graphics.inc
	echo "fireplace_e_lzsa: .incbin \"fireplace_e.lzsa\"" >> octagon_graphics.inc
	echo "in_fireplace_w_lzsa: .incbin \"in_fireplace_w.lzsa\"" >> octagon_graphics.inc
	echo "in_fireplace_door_lzsa: .incbin \"in_fireplace_door.lzsa\"" >> octagon_graphics.inc
	echo "frame_door_open_lzsa: .incbin \"frame_door_open.lzsa\"" >> octagon_graphics.inc
	echo "frame_bookcase_open_lzsa: .incbin \"frame_bookcase_open.lzsa\"" >> octagon_graphics.inc
	echo "blue_book_shelf_lzsa: .incbin \"blue_book_shelf.lzsa\"" >> octagon_graphics.inc
	echo "bookshelf_n_lzsa: .incbin \"bookshelf_n.lzsa\"" >> octagon_graphics.inc
	echo "bookshelf_open_n_lzsa: .incbin \"bookshelf_open_n.lzsa\"" >> octagon_graphics.inc
	echo "bookshelf_close_n_lzsa: .incbin \"bookshelf_close_n.lzsa\"" >> octagon_graphics.inc
	echo "map_lzsa: .incbin \"map.lzsa\"" >> octagon_graphics.inc
	echo "tower_rotation_lzsa: .incbin \"tower_rotation.lzsa\"" >> octagon_graphics.inc
	echo "tower_hall1_n_lzsa: .incbin \"tower_hall1_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_hall1_s_lzsa: .incbin \"tower_hall1_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_hall2_n_lzsa: .incbin \"tower_hall2_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_hall2_s_lzsa: .incbin \"tower_hall2_s.lzsa\"" >> octagon_graphics.inc
	echo "elevator_far_n_lzsa: .incbin \"elevator_far_n.lzsa\"" >> octagon_graphics.inc
	echo "elevator_n_lzsa: .incbin \"elevator_n.lzsa\"" >> octagon_graphics.inc
	echo "elevator_s_lzsa: .incbin \"elevator_s.lzsa\"" >> octagon_graphics.inc
	echo "elevator_open_n_lzsa: .incbin \"elevator_open_n.lzsa\"" >> octagon_graphics.inc
	echo "elevator_lib_s_lzsa: .incbin \"elevator_lib_s.lzsa\"" >> octagon_graphics.inc
	echo "elevator_tower_s_lzsa: .incbin \"elevator_tower_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_book_s_lzsa: .incbin \"tower_book_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_book_n_lzsa: .incbin \"tower_book_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_book_e_lzsa: .incbin \"tower_book_e.lzsa\"" >> octagon_graphics.inc
	echo "tower_book_w_lzsa: .incbin \"tower_book_w.lzsa\"" >> octagon_graphics.inc
	echo "tower_book_ladder_s_lzsa: .incbin \"tower_book_ladder_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_book_ladder_n_lzsa: .incbin \"tower_book_ladder_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_book_view_n_lzsa: .incbin \"tower_book_view_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_book_view_blank_s_lzsa: .incbin \"tower_book_view_blank_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_book_view_ship_s_lzsa: .incbin \"tower_book_view_ship_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_key_n_lzsa: .incbin \"tower_key_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_key_s_lzsa: .incbin \"tower_key_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_key_e_lzsa: .incbin \"tower_key_e.lzsa\"" >> octagon_graphics.inc
	echo "tower_key_w_lzsa: .incbin \"tower_key_w.lzsa\"" >> octagon_graphics.inc
	echo "tower_left_n_lzsa: .incbin \"tower_left_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_left_s_lzsa: .incbin \"tower_left_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_right_n_lzsa: .incbin \"tower_right_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_right_s_lzsa: .incbin \"tower_right_s.lzsa\"" >> octagon_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa octagon_graphics.inc

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
	blue_book_open.lzsa blue_book_closed.lzsa \
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
	tower_book_view_blank_s.lzsa \
	tower_book_view_ship_up_s.lzsa tower_book_view_ship_down_s.lzsa \
	tower_book_view_gears_closed_s.lzsa tower_book_view_gears_open_s.lzsa \
	tower_book_view_tree_s.lzsa \
	tower_book_view_rocket_s.lzsa \
	tower_key_n.lzsa tower_key_s.lzsa tower_key_e.lzsa tower_key_w.lzsa \
	tower_left_n.lzsa tower_left_s.lzsa \
	tower_right_n.lzsa tower_right_s.lzsa \
	tower_key_ladder_n.lzsa tower_key_ladder_s.lzsa \
	tower_key_view_blank_n.lzsa tower_key_view_s.lzsa \
	tower_key_view_rocket_hint_n.lzsa tower_key_view_dock_hint_n.lzsa \
	tower_key_view_gears_hint_n.lzsa tower_key_view_tree_hint_n.lzsa \
	elevator_door_closed_s.lzsa \
	elevator_dark_s.lzsa \
	red_book_ending.lzsa blue_book_ending.lzsa \
	fireplace_shelf.lzsa \
	green_book.lzsa green_book_open.lzsa \
	dni_n.lzsa dni_s.lzsa dni_e.lzsa dni_w.lzsa \
	dni_desk_n.lzsa dni_desk_s.lzsa
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
	echo "fireplace_e_lzsa: .incbin \"fireplace_e.lzsa\"" >> octagon_graphics.inc
	echo "in_fireplace_w_lzsa: .incbin \"in_fireplace_w.lzsa\"" >> octagon_graphics.inc
	echo "in_fireplace_door_lzsa: .incbin \"in_fireplace_door.lzsa\"" >> octagon_graphics.inc
	echo "frame_door_open_lzsa: .incbin \"frame_door_open.lzsa\"" >> octagon_graphics.inc
	echo "frame_bookcase_open_lzsa: .incbin \"frame_bookcase_open.lzsa\"" >> octagon_graphics.inc
	echo "blue_book_shelf_lzsa: .incbin \"blue_book_shelf.lzsa\"" >> octagon_graphics.inc
	echo "blue_book_open_lzsa: .incbin \"blue_book_open.lzsa\"" >> octagon_graphics.inc
	echo "blue_book_closed_lzsa: .incbin \"blue_book_closed.lzsa\"" >> octagon_graphics.inc
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
	echo "tower_book_view_ship_down_s_lzsa: .incbin \"tower_book_view_ship_down_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_book_view_ship_up_s_lzsa: .incbin \"tower_book_view_ship_up_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_book_view_gears_open_s_lzsa: .incbin \"tower_book_view_gears_open_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_book_view_gears_closed_s_lzsa: .incbin \"tower_book_view_gears_closed_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_book_view_rocket_s_lzsa: .incbin \"tower_book_view_rocket_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_book_view_tree_s_lzsa: .incbin \"tower_book_view_tree_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_key_n_lzsa: .incbin \"tower_key_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_key_s_lzsa: .incbin \"tower_key_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_key_e_lzsa: .incbin \"tower_key_e.lzsa\"" >> octagon_graphics.inc
	echo "tower_key_w_lzsa: .incbin \"tower_key_w.lzsa\"" >> octagon_graphics.inc
	echo "tower_left_n_lzsa: .incbin \"tower_left_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_left_s_lzsa: .incbin \"tower_left_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_right_n_lzsa: .incbin \"tower_right_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_right_s_lzsa: .incbin \"tower_right_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_key_ladder_n_lzsa: .incbin \"tower_key_ladder_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_key_ladder_s_lzsa: .incbin \"tower_key_ladder_s.lzsa\"" >> octagon_graphics.inc
	echo "tower_key_view_blank_n_lzsa: .incbin \"tower_key_view_blank_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_key_view_rocket_hint_n_lzsa: .incbin \"tower_key_view_rocket_hint_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_key_view_gears_hint_n_lzsa: .incbin \"tower_key_view_gears_hint_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_key_view_tree_hint_n_lzsa: .incbin \"tower_key_view_tree_hint_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_key_view_dock_hint_n_lzsa: .incbin \"tower_key_view_dock_hint_n.lzsa\"" >> octagon_graphics.inc
	echo "tower_key_view_s_lzsa: .incbin \"tower_key_view_s.lzsa\"" >> octagon_graphics.inc
	echo "elevator_door_closed_s_lzsa: .incbin \"elevator_door_closed_s.lzsa\"" >> octagon_graphics.inc
	echo "elevator_dark_s_lzsa: .incbin \"elevator_dark_s.lzsa\"" >> octagon_graphics.inc
	echo "red_book_ending_lzsa: .incbin \"red_book_ending.lzsa\"" >> octagon_graphics.inc
	echo "blue_book_ending_lzsa: .incbin \"blue_book_ending.lzsa\"" >> octagon_graphics.inc
	echo "fireplace_shelf_lzsa: .incbin \"fireplace_shelf.lzsa\"" >> octagon_graphics.inc
	echo "green_book_lzsa: .incbin \"green_book.lzsa\"" >> octagon_graphics.inc
	echo "green_book_open_lzsa: .incbin \"green_book_open.lzsa\"" >> octagon_graphics.inc
	echo "dni_n_lzsa: .incbin \"dni_n.lzsa\"" >> octagon_graphics.inc
	echo "dni_s_lzsa: .incbin \"dni_s.lzsa\"" >> octagon_graphics.inc
	echo "dni_e_lzsa: .incbin \"dni_e.lzsa\"" >> octagon_graphics.inc
	echo "dni_w_lzsa: .incbin \"dni_w.lzsa\"" >> octagon_graphics.inc
	echo "dni_desk_n_lzsa: .incbin \"dni_desk_n.lzsa\"" >> octagon_graphics.inc
	echo "dni_desk_s_lzsa: .incbin \"dni_desk_s.lzsa\"" >> octagon_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa octagon_graphics.inc

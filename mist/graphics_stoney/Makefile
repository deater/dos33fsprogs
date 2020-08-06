#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	stoney_graphics.inc

####

stoney_graphics.inc:	\
	arrival_n.lzsa arrival_s.lzsa arrival_e.lzsa arrival_w.lzsa \
	umbrella_e.lzsa umbrella_w.lzsa \
	umbrella_path_e.lzsa umbrella_path_w.lzsa \
	lighthouse_path_e.lzsa lighthouse_path_w.lzsa \
	lighthouse_door_e.lzsa lighthouse_door_w.lzsa \
	lighthouse_inside_e.lzsa lighthouse_inside_w.lzsa lighthouse_inside_n.lzsa \
	lighthouse_upstairs_e.lzsa lighthouse_upstairs_w.lzsa \
	lighthouse_battery_w.lzsa \
	lighthouse_downladder_e.lzsa \
	doorway1_n.lzsa doorway1_s.lzsa doorway1_e.lzsa doorway1_w.lzsa \
	bridge_e.lzsa bridge_w.lzsa \
	exit_tunnel_n.lzsa exit_tunnel_s.lzsa \
	exit_airlock_n.lzsa exit_airlock_s.lzsa \
	exit_airlock_open_s.lzsa \
	book_stairs1_n.lzsa book_stairs1_s.lzsa \
	book_stairs2_n.lzsa book_stairs2_w.lzsa \
	book_room_n.lzsa book_room_s.lzsa \
	book_table_n.lzsa \
	book_table_open_n.lzsa book_table_closed_n.lzsa \
	doorway2_n.lzsa doorway2_s.lzsa doorway2_e.lzsa doorway2_w.lzsa \
	telescope_path1_e.lzsa telescope_path1_w.lzsa \
	telescope_path2_e.lzsa telescope_path2_w.lzsa \
	telescope_path3_e.lzsa telescope_path3_w.lzsa \
	telescope_e.lzsa telescope_w.lzsa \
	telescope_view.lzsa \
	left_tunnel1_n.lzsa left_tunnel1_s.lzsa \
	left_tunnel2_n.lzsa left_tunnel2_s.lzsa left_tunnel2_w.lzsa \
	left_airlock_n.lzsa left_airlock_s.lzsa left_airlock_open_n.lzsa \
	red_room_n.lzsa red_room_s.lzsa red_room_e.lzsa red_room_w.lzsa \
	dresser_e.lzsa dresser_open_e.lzsa \
	compass_room_n.lzsa compass_room_w.lzsa compass_room_e.lzsa \
	compass_rose_w.lzsa \
	crawlway_e.lzsa crawlway_w.lzsa \
	blue_room_n.lzsa blue_room_s.lzsa blue_room_e.lzsa blue_room_w.lzsa \
	map_case_open_e.lzsa map_case_closed_e.lzsa \
	right_tunnel1_n.lzsa right_tunnel1_s.lzsa \
	right_tunnel2_n.lzsa right_tunnel2_s.lzsa right_tunnel2_w.lzsa \
	right_airlock_n.lzsa right_airlock_s.lzsa right_airlock_open_n.lzsa \
	left_letter.lzsa \
	crawlway_entrance_e.lzsa
	echo "arrival_n_lzsa: .incbin \"arrival_n.lzsa\"" > stoney_graphics.inc
	echo "arrival_s_lzsa: .incbin \"arrival_s.lzsa\"" >> stoney_graphics.inc
	echo "arrival_e_lzsa: .incbin \"arrival_e.lzsa\"" >> stoney_graphics.inc
	echo "arrival_w_lzsa: .incbin \"arrival_w.lzsa\"" >> stoney_graphics.inc
	echo "umbrella_e_lzsa: .incbin \"umbrella_e.lzsa\"" >> stoney_graphics.inc
	echo "umbrella_w_lzsa: .incbin \"umbrella_w.lzsa\"" >> stoney_graphics.inc
	echo "umbrella_path_e_lzsa: .incbin \"umbrella_path_e.lzsa\"" >> stoney_graphics.inc
	echo "umbrella_path_w_lzsa: .incbin \"umbrella_path_w.lzsa\"" >> stoney_graphics.inc
	echo "lighthouse_path_e_lzsa: .incbin \"lighthouse_path_e.lzsa\"" >> stoney_graphics.inc
	echo "lighthouse_path_w_lzsa: .incbin \"lighthouse_path_w.lzsa\"" >> stoney_graphics.inc
	echo "lighthouse_door_e_lzsa: .incbin \"lighthouse_door_e.lzsa\"" >> stoney_graphics.inc
	echo "lighthouse_door_w_lzsa: .incbin \"lighthouse_door_w.lzsa\"" >> stoney_graphics.inc
	echo "lighthouse_inside_e_lzsa: .incbin \"lighthouse_inside_e.lzsa\"" >> stoney_graphics.inc
	echo "lighthouse_inside_w_lzsa: .incbin \"lighthouse_inside_w.lzsa\"" >> stoney_graphics.inc
	echo "lighthouse_inside_n_lzsa: .incbin \"lighthouse_inside_n.lzsa\"" >> stoney_graphics.inc
	echo "lighthouse_upstairs_e_lzsa: .incbin \"lighthouse_upstairs_e.lzsa\"" >> stoney_graphics.inc
	echo "lighthouse_upstairs_w_lzsa: .incbin \"lighthouse_upstairs_w.lzsa\"" >> stoney_graphics.inc
	echo "lighthouse_battery_w_lzsa: .incbin \"lighthouse_battery_w.lzsa\"" >> stoney_graphics.inc
	echo "lighthouse_downladder_e_lzsa: .incbin \"lighthouse_downladder_e.lzsa\"" >> stoney_graphics.inc
	echo "doorway1_n_lzsa: .incbin \"doorway1_n.lzsa\"" >> stoney_graphics.inc
	echo "doorway1_s_lzsa: .incbin \"doorway1_s.lzsa\"" >> stoney_graphics.inc
	echo "doorway1_e_lzsa: .incbin \"doorway1_e.lzsa\"" >> stoney_graphics.inc
	echo "doorway1_w_lzsa: .incbin \"doorway1_w.lzsa\"" >> stoney_graphics.inc
	echo "bridge_e_lzsa: .incbin \"bridge_e.lzsa\"" >> stoney_graphics.inc
	echo "bridge_w_lzsa: .incbin \"bridge_w.lzsa\"" >> stoney_graphics.inc
	echo "exit_tunnel_n_lzsa: .incbin \"exit_tunnel_n.lzsa\"" >> stoney_graphics.inc
	echo "exit_tunnel_s_lzsa: .incbin \"exit_tunnel_s.lzsa\"" >> stoney_graphics.inc
	echo "exit_airlock_n_lzsa: .incbin \"exit_airlock_n.lzsa\"" >> stoney_graphics.inc
	echo "exit_airlock_s_lzsa: .incbin \"exit_airlock_s.lzsa\"" >> stoney_graphics.inc
	echo "exit_airlock_open_s_lzsa: .incbin \"exit_airlock_open_s.lzsa\"" >> stoney_graphics.inc
	echo "book_stairs1_n_lzsa: .incbin \"book_stairs1_n.lzsa\"" >> stoney_graphics.inc
	echo "book_stairs1_s_lzsa: .incbin \"book_stairs1_s.lzsa\"" >> stoney_graphics.inc
	echo "book_stairs2_n_lzsa: .incbin \"book_stairs2_n.lzsa\"" >> stoney_graphics.inc
	echo "book_stairs2_w_lzsa: .incbin \"book_stairs2_w.lzsa\"" >> stoney_graphics.inc
	echo "book_room_n_lzsa: .incbin \"book_room_n.lzsa\"" >> stoney_graphics.inc
	echo "book_room_s_lzsa: .incbin \"book_room_s.lzsa\"" >> stoney_graphics.inc
	echo "book_table_n_lzsa: .incbin \"book_table_n.lzsa\"" >> stoney_graphics.inc
	echo "book_table_open_n_lzsa: .incbin \"book_table_open_n.lzsa\"" >> stoney_graphics.inc
	echo "book_table_closed_n_lzsa: .incbin \"book_table_closed_n.lzsa\"" >> stoney_graphics.inc
	echo "doorway2_n_lzsa: .incbin \"doorway2_n.lzsa\"" >> stoney_graphics.inc
	echo "doorway2_s_lzsa: .incbin \"doorway2_s.lzsa\"" >> stoney_graphics.inc
	echo "doorway2_e_lzsa: .incbin \"doorway2_e.lzsa\"" >> stoney_graphics.inc
	echo "doorway2_w_lzsa: .incbin \"doorway2_w.lzsa\"" >> stoney_graphics.inc
	echo "telescope_path1_e_lzsa: .incbin \"telescope_path1_e.lzsa\"" >> stoney_graphics.inc
	echo "telescope_path1_w_lzsa: .incbin \"telescope_path1_w.lzsa\"" >> stoney_graphics.inc
	echo "telescope_path2_e_lzsa: .incbin \"telescope_path2_e.lzsa\"" >> stoney_graphics.inc
	echo "telescope_path2_w_lzsa: .incbin \"telescope_path2_w.lzsa\"" >> stoney_graphics.inc
	echo "telescope_path3_e_lzsa: .incbin \"telescope_path3_e.lzsa\"" >> stoney_graphics.inc
	echo "telescope_path3_w_lzsa: .incbin \"telescope_path3_w.lzsa\"" >> stoney_graphics.inc
	echo "telescope_e_lzsa: .incbin \"telescope_e.lzsa\"" >> stoney_graphics.inc
	echo "telescope_w_lzsa: .incbin \"telescope_w.lzsa\"" >> stoney_graphics.inc
	echo "telescope_view_lzsa: .incbin \"telescope_view.lzsa\"" >> stoney_graphics.inc
	echo "left_tunnel1_n_lzsa: .incbin \"left_tunnel1_n.lzsa\"" >> stoney_graphics.inc
	echo "left_tunnel1_s_lzsa: .incbin \"left_tunnel1_s.lzsa\"" >> stoney_graphics.inc
	echo "left_tunnel2_n_lzsa: .incbin \"left_tunnel2_n.lzsa\"" >> stoney_graphics.inc
	echo "left_tunnel2_s_lzsa: .incbin \"left_tunnel2_s.lzsa\"" >> stoney_graphics.inc
	echo "left_tunnel2_w_lzsa: .incbin \"left_tunnel2_w.lzsa\"" >> stoney_graphics.inc
	echo "left_airlock_n_lzsa: .incbin \"left_airlock_n.lzsa\"" >> stoney_graphics.inc
	echo "left_airlock_s_lzsa: .incbin \"left_airlock_s.lzsa\"" >> stoney_graphics.inc
	echo "left_airlock_open_n_lzsa: .incbin \"left_airlock_open_n.lzsa\"" >> stoney_graphics.inc
	echo "red_room_n_lzsa: .incbin \"red_room_n.lzsa\"" >> stoney_graphics.inc
	echo "red_room_s_lzsa: .incbin \"red_room_s.lzsa\"" >> stoney_graphics.inc
	echo "red_room_e_lzsa: .incbin \"red_room_e.lzsa\"" >> stoney_graphics.inc
	echo "red_room_w_lzsa: .incbin \"red_room_w.lzsa\"" >> stoney_graphics.inc
	echo "dresser_e_lzsa: .incbin \"dresser_e.lzsa\"" >> stoney_graphics.inc
	echo "dresser_open_e_lzsa: .incbin \"dresser_open_e.lzsa\"" >> stoney_graphics.inc
	echo "compass_room_e_lzsa: .incbin \"compass_room_e.lzsa\"" >> stoney_graphics.inc
	echo "compass_room_w_lzsa: .incbin \"compass_room_w.lzsa\"" >> stoney_graphics.inc
	echo "compass_room_n_lzsa: .incbin \"compass_room_n.lzsa\"" >> stoney_graphics.inc
	echo "compass_rose_w_lzsa: .incbin \"compass_rose_w.lzsa\"" >> stoney_graphics.inc
	echo "crawlway_e_lzsa: .incbin \"crawlway_e.lzsa\"" >> stoney_graphics.inc
	echo "crawlway_w_lzsa: .incbin \"crawlway_w.lzsa\"" >> stoney_graphics.inc
	echo "blue_room_n_lzsa: .incbin \"blue_room_n.lzsa\"" >> stoney_graphics.inc
	echo "blue_room_s_lzsa: .incbin \"blue_room_s.lzsa\"" >> stoney_graphics.inc
	echo "blue_room_e_lzsa: .incbin \"blue_room_e.lzsa\"" >> stoney_graphics.inc
	echo "blue_room_w_lzsa: .incbin \"blue_room_w.lzsa\"" >> stoney_graphics.inc
	echo "map_case_open_e_lzsa: .incbin \"map_case_open_e.lzsa\"" >> stoney_graphics.inc
	echo "map_case_closed_e_lzsa: .incbin \"map_case_closed_e.lzsa\"" >> stoney_graphics.inc
	echo "right_tunnel1_n_lzsa: .incbin \"right_tunnel1_n.lzsa\"" >> stoney_graphics.inc
	echo "right_tunnel1_s_lzsa: .incbin \"right_tunnel1_s.lzsa\"" >> stoney_graphics.inc
	echo "right_tunnel2_n_lzsa: .incbin \"right_tunnel2_n.lzsa\"" >> stoney_graphics.inc
	echo "right_tunnel2_s_lzsa: .incbin \"right_tunnel2_s.lzsa\"" >> stoney_graphics.inc
	echo "right_tunnel2_w_lzsa: .incbin \"right_tunnel2_w.lzsa\"" >> stoney_graphics.inc
	echo "right_airlock_n_lzsa: .incbin \"right_airlock_n.lzsa\"" >> stoney_graphics.inc
	echo "right_airlock_s_lzsa: .incbin \"right_airlock_s.lzsa\"" >> stoney_graphics.inc
	echo "right_airlock_open_n_lzsa: .incbin \"right_airlock_open_n.lzsa\"" >> stoney_graphics.inc
	echo "left_letter_lzsa: .incbin \"left_letter.lzsa\"" >> stoney_graphics.inc
	echo "crawlway_entrance_e_lzsa: .incbin \"crawlway_entrance_e.lzsa\"" >> stoney_graphics.inc


%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa stoney_graphics.inc

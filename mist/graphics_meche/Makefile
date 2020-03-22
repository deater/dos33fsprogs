#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	meche_graphics.inc


####

meche_graphics.inc:	\
	departure_e.lzsa \
	arrival_w.lzsa \
	entrance_e.lzsa entrance_s.lzsa entrance_n.lzsa entrance_w.lzsa \
	meche_book_closed.lzsa meche_book_open.lzsa \
	fort_view_n.lzsa fort_view_s.lzsa \
	bridge2_n.lzsa bridge2_s.lzsa bridge2_e.lzsa bridge2_w.lzsa \
	fort_door_n.lzsa \
	fort_entry_n.lzsa fort_entry_s.lzsa fort_entry_e.lzsa \
	westturn_s.lzsa westturn_n.lzsa westturn_w.lzsa westturn_e.lzsa \
	north_hint_n.lzsa \
	north_top_n.lzsa north_top_s.lzsa \
	north_dip_n.lzsa north_dip_s.lzsa \
	northturn_s.lzsa northturn_n.lzsa northturn_w.lzsa northturn_e.lzsa \
	left_hall2_n.lzsa left_hall2_s.lzsa \
	left_hall_corner_s.lzsa left_hall_corner_e.lzsa \
	red_room_center_e.lzsa red_room_center_w.lzsa \
	center_hall_e.lzsa center_hall_w.lzsa center_hall_s.lzsa \
	red_button_n.lzsa red_button_s.lzsa red_button_e.lzsa \
	red_button_of_oe_w.lzsa red_button_of_ce_w.lzsa \
	red_button_cf_oe_w.lzsa red_button_cf_ce_w.lzsa \
	basement_controls_w.lzsa \
	elevator_basement_e.lzsa elevator_basement_w.lzsa \
	right_hall2_s.lzsa \
	right_hall_corner_n.lzsa right_hall_corner_w.lzsa \
	blue_room_center_n.lzsa blue_room_center_s.lzsa \
	center_hall2_n.lzsa center_hall2_s.lzsa center_hall2_w.lzsa \
	elevator_path_e.lzsa elevator_path_w.lzsa \
	elevator_ground_e.lzsa \
	elevator_top_e.lzsa \
	elevator_half_e.lzsa \
	top_floor_e.lzsa \
	top_floor_ye_w.lzsa top_floor_ne_w.lzsa \
	rotate_controls_e.lzsa \
	eastturn_e.lzsa eastturn_w.lzsa \
	east_arch_w.lzsa east_arch_s.lzsa \
	east_hint_e.lzsa \
	east_top_e.lzsa east_top_w.lzsa \
	fort_exit_n.lzsa fort_exit_w.lzsa fort_exit_e.lzsa
	echo "departure_e_lzsa: .incbin \"departure_e.lzsa\"" > meche_graphics.inc
	echo "arrival_w_lzsa: .incbin \"arrival_w.lzsa\"" >> meche_graphics.inc
	echo "entrance_e_lzsa: .incbin \"entrance_e.lzsa\"" >> meche_graphics.inc
	echo "entrance_s_lzsa: .incbin \"entrance_s.lzsa\"" >> meche_graphics.inc
	echo "entrance_n_lzsa: .incbin \"entrance_n.lzsa\"" >> meche_graphics.inc
	echo "entrance_w_lzsa: .incbin \"entrance_w.lzsa\"" >> meche_graphics.inc
	echo "meche_book_closed_lzsa: .incbin \"meche_book_closed.lzsa\"" >> meche_graphics.inc
	echo "meche_book_open_lzsa: .incbin \"meche_book_open.lzsa\"" >> meche_graphics.inc
	echo "fort_view_n_lzsa: .incbin \"fort_view_n.lzsa\"" >> meche_graphics.inc
	echo "fort_view_s_lzsa: .incbin \"fort_view_s.lzsa\"" >> meche_graphics.inc
	echo "bridge2_n_lzsa: .incbin \"bridge2_n.lzsa\"" >> meche_graphics.inc
	echo "bridge2_s_lzsa: .incbin \"bridge2_s.lzsa\"" >> meche_graphics.inc
	echo "bridge2_e_lzsa: .incbin \"bridge2_e.lzsa\"" >> meche_graphics.inc
	echo "bridge2_w_lzsa: .incbin \"bridge2_w.lzsa\"" >> meche_graphics.inc
	echo "fort_door_n_lzsa: .incbin \"fort_door_n.lzsa\"" >> meche_graphics.inc
	echo "fort_entry_n_lzsa: .incbin \"fort_entry_n.lzsa\"" >> meche_graphics.inc
	echo "fort_entry_s_lzsa: .incbin \"fort_entry_s.lzsa\"" >> meche_graphics.inc
	echo "fort_entry_e_lzsa: .incbin \"fort_entry_e.lzsa\"" >> meche_graphics.inc
	echo "westturn_n_lzsa: .incbin \"westturn_n.lzsa\"" >> meche_graphics.inc
	echo "westturn_s_lzsa: .incbin \"westturn_s.lzsa\"" >> meche_graphics.inc
	echo "westturn_e_lzsa: .incbin \"westturn_e.lzsa\"" >> meche_graphics.inc
	echo "westturn_w_lzsa: .incbin \"westturn_w.lzsa\"" >> meche_graphics.inc
	echo "north_hint_n_lzsa: .incbin \"north_hint_n.lzsa\"" >> meche_graphics.inc
	echo "north_top_n_lzsa: .incbin \"north_top_n.lzsa\"" >> meche_graphics.inc
	echo "north_top_s_lzsa: .incbin \"north_top_s.lzsa\"" >> meche_graphics.inc
	echo "north_dip_n_lzsa: .incbin \"north_dip_n.lzsa\"" >> meche_graphics.inc
	echo "north_dip_s_lzsa: .incbin \"north_dip_s.lzsa\"" >> meche_graphics.inc
	echo "northturn_n_lzsa: .incbin \"northturn_n.lzsa\"" >> meche_graphics.inc
	echo "northturn_s_lzsa: .incbin \"northturn_s.lzsa\"" >> meche_graphics.inc
	echo "northturn_e_lzsa: .incbin \"northturn_e.lzsa\"" >> meche_graphics.inc
	echo "northturn_w_lzsa: .incbin \"northturn_w.lzsa\"" >> meche_graphics.inc
	echo "left_hall2_n_lzsa: .incbin \"left_hall2_n.lzsa\"" >> meche_graphics.inc
	echo "left_hall2_s_lzsa: .incbin \"left_hall2_s.lzsa\"" >> meche_graphics.inc
	echo "left_hall_corner_s_lzsa: .incbin \"left_hall_corner_s.lzsa\"" >> meche_graphics.inc
	echo "left_hall_corner_e_lzsa: .incbin \"left_hall_corner_e.lzsa\"" >> meche_graphics.inc
	echo "red_room_center_e_lzsa: .incbin \"red_room_center_e.lzsa\"" >> meche_graphics.inc
	echo "red_room_center_w_lzsa: .incbin \"red_room_center_w.lzsa\"" >> meche_graphics.inc
	echo "center_hall_e_lzsa: .incbin \"center_hall_e.lzsa\"" >> meche_graphics.inc
	echo "center_hall_w_lzsa: .incbin \"center_hall_w.lzsa\"" >> meche_graphics.inc
	echo "center_hall_s_lzsa: .incbin \"center_hall_s.lzsa\"" >> meche_graphics.inc
	echo "red_button_n_lzsa: .incbin \"red_button_n.lzsa\"" >> meche_graphics.inc
	echo "red_button_s_lzsa: .incbin \"red_button_s.lzsa\"" >> meche_graphics.inc
	echo "red_button_e_lzsa: .incbin \"red_button_e.lzsa\"" >> meche_graphics.inc
	echo "red_button_of_oe_w_lzsa: .incbin \"red_button_of_oe_w.lzsa\"" >> meche_graphics.inc
	echo "red_button_cf_oe_w_lzsa: .incbin \"red_button_cf_oe_w.lzsa\"" >> meche_graphics.inc
	echo "red_button_of_ce_w_lzsa: .incbin \"red_button_of_ce_w.lzsa\"" >> meche_graphics.inc
	echo "red_button_cf_ce_w_lzsa: .incbin \"red_button_cf_ce_w.lzsa\"" >> meche_graphics.inc
	echo "basement_controls_w_lzsa: .incbin \"basement_controls_w.lzsa\"" >> meche_graphics.inc
	echo "elevator_basement_w_lzsa: .incbin \"elevator_basement_w.lzsa\"" >> meche_graphics.inc
	echo "elevator_basement_e_lzsa: .incbin \"elevator_basement_e.lzsa\"" >> meche_graphics.inc
	echo "right_hall2_s_lzsa: .incbin \"right_hall2_s.lzsa\"" >> meche_graphics.inc
	echo "right_hall_corner_n_lzsa: .incbin \"right_hall_corner_n.lzsa\"" >> meche_graphics.inc
	echo "right_hall_corner_w_lzsa: .incbin \"right_hall_corner_w.lzsa\"" >> meche_graphics.inc
	echo "blue_room_center_n_lzsa: .incbin \"blue_room_center_n.lzsa\"" >> meche_graphics.inc
	echo "blue_room_center_s_lzsa: .incbin \"blue_room_center_s.lzsa\"" >> meche_graphics.inc
	echo "center_hall2_n_lzsa: .incbin \"center_hall2_n.lzsa\"" >> meche_graphics.inc
	echo "center_hall2_s_lzsa: .incbin \"center_hall2_s.lzsa\"" >> meche_graphics.inc
	echo "center_hall2_w_lzsa: .incbin \"center_hall2_w.lzsa\"" >> meche_graphics.inc
	echo "elevator_path_w_lzsa: .incbin \"elevator_path_w.lzsa\"" >> meche_graphics.inc
	echo "elevator_path_e_lzsa: .incbin \"elevator_path_e.lzsa\"" >> meche_graphics.inc
	echo "elevator_ground_e_lzsa: .incbin \"elevator_ground_e.lzsa\"" >> meche_graphics.inc
	echo "elevator_half_e_lzsa: .incbin \"elevator_half_e.lzsa\"" >> meche_graphics.inc
	echo "elevator_top_e_lzsa: .incbin \"elevator_top_e.lzsa\"" >> meche_graphics.inc
	echo "top_floor_e_lzsa: .incbin \"top_floor_e.lzsa\"" >> meche_graphics.inc
	echo "top_floor_ye_w_lzsa: .incbin \"top_floor_ye_w.lzsa\"" >> meche_graphics.inc
	echo "top_floor_ne_w_lzsa: .incbin \"top_floor_ne_w.lzsa\"" >> meche_graphics.inc
	echo "rotate_controls_e_lzsa: .incbin \"rotate_controls_e.lzsa\"" >> meche_graphics.inc
	echo "eastturn_e_lzsa: .incbin \"eastturn_e.lzsa\"" >> meche_graphics.inc
	echo "eastturn_w_lzsa: .incbin \"eastturn_w.lzsa\"" >> meche_graphics.inc
	echo "east_arch_w_lzsa: .incbin \"east_arch_w.lzsa\"" >> meche_graphics.inc
	echo "east_arch_s_lzsa: .incbin \"east_arch_s.lzsa\"" >> meche_graphics.inc
	echo "east_hint_e_lzsa: .incbin \"east_hint_e.lzsa\"" >> meche_graphics.inc
	echo "east_top_e_lzsa: .incbin \"east_top_e.lzsa\"" >> meche_graphics.inc
	echo "east_top_w_lzsa: .incbin \"east_top_w.lzsa\"" >> meche_graphics.inc
	echo "fort_exit_n_lzsa: .incbin \"fort_exit_n.lzsa\"" >> meche_graphics.inc
	echo "fort_exit_w_lzsa: .incbin \"fort_exit_w.lzsa\"" >> meche_graphics.inc
	echo "fort_exit_e_lzsa: .incbin \"fort_exit_e.lzsa\"" >> meche_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa meche_graphics.inc

#include ../Makefile.inc

PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	nibel_graphics.inc

####

nibel_graphics.inc:	\
	elevator2_open_top.lzsa elevator2_closed_top.lzsa \
	outside_elevator2_e.lzsa outside_elevator2_open_w.lzsa outside_elevator2_closed_w.lzsa \
	blue_path_0p5_n.lzsa blue_path_0p5_s.lzsa \
	blue_path1_n.lzsa blue_path1_s.lzsa \
	blue_path2_n.lzsa blue_path2_s.lzsa \
	blue_path_2p25_n.lzsa blue_path_2p25_s.lzsa blue_path_2p25_e.lzsa \
	blue_path_2p25_open_e.lzsa \
	blue_path_2p25_gate_s.lzsa \
	blue_path_2p5_n.lzsa blue_path_2p5_s.lzsa \
	blue_path_2p5_gate_n.lzsa \
	blue_path_2p75_n.lzsa blue_path_2p75_s.lzsa \
	blue_path3_n.lzsa blue_path3_s.lzsa \
	blue_house_door_n.lzsa blue_house_door_s.lzsa blue_house_door_open_s.lzsa \
	blue_house_n.lzsa blue_house_s.lzsa blue_house_e.lzsa blue_house_w.lzsa \
	projector_e.lzsa \
	red_path1_e.lzsa red_path1_w.lzsa \
	red_room_n.lzsa red_room_s.lzsa red_room_e.lzsa red_room_w.lzsa \
	red_door_e.lzsa red_door_closed_w.lzsa red_door_open_w.lzsa \
	red_room_table_s.lzsa red_room_table_open_s.lzsa \
	red_room_bed_w.lzsa red_room_bed_open_w.lzsa \
	right_letter.lzsa \
	shack_outside_n.lzsa shack_outside_s.lzsa \
	shack_hallway_n.lzsa shack_hallway_s.lzsa \
	shack_exit_n.lzsa shack_exit_s.lzsa \
	shack_center_n.lzsa shack_center_s.lzsa \
	shack_entrance_n.lzsa shack_entrance_s.lzsa shack_entrance_open_n.lzsa \
	shack_entrance_playing_s.lzsa
	echo "elevator2_open_top_lzsa: .incbin \"elevator2_open_top.lzsa\"" > nibel_graphics.inc
	echo "elevator2_closed_top_lzsa: .incbin \"elevator2_closed_top.lzsa\"" >> nibel_graphics.inc
	echo "outside_elevator2_e_lzsa: .incbin \"outside_elevator2_e.lzsa\"" >> nibel_graphics.inc
	echo "outside_elevator2_open_w_lzsa: .incbin \"outside_elevator2_open_w.lzsa\"" >> nibel_graphics.inc
	echo "outside_elevator2_closed_w_lzsa: .incbin \"outside_elevator2_closed_w.lzsa\"" >> nibel_graphics.inc
	echo "blue_path_0p5_n_lzsa: .incbin \"blue_path_0p5_n.lzsa\"" >> nibel_graphics.inc
	echo "blue_path_0p5_s_lzsa: .incbin \"blue_path_0p5_s.lzsa\"" >> nibel_graphics.inc
	echo "blue_path1_n_lzsa: .incbin \"blue_path1_n.lzsa\"" >> nibel_graphics.inc
	echo "blue_path1_s_lzsa: .incbin \"blue_path1_s.lzsa\"" >> nibel_graphics.inc
	echo "blue_path2_n_lzsa: .incbin \"blue_path2_n.lzsa\"" >> nibel_graphics.inc
	echo "blue_path2_s_lzsa: .incbin \"blue_path2_s.lzsa\"" >> nibel_graphics.inc
	echo "blue_path_2p25_n_lzsa: .incbin \"blue_path_2p25_n.lzsa\"" >> nibel_graphics.inc
	echo "blue_path_2p25_s_lzsa: .incbin \"blue_path_2p25_s.lzsa\"" >> nibel_graphics.inc
	echo "blue_path_2p25_e_lzsa: .incbin \"blue_path_2p25_e.lzsa\"" >> nibel_graphics.inc
	echo "blue_path_2p25_open_e_lzsa: .incbin \"blue_path_2p25_open_e.lzsa\"" >> nibel_graphics.inc
	echo "blue_path_2p25_gate_s_lzsa: .incbin \"blue_path_2p25_gate_s.lzsa\"" >> nibel_graphics.inc
	echo "blue_path_2p5_n_lzsa: .incbin \"blue_path_2p5_n.lzsa\"" >> nibel_graphics.inc
	echo "blue_path_2p5_s_lzsa: .incbin \"blue_path_2p5_s.lzsa\"" >> nibel_graphics.inc
	echo "blue_path_2p5_gate_n_lzsa: .incbin \"blue_path_2p5_gate_n.lzsa\"" >> nibel_graphics.inc
	echo "blue_path_2p75_n_lzsa: .incbin \"blue_path_2p75_n.lzsa\"" >> nibel_graphics.inc
	echo "blue_path_2p75_s_lzsa: .incbin \"blue_path_2p75_s.lzsa\"" >> nibel_graphics.inc
	echo "blue_path3_n_lzsa: .incbin \"blue_path3_n.lzsa\"" >> nibel_graphics.inc
	echo "blue_path3_s_lzsa: .incbin \"blue_path3_s.lzsa\"" >> nibel_graphics.inc
	echo "blue_house_door_n_lzsa: .incbin \"blue_house_door_n.lzsa\"" >> nibel_graphics.inc
	echo "blue_house_door_s_lzsa: .incbin \"blue_house_door_s.lzsa\"" >> nibel_graphics.inc
	echo "blue_house_door_open_s_lzsa: .incbin \"blue_house_door_open_s.lzsa\"" >> nibel_graphics.inc
	echo "blue_house_n_lzsa: .incbin \"blue_house_n.lzsa\"" >> nibel_graphics.inc
	echo "blue_house_s_lzsa: .incbin \"blue_house_s.lzsa\"" >> nibel_graphics.inc
	echo "blue_house_e_lzsa: .incbin \"blue_house_e.lzsa\"" >> nibel_graphics.inc
	echo "blue_house_w_lzsa: .incbin \"blue_house_w.lzsa\"" >> nibel_graphics.inc
	echo "projector_e_lzsa: .incbin \"projector_e.lzsa\"" >> nibel_graphics.inc
	echo "red_path1_e_lzsa: .incbin \"red_path1_e.lzsa\"" >> nibel_graphics.inc
	echo "red_path1_w_lzsa: .incbin \"red_path1_w.lzsa\"" >> nibel_graphics.inc
	echo "red_room_n_lzsa: .incbin \"red_room_n.lzsa\"" >> nibel_graphics.inc
	echo "red_room_s_lzsa: .incbin \"red_room_s.lzsa\"" >> nibel_graphics.inc
	echo "red_room_e_lzsa: .incbin \"red_room_e.lzsa\"" >> nibel_graphics.inc
	echo "red_room_w_lzsa: .incbin \"red_room_w.lzsa\"" >> nibel_graphics.inc
	echo "red_door_e_lzsa: .incbin \"red_door_e.lzsa\"" >> nibel_graphics.inc
	echo "red_door_open_w_lzsa: .incbin \"red_door_open_w.lzsa\"" >> nibel_graphics.inc
	echo "red_door_closed_w_lzsa: .incbin \"red_door_closed_w.lzsa\"" >> nibel_graphics.inc
	echo "red_room_table_s_lzsa: .incbin \"red_room_table_s.lzsa\"" >> nibel_graphics.inc
	echo "red_room_table_open_s_lzsa: .incbin \"red_room_table_open_s.lzsa\"" >> nibel_graphics.inc
	echo "red_room_bed_w_lzsa: .incbin \"red_room_bed_w.lzsa\"" >> nibel_graphics.inc
	echo "red_room_bed_open_w_lzsa: .incbin \"red_room_bed_open_w.lzsa\"" >> nibel_graphics.inc
	echo "right_letter_lzsa: .incbin \"right_letter.lzsa\"" >> nibel_graphics.inc
	echo "shack_outside_n_lzsa: .incbin \"shack_outside_n.lzsa\"" >> nibel_graphics.inc
	echo "shack_outside_s_lzsa: .incbin \"shack_outside_s.lzsa\"" >> nibel_graphics.inc
	echo "shack_hallway_n_lzsa: .incbin \"shack_hallway_n.lzsa\"" >> nibel_graphics.inc
	echo "shack_hallway_s_lzsa: .incbin \"shack_hallway_s.lzsa\"" >> nibel_graphics.inc
	echo "shack_exit_n_lzsa: .incbin \"shack_exit_n.lzsa\"" >> nibel_graphics.inc
	echo "shack_exit_s_lzsa: .incbin \"shack_exit_s.lzsa\"" >> nibel_graphics.inc
	echo "shack_center_n_lzsa: .incbin \"shack_center_n.lzsa\"" >> nibel_graphics.inc
	echo "shack_center_s_lzsa: .incbin \"shack_center_s.lzsa\"" >> nibel_graphics.inc
	echo "shack_entrance_n_lzsa: .incbin \"shack_entrance_n.lzsa\"" >> nibel_graphics.inc
	echo "shack_entrance_open_n_lzsa: .incbin \"shack_entrance_open_n.lzsa\"" >> nibel_graphics.inc
	echo "shack_entrance_s_lzsa: .incbin \"shack_entrance_s.lzsa\"" >> nibel_graphics.inc
	echo "shack_entrance_playing_s_lzsa: .incbin \"shack_entrance_playing_s.lzsa\"" >> nibel_graphics.inc


%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa nibel_graphics.inc

#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	mist_graphics.inc


####

mist_graphics.inc:	\
	dock_n.lzsa dock_s.lzsa dock_e.lzsa dock_w.lzsa dock_w_open.lzsa \
	dock_switch_n.lzsa dock_switch_s.lzsa \
	dock_steps_w.lzsa \
	cat_letter.lzsa \
	above_dock_e.lzsa above_dock_n.lzsa above_dock_s.lzsa \
	step_base_s.lzsa step_base_n.lzsa \
	step_land1_w.lzsa step_land1_e.lzsa \
	step_land2_e.lzsa step_land2_w.lzsa \
	step_dentist_n.lzsa step_dentist_e.lzsa step_dentist_w.lzsa \
	step_land3_w.lzsa step_land3_e.lzsa \
	step_top_e.lzsa step_top_w.lzsa step_top_n.lzsa step_top_s.lzsa \
	pool_s.lzsa \
	clock_e.lzsa clock_n.lzsa clock_s.lzsa clock_bridge.lzsa \
	spaceship_far_e.lzsa spaceship_far_n.lzsa \
	tree2_n.lzsa \
	tree5_n.lzsa tree5_e.lzsa tree5_s.lzsa \
	gear_n.lzsa gear_w.lzsa gear_s.lzsa gear_open_n.lzsa\
	gear_base_n.lzsa \
	spaceship_switch_n.lzsa \
	tree4_n.lzsa tree4_s.lzsa tree4_w.lzsa tree4_e.lzsa \
	clock_island_s.lzsa clock_island_n.lzsa \
	clock_puzzle_s.lzsa clock_puzzle_bridge.lzsa \
	clock_inside_s.lzsa clock_inside_open.lzsa \
	gear_open_e.lzsa \
	generator_n.lzsa generator_s.lzsa \
	green_house_w.lzsa green_house_e.lzsa \
	green_steps1_n.lzsa green_steps1_s.lzsa \
	gen_door_closed_n.lzsa gen_door_open_n.lzsa gen_door_s.lzsa \
	green_steps6_n.lzsa green_steps6_w.lzsa \
	pad_n.lzsa pad_e.lzsa \
	spaceship_door_n.lzsa spaceship_door_open_n.lzsa \
	tower2_base_w.lzsa tower2_top_w.lzsa \
	tower2_path_e.lzsa tower2_path_n.lzsa \
	tower1_trail_w.lzsa tower1_trail_e.lzsa \
	tower1_trail2_n.lzsa tower1_trail2_w.lzsa tower1_trail2_s.lzsa \
	tower1_base_e.lzsa \
	tower1_top_e.lzsa
	echo "dock_n_lzsa: .incbin \"dock_n.lzsa\"" > mist_graphics.inc
	echo "dock_s_lzsa: .incbin \"dock_s.lzsa\"" >> mist_graphics.inc
	echo "dock_e_lzsa: .incbin \"dock_e.lzsa\"" >> mist_graphics.inc
	echo "dock_w_lzsa: .incbin \"dock_w.lzsa\"" >> mist_graphics.inc
	echo "dock_w_open_lzsa: .incbin \"dock_w_open.lzsa\"" >> mist_graphics.inc
	echo "dock_switch_n_lzsa: .incbin \"dock_switch_n.lzsa\"" >> mist_graphics.inc
	echo "dock_switch_s_lzsa: .incbin \"dock_switch_s.lzsa\"" >> mist_graphics.inc
	echo "dock_steps_w_lzsa: .incbin \"dock_steps_w.lzsa\"" >> mist_graphics.inc
	echo "cat_letter_lzsa: .incbin \"cat_letter.lzsa\"" >> mist_graphics.inc
	echo "above_dock_e_lzsa: .incbin \"above_dock_e.lzsa\"" >> mist_graphics.inc
	echo "above_dock_s_lzsa: .incbin \"above_dock_s.lzsa\"" >> mist_graphics.inc
	echo "above_dock_n_lzsa: .incbin \"above_dock_n.lzsa\"" >> mist_graphics.inc
	echo "step_base_n_lzsa: .incbin \"step_base_n.lzsa\"" >> mist_graphics.inc
	echo "step_base_s_lzsa: .incbin \"step_base_s.lzsa\"" >> mist_graphics.inc
	echo "step_land1_w_lzsa: .incbin \"step_land1_w.lzsa\"" >> mist_graphics.inc
	echo "step_land1_e_lzsa: .incbin \"step_land1_e.lzsa\"" >> mist_graphics.inc
	echo "step_land2_w_lzsa: .incbin \"step_land2_w.lzsa\"" >> mist_graphics.inc
	echo "step_land2_e_lzsa: .incbin \"step_land2_e.lzsa\"" >> mist_graphics.inc
	echo "step_dentist_n_lzsa: .incbin \"step_dentist_n.lzsa\"" >> mist_graphics.inc
	echo "step_dentist_w_lzsa: .incbin \"step_dentist_w.lzsa\"" >> mist_graphics.inc
	echo "step_dentist_e_lzsa: .incbin \"step_dentist_e.lzsa\"" >> mist_graphics.inc
	echo "step_land3_w_lzsa: .incbin \"step_land3_w.lzsa\"" >> mist_graphics.inc
	echo "step_land3_e_lzsa: .incbin \"step_land3_e.lzsa\"" >> mist_graphics.inc
	echo "step_top_e_lzsa: .incbin \"step_top_e.lzsa\"" >> mist_graphics.inc
	echo "step_top_w_lzsa: .incbin \"step_top_w.lzsa\"" >> mist_graphics.inc
	echo "step_top_n_lzsa: .incbin \"step_top_n.lzsa\"" >> mist_graphics.inc
	echo "step_top_s_lzsa: .incbin \"step_top_s.lzsa\"" >> mist_graphics.inc
	echo "pool_s_lzsa: .incbin \"pool_s.lzsa\"" >> mist_graphics.inc
	echo "clock_s_lzsa: .incbin \"clock_s.lzsa\"" >> mist_graphics.inc
	echo "clock_n_lzsa: .incbin \"clock_n.lzsa\"" >> mist_graphics.inc
	echo "clock_e_lzsa: .incbin \"clock_e.lzsa\"" >> mist_graphics.inc
	echo "clock_bridge_lzsa: .incbin \"clock_bridge.lzsa\"" >> mist_graphics.inc
	echo "spaceship_far_n_lzsa: .incbin \"spaceship_far_n.lzsa\"" >> mist_graphics.inc
	echo "spaceship_far_e_lzsa: .incbin \"spaceship_far_e.lzsa\"" >> mist_graphics.inc
	echo "tree2_n_lzsa: .incbin \"tree2_n.lzsa\"" >> mist_graphics.inc
	echo "tree5_n_lzsa: .incbin \"tree5_n.lzsa\"" >> mist_graphics.inc
	echo "tree5_s_lzsa: .incbin \"tree5_s.lzsa\"" >> mist_graphics.inc
	echo "tree5_e_lzsa: .incbin \"tree5_e.lzsa\"" >> mist_graphics.inc
	echo "gear_n_lzsa: .incbin \"gear_n.lzsa\"" >> mist_graphics.inc
	echo "gear_s_lzsa: .incbin \"gear_s.lzsa\"" >> mist_graphics.inc
	echo "gear_w_lzsa: .incbin \"gear_w.lzsa\"" >> mist_graphics.inc
	echo "gear_open_n_lzsa: .incbin \"gear_open_n.lzsa\"" >> mist_graphics.inc
	echo "gear_base_n_lzsa: .incbin \"gear_base_n.lzsa\"" >> mist_graphics.inc
	echo "spaceship_switch_n_lzsa: .incbin \"spaceship_switch_n.lzsa\"" >> mist_graphics.inc
	echo "tree4_n_lzsa: .incbin \"tree4_n.lzsa\"" >> mist_graphics.inc
	echo "tree4_s_lzsa: .incbin \"tree4_s.lzsa\"" >> mist_graphics.inc
	echo "tree4_w_lzsa: .incbin \"tree4_w.lzsa\"" >> mist_graphics.inc
	echo "tree4_e_lzsa: .incbin \"tree4_e.lzsa\"" >> mist_graphics.inc
	echo "clock_island_s_lzsa: .incbin \"clock_island_s.lzsa\"" >> mist_graphics.inc
	echo "clock_island_n_lzsa: .incbin \"clock_island_n.lzsa\"" >> mist_graphics.inc
	echo "clock_puzzle_s_lzsa: .incbin \"clock_puzzle_s.lzsa\"" >> mist_graphics.inc
	echo "clock_puzzle_bridge_lzsa: .incbin \"clock_puzzle_bridge.lzsa\"" >> mist_graphics.inc
	echo "clock_inside_s_lzsa: .incbin \"clock_inside_s.lzsa\"" >> mist_graphics.inc
	echo "clock_inside_open_lzsa: .incbin \"clock_inside_open.lzsa\"" >> mist_graphics.inc
	echo "gear_open_e_lzsa: .incbin \"gear_open_e.lzsa\"" >> mist_graphics.inc
	echo "generator_n_lzsa: .incbin \"generator_n.lzsa\"" >> mist_graphics.inc
	echo "generator_s_lzsa: .incbin \"generator_s.lzsa\"" >> mist_graphics.inc
	echo "green_house_w_lzsa: .incbin \"green_house_w.lzsa\"" >> mist_graphics.inc
	echo "green_house_e_lzsa: .incbin \"green_house_e.lzsa\"" >> mist_graphics.inc
	echo "green_steps1_n_lzsa: .incbin \"green_steps1_n.lzsa\"" >> mist_graphics.inc
	echo "green_steps1_s_lzsa: .incbin \"green_steps1_s.lzsa\"" >> mist_graphics.inc
	echo "gen_door_closed_n_lzsa: .incbin \"gen_door_closed_n.lzsa\"" >> mist_graphics.inc
	echo "gen_door_open_n_lzsa: .incbin \"gen_door_open_n.lzsa\"" >> mist_graphics.inc
	echo "gen_door_s_lzsa: .incbin \"gen_door_s.lzsa\"" >> mist_graphics.inc
	echo "green_steps6_n_lzsa: .incbin \"green_steps6_n.lzsa\"" >> mist_graphics.inc
	echo "green_steps6_w_lzsa: .incbin \"green_steps6_w.lzsa\"" >> mist_graphics.inc
	echo "pad_n_lzsa: .incbin \"pad_n.lzsa\"" >> mist_graphics.inc
	echo "pad_e_lzsa: .incbin \"pad_e.lzsa\"" >> mist_graphics.inc
	echo "spaceship_door_n_lzsa: .incbin \"spaceship_door_n.lzsa\"" >> mist_graphics.inc
	echo "spaceship_door_open_n_lzsa: .incbin \"spaceship_door_open_n.lzsa\"" >> mist_graphics.inc
	echo "tower2_base_w_lzsa: .incbin \"tower2_base_w.lzsa\"" >> mist_graphics.inc
	echo "tower2_top_w_lzsa: .incbin \"tower2_top_w.lzsa\"" >> mist_graphics.inc
	echo "tower2_path_e_lzsa: .incbin \"tower2_path_e.lzsa\"" >> mist_graphics.inc
	echo "tower2_path_n_lzsa: .incbin \"tower2_path_n.lzsa\"" >> mist_graphics.inc
	echo "tower1_trail_w_lzsa: .incbin \"tower1_trail_w.lzsa\"" >> mist_graphics.inc
	echo "tower1_trail_e_lzsa: .incbin \"tower1_trail_e.lzsa\"" >> mist_graphics.inc
	echo "tower1_trail2_n_lzsa: .incbin \"tower1_trail2_n.lzsa\"" >> mist_graphics.inc
	echo "tower1_trail2_w_lzsa: .incbin \"tower1_trail2_w.lzsa\"" >> mist_graphics.inc
	echo "tower1_trail2_s_lzsa: .incbin \"tower1_trail2_s.lzsa\"" >> mist_graphics.inc
	echo "tower1_base_e_lzsa: .incbin \"tower1_base_e.lzsa\"" >> mist_graphics.inc
	echo "tower1_top_e_lzsa: .incbin \"tower1_top_e.lzsa\"" >> mist_graphics.inc


%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa mist_graphics.inc

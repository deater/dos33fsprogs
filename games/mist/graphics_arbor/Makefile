#include ../Makefile.inc

PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	arbor_graphics.inc

####

arbor_graphics.inc:	\
	arrival_e.lzsa arrival_w.lzsa arrival_open_e.lzsa \
	arrival_down_e.lzsa arrival_noelev_e.lzsa \
	inside_elevator1_closed_w.lzsa inside_elevator1_open_w.lzsa \
	bridge1_e.lzsa bridge1_w.lzsa \
	hut1_e.lzsa hut1_w.lzsa hut1_s.lzsa \
	bridge2_n.lzsa bridge2_s.lzsa \
	shack1_n.lzsa shack1_s.lzsa shack1_e.lzsa shack1_w.lzsa \
	bridge3_e.lzsa bridge3_w.lzsa \
	longshack1_e.lzsa longshack1_w.lzsa \
	longshack2_e.lzsa longshack2_w.lzsa longshack2_n.lzsa longshack2_s.lzsa \
	switch_bridge1_n.lzsa switch_bridge1_s.lzsa \
	switch_hut1_n.lzsa switch_hut1_e.lzsa \
	switch_bridge2_e.lzsa switch_bridge2_w.lzsa \
	switch_hut_w.lzsa switch_hut_closed_s.lzsa switch_hut_open_s.lzsa \
	bridge4_e.lzsa bridge4_w.lzsa \
	hut2_e.lzsa hut2_w.lzsa \
	hut2_inside_w.lzsa hut2_inside_s.lzsa hut2_inside_n.lzsa \
	bridge5_n.lzsa bridge5_s.lzsa \
	longshack3_n.lzsa longshack3_s.lzsa \
	bridge6_n.lzsa bridge6_s.lzsa \
	shack2_n.lzsa shack2_s.lzsa shack2_e.lzsa shack2_w.lzsa \
	bridge7_e.lzsa bridge7_open_w.lzsa bridge7_closed_w.lzsa \
	doors_e.lzsa doors_closed_w.lzsa doors_open_w.lzsa \
	doors_elev2_open_w.lzsa doors_open_elev2_closed_w.lzsa \
	inside_elevator2_open.lzsa inside_elevator2_closed.lzsa \
	steps_top_e.lzsa steps_top_w.lzsa \
	steps1_e.lzsa steps1_w.lzsa \
	steps2_e.lzsa steps2_w.lzsa \
	steps_bottom_e.lzsa steps_bottom_open_w.lzsa steps_bottom_closed_w.lzsa \
	inlongshack3_n.lzsa inlongshack3_s.lzsa inlongshack3_e.lzsa inlongshack3_w.lzsa \
	hut6_n.lzsa hut6_w.lzsa \
	hut5_s.lzsa hut5_w.lzsa \
	hut4_n.lzsa hut4_s.lzsa hut4_e.lzsa hut4_w.lzsa \
	hut3_s.lzsa \
	hut7_n.lzsa
	echo "arrival_e_lzsa: .incbin \"arrival_e.lzsa\"" > arbor_graphics.inc
	echo "arrival_open_e_lzsa: .incbin \"arrival_open_e.lzsa\"" >> arbor_graphics.inc
	echo "arrival_w_lzsa: .incbin \"arrival_w.lzsa\"" >> arbor_graphics.inc
	echo "arrival_down_e_lzsa: .incbin \"arrival_down_e.lzsa\"" >> arbor_graphics.inc
	echo "arrival_noelev_e_lzsa: .incbin \"arrival_noelev_e.lzsa\"" >> arbor_graphics.inc
	echo "inside_elevator1_open_w_lzsa: .incbin \"inside_elevator1_open_w.lzsa\"" >> arbor_graphics.inc
	echo "inside_elevator1_closed_w_lzsa: .incbin \"inside_elevator1_closed_w.lzsa\"" >> arbor_graphics.inc
	echo "bridge1_e_lzsa: .incbin \"bridge1_e.lzsa\"" >> arbor_graphics.inc
	echo "bridge1_w_lzsa: .incbin \"bridge1_w.lzsa\"" >> arbor_graphics.inc
	echo "hut1_e_lzsa: .incbin \"hut1_e.lzsa\"" >> arbor_graphics.inc
	echo "hut1_w_lzsa: .incbin \"hut1_w.lzsa\"" >> arbor_graphics.inc
	echo "hut1_s_lzsa: .incbin \"hut1_s.lzsa\"" >> arbor_graphics.inc
	echo "bridge2_n_lzsa: .incbin \"bridge2_n.lzsa\"" >> arbor_graphics.inc
	echo "bridge2_s_lzsa: .incbin \"bridge2_s.lzsa\"" >> arbor_graphics.inc
	echo "shack1_n_lzsa: .incbin \"shack1_n.lzsa\"" >> arbor_graphics.inc
	echo "shack1_s_lzsa: .incbin \"shack1_s.lzsa\"" >> arbor_graphics.inc
	echo "shack1_e_lzsa: .incbin \"shack1_e.lzsa\"" >> arbor_graphics.inc
	echo "shack1_w_lzsa: .incbin \"shack1_w.lzsa\"" >> arbor_graphics.inc
	echo "bridge3_e_lzsa: .incbin \"bridge3_e.lzsa\"" >> arbor_graphics.inc
	echo "bridge3_w_lzsa: .incbin \"bridge3_w.lzsa\"" >> arbor_graphics.inc
	echo "longshack1_e_lzsa: .incbin \"longshack1_e.lzsa\"" >> arbor_graphics.inc
	echo "longshack1_w_lzsa: .incbin \"longshack1_w.lzsa\"" >> arbor_graphics.inc
	echo "longshack2_e_lzsa: .incbin \"longshack2_e.lzsa\"" >> arbor_graphics.inc
	echo "longshack2_w_lzsa: .incbin \"longshack2_w.lzsa\"" >> arbor_graphics.inc
	echo "longshack2_n_lzsa: .incbin \"longshack2_n.lzsa\"" >> arbor_graphics.inc
	echo "longshack2_s_lzsa: .incbin \"longshack2_s.lzsa\"" >> arbor_graphics.inc
	echo "switch_bridge1_n_lzsa: .incbin \"switch_bridge1_n.lzsa\"" >> arbor_graphics.inc
	echo "switch_bridge1_s_lzsa: .incbin \"switch_bridge1_s.lzsa\"" >> arbor_graphics.inc
	echo "switch_hut1_n_lzsa: .incbin \"switch_hut1_n.lzsa\"" >> arbor_graphics.inc
	echo "switch_hut1_e_lzsa: .incbin \"switch_hut1_e.lzsa\"" >> arbor_graphics.inc
	echo "switch_bridge2_e_lzsa: .incbin \"switch_bridge2_e.lzsa\"" >> arbor_graphics.inc
	echo "switch_bridge2_w_lzsa: .incbin \"switch_bridge2_w.lzsa\"" >> arbor_graphics.inc
	echo "switch_hut_w_lzsa: .incbin \"switch_hut_w.lzsa\"" >> arbor_graphics.inc
	echo "switch_hut_closed_s_lzsa: .incbin \"switch_hut_closed_s.lzsa\"" >> arbor_graphics.inc
	echo "switch_hut_open_s_lzsa: .incbin \"switch_hut_open_s.lzsa\"" >> arbor_graphics.inc
	echo "bridge4_e_lzsa: .incbin \"bridge4_e.lzsa\"" >> arbor_graphics.inc
	echo "bridge4_w_lzsa: .incbin \"bridge4_w.lzsa\"" >> arbor_graphics.inc
	echo "hut2_e_lzsa: .incbin \"hut2_e.lzsa\"" >> arbor_graphics.inc
	echo "hut2_w_lzsa: .incbin \"hut2_w.lzsa\"" >> arbor_graphics.inc
	echo "hut2_inside_w_lzsa: .incbin \"hut2_inside_w.lzsa\"" >> arbor_graphics.inc
	echo "hut2_inside_s_lzsa: .incbin \"hut2_inside_s.lzsa\"" >> arbor_graphics.inc
	echo "hut2_inside_n_lzsa: .incbin \"hut2_inside_n.lzsa\"" >> arbor_graphics.inc
	echo "bridge5_n_lzsa: .incbin \"bridge5_n.lzsa\"" >> arbor_graphics.inc
	echo "bridge5_s_lzsa: .incbin \"bridge5_s.lzsa\"" >> arbor_graphics.inc
	echo "longshack3_n_lzsa: .incbin \"longshack3_n.lzsa\"" >> arbor_graphics.inc
	echo "longshack3_s_lzsa: .incbin \"longshack3_s.lzsa\"" >> arbor_graphics.inc
	echo "bridge6_n_lzsa: .incbin \"bridge6_n.lzsa\"" >> arbor_graphics.inc
	echo "bridge6_s_lzsa: .incbin \"bridge6_s.lzsa\"" >> arbor_graphics.inc
	echo "shack2_n_lzsa: .incbin \"shack2_n.lzsa\"" >> arbor_graphics.inc
	echo "shack2_s_lzsa: .incbin \"shack2_s.lzsa\"" >> arbor_graphics.inc
	echo "shack2_e_lzsa: .incbin \"shack2_e.lzsa\"" >> arbor_graphics.inc
	echo "shack2_w_lzsa: .incbin \"shack2_w.lzsa\"" >> arbor_graphics.inc
	echo "bridge7_e_lzsa: .incbin \"bridge7_e.lzsa\"" >> arbor_graphics.inc
	echo "bridge7_closed_w_lzsa: .incbin \"bridge7_closed_w.lzsa\"" >> arbor_graphics.inc
	echo "bridge7_open_w_lzsa: .incbin \"bridge7_open_w.lzsa\"" >> arbor_graphics.inc
	echo "doors_e_lzsa: .incbin \"doors_e.lzsa\"" >> arbor_graphics.inc
	echo "doors_closed_w_lzsa: .incbin \"doors_closed_w.lzsa\"" >> arbor_graphics.inc
	echo "doors_open_w_lzsa: .incbin \"doors_open_w.lzsa\"" >> arbor_graphics.inc
	echo "doors_elev2_open_w_lzsa: .incbin \"doors_elev2_open_w.lzsa\"" >> arbor_graphics.inc
	echo "doors_open_elev2_closed_w_lzsa: .incbin \"doors_open_elev2_closed_w.lzsa\"" >> arbor_graphics.inc
	echo "inside_elevator2_open_lzsa: .incbin \"inside_elevator2_open.lzsa\"" >> arbor_graphics.inc
	echo "inside_elevator2_closed_lzsa: .incbin \"inside_elevator2_closed.lzsa\"" >> arbor_graphics.inc
	echo "steps_top_e_lzsa: .incbin \"steps_top_e.lzsa\"" >> arbor_graphics.inc
	echo "steps_top_w_lzsa: .incbin \"steps_top_w.lzsa\"" >> arbor_graphics.inc
	echo "steps1_w_lzsa: .incbin \"steps1_w.lzsa\"" >> arbor_graphics.inc
	echo "steps1_e_lzsa: .incbin \"steps1_e.lzsa\"" >> arbor_graphics.inc
	echo "steps2_w_lzsa: .incbin \"steps2_w.lzsa\"" >> arbor_graphics.inc
	echo "steps2_e_lzsa: .incbin \"steps2_e.lzsa\"" >> arbor_graphics.inc
	echo "steps_bottom_e_lzsa: .incbin \"steps_bottom_e.lzsa\"" >> arbor_graphics.inc
	echo "steps_bottom_open_w_lzsa: .incbin \"steps_bottom_open_w.lzsa\"" >> arbor_graphics.inc
	echo "steps_bottom_closed_w_lzsa: .incbin \"steps_bottom_closed_w.lzsa\"" >> arbor_graphics.inc
	echo "inlongshack3_n_lzsa: .incbin \"inlongshack3_n.lzsa\"" >> arbor_graphics.inc
	echo "inlongshack3_s_lzsa: .incbin \"inlongshack3_s.lzsa\"" >> arbor_graphics.inc
	echo "inlongshack3_e_lzsa: .incbin \"inlongshack3_e.lzsa\"" >> arbor_graphics.inc
	echo "inlongshack3_w_lzsa: .incbin \"inlongshack3_w.lzsa\"" >> arbor_graphics.inc
	echo "hut6_n_lzsa: .incbin \"hut6_n.lzsa\"" >> arbor_graphics.inc
	echo "hut6_w_lzsa: .incbin \"hut6_w.lzsa\"" >> arbor_graphics.inc
	echo "hut5_s_lzsa: .incbin \"hut5_s.lzsa\"" >> arbor_graphics.inc
	echo "hut5_w_lzsa: .incbin \"hut5_w.lzsa\"" >> arbor_graphics.inc
	echo "hut4_n_lzsa: .incbin \"hut4_n.lzsa\"" >> arbor_graphics.inc
	echo "hut4_s_lzsa: .incbin \"hut4_s.lzsa\"" >> arbor_graphics.inc
	echo "hut4_e_lzsa: .incbin \"hut4_e.lzsa\"" >> arbor_graphics.inc
	echo "hut4_w_lzsa: .incbin \"hut4_w.lzsa\"" >> arbor_graphics.inc
	echo "hut3_s_lzsa: .incbin \"hut3_s.lzsa\"" >> arbor_graphics.inc
	echo "hut7_n_lzsa: .incbin \"hut7_n.lzsa\"" >> arbor_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa arbor_graphics.inc

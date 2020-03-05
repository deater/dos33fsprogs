#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	mist_graphics.inc


####

mist_graphics.inc:	\
	m_link_book.lzsa \
	dock_n.lzsa dock_s.lzsa dock_e.lzsa dock_w.lzsa \
	dock_switch_n.lzsa dock_switch_s.lzsa \
	dock_steps_w.lzsa \
	above_dock_e.lzsa above_dock_n.lzsa above_dock_s.lzsa \
	step_base_s.lzsa step_base_n.lzsa \
	step_land1_w.lzsa step_land1_e.lzsa \
	step_land2_e.lzsa step_land2_w.lzsa \
	step_dentist_e.lzsa step_dentist_w.lzsa \
	step_land3_w.lzsa step_land3_e.lzsa \
	step_top_e.lzsa step_top_w.lzsa step_top_n.lzsa step_top_s.lzsa \
	temple_door_n.lzsa temple_door_s.lzsa \
	temple_center_n.lzsa temple_center_s.lzsa temple_center_e.lzsa temple_center_w.lzsa \
	red_book_shelf.lzsa \
	red_book_closed.lzsa \
	pool_s.lzsa \
	clock_s.lzsa \
	spaceship_far_e.lzsa spaceship_far_n.lzsa \
	red_book_open.lzsa red_book_static.lzsa red_book_static2.lzsa \
	tree2_n.lzsa \
	tree5_n.lzsa tree5_e.lzsa \
	gear_n.lzsa gear_w.lzsa gear_s.lzsa \
	gear_base_n.lzsa
	echo "m_link_book_lzsa: .incbin \"m_link_book.lzsa\"" > mist_graphics.inc
	echo "dock_n_lzsa: .incbin \"dock_n.lzsa\"" >> mist_graphics.inc
	echo "dock_s_lzsa: .incbin \"dock_s.lzsa\"" >> mist_graphics.inc
	echo "dock_e_lzsa: .incbin \"dock_e.lzsa\"" >> mist_graphics.inc
	echo "dock_w_lzsa: .incbin \"dock_w.lzsa\"" >> mist_graphics.inc
	echo "dock_switch_n_lzsa: .incbin \"dock_switch_n.lzsa\"" >> mist_graphics.inc
	echo "dock_switch_s_lzsa: .incbin \"dock_switch_s.lzsa\"" >> mist_graphics.inc
	echo "dock_steps_w_lzsa: .incbin \"dock_steps_w.lzsa\"" >> mist_graphics.inc
	echo "above_dock_e_lzsa: .incbin \"above_dock_e.lzsa\"" >> mist_graphics.inc
	echo "above_dock_s_lzsa: .incbin \"above_dock_s.lzsa\"" >> mist_graphics.inc
	echo "above_dock_n_lzsa: .incbin \"above_dock_n.lzsa\"" >> mist_graphics.inc
	echo "step_base_n_lzsa: .incbin \"step_base_n.lzsa\"" >> mist_graphics.inc
	echo "step_base_s_lzsa: .incbin \"step_base_s.lzsa\"" >> mist_graphics.inc
	echo "step_land1_w_lzsa: .incbin \"step_land1_w.lzsa\"" >> mist_graphics.inc
	echo "step_land1_e_lzsa: .incbin \"step_land1_e.lzsa\"" >> mist_graphics.inc
	echo "step_land2_w_lzsa: .incbin \"step_land2_w.lzsa\"" >> mist_graphics.inc
	echo "step_land2_e_lzsa: .incbin \"step_land2_e.lzsa\"" >> mist_graphics.inc
	echo "step_dentist_w_lzsa: .incbin \"step_dentist_w.lzsa\"" >> mist_graphics.inc
	echo "step_dentist_e_lzsa: .incbin \"step_dentist_e.lzsa\"" >> mist_graphics.inc
	echo "step_land3_w_lzsa: .incbin \"step_land3_w.lzsa\"" >> mist_graphics.inc
	echo "step_land3_e_lzsa: .incbin \"step_land3_e.lzsa\"" >> mist_graphics.inc
	echo "step_top_e_lzsa: .incbin \"step_top_e.lzsa\"" >> mist_graphics.inc
	echo "step_top_w_lzsa: .incbin \"step_top_w.lzsa\"" >> mist_graphics.inc
	echo "step_top_n_lzsa: .incbin \"step_top_n.lzsa\"" >> mist_graphics.inc
	echo "step_top_s_lzsa: .incbin \"step_top_s.lzsa\"" >> mist_graphics.inc
	echo "temple_door_n_lzsa: .incbin \"temple_door_n.lzsa\"" >> mist_graphics.inc
	echo "temple_door_s_lzsa: .incbin \"temple_door_s.lzsa\"" >> mist_graphics.inc
	echo "temple_center_n_lzsa: .incbin \"temple_center_n.lzsa\"" >> mist_graphics.inc
	echo "temple_center_s_lzsa: .incbin \"temple_center_s.lzsa\"" >> mist_graphics.inc
	echo "temple_center_e_lzsa: .incbin \"temple_center_e.lzsa\"" >> mist_graphics.inc
	echo "temple_center_w_lzsa: .incbin \"temple_center_w.lzsa\"" >> mist_graphics.inc
	echo "red_book_closed_lzsa: .incbin \"red_book_closed.lzsa\"" >> mist_graphics.inc
	echo "red_book_shelf_lzsa: .incbin \"red_book_shelf.lzsa\"" >> mist_graphics.inc
	echo "pool_s_lzsa: .incbin \"pool_s.lzsa\"" >> mist_graphics.inc
	echo "clock_s_lzsa: .incbin \"clock_s.lzsa\"" >> mist_graphics.inc
	echo "spaceship_far_n_lzsa: .incbin \"spaceship_far_n.lzsa\"" >> mist_graphics.inc
	echo "spaceship_far_e_lzsa: .incbin \"spaceship_far_e.lzsa\"" >> mist_graphics.inc
	echo "red_book_open_lzsa: .incbin \"red_book_open.lzsa\"" >> mist_graphics.inc
	echo "red_book_static_lzsa: .incbin \"red_book_static.lzsa\"" >> mist_graphics.inc
	echo "red_book_static2_lzsa: .incbin \"red_book_static2.lzsa\"" >> mist_graphics.inc
	echo "tree2_n_lzsa: .incbin \"tree2_n.lzsa\"" >> mist_graphics.inc
	echo "tree5_n_lzsa: .incbin \"tree5_n.lzsa\"" >> mist_graphics.inc
	echo "tree5_e_lzsa: .incbin \"tree5_e.lzsa\"" >> mist_graphics.inc
	echo "gear_n_lzsa: .incbin \"gear_n.lzsa\"" >> mist_graphics.inc
	echo "gear_s_lzsa: .incbin \"gear_s.lzsa\"" >> mist_graphics.inc
	echo "gear_w_lzsa: .incbin \"gear_w.lzsa\"" >> mist_graphics.inc
	echo "gear_base_n_lzsa: .incbin \"gear_base_n.lzsa\"" >> mist_graphics.inc


%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr mist_graphics.inc

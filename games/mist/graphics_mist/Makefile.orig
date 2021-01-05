#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle

all:	mist_graphics.inc

####

mist_graphics.inc:	\
	m_link_book.png \
	dock_n.png dock_s.png dock_e.png dock_w.png \
	dock_switch_n.png \
	dock_steps_w.png \
	above_dock_e.png above_dock_n.png above_dock_s.png \
	step_base_s.png step_base_n.png \
	step_land1_w.png step_land1_e.png \
	step_land2_e.png step_land2_w.png \
	step_dentist_e.png step_dentist_w.png \
	step_land3_w.png step_land3_e.png \
	step_top_e.png step_top_w.png step_top_n.png step_top_s.png \
	temple_door_n.png temple_door_s.png \
	temple_center_n.png temple_center_w.png \
	red_book_shelf.png \
	red_book_closed.png \
	pool_s.png \
	clock_s.png \
	spaceship_far_e.png spaceship_far_n.png \
	red_book_open.png red_book_static.png red_book_static2.png \
	tree2_n.png \
	tree5_n.png tree5_e.png \
	gear_n.png gear_w.png gear_s.png \
	gear_base_n.png
	$(PNG2RLE) asm m_link_book.png link_book_rle > mist_graphics.inc
	$(PNG2RLE) asm dock_n.png dock_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm dock_s.png dock_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm dock_e.png dock_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm dock_w.png dock_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm dock_switch_n.png dock_switch_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm dock_switch_s.png dock_switch_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm dock_steps_w.png dock_steps_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm above_dock_e.png above_dock_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm above_dock_s.png above_dock_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm above_dock_n.png above_dock_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_base_n.png step_base_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_base_s.png step_base_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_land1_w.png step_land1_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_land1_e.png step_land1_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_land2_w.png step_land2_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_land2_e.png step_land2_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_dentist_w.png step_dentist_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_dentist_e.png step_dentist_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_land3_w.png step_land3_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_land3_e.png step_land3_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_top_e.png step_top_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_top_w.png step_top_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_top_n.png step_top_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_top_s.png step_top_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm temple_door_n.png temple_door_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm temple_door_s.png temple_door_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm temple_center_n.png temple_center_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm temple_center_s.png temple_center_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm temple_center_e.png temple_center_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm temple_center_w.png temple_center_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm red_book_closed.png red_book_closed_rle >> mist_graphics.inc
	$(PNG2RLE) asm red_book_shelf.png red_book_shelf_rle >> mist_graphics.inc
	$(PNG2RLE) asm pool_s.png pool_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm clock_s.png clock_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm spaceship_far_n.png ss_far_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm spaceship_far_e.png ss_far_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm red_book_open.png red_book_open_rle >> mist_graphics.inc
	$(PNG2RLE) asm red_book_static.png red_book_static_rle >> mist_graphics.inc
	$(PNG2RLE) asm red_book_static2.png red_book_static2_rle >> mist_graphics.inc
	$(PNG2RLE) asm tree2_n.png tree2_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm tree5_n.png tree5_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm tree5_e.png tree5_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm gear_n.png gear_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm gear_s.png gear_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm gear_w.png gear_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm gear_base_n.png gear_base_n_rle >> mist_graphics.inc


####

clean:		
		rm -f *~ *.o *.lst mist_graphics.inc

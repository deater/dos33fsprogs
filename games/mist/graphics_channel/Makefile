#include ../Makefile.inc

PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	channel_graphics.inc

####

channel_graphics.inc:	\
	arrival_n.lzsa arrival_s.lzsa \
	bridge_w.lzsa bridge_down_e.lzsa bridge_up_e.lzsa \
	path2_e.lzsa path2_s.lzsa path2_n.lzsa \
	path3_w.lzsa path3_e.lzsa path3_n.lzsa \
	path4_e.lzsa path4_w.lzsa path4_s.lzsa \
	path5_e.lzsa path5_s.lzsa path5_n.lzsa \
	path6_s.lzsa path6_w.lzsa path6_n.lzsa \
	path7_s.lzsa path7_n.lzsa \
	fork_n.lzsa fork_s.lzsa fork_w.lzsa fork_gone_w.lzsa \
	before_elev1_e.lzsa before_elev1_w.lzsa before_elev1_open_w.lzsa \
	before_elev1_gone_w.lzsa \
	pipe_bridge2_up_w.lzsa pipe_bridge2_w.lzsa pipe_bridge2_e.lzsa \
	elevator1_open.lzsa elevator1_closed.lzsa \
	steps_fork_n.lzsa steps_fork_s.lzsa steps_fork_w.lzsa \
	steps_path_e.lzsa steps_path_w.lzsa steps_path_open_w.lzsa \
	steps_door_e.lzsa steps_door_w.lzsa steps_door_open_w.lzsa \
	wind_path_n.lzsa wind_path_s.lzsa \
	wind_path2_n.lzsa wind_path2_s.lzsa \
	island1_n.lzsa island1_s.lzsa \
	island2_n.lzsa island2_s.lzsa \
	island3_n.lzsa island3_s.lzsa \
	shack_n.lzsa shack_s.lzsa \
	tank_n.lzsa tank_s.lzsa tank_close.lzsa \
	windmill_n.lzsa windmill_s.lzsa \
	outback_n.lzsa outback_s.lzsa \
	after_bridge1_e.lzsa after_bridge1_w.lzsa \
	after_bridge2_e.lzsa after_bridge2_w.lzsa \
	book_fork_n.lzsa book_fork_s.lzsa book_fork_w.lzsa \
	pipe_extend_n.lzsa pipe_extend_down_s.lzsa pipe_extend_up_s.lzsa \
	book_room_n.lzsa book_room_s.lzsa \
	book_elevator_s.lzsa \
	book_elevator_open_n.lzsa book_elevator_closed_n.lzsa \
	book_elevator_inside_gnd_open.lzsa book_elevator_inside_gnd_closed.lzsa \
	book_elevator_inside_top_open.lzsa book_elevator_inside_top_closed.lzsa \
	book_mist_closed_s.lzsa book_mist_open_s.lzsa \
	valve_bottom_on.lzsa valve_bottom_off.lzsa \
	valve_top_on.lzsa valve_top_off.lzsa
	echo "arrival_n_lzsa: .incbin \"arrival_n.lzsa\"" > channel_graphics.inc
	echo "arrival_s_lzsa: .incbin \"arrival_s.lzsa\"" >> channel_graphics.inc
	echo "bridge_w_lzsa: .incbin \"bridge_w.lzsa\"" >> channel_graphics.inc
	echo "bridge_down_e_lzsa: .incbin \"bridge_down_e.lzsa\"" >> channel_graphics.inc
	echo "bridge_up_e_lzsa: .incbin \"bridge_up_e.lzsa\"" >> channel_graphics.inc
	echo "path2_n_lzsa: .incbin \"path2_n.lzsa\"" >> channel_graphics.inc
	echo "path2_s_lzsa: .incbin \"path2_s.lzsa\"" >> channel_graphics.inc
	echo "path2_e_lzsa: .incbin \"path2_e.lzsa\"" >> channel_graphics.inc
	echo "path3_w_lzsa: .incbin \"path3_w.lzsa\"" >> channel_graphics.inc
	echo "path3_e_lzsa: .incbin \"path3_e.lzsa\"" >> channel_graphics.inc
	echo "path3_n_lzsa: .incbin \"path3_n.lzsa\"" >> channel_graphics.inc
	echo "path4_e_lzsa: .incbin \"path4_e.lzsa\"" >> channel_graphics.inc
	echo "path4_w_lzsa: .incbin \"path4_w.lzsa\"" >> channel_graphics.inc
	echo "path4_s_lzsa: .incbin \"path4_s.lzsa\"" >> channel_graphics.inc
	echo "path5_e_lzsa: .incbin \"path5_e.lzsa\"" >> channel_graphics.inc
	echo "path5_s_lzsa: .incbin \"path5_s.lzsa\"" >> channel_graphics.inc
	echo "path5_n_lzsa: .incbin \"path5_n.lzsa\"" >> channel_graphics.inc
	echo "path6_s_lzsa: .incbin \"path6_s.lzsa\"" >> channel_graphics.inc
	echo "path6_w_lzsa: .incbin \"path6_w.lzsa\"" >> channel_graphics.inc
	echo "path6_n_lzsa: .incbin \"path6_n.lzsa\"" >> channel_graphics.inc
	echo "path7_n_lzsa: .incbin \"path7_n.lzsa\"" >> channel_graphics.inc
	echo "path7_s_lzsa: .incbin \"path7_s.lzsa\"" >> channel_graphics.inc
	echo "fork_n_lzsa: .incbin \"fork_n.lzsa\"" >> channel_graphics.inc
	echo "fork_s_lzsa: .incbin \"fork_s.lzsa\"" >> channel_graphics.inc
	echo "fork_w_lzsa: .incbin \"fork_w.lzsa\"" >> channel_graphics.inc
	echo "fork_gone_w_lzsa: .incbin \"fork_gone_w.lzsa\"" >> channel_graphics.inc
	echo "before_elev1_e_lzsa: .incbin \"before_elev1_e.lzsa\"" >> channel_graphics.inc
	echo "before_elev1_w_lzsa: .incbin \"before_elev1_w.lzsa\"" >> channel_graphics.inc
	echo "before_elev1_gone_w_lzsa: .incbin \"before_elev1_gone_w.lzsa\"" >> channel_graphics.inc
	echo "before_elev1_open_w_lzsa: .incbin \"before_elev1_open_w.lzsa\"" >> channel_graphics.inc
	echo "pipe_bridge2_e_lzsa: .incbin \"pipe_bridge2_e.lzsa\"" >> channel_graphics.inc
	echo "pipe_bridge2_w_lzsa: .incbin \"pipe_bridge2_w.lzsa\"" >> channel_graphics.inc
	echo "pipe_bridge2_up_w_lzsa: .incbin \"pipe_bridge2_up_w.lzsa\"" >> channel_graphics.inc
	echo "elevator1_open_lzsa: .incbin \"elevator1_open.lzsa\"" >> channel_graphics.inc
	echo "elevator1_closed_lzsa: .incbin \"elevator1_closed.lzsa\"" >> channel_graphics.inc
	echo "steps_fork_n_lzsa: .incbin \"steps_fork_n.lzsa\"" >> channel_graphics.inc
	echo "steps_fork_s_lzsa: .incbin \"steps_fork_s.lzsa\"" >> channel_graphics.inc
	echo "steps_fork_w_lzsa: .incbin \"steps_fork_w.lzsa\"" >> channel_graphics.inc
	echo "steps_path_e_lzsa: .incbin \"steps_path_e.lzsa\"" >> channel_graphics.inc
	echo "steps_path_w_lzsa: .incbin \"steps_path_w.lzsa\"" >> channel_graphics.inc
	echo "steps_path_open_w_lzsa: .incbin \"steps_path_open_w.lzsa\"" >> channel_graphics.inc
	echo "steps_door_e_lzsa: .incbin \"steps_door_e.lzsa\"" >> channel_graphics.inc
	echo "steps_door_w_lzsa: .incbin \"steps_door_w.lzsa\"" >> channel_graphics.inc
	echo "steps_door_open_w_lzsa: .incbin \"steps_door_open_w.lzsa\"" >> channel_graphics.inc
	echo "wind_path_n_lzsa: .incbin \"wind_path_n.lzsa\"" >> channel_graphics.inc
	echo "wind_path_s_lzsa: .incbin \"wind_path_s.lzsa\"" >> channel_graphics.inc
	echo "wind_path2_n_lzsa: .incbin \"wind_path2_n.lzsa\"" >> channel_graphics.inc
	echo "wind_path2_s_lzsa: .incbin \"wind_path2_s.lzsa\"" >> channel_graphics.inc
	echo "island1_n_lzsa: .incbin \"island1_n.lzsa\"" >> channel_graphics.inc
	echo "island1_s_lzsa: .incbin \"island1_s.lzsa\"" >> channel_graphics.inc
	echo "island2_n_lzsa: .incbin \"island2_n.lzsa\"" >> channel_graphics.inc
	echo "island2_s_lzsa: .incbin \"island2_s.lzsa\"" >> channel_graphics.inc
	echo "island3_n_lzsa: .incbin \"island3_n.lzsa\"" >> channel_graphics.inc
	echo "island3_s_lzsa: .incbin \"island3_s.lzsa\"" >> channel_graphics.inc
	echo "shack_n_lzsa: .incbin \"shack_n.lzsa\"" >> channel_graphics.inc
	echo "shack_s_lzsa: .incbin \"shack_s.lzsa\"" >> channel_graphics.inc
	echo "tank_n_lzsa: .incbin \"tank_n.lzsa\"" >> channel_graphics.inc
	echo "tank_s_lzsa: .incbin \"tank_s.lzsa\"" >> channel_graphics.inc
	echo "tank_close_lzsa: .incbin \"tank_close.lzsa\"" >> channel_graphics.inc
	echo "windmill_n_lzsa: .incbin \"windmill_n.lzsa\"" >> channel_graphics.inc
	echo "windmill_s_lzsa: .incbin \"windmill_s.lzsa\"" >> channel_graphics.inc
	echo "outback_n_lzsa: .incbin \"outback_n.lzsa\"" >> channel_graphics.inc
	echo "outback_s_lzsa: .incbin \"outback_s.lzsa\"" >> channel_graphics.inc
	echo "after_bridge1_e_lzsa: .incbin \"after_bridge1_e.lzsa\"" >> channel_graphics.inc
	echo "after_bridge1_w_lzsa: .incbin \"after_bridge1_w.lzsa\"" >> channel_graphics.inc
	echo "after_bridge2_e_lzsa: .incbin \"after_bridge2_e.lzsa\"" >> channel_graphics.inc
	echo "after_bridge2_w_lzsa: .incbin \"after_bridge2_w.lzsa\"" >> channel_graphics.inc
	echo "book_fork_n_lzsa: .incbin \"book_fork_n.lzsa\"" >> channel_graphics.inc
	echo "book_fork_s_lzsa: .incbin \"book_fork_s.lzsa\"" >> channel_graphics.inc
	echo "book_fork_w_lzsa: .incbin \"book_fork_w.lzsa\"" >> channel_graphics.inc
	echo "pipe_extend_n_lzsa: .incbin \"pipe_extend_n.lzsa\"" >> channel_graphics.inc
	echo "pipe_extend_up_s_lzsa: .incbin \"pipe_extend_up_s.lzsa\"" >> channel_graphics.inc
	echo "pipe_extend_down_s_lzsa: .incbin \"pipe_extend_down_s.lzsa\"" >> channel_graphics.inc
	echo "book_room_n_lzsa: .incbin \"book_room_n.lzsa\"" >> channel_graphics.inc
	echo "book_room_s_lzsa: .incbin \"book_room_s.lzsa\"" >> channel_graphics.inc
	echo "book_elevator_s_lzsa: .incbin \"book_elevator_s.lzsa\"" >> channel_graphics.inc
	echo "book_elevator_open_n_lzsa: .incbin \"book_elevator_open_n.lzsa\"" >> channel_graphics.inc
	echo "book_elevator_closed_n_lzsa: .incbin \"book_elevator_closed_n.lzsa\"" >> channel_graphics.inc
	echo "book_elevator_inside_gnd_open_lzsa: .incbin \"book_elevator_inside_gnd_open.lzsa\"" >> channel_graphics.inc
	echo "book_elevator_inside_gnd_closed_lzsa: .incbin \"book_elevator_inside_gnd_closed.lzsa\"" >> channel_graphics.inc
	echo "book_elevator_inside_top_open_lzsa: .incbin \"book_elevator_inside_top_open.lzsa\"" >> channel_graphics.inc
	echo "book_elevator_inside_top_closed_lzsa: .incbin \"book_elevator_inside_top_closed.lzsa\"" >> channel_graphics.inc
	echo "book_mist_closed_s_lzsa: .incbin \"book_mist_closed_s.lzsa\"" >> channel_graphics.inc
	echo "book_mist_open_s_lzsa: .incbin \"book_mist_open_s.lzsa\"" >> channel_graphics.inc
	echo "valve_top_on_lzsa: .incbin \"valve_top_on.lzsa\"" >> channel_graphics.inc
	echo "valve_top_off_lzsa: .incbin \"valve_top_off.lzsa\"" >> channel_graphics.inc
	echo "valve_bottom_on_lzsa: .incbin \"valve_bottom_on.lzsa\"" >> channel_graphics.inc
	echo "valve_bottom_off_lzsa: .incbin \"valve_bottom_off.lzsa\"" >> channel_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa channel_graphics.inc

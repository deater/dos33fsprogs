#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	stoney_graphics.inc

####

stoney_graphics.inc:	\
	ship_entry_n.lzsa ship_entry_s.lzsa \
	ship_bow_s.lzsa ship_bow_go_n.lzsa \
	ship_door_open_s.lzsa ship_door_closed_s.lzsa \
	book_chair_s.lzsa book_chair_n.lzsa \
	book_chair_open_s.lzsa book_chair_closed_s.lzsa \
	arrival_n.lzsa arrival_s.lzsa arrival_e.lzsa arrival_w.lzsa \
	umbrella_e.lzsa umbrella_w.lzsa \
	umbrella_path_e.lzsa umbrella_path_w.lzsa \
	lighthouse_path_e.lzsa lighthouse_path_w.lzsa \
	lighthouse_door_e.lzsa lighthouse_door_w.lzsa \
	lighthouse_inside_e.lzsa lighthouse_inside_w.lzsa lighthouse_inside_n.lzsa \
	lighthouse_upstairs_e.lzsa lighthouse_upstairs_w.lzsa \
	lighthouse_battery_w.lzsa \
	lighthouse_downladder_e.lzsa
	echo "ship_entry_n_lzsa: .incbin \"ship_entry_n.lzsa\"" > stoney_graphics.inc
	echo "ship_entry_s_lzsa: .incbin \"ship_entry_s.lzsa\"" >> stoney_graphics.inc
	echo "ship_bow_s_lzsa: .incbin \"ship_bow_s.lzsa\"" >> stoney_graphics.inc
	echo "ship_bow_go_n_lzsa: .incbin \"ship_bow_go_n.lzsa\"" >> stoney_graphics.inc
	echo "ship_door_open_s_lzsa: .incbin \"ship_door_open_s.lzsa\"" >> stoney_graphics.inc
	echo "ship_door_closed_s_lzsa: .incbin \"ship_door_closed_s.lzsa\"" >> stoney_graphics.inc
	echo "book_chair_s_lzsa: .incbin \"book_chair_s.lzsa\"" >> stoney_graphics.inc
	echo "book_chair_n_lzsa: .incbin \"book_chair_n.lzsa\"" >> stoney_graphics.inc
	echo "book_chair_open_s_lzsa: .incbin \"book_chair_open_s.lzsa\"" >> stoney_graphics.inc
	echo "book_chair_closed_s_lzsa: .incbin \"book_chair_closed_s.lzsa\"" >> stoney_graphics.inc
	echo "arrival_n_lzsa: .incbin \"arrival_n.lzsa\"" >> stoney_graphics.inc
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

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa stoney_graphics.inc

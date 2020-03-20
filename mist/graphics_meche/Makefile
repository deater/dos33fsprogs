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
	northturn_s.lzsa northturn_n.lzsa northturn_w.lzsa northturn_e.lzsa
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


%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr meche_graphics.inc

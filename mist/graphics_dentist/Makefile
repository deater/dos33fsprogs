PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	dentist_graphics.inc


####

dentist_graphics.inc:	\
	dentist_door_n.lzsa dentist_door_s.lzsa \
	dentist_door_open_n.lzsa \
	dentist_door_open_dark_n.lzsa \
	chair_view_s.lzsa chair_view_n.lzsa \
	chair_view_dark_s.lzsa chair_view_dark_n.lzsa \
	chair_close_s.lzsa chair_close_n.lzsa \
	chair_close_dark_s.lzsa chair_close_dark_n.lzsa \
	panel_up.lzsa panel_up_dark.lzsa \
	panel.lzsa
	echo "dentist_door_n_lzsa: .incbin \"dentist_door_n.lzsa\"" > dentist_graphics.inc
	echo "dentist_door_open_n_lzsa: .incbin \"dentist_door_open_n.lzsa\"" >> dentist_graphics.inc
	echo "dentist_door_open_dark_n_lzsa: .incbin \"dentist_door_open_dark_n.lzsa\"" >> dentist_graphics.inc
	echo "dentist_door_s_lzsa: .incbin \"dentist_door_s.lzsa\"" >> dentist_graphics.inc
	echo "chair_view_s_lzsa: .incbin \"chair_view_s.lzsa\"" >> dentist_graphics.inc
	echo "chair_view_n_lzsa: .incbin \"chair_view_n.lzsa\"" >> dentist_graphics.inc
	echo "chair_view_dark_s_lzsa: .incbin \"chair_view_dark_s.lzsa\"" >> dentist_graphics.inc
	echo "chair_view_dark_n_lzsa: .incbin \"chair_view_dark_n.lzsa\"" >> dentist_graphics.inc
	echo "chair_close_s_lzsa: .incbin \"chair_close_s.lzsa\"" >> dentist_graphics.inc
	echo "chair_close_n_lzsa: .incbin \"chair_close_n.lzsa\"" >> dentist_graphics.inc
	echo "chair_close_dark_s_lzsa: .incbin \"chair_close_dark_s.lzsa\"" >> dentist_graphics.inc
	echo "chair_close_dark_n_lzsa: .incbin \"chair_close_dark_n.lzsa\"" >> dentist_graphics.inc
	echo "panel_up_lzsa: .incbin \"panel_up.lzsa\"" >> dentist_graphics.inc
	echo "panel_up_dark_lzsa: .incbin \"panel_up_dark.lzsa\"" >> dentist_graphics.inc
	echo "panel_lzsa: .incbin \"panel.lzsa\"" >> dentist_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa dentist_graphics.inc

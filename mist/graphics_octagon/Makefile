#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	octagon_graphics.inc


####

octagon_graphics.inc:	\
	temple_door_n.lzsa temple_door_s.lzsa \
	temple_center_n.lzsa temple_center_s.lzsa temple_center_e.lzsa \
	temple_center_w.lzsa temple_center_up.lzsa \
	red_book_shelf.lzsa \
	red_book_open.lzsa red_book_closed.lzsa \
	red_book_static.lzsa red_book_static2.lzsa \
	fireplace_e.lzsa \
	in_fireplace_w.lzsa in_fireplace_door.lzsa \
	frame_door_open.lzsa \
	frame_bookcase_open.lzsa \
	blue_book_shelf.lzsa \
	bookshelf_n.lzsa \
	map.lzsa
	echo "temple_door_n_lzsa: .incbin \"temple_door_n.lzsa\"" > octagon_graphics.inc
	echo "temple_door_s_lzsa: .incbin \"temple_door_s.lzsa\"" >> octagon_graphics.inc
	echo "temple_center_n_lzsa: .incbin \"temple_center_n.lzsa\"" >> octagon_graphics.inc
	echo "temple_center_s_lzsa: .incbin \"temple_center_s.lzsa\"" >> octagon_graphics.inc
	echo "temple_center_e_lzsa: .incbin \"temple_center_e.lzsa\"" >> octagon_graphics.inc
	echo "temple_center_w_lzsa: .incbin \"temple_center_w.lzsa\"" >> octagon_graphics.inc
	echo "temple_center_up_lzsa: .incbin \"temple_center_up.lzsa\"" >> octagon_graphics.inc
	echo "red_book_open_lzsa: .incbin \"red_book_open.lzsa\"" >> octagon_graphics.inc
	echo "red_book_closed_lzsa: .incbin \"red_book_closed.lzsa\"" >> octagon_graphics.inc
	echo "red_book_shelf_lzsa: .incbin \"red_book_shelf.lzsa\"" >> octagon_graphics.inc
	echo "red_book_static_lzsa: .incbin \"red_book_static.lzsa\"" >> octagon_graphics.inc
	echo "red_book_static2_lzsa: .incbin \"red_book_static2.lzsa\"" >> octagon_graphics.inc
	echo "fireplace_e_lzsa: .incbin \"fireplace_e.lzsa\"" >> octagon_graphics.inc
	echo "in_fireplace_w_lzsa: .incbin \"in_fireplace_w.lzsa\"" >> octagon_graphics.inc
	echo "in_fireplace_door_lzsa: .incbin \"in_fireplace_door.lzsa\"" >> octagon_graphics.inc
	echo "frame_door_open_lzsa: .incbin \"frame_door_open.lzsa\"" >> octagon_graphics.inc
	echo "frame_bookcase_open_lzsa: .incbin \"frame_bookcase_open.lzsa\"" >> octagon_graphics.inc
	echo "blue_book_shelf_lzsa: .incbin \"blue_book_shelf.lzsa\"" >> octagon_graphics.inc
	echo "bookshelf_n_lzsa: .incbin \"bookshelf_n.lzsa\"" >> octagon_graphics.inc
	echo "map_lzsa: .incbin \"map.lzsa\"" >> octagon_graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr octagon_graphics.inc

#include ../Makefile.inc

PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	graphics.inc

####

graphics.inc:	\
	lookout.lzsa poster.lzsa dock.lzsa bar.lzsa town.lzsa map.lzsa \
	bar_inside1.lzsa bar_inside2.lzsa bar_inside3.lzsa \
	zipline.lzsa \
	church.lzsa mansion.lzsa mansion_path.lzsa \
	voodoo1.lzsa voodoo2.lzsa \
	part1.lzsa lechuck_ship.lzsa lechuck_cabin.lzsa
	echo "lookout_lzsa: .incbin \"lookout.lzsa\"" > graphics.inc
	echo "poster_lzsa: .incbin \"poster.lzsa\"" >> graphics.inc
	echo "dock_lzsa: .incbin \"dock.lzsa\"" >> graphics.inc
	echo "bar_lzsa: .incbin \"bar.lzsa\"" >> graphics.inc
	echo "town_lzsa: .incbin \"town.lzsa\"" >> graphics.inc
	echo "map_lzsa: .incbin \"map.lzsa\"" >> graphics.inc
	echo "bar_inside1_lzsa: .incbin \"bar_inside1.lzsa\"" >> graphics.inc
	echo "bar_inside2_lzsa: .incbin \"bar_inside2.lzsa\"" >> graphics.inc
	echo "bar_inside3_lzsa: .incbin \"bar_inside3.lzsa\"" >> graphics.inc
	echo "zipline_lzsa: .incbin \"zipline.lzsa\"" >> graphics.inc
	echo "church_lzsa: .incbin \"church.lzsa\"" >> graphics.inc
	echo "mansion_lzsa: .incbin \"mansion.lzsa\"" >> graphics.inc
	echo "mansion_path_lzsa: .incbin \"mansion_path.lzsa\"" >> graphics.inc
	echo "voodoo1_lzsa: .incbin \"voodoo1.lzsa\"" >> graphics.inc
	echo "voodoo2_lzsa: .incbin \"voodoo2.lzsa\"" >> graphics.inc
	echo "part1_lzsa: .incbin \"part1.lzsa\"" >> graphics.inc
	echo "lechuck_ship_lzsa: .incbin \"lechuck_ship.lzsa\"" >> graphics.inc
	echo "lechuck_cabin_lzsa: .incbin \"lechuck_cabin.lzsa\"" >> graphics.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa graphics.inc

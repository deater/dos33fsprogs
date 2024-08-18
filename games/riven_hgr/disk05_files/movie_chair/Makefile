include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	movie_chair.inc

movie_chair.inc:	\
	chair_base.gr.zx02 \
	empty.gr.zx02 \
	overlay04.gr.zx02 overlay05.gr.zx02 overlay06.gr.zx02 \
	overlay07.gr.zx02 overlay08.gr.zx02
	echo "chair_base: .incbin \"chair_base.gr.zx02\"" > movie_chair.inc
	echo "empty: .incbin \"empty.gr.zx02\"" >> movie_chair.inc
	echo "overlay04: .incbin \"overlay04.gr.zx02\"" >> movie_chair.inc
	echo "overlay05: .incbin \"overlay05.gr.zx02\"" >> movie_chair.inc
	echo "overlay06: .incbin \"overlay06.gr.zx02\"" >> movie_chair.inc
	echo "overlay07: .incbin \"overlay07.gr.zx02\"" >> movie_chair.inc
	echo "overlay08: .incbin \"overlay08.gr.zx02\"" >> movie_chair.inc




####

%.gr:	%.png
	$(PNG2GR) $< $@

%.gr.zx02: %.gr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.gr movie_maglev_ride.inc

distclean:
	rm -f *~ *.o *.lst  *.zx02 *.gr movie_maglev_ride.inc
	cd overlays && make clean


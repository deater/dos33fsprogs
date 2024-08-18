include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	movie_chair.inc

movie_chair.inc:	\
	chair_base.gr.zx02 \
	empty.gr.zx02 \
	overlay04.gr.zx02 overlay05.gr.zx02 overlay06.gr.zx02 \
	overlay07.gr.zx02 overlay08.gr.zx02 overlay09.gr.zx02 \
	overlay10.gr.zx02 overlay11.gr.zx02 overlay12.gr.zx02 \
	overlay13.gr.zx02 overlay14.gr.zx02 overlay15.gr.zx02 \
	overlay16.gr.zx02 overlay17.gr.zx02 overlay18.gr.zx02
	echo "chair_base: .incbin \"chair_base.gr.zx02\"" > movie_chair.inc
	echo "empty: .incbin \"empty.gr.zx02\"" >> movie_chair.inc
	echo "overlay04: .incbin \"overlay04.gr.zx02\"" >> movie_chair.inc
	echo "overlay05: .incbin \"overlay05.gr.zx02\"" >> movie_chair.inc
	echo "overlay06: .incbin \"overlay06.gr.zx02\"" >> movie_chair.inc
	echo "overlay07: .incbin \"overlay07.gr.zx02\"" >> movie_chair.inc
	echo "overlay08: .incbin \"overlay08.gr.zx02\"" >> movie_chair.inc
	echo "overlay09: .incbin \"overlay09.gr.zx02\"" >> movie_chair.inc
	echo "overlay10: .incbin \"overlay10.gr.zx02\"" >> movie_chair.inc
	echo "overlay11: .incbin \"overlay11.gr.zx02\"" >> movie_chair.inc
	echo "overlay12: .incbin \"overlay12.gr.zx02\"" >> movie_chair.inc
	echo "overlay13: .incbin \"overlay13.gr.zx02\"" >> movie_chair.inc
	echo "overlay14: .incbin \"overlay14.gr.zx02\"" >> movie_chair.inc
	echo "overlay15: .incbin \"overlay15.gr.zx02\"" >> movie_chair.inc
	echo "overlay16: .incbin \"overlay16.gr.zx02\"" >> movie_chair.inc
	echo "overlay17: .incbin \"overlay17.gr.zx02\"" >> movie_chair.inc
	echo "overlay18: .incbin \"overlay18.gr.zx02\"" >> movie_chair.inc

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


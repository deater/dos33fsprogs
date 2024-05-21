include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2GR = ../../../utils/gr-utils/png2gr

all:	movie1.inc

movie1.inc:	\
	img025_bg.gr.zx02 \
	img055_bg.gr.zx02 img056_bg.gr.zx02 img057_bg.gr.zx02 \
	img058_bg.gr.zx02 img059_bg.gr.zx02 img060_bg.gr.zx02 \
	img061_bg.gr.zx02 img062_bg.gr.zx02 img063_bg.gr.zx02 \
	img064_bg.gr.zx02
	echo "img025_bg_zx02: .incbin \"img025_bg.gr.zx02\"" > movie1.inc
	echo "img055_bg_zx02: .incbin \"img055_bg.gr.zx02\"" >> movie1.inc
	echo "img056_bg_zx02: .incbin \"img056_bg.gr.zx02\"" >> movie1.inc
	echo "img057_bg_zx02: .incbin \"img057_bg.gr.zx02\"" >> movie1.inc
	echo "img058_bg_zx02: .incbin \"img058_bg.gr.zx02\"" >> movie1.inc
	echo "img059_bg_zx02: .incbin \"img059_bg.gr.zx02\"" >> movie1.inc
	echo "img060_bg_zx02: .incbin \"img060_bg.gr.zx02\"" >> movie1.inc
	echo "img061_bg_zx02: .incbin \"img061_bg.gr.zx02\"" >> movie1.inc
	echo "img062_bg_zx02: .incbin \"img062_bg.gr.zx02\"" >> movie1.inc
	echo "img063_bg_zx02: .incbin \"img063_bg.gr.zx02\"" >> movie1.inc
	echo "img064_bg_zx02: .incbin \"img064_bg.gr.zx02\"" >> movie1.inc



####

%.gr:	%.png
	$(PNG2GR) $< $@

%.gr.zx02: %.gr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.gr


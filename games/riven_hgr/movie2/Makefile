include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2GR = ../../../utils/gr-utils/png2gr

all:	movie2.inc

movie2.inc:	\
	img096_bg.gr.zx02 \
	img114_bg.gr.zx02 img115_bg.gr.zx02 img116_bg.gr.zx02 \
	img117_bg.gr.zx02
	echo "img096_bg_zx02: .incbin \"img096_bg.gr.zx02\"" > movie2.inc
	echo "img114_bg_zx02: .incbin \"img114_bg.gr.zx02\"" >> movie2.inc
	echo "img115_bg_zx02: .incbin \"img115_bg.gr.zx02\"" >> movie2.inc
	echo "img116_bg_zx02: .incbin \"img116_bg.gr.zx02\"" >> movie2.inc
	echo "img117_bg_zx02: .incbin \"img117_bg.gr.zx02\"" >> movie2.inc

####

%.gr:	%.png
	$(PNG2GR) $< $@

%.gr.zx02: %.gr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.gr movie2.inc


include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2GR = ../../../utils/gr-utils/png2gr

all:	movie1.inc

movie1.inc:	\
	img025_bg.gr.zx02
	echo "img025_bg_zx02: .incbin \"img025_bg.gr.zx02\"" > movie1.inc


####

%.gr:	%.png
	$(PNG2GR) $< $@

%.gr.zx02: %.gr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.gr


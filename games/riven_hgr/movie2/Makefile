include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2GR = ../../../utils/gr-utils/png2gr

all:	movie2.inc

movie2.inc:	\
	img096_bg.gr.zx02 \
	img114_bg.gr.zx02 img115_bg.gr.zx02 img116_bg.gr.zx02 \
	img117_bg.gr.zx02 img118_bg.gr.zx02 img119_bg.gr.zx02 \
	img120_bg.gr.zx02 img121_bg.gr.zx02 img122_bg.gr.zx02 \
	img123_bg.gr.zx02 img124_bg.gr.zx02 img125_bg.gr.zx02 \
	img126_bg.gr.zx02 img127_bg.gr.zx02 img128_bg.gr.zx02 \
	img129_bg.gr.zx02 img130_bg.gr.zx02 img131_bg.gr.zx02 \
	img132_bg.gr.zx02 img133_bg.gr.zx02 img134_bg.gr.zx02 \
	img135_bg.gr.zx02 img136_bg.gr.zx02 img137_bg.gr.zx02 \
	img138_bg.gr.zx02 img139_bg.gr.zx02
	echo "img096_bg_zx02: .incbin \"img096_bg.gr.zx02\"" > movie2.inc
	echo "img114_bg_zx02: .incbin \"img114_bg.gr.zx02\"" >> movie2.inc
	echo "img115_bg_zx02: .incbin \"img115_bg.gr.zx02\"" >> movie2.inc
	echo "img116_bg_zx02: .incbin \"img116_bg.gr.zx02\"" >> movie2.inc
	echo "img117_bg_zx02: .incbin \"img117_bg.gr.zx02\"" >> movie2.inc
	echo "img118_bg_zx02: .incbin \"img118_bg.gr.zx02\"" >> movie2.inc
	echo "img119_bg_zx02: .incbin \"img119_bg.gr.zx02\"" >> movie2.inc
	echo "img120_bg_zx02: .incbin \"img120_bg.gr.zx02\"" >> movie2.inc
	echo "img121_bg_zx02: .incbin \"img121_bg.gr.zx02\"" >> movie2.inc
	echo "img122_bg_zx02: .incbin \"img122_bg.gr.zx02\"" >> movie2.inc
	echo "img123_bg_zx02: .incbin \"img123_bg.gr.zx02\"" >> movie2.inc
	echo "img124_bg_zx02: .incbin \"img124_bg.gr.zx02\"" >> movie2.inc
	echo "img125_bg_zx02: .incbin \"img125_bg.gr.zx02\"" >> movie2.inc
	echo "img126_bg_zx02: .incbin \"img126_bg.gr.zx02\"" >> movie2.inc
	echo "img127_bg_zx02: .incbin \"img127_bg.gr.zx02\"" >> movie2.inc
	echo "img128_bg_zx02: .incbin \"img128_bg.gr.zx02\"" >> movie2.inc
	echo "img129_bg_zx02: .incbin \"img129_bg.gr.zx02\"" >> movie2.inc
	echo "img130_bg_zx02: .incbin \"img130_bg.gr.zx02\"" >> movie2.inc
	echo "img131_bg_zx02: .incbin \"img131_bg.gr.zx02\"" >> movie2.inc
	echo "img132_bg_zx02: .incbin \"img132_bg.gr.zx02\"" >> movie2.inc
	echo "img133_bg_zx02: .incbin \"img133_bg.gr.zx02\"" >> movie2.inc
	echo "img134_bg_zx02: .incbin \"img134_bg.gr.zx02\"" >> movie2.inc
	echo "img135_bg_zx02: .incbin \"img135_bg.gr.zx02\"" >> movie2.inc
	echo "img136_bg_zx02: .incbin \"img136_bg.gr.zx02\"" >> movie2.inc
	echo "img137_bg_zx02: .incbin \"img137_bg.gr.zx02\"" >> movie2.inc
	echo "img138_bg_zx02: .incbin \"img138_bg.gr.zx02\"" >> movie2.inc
	echo "img139_bg_zx02: .incbin \"img139_bg.gr.zx02\"" >> movie2.inc



####

%.gr:	%.png
	$(PNG2GR) $< $@

%.gr.zx02: %.gr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.gr movie2.inc


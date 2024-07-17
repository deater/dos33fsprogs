include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	movie_maglev_flip.inc

movie_maglev_flip.inc:	\
	img025_bg.gr.zx02
#	img055_bg.gr.zx02 img056_bg.gr.zx02 img057_bg.gr.zx02 \
#	img058_bg.gr.zx02 img059_bg.gr.zx02 img060_bg.gr.zx02 \
#	img061_bg.gr.zx02 img062_bg.gr.zx02 img063_bg.gr.zx02 \
#	img064_bg.gr.zx02 img065_bg.gr.zx02 img066_bg.gr.zx02 \
#	img067_bg.gr.zx02 img068_bg.gr.zx02 img069_bg.gr.zx02 \
#	img070_bg.gr.zx02 img071_bg.gr.zx02 img072_bg.gr.zx02 \
#	img073_bg.gr.zx02 img074_bg.gr.zx02 img075_bg.gr.zx02 \
#	img076_bg.gr.zx02 img077_bg.gr.zx02 img078_bg.gr.zx02 \
#	img079_bg.gr.zx02 img080_bg.gr.zx02 img081_bg.gr.zx02 \
#	img082_bg.gr.zx02 img083_bg.gr.zx02 img084_bg.gr.zx02
	echo "img025_bg_zx02: .incbin \"img025_bg.gr.zx02\"" > movie_maglev_flip.inc
#	echo "img055_bg_zx02: .incbin \"img055_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img056_bg_zx02: .incbin \"img056_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img057_bg_zx02: .incbin \"img057_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img058_bg_zx02: .incbin \"img058_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img059_bg_zx02: .incbin \"img059_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img060_bg_zx02: .incbin \"img060_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img061_bg_zx02: .incbin \"img061_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img062_bg_zx02: .incbin \"img062_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img063_bg_zx02: .incbin \"img063_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img064_bg_zx02: .incbin \"img064_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img065_bg_zx02: .incbin \"img065_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img066_bg_zx02: .incbin \"img066_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img067_bg_zx02: .incbin \"img067_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img068_bg_zx02: .incbin \"img068_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img069_bg_zx02: .incbin \"img069_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img070_bg_zx02: .incbin \"img070_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img071_bg_zx02: .incbin \"img071_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img072_bg_zx02: .incbin \"img072_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img073_bg_zx02: .incbin \"img073_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img074_bg_zx02: .incbin \"img074_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img075_bg_zx02: .incbin \"img075_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img076_bg_zx02: .incbin \"img076_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img077_bg_zx02: .incbin \"img077_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img078_bg_zx02: .incbin \"img078_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img079_bg_zx02: .incbin \"img079_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img080_bg_zx02: .incbin \"img080_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img081_bg_zx02: .incbin \"img081_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img082_bg_zx02: .incbin \"img082_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img083_bg_zx02: .incbin \"img083_bg.gr.zx02\"" >> movie_maglev_flip.inc
#	echo "img084_bg_zx02: .incbin \"img084_bg.gr.zx02\"" >> movie_maglev_flip.inc

####

%.gr:	%.png
	$(PNG2GR) $< $@

%.gr.zx02: %.gr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.gr movie_maglev_flip.inc

distclean:
	rm -f *~ *.o *.lst  *.zx02 *.gr movie_maglev_flip.inc
	cd overlays && make clean

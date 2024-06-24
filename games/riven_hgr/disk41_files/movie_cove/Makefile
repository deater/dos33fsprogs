include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	combined_cove.zx02

combined_cove.zx02:	combined_cove
	$(ZX02) -f combined_cove combined_cove.zx02

combined_cove: \
	cove_bg_040.gr \
	cove_bg_045.gr \
	cove_bg_050.gr \
	cove_bg_055.gr \
	cove_bg_060.gr \
	cove_bg_065.gr \
	cove_bg_070.gr \
	cove_bg_075.gr \
	cove_bg_080.gr \
	cove_bg_085.gr \
	cove_bg_090.gr \
	cove_bg_095.gr \
	cove_bg_100.gr \
	cove_bg_105.gr \
	cove_bg_110.gr \
	cove_bg_115.gr \
	cove_bg_120.gr \
	cove_bg_125.gr \
	cove_bg_130.gr \
	cove_bg_135.gr \
	cove_bg_140.gr \
	cove_bg_145.gr \
	cove_bg_150.gr \
	cove_bg_155.gr \
	cove_bg_160.gr \
	cove_bg_165.gr \
	cove_bg_170.gr \
	cove_bg_175.gr \
	cove_bg_180.gr
	cat cove_bg_040.gr > combined_cove
	cat cove_bg_045.gr >> combined_cove
	cat cove_bg_050.gr >> combined_cove
	cat cove_bg_055.gr >> combined_cove
	cat cove_bg_060.gr >> combined_cove
	cat cove_bg_065.gr >> combined_cove
	cat cove_bg_070.gr >> combined_cove
	cat cove_bg_075.gr >> combined_cove
	cat cove_bg_080.gr >> combined_cove
	cat cove_bg_085.gr >> combined_cove
	cat cove_bg_090.gr >> combined_cove
	cat cove_bg_095.gr >> combined_cove
	cat cove_bg_100.gr >> combined_cove
	cat cove_bg_105.gr >> combined_cove
	cat cove_bg_110.gr >> combined_cove
	cat cove_bg_115.gr >> combined_cove
	cat cove_bg_120.gr >> combined_cove
	cat cove_bg_125.gr >> combined_cove
	cat cove_bg_130.gr >> combined_cove
	cat cove_bg_135.gr >> combined_cove
	cat cove_bg_140.gr >> combined_cove
	cat cove_bg_145.gr >> combined_cove
	cat cove_bg_150.gr >> combined_cove
	cat cove_bg_155.gr >> combined_cove
	cat cove_bg_160.gr >> combined_cove
	cat cove_bg_165.gr >> combined_cove
	cat cove_bg_170.gr >> combined_cove
	cat cove_bg_175.gr >> combined_cove
	cat cove_bg_180.gr >> combined_cove

#movie_cove.inc:	\
#	cove_bg.gr.zx02
#	echo "cove_bg_zx02: .incbin \"cove_bg.gr.zx02\"" > movie_cove.inc

####

%.gr:	%.png
	$(PNG2GR) $< $@

%.gr.zx02: %.gr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.gr movie_cove.inc

distclean:
	rm -f *~ *.o *.lst  *.zx02 *.gr movie_cove.inc
	cd overlays && make clean

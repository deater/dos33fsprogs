include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	img001.zx02 img002.zx02 img004.zx02 img008.zx02


img001.zx02:	00001.gr
	$(ZX02) -f 00001.gr img001.zx02

####

img002.zx02:	img002.big
	$(ZX02) -f img002.big img002.zx02

img002.big:	00001.gr 00002.gr
	cat 00001.gr > img002.big
	cat 00002.gr >> img002.big

###

img004.zx02:	img004.big
	$(ZX02) -f img004.big img004.zx02

img004.big:	00001.gr 00002.gr 00003.gr 00004.gr
	cat 00001.gr > img004.big
	cat 00002.gr >> img004.big
	cat 00003.gr >> img004.big
	cat 00004.gr >> img004.big

###

img008.zx02:	img008.big
	$(ZX02) -f img008.big img008.zx02

img008.big:	00001.gr 00002.gr 00003.gr 00004.gr \
		00005.gr 00006.gr 00007.gr 00008.gr
	cat 00001.gr > img008.big
	cat 00002.gr >> img008.big
	cat 00003.gr >> img008.big
	cat 00004.gr >> img008.big
	cat 00005.gr >> img008.big
	cat 00006.gr >> img008.big
	cat 00007.gr >> img008.big
	cat 00008.gr >> img008.big




#	img096_bg.gr.zx02 \
#	img114_bg.gr.zx02
#	echo "img096_bg_zx02: .incbin \"img096_bg.gr.zx02\"" > movie_maglev_ride.inc
#	echo "img114_bg_zx02: .incbin \"img114_bg.gr.zx02\"" >> movie_maglev_ride.inc


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


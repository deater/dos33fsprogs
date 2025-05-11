include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2GR = ../../../../utils/gr-utils/png2gr

#all:	img001.zx02 img002.zx02 img004.zx02 img008.zx02

all:	road000.zx02 road001.zx02 road002.zx02 road003.zx02


###

road000.zx02:	road000.big
	$(ZX02) -f road000.big road000.zx02

road000.big:	00001.gr 00002.gr 00003.gr 00004.gr \
		00005.gr 00006.gr 00007.gr 00008.gr
	cat 00001.gr > road000.big
	cat 00002.gr >> road000.big
	cat 00003.gr >> road000.big
	cat 00004.gr >> road000.big
	cat 00005.gr >> road000.big
	cat 00006.gr >> road000.big
	cat 00007.gr >> road000.big
	cat 00008.gr >> road000.big

###

road001.zx02:	road001.big
	$(ZX02) -f road001.big road001.zx02

road001.big:	00009.gr 00010.gr 00011.gr 00012.gr \
		00013.gr 00014.gr 00015.gr 00016.gr
	cat 00009.gr > road001.big
	cat 00010.gr >> road001.big
	cat 00011.gr >> road001.big
	cat 00012.gr >> road001.big
	cat 00013.gr >> road001.big
	cat 00014.gr >> road001.big
	cat 00015.gr >> road001.big
	cat 00016.gr >> road001.big

###

road002.zx02:	road002.big
	$(ZX02) -f road002.big road002.zx02

road002.big:	00017.gr 00018.gr 00019.gr 00020.gr \
		00021.gr 00022.gr 00023.gr 00024.gr
	cat 00017.gr > road002.big
	cat 00018.gr >> road002.big
	cat 00019.gr >> road002.big
	cat 00020.gr >> road002.big
	cat 00021.gr >> road002.big
	cat 00022.gr >> road002.big
	cat 00023.gr >> road002.big
	cat 00024.gr >> road002.big

###

road003.zx02:	road003.big
	$(ZX02) -f road003.big road003.zx02

road003.big:	00025.gr 00026.gr 00027.gr 00028.gr \
		00029.gr 00030.gr 00031.gr 00032.gr
	cat 00025.gr > road003.big
	cat 00026.gr >> road003.big
	cat 00027.gr >> road003.big
	cat 00028.gr >> road003.big
	cat 00029.gr >> road003.big
	cat 00030.gr >> road003.big
	cat 00031.gr >> road003.big
	cat 00032.gr >> road003.big








######



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


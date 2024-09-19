
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
#LZSA = ~/research/lzsa/lzsa/lzsa
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
B2D = ../../../utils/bmp2dhr/b2d

all:	vid_graphics.inc

vid_graphics.inc:	\
	videlectrix.zx02 \
	title_anim01.zx02 title_anim02.zx02 title_anim03.zx02 \
	title_anim04.zx02 title_anim05.zx02 title_anim06.zx02 \
	title_anim07.zx02 title_anim08.zx02 title_anim09.zx02 \
	title_anim10.zx02 title_anim11.zx02 title_anim12.zx02 \
	title_anim13.zx02 title_anim14.zx02 title_anim15.zx02 \
	title_anim16.zx02 title_anim17.zx02 title_anim18.zx02 \
	title_anim19.zx02 title_anim20.zx02 title_anim21.zx02 \
	title_anim22.zx02 title_anim23.zx02 title_anim24.zx02 \
	title_anim25.zx02 title_anim26.zx02 title_anim27.zx02 \
	title_anim28.zx02 title_anim29.zx02 title_anim30.zx02 \
	title_anim31.zx02 title_anim32.zx02 title_anim33.zx02 \
	title_anim34.zx02
	echo "videlectrix_zx02: .incbin \"videlectrix.zx02\"" > vid_graphics.inc
#	echo "title_anim01_zx02: .incbin \"title_anim01.zx02\"" >> vid_graphics.inc
	echo "title_anim02_zx02: .incbin \"title_anim02.zx02\"" >> vid_graphics.inc
	echo "title_anim03_zx02: .incbin \"title_anim03.zx02\"" >> vid_graphics.inc
#	echo "title_anim04_zx02: .incbin \"title_anim04.zx02\"" >> vid_graphics.inc
	echo "title_anim05_zx02: .incbin \"title_anim05.zx02\"" >> vid_graphics.inc
#	echo "title_anim06_zx02: .incbin \"title_anim06.zx02\"" >> vid_graphics.inc
	echo "title_anim07_zx02: .incbin \"title_anim07.zx02\"" >> vid_graphics.inc
#	echo "title_anim08_zx02: .incbin \"title_anim08.zx02\"" >> vid_graphics.inc
	echo "title_anim09_zx02: .incbin \"title_anim09.zx02\"" >> vid_graphics.inc
#	echo "title_anim10_zx02: .incbin \"title_anim10.zx02\"" >> vid_graphics.inc
	echo "title_anim11_zx02: .incbin \"title_anim11.zx02\"" >> vid_graphics.inc
#	echo "title_anim12_zx02: .incbin \"title_anim12.zx02\"" >> vid_graphics.inc
	echo "title_anim13_zx02: .incbin \"title_anim13.zx02\"" >> vid_graphics.inc
#	echo "title_anim14_zx02: .incbin \"title_anim14.zx02\"" >> vid_graphics.inc
	echo "title_anim15_zx02: .incbin \"title_anim15.zx02\"" >> vid_graphics.inc
#	echo "title_anim16_zx02: .incbin \"title_anim16.zx02\"" >> vid_graphics.inc
	echo "title_anim17_zx02: .incbin \"title_anim17.zx02\"" >> vid_graphics.inc
#	echo "title_anim18_zx02: .incbin \"title_anim18.zx02\"" >> vid_graphics.inc
	echo "title_anim19_zx02: .incbin \"title_anim19.zx02\"" >> vid_graphics.inc
#	echo "title_anim20_zx02: .incbin \"title_anim20.zx02\"" >> vid_graphics.inc
	echo "title_anim21_zx02: .incbin \"title_anim21.zx02\"" >> vid_graphics.inc
#	echo "title_anim22_zx02: .incbin \"title_anim22.zx02\"" >> vid_graphics.inc
	echo "title_anim23_zx02: .incbin \"title_anim23.zx02\"" >> vid_graphics.inc
#	echo "title_anim24_zx02: .incbin \"title_anim24.zx02\"" >> vid_graphics.inc
	echo "title_anim25_zx02: .incbin \"title_anim25.zx02\"" >> vid_graphics.inc
#	echo "title_anim26_zx02: .incbin \"title_anim26.zx02\"" >> vid_graphics.inc
	echo "title_anim27_zx02: .incbin \"title_anim27.zx02\"" >> vid_graphics.inc
#	echo "title_anim28_zx02: .incbin \"title_anim28.zx02\"" >> vid_graphics.inc
	echo "title_anim29_zx02: .incbin \"title_anim29.zx02\"" >> vid_graphics.inc
	echo "title_anim30_zx02: .incbin \"title_anim30.zx02\"" >> vid_graphics.inc
	echo "title_anim31_zx02: .incbin \"title_anim31.zx02\"" >> vid_graphics.inc
	echo "title_anim32_zx02: .incbin \"title_anim32.zx02\"" >> vid_graphics.inc
	echo "title_anim33_zx02: .incbin \"title_anim33.zx02\"" >> vid_graphics.inc
	echo "title_anim34_zx02: .incbin \"title_anim34.zx02\"" >> vid_graphics.inc

%.hgr:	%.png
	$(PNG2HGR) $< > $@

%.zx02:	%.hgr
	$(ZX02) $< $@

#%.lzsa:	%.hgr
#	$(LZSA) -r -f2 $< $@

###

clean:	
	rm -f *~ vid_graphics.inc *.zx02 *.gr *.hgr


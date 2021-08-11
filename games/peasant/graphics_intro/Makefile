
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d

all:	intro_graphics.inc

intro_graphics.inc:	\
	videlectrix.lzsa \
	title_anim01.lzsa title_anim02.lzsa title_anim03.lzsa \
	title_anim04.lzsa title_anim05.lzsa title_anim06.lzsa \
	title_anim07.lzsa title_anim08.lzsa title_anim09.lzsa \
	title_anim10.lzsa title_anim11.lzsa title_anim12.lzsa \
	title_anim13.lzsa title_anim14.lzsa title_anim15.lzsa \
	title_anim16.lzsa title_anim17.lzsa title_anim18.lzsa \
	title_anim19.lzsa title_anim20.lzsa title_anim21.lzsa \
	title_anim22.lzsa title_anim23.lzsa title_anim24.lzsa \
	title_anim25.lzsa title_anim26.lzsa title_anim27.lzsa \
	title_anim28.lzsa title_anim29.lzsa title_anim30.lzsa \
	title_anim31.lzsa title_anim32.lzsa title_anim33.lzsa \
	title_anim34.lzsa
	echo "videlectrix_lzsa: .incbin \"videlectrix.lzsa\"" > intro_graphics.inc
	echo "title_anim01_lzsa: .incbin \"title_anim01.lzsa\"" >> intro_graphics.inc
	echo "title_anim02_lzsa: .incbin \"title_anim02.lzsa\"" >> intro_graphics.inc
	echo "title_anim03_lzsa: .incbin \"title_anim03.lzsa\"" >> intro_graphics.inc
	echo "title_anim04_lzsa: .incbin \"title_anim04.lzsa\"" >> intro_graphics.inc
	echo "title_anim05_lzsa: .incbin \"title_anim05.lzsa\"" >> intro_graphics.inc
	echo "title_anim06_lzsa: .incbin \"title_anim06.lzsa\"" >> intro_graphics.inc
	echo "title_anim07_lzsa: .incbin \"title_anim07.lzsa\"" >> intro_graphics.inc
	echo "title_anim08_lzsa: .incbin \"title_anim08.lzsa\"" >> intro_graphics.inc
	echo "title_anim09_lzsa: .incbin \"title_anim09.lzsa\"" >> intro_graphics.inc
	echo "title_anim10_lzsa: .incbin \"title_anim10.lzsa\"" >> intro_graphics.inc
	echo "title_anim11_lzsa: .incbin \"title_anim11.lzsa\"" >> intro_graphics.inc
	echo "title_anim12_lzsa: .incbin \"title_anim12.lzsa\"" >> intro_graphics.inc
	echo "title_anim13_lzsa: .incbin \"title_anim13.lzsa\"" >> intro_graphics.inc
	echo "title_anim14_lzsa: .incbin \"title_anim14.lzsa\"" >> intro_graphics.inc
	echo "title_anim15_lzsa: .incbin \"title_anim15.lzsa\"" >> intro_graphics.inc
	echo "title_anim16_lzsa: .incbin \"title_anim16.lzsa\"" >> intro_graphics.inc
	echo "title_anim17_lzsa: .incbin \"title_anim17.lzsa\"" >> intro_graphics.inc
	echo "title_anim18_lzsa: .incbin \"title_anim18.lzsa\"" >> intro_graphics.inc
	echo "title_anim19_lzsa: .incbin \"title_anim19.lzsa\"" >> intro_graphics.inc
	echo "title_anim20_lzsa: .incbin \"title_anim20.lzsa\"" >> intro_graphics.inc
	echo "title_anim21_lzsa: .incbin \"title_anim21.lzsa\"" >> intro_graphics.inc
	echo "title_anim22_lzsa: .incbin \"title_anim22.lzsa\"" >> intro_graphics.inc
	echo "title_anim23_lzsa: .incbin \"title_anim23.lzsa\"" >> intro_graphics.inc
	echo "title_anim24_lzsa: .incbin \"title_anim24.lzsa\"" >> intro_graphics.inc
	echo "title_anim25_lzsa: .incbin \"title_anim25.lzsa\"" >> intro_graphics.inc
	echo "title_anim26_lzsa: .incbin \"title_anim26.lzsa\"" >> intro_graphics.inc
	echo "title_anim27_lzsa: .incbin \"title_anim27.lzsa\"" >> intro_graphics.inc
	echo "title_anim28_lzsa: .incbin \"title_anim28.lzsa\"" >> intro_graphics.inc
	echo "title_anim29_lzsa: .incbin \"title_anim29.lzsa\"" >> intro_graphics.inc
	echo "title_anim30_lzsa: .incbin \"title_anim30.lzsa\"" >> intro_graphics.inc
	echo "title_anim31_lzsa: .incbin \"title_anim31.lzsa\"" >> intro_graphics.inc
	echo "title_anim32_lzsa: .incbin \"title_anim32.lzsa\"" >> intro_graphics.inc
	echo "title_anim33_lzsa: .incbin \"title_anim33.lzsa\"" >> intro_graphics.inc
	echo "title_anim34_lzsa: .incbin \"title_anim34.lzsa\"" >> intro_graphics.inc

%.hgr:	%.png
	$(PNG2HGR) $< > $@

%.lzsa:	%.hgr
	$(LZSA) -r -f2 $< $@

###

clean:	
	rm -f *~ outline.inc *.lzsa *.gr *.hgr


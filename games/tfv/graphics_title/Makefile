include ../../../Makefile.inc

PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d

all:	tfv_title.inc


tfv_title.inc:	\
	title.lzsa tfv_story.lzsa
	echo "title_lzsa: .incbin \"title.lzsa\"" > tfv_title.inc
	echo "tfv_story_lzsa: .incbin \"tfv_story.lzsa\"" >> tfv_title.inc


###

tfv_story.lzsa:	tfv_story.hgr
	$(LZSA) -r -f2 tfv_story.hgr tfv_story.lzsa

tfv_story.hgr:	tfv_story.png
	$(PNG2HGR) tfv_story.png > tfv_story.hgr

###

title.lzsa:	title.gr
	$(LZSA) -r -f2 title.gr title.lzsa

title.gr:	title.png
	$(PNG2GR) title.png title.gr

###


clean:	
	rm -f *~ tfv_title.inc *.lzsa *.gr *.hgr


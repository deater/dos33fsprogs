include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	\
	sb_title1.hgr.zx02 \
	title1.hgr.zx02


####

sb_title1.hgr.zx02:	sb_title1.hgr
	$(ZX02) sb_title1.hgr sb_title1.hgr.zx02

sb_title1.hgr:	sb_title1.png
	$(PNG_TO_HGR) sb_title1.png > sb_title1.hgr

####

title1.hgr.zx02:	title1.hgr
	$(ZX02) title1.hgr title1.hgr.zx02

title1.hgr:	title1.png
	$(PNG_TO_HGR) title1.png > title1.hgr


####


clean:
	rm -f *~ *.zx02

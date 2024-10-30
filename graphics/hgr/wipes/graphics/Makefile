include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	a2_dating.hgr.zx02

####

a2_dating.hgr.zx02:	a2_dating.hgr
	$(ZX02) a2_dating.hgr a2_dating.hgr.zx02

a2_dating.hgr:	a2_dating.png
	$(PNG_TO_HGR) a2_dating.png > a2_dating.hgr

####

clean:
	rm -f *~ *.zx02

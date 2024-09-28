include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	a2_dating.hgr.zx02 dating_title.hgr.zx02

####

a2_dating.hgr.zx02:	a2_dating.hgr
	$(ZX02) a2_dating.hgr a2_dating.hgr.zx02

a2_dating.hgr:	a2_dating.png
	$(PNG_TO_HGR) a2_dating.png > a2_dating.hgr

####

dating_title.hgr.zx02:	dating_title.hgr
	$(ZX02) dating_title.hgr dating_title.hgr.zx02

dating_title.hgr:	dating_title.png
	$(PNG_TO_HGR) dating_title.png > dating_title.hgr


####

clean:
	rm -f *~ *.o *.lst *.zx02 *.hgr


include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	floater_wide_steffest.hgr.zx02

####

floater_wide_steffest.hgr.zx02:	floater_wide_steffest.hgr
	$(ZX02) floater_wide_steffest.hgr floater_wide_steffest.hgr.zx02

floater_wide_steffest.hgr:	floater_wide_steffest.png
	$(PNG_TO_HGR) floater_wide_steffest.png > floater_wide_steffest.hgr

####

clean:
	rm -f *~ *.zx02

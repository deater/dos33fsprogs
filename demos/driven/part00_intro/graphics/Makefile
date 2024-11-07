include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	desire.hgr.zx02 logo_frame01.hgr.zx02 logo_frame46.hgr.zx02

####

logo_frame01.hgr:	logo_frame01.png
	$(PNG_TO_HGR) logo_frame01.png > logo_frame01.hgr

logo_frame01.hgr.zx02:	logo_frame01.hgr
	$(ZX02) -f logo_frame01.hgr logo_frame01.hgr.zx02


####

logo_frame46.hgr:	logo_frame46.png
	$(PNG_TO_HGR) logo_frame46.png > logo_frame46.hgr

logo_frame46.hgr.zx02:	logo_frame46.hgr
	$(ZX02) -f logo_frame46.hgr logo_frame46.hgr.zx02

####

desire.hgr:	desire-cyan-steffest.png
	$(PNG_TO_HGR) desire-cyan-steffest.png > desire.hgr

desire.hgr.zx02:	desire.hgr
	$(ZX02) -f desire.hgr desire.hgr.zx02

####

clean:
	rm -f *~ *.zx02 *.hgr

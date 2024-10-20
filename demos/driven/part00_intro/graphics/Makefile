include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	desire.hgr.zx02


####

desire.hgr:	desire-cyan-steffest.png
	$(PNG_TO_HGR) desire-cyan-steffest.png > desire.hgr

desire.hgr.zx02:	desire.hgr
	$(ZX02) desire.hgr desire.hgr.zx02

####

clean:
	rm -f *~ *.zx02 *.hgr

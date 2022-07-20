include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR =	../../../utils/hgr-utils/png2hgr

all:	bbl.hgr.zx02 bbl2.hgr.zx02 \
	grl.hgr.zx02 1bg.hgr.zx02 fup.hgr.zx02 witch.hgr.zx02

####

bbl.hgr.zx02:	bbl.hgr
	$(ZX02) bbl.hgr bbl.hgr.zx02

bbl.hgr:	bbl.png
	$(PNG_TO_HGR) bbl.png > bbl.hgr

####

bbl2.hgr.zx02:	bbl2.hgr
	$(ZX02) bbl2.hgr bbl2.hgr.zx02

bbl2.hgr:	bbl2.png
	$(PNG_TO_HGR) bbl2.png > bbl2.hgr

####

1bg.hgr.zx02:	1bg.hgr
	$(ZX02) 1bg.hgr 1bg.hgr.zx02

1bg.hgr:	1bg.png
	$(PNG_TO_HGR) 1bg.png > 1bg.hgr


####

fup.hgr.zx02:	fup.hgr
	$(ZX02) fup.hgr fup.hgr.zx02

fup.hgr:	fup.png
	$(PNG_TO_HGR) fup.png > fup.hgr

####

witch.hgr.zx02:	witch.hgr
	$(ZX02) witch.hgr witch.hgr.zx02

witch.hgr:	witch.png
	$(PNG_TO_HGR) witch.png > witch.hgr

###

grl.hgr.zx02:	grl.hgr
	$(ZX02) grl.hgr grl.hgr.zx02

###


clean:
		rm -f *~ *.o *.lst


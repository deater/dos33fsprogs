include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR =	../../../utils/hgr-utils/png2hgr

all:	grl.hgr.zx02 witch.hgr.zx02 mona.hgr.zx02 gw.hgr.zx02 skull.hgr.zx02 \
	uw.hgr.zx02


####

witch.hgr.zx02:	witch.hgr
	$(ZX02) -f witch.hgr witch.hgr.zx02

###

grl.hgr.zx02:	grl.hgr
	$(ZX02) -f grl.hgr grl.hgr.zx02

###

mona.hgr:	mona.png
	$(PNG_TO_HGR) mona.png > mona.hgr

mona.hgr.zx02:	mona.hgr
	$(ZX02) -f mona.hgr mona.hgr.zx02

###

#gw.hgr:	gw.png
#	$(PNG_TO_HGR) gw.png > gw.hgr

gw.hgr.zx02:	gw.hgr
	$(ZX02) -f gw.hgr gw.hgr.zx02

###

skull.hgr:	skull.png
	$(PNG_TO_HGR) skull.png > skull.hgr

skull.hgr.zx02:	skull.hgr
	$(ZX02) -f skull.hgr skull.hgr.zx02

###

uw.hgr:	uw.png
	$(PNG_TO_HGR) uw.png > uw.hgr

uw.hgr.zx02:	uw.hgr
	$(ZX02) -f uw.hgr uw.hgr.zx02




###

clean:
		rm -f *~ *.o *.lst


include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite

all:	gp_hgr.zx02 merry_christmas.zx02 MERRY_XMAS

####

MERRY_XMAS:	merry_christmas.hgr
	cp merry_christmas.hgr MERRY_XMAS

merry_christmas.zx02:	merry_christmas.hgr
	$(ZX02) merry_christmas.hgr merry_christmas.zx02

merry_christmas.hgr:	merry_christmas.png
	$(PNG_TO_HGR) merry_christmas.png > merry_christmas.hgr

####

gp_hgr.zx02:	gp_hgr.hgr
	$(ZX02) gp_hgr.hgr gp_hgr.zx02

gp_hgr.hgr:	gp_hgr.png
	$(PNG_TO_HGR) gp_hgr.png > gp_hgr.hgr


####

clean:
	rm -f *~ *.zx02

include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	mntscrl3.hgr.zx02

####

mntscrl3.hgr.zx02:	mntscrl3.hgr
	$(ZX02) mntscrl3.hgr mntscrl3.hgr.zx02

####

clean:
	rm -f *~

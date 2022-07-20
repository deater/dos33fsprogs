include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR =	../../../utils/hgr-utils/png2hgr

all:	gp.hgr.zx02 peddle.hgr.zx02

####

gp.hgr.zx02:	gp.hgr
	$(ZX02) gp.hgr gp.hgr.zx02

gp.hgr:	gp.png
	$(PNG_TO_HGR) gp.png > gp.hgr

####

peddle.hgr.zx02:	peddle.hgr
	$(ZX02) peddle.hgr peddle.hgr.zx02

####

clean:
		rm -f *~ *.o *.lst


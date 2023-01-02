include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr

all:	cats.hgr.zx02 captain.hgr.zx02 operator.hgr.zx02

####

cats.hgr.zx02:	cats.hgr
	$(ZX02) cats.hgr cats.hgr.zx02

cats.hgr:	cats.png
	$(PNG_TO_HGR) cats.png > cats.hgr

####

captain.hgr.zx02:	captain.hgr
	$(ZX02) captain.hgr captain.hgr.zx02

captain.hgr:	captain.png
	$(PNG_TO_HGR) captain.png > captain.hgr

####

operator.hgr.zx02:	operator.hgr
	$(ZX02) operator.hgr operator.hgr.zx02

operator.hgr:	operator.png
	$(PNG_TO_HGR) operator.png > operator.hgr



####

clean:
	rm -f *~

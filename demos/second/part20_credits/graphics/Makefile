include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	nuts4.hgr.zx02


####

nuts4.hgr:	nuts4.png
	$(PNG_TO_HGR) nuts4.png > nuts4.hgr

nuts4.hgr.zx02:	nuts4.hgr
	$(ZX02) nuts4.hgr nuts4.hgr.zx02

####

clean:
	rm -f *~

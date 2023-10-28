include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	spheres.hgr.zx02

####

spheres.hgr:	spheres.png
	$(PNG_TO_HGR) spheres.png > spheres.hgr

spheres.hgr.zx02:	spheres.hgr
	$(ZX02) spheres.hgr spheres.hgr.zx02

####

clean:
	rm -f *~

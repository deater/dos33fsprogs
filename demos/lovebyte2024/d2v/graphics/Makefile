include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	scene.hgr.zx02


####

scene.hgr:	scene.png
	$(PNG_TO_HGR) scene.png > scene.hgr

scene.hgr.zx02:	scene.hgr
	$(ZX02) scene.hgr scene.hgr.zx02

####

clean:
	rm -f *~

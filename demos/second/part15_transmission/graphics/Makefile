include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	spheres.hgr.zx02 spheres.gr.zx02

####

spheres.gr.zx02:	spheres.gr
	$(ZX02) spheres.gr spheres.gr.zx02

spheres.gr:	spheres_lores.png
	$(PNG2GR) spheres_lores.png spheres.gr


####

spheres.hgr:	spheres.png
	$(PNG_TO_HGR) spheres.png > spheres.hgr

spheres.hgr.zx02:	spheres.hgr
	$(ZX02) spheres.hgr spheres.hgr.zx02

####

clean:
	rm -f *~

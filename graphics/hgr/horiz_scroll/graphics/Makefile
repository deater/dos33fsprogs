include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	pq2_bgl.hgr.zx02 pq2_bgr.hgr.zx02


####

pq2_dialog1.hgr.zx02:	pq2_dialog1.hgr
	$(ZX02) pq2_dialog1.hgr pq2_dialog1.hgr.zx02

pq2_dialog1.hgr:	pq2_dialog1.png
	$(PNG_TO_HGR) pq2_dialog1.png > pq2_dialog1.hgr

####

pq2_dialog2.hgr.zx02:	pq2_dialog2.hgr
	$(ZX02) pq2_dialog2.hgr pq2_dialog2.hgr.zx02

pq2_dialog2.hgr:	pq2_dialog2.png
	$(PNG_TO_HGR) pq2_dialog2.png > pq2_dialog2.hgr


####

pq2_bgl.hgr.zx02:	pq2_bgl.hgr
	$(ZX02) pq2_bgl.hgr pq2_bgl.hgr.zx02

pq2_bgl.hgr:	pq2_bgl.png
	$(PNG_TO_HGR) pq2_bgl.png > pq2_bgl.hgr

####

pq2_bgr.hgr.zx02:	pq2_bgr.hgr
	$(ZX02) pq2_bgr.hgr pq2_bgr.hgr.zx02

pq2_bgr.hgr:	pq2_bgr.png
	$(PNG_TO_HGR) pq2_bgr.png > pq2_bgr.hgr



####

clean:	
	rm -f *~ *.zx02 *.hgr



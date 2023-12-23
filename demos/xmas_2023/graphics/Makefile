include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../utils/gr-utils/png2gr

all:	tree01.gr.zx02 tree03.gr.zx02 \
	tree05.gr.zx02 tree07.gr.zx02 \
	tree09.gr.zx02 tree11.gr.zx02 \
	tree13.gr.zx02 tree15.gr.zx02 \
	tree02.gr.zx02 tree04.gr.zx02 \
	tree06.gr.zx02 tree08.gr.zx02 \
	tree10.gr.zx02 tree12.gr.zx02 \
	tree14.gr.zx02 tree16.gr.zx02 \
	merry.hgr.zx02 greets.raw.zx02

####

greets.raw.zx02:	greets.raw
	$(ZX02) greets.raw greets.raw.zx02

####

merry.hgr.zx02:	merry.hgr
	$(ZX02) merry.hgr merry.hgr.zx02

merry.hgr:	merry.png
	$(PNG_TO_HGR) merry.png > merry.hgr

####

tree01.gr.zx02:	tree01.gr
	$(ZX02) tree01.gr tree01.gr.zx02

tree01.gr:	tree01.png
	$(PNG2GR) tree01.png tree01.gr

####

tree02.gr.zx02:	tree02.gr
	$(ZX02) tree02.gr tree02.gr.zx02

tree02.gr:	tree02.png
	$(PNG2GR) tree02.png tree02.gr


####

tree03.gr.zx02:	tree03.gr
	$(ZX02) tree03.gr tree03.gr.zx02

tree03.gr:	tree03.png
	$(PNG2GR) tree03.png tree03.gr

####

tree04.gr.zx02:	tree04.gr
	$(ZX02) tree04.gr tree04.gr.zx02

tree04.gr:	tree04.png
	$(PNG2GR) tree04.png tree04.gr

####

tree05.gr.zx02:	tree05.gr
	$(ZX02) tree05.gr tree05.gr.zx02

tree05.gr:	tree05.png
	$(PNG2GR) tree05.png tree05.gr

####

tree06.gr.zx02:	tree06.gr
	$(ZX02) tree06.gr tree06.gr.zx02

tree06.gr:	tree06.png
	$(PNG2GR) tree06.png tree06.gr

####

tree07.gr.zx02:	tree07.gr
	$(ZX02) tree07.gr tree07.gr.zx02

tree07.gr:	tree07.png
	$(PNG2GR) tree07.png tree07.gr

####

tree08.gr.zx02:	tree08.gr
	$(ZX02) tree08.gr tree08.gr.zx02

tree08.gr:	tree08.png
	$(PNG2GR) tree08.png tree08.gr


####

tree09.gr.zx02:	tree09.gr
	$(ZX02) tree09.gr tree09.gr.zx02

tree09.gr:	tree09.png
	$(PNG2GR) tree09.png tree09.gr

####

tree10.gr.zx02:	tree10.gr
	$(ZX02) tree10.gr tree10.gr.zx02

tree10.gr:	tree10.png
	$(PNG2GR) tree10.png tree10.gr


####

tree11.gr.zx02:	tree11.gr
	$(ZX02) tree11.gr tree11.gr.zx02

tree11.gr:	tree11.png
	$(PNG2GR) tree11.png tree11.gr

####

tree12.gr.zx02:	tree12.gr
	$(ZX02) tree12.gr tree12.gr.zx02

tree12.gr:	tree12.png
	$(PNG2GR) tree12.png tree12.gr


####

tree13.gr.zx02:	tree13.gr
	$(ZX02) tree13.gr tree13.gr.zx02

tree13.gr:	tree13.png
	$(PNG2GR) tree13.png tree13.gr

####

tree14.gr.zx02:	tree14.gr
	$(ZX02) tree14.gr tree14.gr.zx02

tree14.gr:	tree14.png
	$(PNG2GR) tree14.png tree14.gr

####

tree15.gr.zx02:	tree15.gr
	$(ZX02) tree15.gr tree15.gr.zx02

tree15.gr:	tree15.png
	$(PNG2GR) tree15.png tree15.gr

####

tree16.gr.zx02:	tree16.gr
	$(ZX02) tree16.gr tree16.gr.zx02

tree16.gr:	tree16.png
	$(PNG2GR) tree16.png tree16.gr

####

clean:
	rm -f *~ *.zx02

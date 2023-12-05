include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../utils/gr-utils/png2gr

all:	tree01.gr.zx02 tree03.gr.zx02 \
	tree05.gr.zx02 tree07.gr.zx02 \
	tree09.gr.zx02 tree11.gr.zx02 \
	tree13.gr.zx02 tree15.gr.zx02 \


####

tree01.gr.zx02:	tree01.gr
	$(ZX02) tree01.gr tree01.gr.zx02

tree01.gr:	tree01.png
	$(PNG2GR) tree01.png tree01.gr

####

tree03.gr.zx02:	tree03.gr
	$(ZX02) tree03.gr tree03.gr.zx02

tree03.gr:	tree03.png
	$(PNG2GR) tree03.png tree03.gr


####

tree05.gr.zx02:	tree05.gr
	$(ZX02) tree05.gr tree05.gr.zx02

tree05.gr:	tree05.png
	$(PNG2GR) tree05.png tree05.gr

####

tree07.gr.zx02:	tree07.gr
	$(ZX02) tree07.gr tree07.gr.zx02

tree07.gr:	tree07.png
	$(PNG2GR) tree07.png tree07.gr


####

tree09.gr.zx02:	tree09.gr
	$(ZX02) tree09.gr tree09.gr.zx02

tree09.gr:	tree09.png
	$(PNG2GR) tree09.png tree09.gr

####

tree11.gr.zx02:	tree11.gr
	$(ZX02) tree11.gr tree11.gr.zx02

tree11.gr:	tree11.png
	$(PNG2GR) tree11.png tree11.gr


####

tree13.gr.zx02:	tree13.gr
	$(ZX02) tree13.gr tree13.gr.zx02

tree13.gr:	tree13.png
	$(PNG2GR) tree13.png tree13.gr

####

tree15.gr.zx02:	tree15.gr
	$(ZX02) tree15.gr tree15.gr.zx02

tree15.gr:	tree15.png
	$(PNG2GR) tree15.png tree15.gr

####

clean:
	rm -f *~ *.zx02

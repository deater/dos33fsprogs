include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	lenspic.gr.zx02

####

lenspic.gr.zx02:	lenspic.gr
	$(ZX02) lenspic.gr lenspic.gr.zx02

lenspic.gr:	lenspic.png
	$(PNG2GR) lenspic.png lenspic.gr


####

clean:
	rm -f *~

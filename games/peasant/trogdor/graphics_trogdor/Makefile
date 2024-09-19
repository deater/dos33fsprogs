
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
#LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	trogdor_graphics.inc \
	priority_trogdor.inc


trogdor_graphics.inc:	\
	trogdor_cave.zx02 \
	trogdor_open.zx02 \
	trogdor_flame1.zx02 \
	trogdor_flame2.zx02 \
	trogdor_sleep.zx02
	echo "trogdor_cave_zx02: .incbin \"trogdor_cave.zx02\"" > trogdor_graphics.inc
	echo "trogdor_open_zx02: .incbin \"trogdor_open.zx02\"" >> trogdor_graphics.inc
	echo "trogdor_flame1_zx02: .incbin \"trogdor_flame1.zx02\"" >> trogdor_graphics.inc
	echo "trogdor_flame2_zx02: .incbin \"trogdor_flame2.zx02\"" >> trogdor_graphics.inc
	echo "trogdor_sleep_zx02: .incbin \"trogdor_sleep.zx02\"" >> trogdor_graphics.inc

###

trogdor_cave.zx02:	trogdor_cave.hgr
	$(ZX02) -f trogdor_cave.hgr trogdor_cave.zx02

trogdor_cave.hgr:	trogdor_cave.png
	$(PNG2HGR) trogdor_cave.png > trogdor_cave.hgr

###

trogdor_open.zx02:	trogdor_open.hgr
	$(ZX02) -f trogdor_open.hgr trogdor_open.zx02

trogdor_open.hgr:	trogdor_open.png
	$(PNG2HGR) trogdor_open.png > trogdor_open.hgr

###

trogdor_flame1.zx02:	trogdor_flame1.hgr
	$(ZX02) -f trogdor_flame1.hgr trogdor_flame1.zx02

trogdor_flame1.hgr:	trogdor_flame1.png
	$(PNG2HGR) trogdor_flame1.png > trogdor_flame1.hgr

###

trogdor_flame2.zx02:	trogdor_flame2.hgr
	$(ZX02) -f trogdor_flame2.hgr trogdor_flame2.zx02

trogdor_flame2.hgr:	trogdor_flame2.png
	$(PNG2HGR) trogdor_flame2.png > trogdor_flame2.hgr

###

trogdor_sleep.zx02:	trogdor_sleep.hgr
	$(ZX02) -f trogdor_sleep.hgr trogdor_sleep.zx02

trogdor_sleep.hgr:	trogdor_sleep.png
	$(PNG2HGR) trogdor_sleep.png > trogdor_sleep.hgr

####

priority_trogdor.inc:  \
	trogdor_priority.zx02
	echo "trogdor_priority_zx02: .incbin \"trogdor_priority.zx02\"" > priority_trogdor.inc

####

trogdor_priority.zx02:	trogdor_priority.gr
	$(ZX02) -f trogdor_priority.gr trogdor_priority.zx02

trogdor_priority.gr:	trogdor_priority.png
	$(PNG2GR) trogdor_priority.png trogdor_priority.gr

####


clean:	
	rm -f *~ trogdor_graphics.inc priority_trogdor.inc *.zx02 *.gr *.hgr


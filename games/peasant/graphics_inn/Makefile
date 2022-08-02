
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
#LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	graphics_inn.inc \
	priority_inn.inc

###

graphics_inn.inc:	\
	inside_inn.zx02 inside_inn_night.zx02
	echo "inside_inn_zx02: .incbin \"inside_inn.zx02\"" > graphics_inn.inc
	echo "inside_inn_night_zx02: .incbin \"inside_inn_night.zx02\"" >> graphics_inn.inc

###

inside_inn.zx02:	inside_inn.hgr
	$(ZX02) -f inside_inn.hgr inside_inn.zx02

inside_inn.hgr:	inside_inn.png
	$(PNG2HGR) inside_inn.png > inside_inn.hgr

###

inside_inn_night.zx02:	inside_inn_night.hgr
	$(ZX02) -f inside_inn_night.hgr inside_inn_night.zx02

inside_inn_night.hgr:	inside_inn_night.png
	$(PNG2HGR) inside_inn_night.png > inside_inn_night.hgr


###

priority_inn.inc:  \
	inside_inn_priority.zx02
	echo "inside_inn_priority_zx02: .incbin \"inside_inn_priority.zx02\"" > priority_inn.inc

####

inside_inn_priority.zx02:	inside_inn_priority.gr
	$(ZX02) -f inside_inn_priority.gr inside_inn_priority.zx02

inside_inn_priority.gr:	inside_inn_priority.png
	$(PNG2GR) inside_inn_priority.png inside_inn_priority.gr

####

clean:	
	rm -f *~ graphics_inn.inc priority_inn.inc *.zx02 *.gr *.hgr


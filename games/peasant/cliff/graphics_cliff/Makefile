
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
#LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	cliff_graphics.inc \
	priority_cliff.inc

###

cliff_graphics.inc:	\
	cliff_base.zx02 cliff_heights.zx02 outer.zx02
	echo "cliff_base_zx02: .incbin \"cliff_base.zx02\"" > cliff_graphics.inc
	echo "cliff_heights_zx02: .incbin \"cliff_heights.zx02\"" >> cliff_graphics.inc
	echo "outer_zx02: .incbin \"outer.zx02\"" >> cliff_graphics.inc

###

cliff_base.zx02:	cliff_base.hgr
	$(ZX02) -f cliff_base.hgr cliff_base.zx02

cliff_base.hgr:	cliff_base.png
	$(PNG2HGR) cliff_base.png > cliff_base.hgr

###

cliff_heights.zx02:	cliff_heights.hgr
	$(ZX02) -f cliff_heights.hgr cliff_heights.zx02

cliff_heights.hgr:	cliff_heights.png
	$(PNG2HGR) cliff_heights.png > cliff_heights.hgr

###

outer.zx02:	outer.hgr
	$(ZX02) -f outer.hgr outer.zx02

outer.hgr:	outer.png
	$(PNG2HGR) outer.png > outer.hgr



###

priority_cliff.inc:  \
	outer_priority.zx02 \
	cliff_base_priority.zx02 \
	cliff_heights_priority.zx02
	echo "cliff_base_priority_zx02: .incbin \"cliff_base_priority.zx02\"" > priority_cliff.inc
	echo "cliff_heights_priority_zx02: .incbin \"cliff_heights_priority.zx02\"" >> priority_cliff.inc
	echo "outer_priority_zx02: .incbin \"outer_priority.zx02\"" >> priority_cliff.inc


####

outer_priority.zx02:	outer_priority.gr
	$(ZX02) -f outer_priority.gr outer_priority.zx02

outer_priority.gr:	outer_priority.png
	$(PNG2GR) outer_priority.png outer_priority.gr

####

cliff_base_priority.zx02:	cliff_base_priority.gr
	$(ZX02) -f cliff_base_priority.gr cliff_base_priority.zx02

cliff_base_priority.gr:	cliff_base_priority.png
	$(PNG2GR) cliff_base_priority.png cliff_base_priority.gr

####

cliff_heights_priority.zx02:	cliff_heights_priority.gr
	$(ZX02) -f cliff_heights_priority.gr cliff_heights_priority.zx02

cliff_heights_priority.gr:	cliff_heights_priority.png
	$(PNG2GR) cliff_heights_priority.png cliff_heights_priority.gr


####


clean:	
	rm -f *~ cliff_graphics.inc priority_cliff.inc *.zx02 *.gr *.hgr


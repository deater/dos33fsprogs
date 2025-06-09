PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	outer_graphics.inc \
	outer_priority.inc

###

outer_graphics.inc:	\
	outer.zx02
	echo "outer_zx02: .incbin \"outer.zx02\"" > outer_graphics.inc

###

outer_priority.inc:  \
	outer_priority.zx02
	echo "outer_priority_zx02: .incbin \"outer_priority.zx02\"" > outer_priority.inc

###

outer.zx02:	outer.hgr
	$(ZX02) -f outer.hgr outer.zx02

outer.hgr:	outer.png
	$(PNG2HGR) outer.png > outer.hgr

####

outer_priority.zx02:	outer_priority.combined
	$(ZX02) -f outer_priority.combined outer_priority.zx02

outer_priority.combined:	outer_priority.gr outer_collision.bin
	cat outer_priority.gr >  outer_priority.combined
	cat outer_collision.bin >> outer_priority.combined

outer_priority.gr:	outer_priority.png
	$(PNG2GR) outer_priority.png outer_priority.gr

outer_collision.bin:	outer_collision.png
	$(PNG2COLLISION) outer_collision.png outer_collision.bin

####


clean:	
	rm -f *~ outer_graphics.inc outer_priority.inc \
	*.bin *.combined *.zx02 *.gr *.hgr


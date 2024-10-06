PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	cliff_heights_graphics.inc \
	priority_cliff_heights.inc

###

cliff_heights_graphics.inc:	\
	cliff_heights.zx02 outer.zx02
	echo "cliff_heights_zx02: .incbin \"cliff_heights.zx02\"" >> cliff_heights_graphics.inc
	echo "outer_zx02: .incbin \"outer.zx02\"" >> cliff_heights_graphics.inc

###

priority_cliff_heights.inc:  \
	cliff_heights_priority.zx02 \
	outer_priority.zx02
	echo "cliff_heights_priority_zx02: .incbin \"cliff_heights_priority.zx02\"" >> priority_cliff_heights.inc
	echo "outer_priority_zx02: .incbin \"outer_priority.zx02\"" >> priority_cliff_heights.inc

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

####

cliff_heights_priority.zx02:	cliff_heights_priority.combined
	$(ZX02) -f cliff_heights_priority.combined cliff_heights_priority.zx02

cliff_heights_priority.combined:	cliff_heights_priority.gr cliff_heights_collision.bin
	cat cliff_heights_priority.gr >  cliff_heights_priority.combined
	cat cliff_heights_collision.bin >> cliff_heights_priority.combined

cliff_heights_priority.gr:	cliff_heights_priority.png
	$(PNG2GR) cliff_heights_priority.png cliff_heights_priority.gr

cliff_heights_collision.bin:	cliff_heights_collision.png
	$(PNG2COLLISION) cliff_heights_collision.png cliff_heights_collision.bin

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
	rm -f *~ cliff_heights_graphics.inc priority_cliff_heights.inc *.zx02 *.gr *.hgr


PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	bottom_prints_graphics.inc \
	bottom_prints_priority.inc

###

bottom_prints_graphics.inc:	\
	bottom_prints.zx02
	echo "bottom_prints_zx02: .incbin \"bottom_prints.zx02\"" > bottom_prints_graphics.inc

###

bottom_prints.zx02:	bottom_prints.hgr
	$(ZX02) -f bottom_prints.hgr bottom_prints.zx02

bottom_prints.hgr:	bottom_prints.png
	$(PNG2HGR) bottom_prints.png > bottom_prints.hgr

###

bottom_prints_priority.inc:  \
	bottom_prints_priority.zx02
	echo "bottom_prints_priority_zx02: .incbin \"bottom_prints_priority.zx02\"" > bottom_prints_priority.inc

####

bottom_prints_priority.zx02:	bottom_prints_priority.combined
	$(ZX02) -f bottom_prints_priority.combined bottom_prints_priority.zx02

bottom_prints_priority.combined:	bottom_prints_priority.gr bottom_prints_collision.bin
	cat bottom_prints_priority.gr >  bottom_prints_priority.combined
	cat bottom_prints_collision.bin >> bottom_prints_priority.combined

bottom_prints_priority.gr:	bottom_prints_priority.png
	$(PNG2GR) bottom_prints_priority.png bottom_prints_priority.gr

bottom_prints_collision.bin:	bottom_prints_collision.png
	$(PNG2COLLISION) bottom_prints_collision.png bottom_prints_collision.bin

####

clean:	
	rm -f *~ bottom_prints_graphics.inc bottom_prints_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


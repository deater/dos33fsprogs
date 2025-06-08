PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	well_graphics.inc \
	well_priority.inc

###

well_graphics.inc:	\
	well.zx02
	echo "well_zx02: .incbin \"well.zx02\"" > well_graphics.inc

###

well.zx02:	well.hgr
	$(ZX02) -f well.hgr well.zx02

well.hgr:	well.png
	$(PNG2HGR) well.png > well.hgr

###

well_priority.inc:  \
	well_priority.zx02
	echo "well_priority_zx02: .incbin \"well_priority.zx02\"" > well_priority.inc

####

well_priority.zx02:	well_priority.combined
	$(ZX02) -f well_priority.combined well_priority.zx02

well_priority.combined:	well_priority.gr well_collision.bin
	cat well_priority.gr >  well_priority.combined
	cat well_collision.bin >> well_priority.combined

well_priority.gr:	well_priority.png
	$(PNG2GR) well_priority.png well_priority.gr

well_collision.bin:	well_collision.png
	$(PNG2COLLISION) well_collision.png well_collision.bin

####

clean:	
	rm -f *~ well_graphics.inc well_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


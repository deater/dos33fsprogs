PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	archery_graphics.inc \
	archery_priority.inc

###

archery_graphics.inc:	\
	archery.zx02
	echo "archery_zx02: .incbin \"archery.zx02\"" > archery_graphics.inc

###

archery.zx02:	archery.hgr
	$(ZX02) -f archery.hgr archery.zx02

archery.hgr:	archery.png
	$(PNG2HGR) archery.png > archery.hgr

###

archery_priority.inc:  \
	archery_priority.zx02
	echo "archery_priority_zx02: .incbin \"archery_priority.zx02\"" > archery_priority.inc

####

archery_priority.zx02:	archery_priority.combined
	$(ZX02) -f archery_priority.combined archery_priority.zx02

archery_priority.combined:	archery_priority.gr archery_collision.bin
	cat archery_priority.gr >  archery_priority.combined
	cat archery_collision.bin >> archery_priority.combined

archery_priority.gr:	archery_priority.png
	$(PNG2GR) archery_priority.png archery_priority.gr

archery_collision.bin:	archery_collision.png
	$(PNG2COLLISION) archery_collision.png archery_collision.bin

####

clean:	
	rm -f *~ archery_graphics.inc archery_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


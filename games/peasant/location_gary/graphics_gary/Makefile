PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	gary_graphics.inc \
	gary_priority.inc \
	gary_priority_after.gr gary_collision_after.bin

###

gary_graphics.inc:	\
	gary.zx02
	echo "gary_zx02: .incbin \"gary.zx02\"" > gary_graphics.inc

###

gary.zx02:	gary.hgr
	$(ZX02) -f gary.hgr gary.zx02

gary.hgr:	gary.png
	$(PNG2HGR) gary.png > gary.hgr

###

gary_priority.inc:  \
	gary_priority.zx02
	echo "gary_priority_zx02: .incbin \"gary_priority.zx02\"" > gary_priority.inc

####

gary_priority.zx02:	gary_priority.combined
	$(ZX02) -f gary_priority.combined gary_priority.zx02

gary_priority.combined:	gary_priority.gr gary_collision.bin
	cat gary_priority.gr >  gary_priority.combined
	cat gary_collision.bin >> gary_priority.combined

gary_priority.gr:	gary_priority.png
	$(PNG2GR) gary_priority.png gary_priority.gr

gary_collision.bin:	gary_collision.png
	$(PNG2COLLISION) gary_collision.png gary_collision.bin

####

gary_priority_after.gr:	gary_priority_after.png
	$(PNG2GR) gary_priority_after.png gary_priority_after.gr

gary_collision_after.bin:	gary_collision_after.png
	$(PNG2COLLISION) gary_collision_after.png gary_collision_after.bin

####

clean:	
	rm -f *~ gary_graphics.inc gary_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


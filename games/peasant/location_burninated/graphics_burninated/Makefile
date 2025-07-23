PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	crooked_tree_graphics.inc \
	crooked_tree_night_graphics.inc \
	crooked_tree_priority.inc

###

crooked_tree_graphics.inc:	\
	crooked_tree.zx02
	echo "crooked_tree_zx02: .incbin \"crooked_tree.zx02\"" > crooked_tree_graphics.inc

crooked_tree_night_graphics.inc:	\
	crooked_tree_night.zx02
	echo "crooked_tree_night_zx02: .incbin \"crooked_tree_night.zx02\"" > crooked_tree_night_graphics.inc


###

crooked_tree.zx02:	crooked_tree.hgr
	$(ZX02) -f crooked_tree.hgr crooked_tree.zx02

crooked_tree.hgr:	crooked_tree.png
	$(PNG2HGR) crooked_tree.png > crooked_tree.hgr

###

crooked_tree_night.zx02:	crooked_tree_night.hgr
	$(ZX02) -f crooked_tree_night.hgr crooked_tree_night.zx02

crooked_tree_night.hgr:	crooked_tree_night.png
	$(PNG2HGR) crooked_tree_night.png > crooked_tree_night.hgr


###

crooked_tree_priority.inc:  \
	crooked_tree_priority.zx02
	echo "crooked_tree_priority_zx02: .incbin \"crooked_tree_priority.zx02\"" > crooked_tree_priority.inc

####

crooked_tree_priority.zx02:	crooked_tree_priority.combined
	$(ZX02) -f crooked_tree_priority.combined crooked_tree_priority.zx02

crooked_tree_priority.combined:	crooked_tree_priority.gr crooked_tree_collision.bin
	cat crooked_tree_priority.gr >  crooked_tree_priority.combined
	cat crooked_tree_collision.bin >> crooked_tree_priority.combined

crooked_tree_priority.gr:	crooked_tree_priority.png
	$(PNG2GR) crooked_tree_priority.png crooked_tree_priority.gr

crooked_tree_collision.bin:	crooked_tree_collision.png
	$(PNG2COLLISION) crooked_tree_collision.png crooked_tree_collision.bin

####

clean:	
	rm -f *~ crooked_tree_graphics.inc crooked_tree_night_graphics.inc \
		crooked_tree_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


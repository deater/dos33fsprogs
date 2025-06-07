PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	yellow_tree_graphics.inc \
	yellow_tree_priority.inc

###

yellow_tree_graphics.inc:	\
	yellow_tree.zx02
	echo "yellow_tree_zx02: .incbin \"yellow_tree.zx02\"" > yellow_tree_graphics.inc

###

yellow_tree.zx02:	yellow_tree.hgr
	$(ZX02) -f yellow_tree.hgr yellow_tree.zx02

yellow_tree.hgr:	yellow_tree.png
	$(PNG2HGR) yellow_tree.png > yellow_tree.hgr

###

yellow_tree_priority.inc:  \
	yellow_tree_priority.zx02
	echo "yellow_tree_priority_zx02: .incbin \"yellow_tree_priority.zx02\"" > yellow_tree_priority.inc

####

yellow_tree_priority.zx02:	yellow_tree_priority.combined
	$(ZX02) -f yellow_tree_priority.combined yellow_tree_priority.zx02

yellow_tree_priority.combined:	yellow_tree_priority.gr yellow_tree_collision.bin
	cat yellow_tree_priority.gr >  yellow_tree_priority.combined
	cat yellow_tree_collision.bin >> yellow_tree_priority.combined

yellow_tree_priority.gr:	yellow_tree_priority.png
	$(PNG2GR) yellow_tree_priority.png yellow_tree_priority.gr

yellow_tree_collision.bin:	yellow_tree_collision.png
	$(PNG2COLLISION) yellow_tree_collision.png yellow_tree_collision.bin

####

clean:	
	rm -f *~ yellow_tree_graphics.inc yellow_tree_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	cottage_graphics.inc \
	cottage_priority.inc

###

cottage_graphics.inc:	\
	cottage.zx02
	echo "cottage_zx02: .incbin \"cottage.zx02\"" > cottage_graphics.inc

###

cottage.zx02:	cottage.hgr
	$(ZX02) -f cottage.hgr cottage.zx02

cottage.hgr:	cottage.png
	$(PNG2HGR) cottage.png > cottage.hgr

###

cottage_priority.inc:  \
	cottage_priority.zx02
	echo "cottage_priority_zx02: .incbin \"cottage_priority.zx02\"" > cottage_priority.inc

####

cottage_priority.zx02:	cottage_priority.combined
	$(ZX02) -f cottage_priority.combined cottage_priority.zx02

cottage_priority.combined:	cottage_priority.gr cottage_collision.bin
	cat cottage_priority.gr >  cottage_priority.combined
	cat cottage_collision.bin >> cottage_priority.combined

cottage_priority.gr:	cottage_priority.png
	$(PNG2GR) cottage_priority.png cottage_priority.gr

cottage_collision.bin:	cottage_collision.png
	$(PNG2COLLISION) cottage_collision.png cottage_collision.bin

####

clean:	
	rm -f *~ cottage_graphics.inc cottage_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


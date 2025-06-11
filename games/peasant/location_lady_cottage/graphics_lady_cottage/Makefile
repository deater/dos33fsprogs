PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	lady_cottage_graphics.inc \
	lady_cottage_priority.inc

###

lady_cottage_graphics.inc:	\
	lady_cottage.zx02
	echo "lady_cottage_zx02: .incbin \"lady_cottage.zx02\"" > lady_cottage_graphics.inc

###

lady_cottage.zx02:	lady_cottage.hgr
	$(ZX02) -f lady_cottage.hgr lady_cottage.zx02

lady_cottage.hgr:	lady_cottage.png
	$(PNG2HGR) lady_cottage.png > lady_cottage.hgr

###

lady_cottage_priority.inc:  \
	lady_cottage_priority.zx02
	echo "lady_cottage_priority_zx02: .incbin \"lady_cottage_priority.zx02\"" > lady_cottage_priority.inc

####

lady_cottage_priority.zx02:	lady_cottage_priority.combined
	$(ZX02) -f lady_cottage_priority.combined lady_cottage_priority.zx02

lady_cottage_priority.combined:	lady_cottage_priority.gr lady_cottage_collision.bin
	cat lady_cottage_priority.gr >  lady_cottage_priority.combined
	cat lady_cottage_collision.bin >> lady_cottage_priority.combined

lady_cottage_priority.gr:	lady_cottage_priority.png
	$(PNG2GR) lady_cottage_priority.png lady_cottage_priority.gr

lady_cottage_collision.bin:	lady_cottage_collision.png
	$(PNG2COLLISION) lady_cottage_collision.png lady_cottage_collision.bin

####

clean:	
	rm -f *~ lady_cottage_graphics.inc lady_cottage_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


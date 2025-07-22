PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	inside_lady_graphics.inc \
	inside_lady_priority.inc

###

inside_lady_graphics.inc:	\
	inside_cottage.zx02
	echo "inside_cottage_zx02: .incbin \"inside_cottage.zx02\"" > inside_lady_graphics.inc

###

inside_cottage.zx02:	inside_cottage.hgr
	$(ZX02) -f inside_cottage.hgr inside_cottage.zx02

inside_cottage.hgr:	inside_cottage.png
	$(PNG2HGR) inside_cottage.png > inside_cottage.hgr

###

inside_lady_priority.inc:  \
	inside_cottage_priority.zx02
	echo "inside_cottage_priority_zx02: .incbin \"inside_cottage_priority.zx02\"" > inside_lady_priority.inc

####

inside_cottage_priority.zx02:	inside_cottage_priority.combined
	$(ZX02) -f inside_cottage_priority.combined inside_cottage_priority.zx02

inside_cottage_priority.combined:	\
	inside_cottage_priority.gr inside_cottage_chair_priority.gr \
	inside_cottage_collision.bin
	cat inside_cottage_priority.gr >  inside_cottage_priority.combined
	cat inside_cottage_collision.bin >> inside_cottage_priority.combined

inside_cottage_priority.gr:	inside_cottage_priority.png
	$(PNG2GR) inside_cottage_priority.png inside_cottage_priority.gr

inside_cottage_collision.bin:	inside_cottage_collision.png
	$(PNG2COLLISION) inside_cottage_collision.png inside_cottage_collision.bin

####

inside_cottage_chair_priority.gr:	inside_cottage_chair_priority.png
	$(PNG2GR) inside_cottage_chair_priority.png inside_cottage_chair_priority.gr

####

clean:	
	rm -f *~ inside_lady_graphics.inc inside_lady_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	haystack_graphics.inc \
	haystack_priority.inc

###

haystack_graphics.inc:	\
	haystack.zx02
	echo "haystack_zx02: .incbin \"haystack.zx02\"" > haystack_graphics.inc

###

haystack.zx02:	haystack.hgr
	$(ZX02) -f haystack.hgr haystack.zx02

haystack.hgr:	haystack.png
	$(PNG2HGR) haystack.png > haystack.hgr

###

haystack_priority.inc:  \
	haystack_priority.zx02
	echo "haystack_priority_zx02: .incbin \"haystack_priority.zx02\"" > haystack_priority.inc

####

haystack_priority.zx02:	haystack_priority.combined
	$(ZX02) -f haystack_priority.combined haystack_priority.zx02

haystack_priority.combined:	haystack_priority.gr haystack_collision.bin
	cat haystack_priority.gr >  haystack_priority.combined
	cat haystack_collision.bin >> haystack_priority.combined

haystack_priority.gr:	haystack_priority.png
	$(PNG2GR) haystack_priority.png haystack_priority.gr

haystack_collision.bin:	haystack_collision.png
	$(PNG2COLLISION) haystack_collision.png haystack_collision.bin

####

clean:	
	rm -f *~ haystack_graphics.inc haystack_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


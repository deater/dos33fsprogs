PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	empty_hut_graphics.inc \
	empty_hut_priority.inc

###

empty_hut_graphics.inc:	\
	empty_hut.zx02
	echo "empty_hut_zx02: .incbin \"empty_hut.zx02\"" > empty_hut_graphics.inc

###

empty_hut.zx02:	empty_hut.hgr
	$(ZX02) -f empty_hut.hgr empty_hut.zx02

empty_hut.hgr:	empty_hut.png
	$(PNG2HGR) empty_hut.png > empty_hut.hgr

###

empty_hut_priority.inc:  \
	empty_hut_priority.zx02
	echo "empty_hut_priority_zx02: .incbin \"empty_hut_priority.zx02\"" > empty_hut_priority.inc

####

empty_hut_priority.zx02:	empty_hut_priority.combined
	$(ZX02) -f empty_hut_priority.combined empty_hut_priority.zx02

empty_hut_priority.combined:	empty_hut_priority.gr empty_hut_collision.bin
	cat empty_hut_priority.gr >  empty_hut_priority.combined
	cat empty_hut_collision.bin >> empty_hut_priority.combined

empty_hut_priority.gr:	empty_hut_priority.png
	$(PNG2GR) empty_hut_priority.png empty_hut_priority.gr

empty_hut_collision.bin:	empty_hut_collision.png
	$(PNG2COLLISION) empty_hut_collision.png empty_hut_collision.bin

####

clean:	
	rm -f *~ empty_hut_graphics.inc empty_hut_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	puddle_graphics.inc \
	puddle_priority.inc

###

puddle_graphics.inc:	\
	puddle.zx02
	echo "puddle_zx02: .incbin \"puddle.zx02\"" > puddle_graphics.inc

###

puddle.zx02:	puddle.hgr
	$(ZX02) -f puddle.hgr puddle.zx02

puddle.hgr:	puddle.png
	$(PNG2HGR) puddle.png > puddle.hgr

###

puddle_priority.inc:  \
	puddle_priority.zx02
	echo "puddle_priority_zx02: .incbin \"puddle_priority.zx02\"" > puddle_priority.inc

####

puddle_priority.zx02:	puddle_priority.combined
	$(ZX02) -f puddle_priority.combined puddle_priority.zx02

puddle_priority.combined:	puddle_priority.gr puddle_collision.bin
	cat puddle_priority.gr >  puddle_priority.combined
	cat puddle_collision.bin >> puddle_priority.combined

puddle_priority.gr:	puddle_priority.png
	$(PNG2GR) puddle_priority.png puddle_priority.gr

puddle_collision.bin:	puddle_collision.png
	$(PNG2COLLISION) puddle_collision.png puddle_collision.bin

####

clean:	
	rm -f *~ puddle_graphics.inc puddle_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	river_graphics.inc river_night_graphics.inc \
	river_priority.inc

###

river_graphics.inc:	\
	river.zx02
	echo "river_zx02: .incbin \"river.zx02\"" > river_graphics.inc

river_night_graphics.inc:	\
	river_night.zx02
	echo "river_night_zx02: .incbin \"river_night.zx02\"" > river_night_graphics.inc


###

river.zx02:	river.hgr
	$(ZX02) -f river.hgr river.zx02

river.hgr:	river.png
	$(PNG2HGR) river.png > river.hgr

###

river_night.zx02:	river_night.hgr
	$(ZX02) -f river_night.hgr river_night.zx02

river_night.hgr:	river_night.png
	$(PNG2HGR) river_night.png > river_night.hgr


###

river_priority.inc:  \
	river_priority.zx02
	echo "river_priority_zx02: .incbin \"river_priority.zx02\"" > river_priority.inc

####

river_priority.zx02:	river_priority.combined
	$(ZX02) -f river_priority.combined river_priority.zx02

river_priority.combined:	river_priority.gr river_collision.bin
	cat river_priority.gr >  river_priority.combined
	cat river_collision.bin >> river_priority.combined

river_priority.gr:	river_priority.png
	$(PNG2GR) river_priority.png river_priority.gr

river_collision.bin:	river_collision.png
	$(PNG2COLLISION) river_collision.png river_collision.bin

####

clean:	
	rm -f *~ river_graphics.inc river_night_graphics.inc \
		river_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


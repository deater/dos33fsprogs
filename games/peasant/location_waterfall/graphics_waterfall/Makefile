PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	waterfall_graphics.inc \
	waterfall_priority.inc

###

waterfall_graphics.inc:	\
	waterfall.zx02
	echo "waterfall_zx02: .incbin \"waterfall.zx02\"" > waterfall_graphics.inc

###

waterfall.zx02:	waterfall.hgr
	$(ZX02) -f waterfall.hgr waterfall.zx02

waterfall.hgr:	waterfall.png
	$(PNG2HGR) waterfall.png > waterfall.hgr

###

waterfall_priority.inc:  \
	waterfall_priority.zx02
	echo "waterfall_priority_zx02: .incbin \"waterfall_priority.zx02\"" > waterfall_priority.inc

####

waterfall_priority.zx02:	waterfall_priority.combined
	$(ZX02) -f waterfall_priority.combined waterfall_priority.zx02

waterfall_priority.combined:	waterfall_priority.gr waterfall_collision.bin
	cat waterfall_priority.gr >  waterfall_priority.combined
	cat waterfall_collision.bin >> waterfall_priority.combined

waterfall_priority.gr:	waterfall_priority.png
	$(PNG2GR) waterfall_priority.png waterfall_priority.gr

waterfall_collision.bin:	waterfall_collision.png
	$(PNG2COLLISION) waterfall_collision.png waterfall_collision.bin

####

clean:	
	rm -f *~ waterfall_graphics.inc waterfall_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


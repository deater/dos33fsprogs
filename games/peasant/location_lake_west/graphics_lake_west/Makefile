PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	lake_w_graphics.inc \
	lake_w_priority.inc

###

lake_w_graphics.inc:	\
	lake_w.zx02
	echo "lake_w_zx02: .incbin \"lake_w.zx02\"" > lake_w_graphics.inc

###

lake_w.zx02:	lake_w.hgr
	$(ZX02) -f lake_w.hgr lake_w.zx02

lake_w.hgr:	lake_w.png
	$(PNG2HGR) lake_w.png > lake_w.hgr

###

lake_w_priority.inc:  \
	lake_w_priority.zx02
	echo "lake_w_priority_zx02: .incbin \"lake_w_priority.zx02\"" > lake_w_priority.inc

####

lake_w_priority.zx02:	lake_w_priority.combined
	$(ZX02) -f lake_w_priority.combined lake_w_priority.zx02

lake_w_priority.combined:	lake_w_priority.gr lake_w_collision.bin
	cat lake_w_priority.gr >  lake_w_priority.combined
	cat lake_w_collision.bin >> lake_w_priority.combined

lake_w_priority.gr:	lake_w_priority.png
	$(PNG2GR) lake_w_priority.png lake_w_priority.gr

lake_w_collision.bin:	lake_w_collision.png
	$(PNG2COLLISION) lake_w_collision.png lake_w_collision.bin

####

clean:	
	rm -f *~ lake_w_graphics.inc lake_w_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


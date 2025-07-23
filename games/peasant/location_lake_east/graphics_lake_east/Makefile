PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	lake_e_graphics.inc lake_e_night_graphics.inc \
	lake_e_priority.inc

###

lake_e_graphics.inc:	\
	lake_e.zx02
	echo "lake_e_zx02: .incbin \"lake_e.zx02\"" > lake_e_graphics.inc

lake_e_night_graphics.inc:	\
	lake_e_night.zx02
	echo "lake_e_night_zx02: .incbin \"lake_e_night.zx02\"" > lake_e_night_graphics.inc


###

lake_e.zx02:	lake_e.hgr
	$(ZX02) -f lake_e.hgr lake_e.zx02

lake_e.hgr:	lake_e.png
	$(PNG2HGR) lake_e.png > lake_e.hgr

###

lake_e_night.zx02:	lake_e_night.hgr
	$(ZX02) -f lake_e_night.hgr lake_e_night.zx02

lake_e_night.hgr:	lake_e_night.png
	$(PNG2HGR) lake_e_night.png > lake_e_night.hgr


###

lake_e_priority.inc:  \
	lake_e_priority.zx02
	echo "lake_e_priority_zx02: .incbin \"lake_e_priority.zx02\"" > lake_e_priority.inc

####

lake_e_priority.zx02:	lake_e_priority.combined
	$(ZX02) -f lake_e_priority.combined lake_e_priority.zx02

lake_e_priority.combined:	lake_e_priority.gr lake_e_collision.bin
	cat lake_e_priority.gr >  lake_e_priority.combined
	cat lake_e_collision.bin >> lake_e_priority.combined

lake_e_priority.gr:	lake_e_priority.png
	$(PNG2GR) lake_e_priority.png lake_e_priority.gr

lake_e_collision.bin:	lake_e_collision.png
	$(PNG2COLLISION) lake_e_collision.png lake_e_collision.bin

####

clean:	
	rm -f *~ lake_e_graphics.inc lake_e_night_graphics.inc \
		lake_e_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


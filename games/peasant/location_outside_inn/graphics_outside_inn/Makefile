PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	outside_inn_graphics.inc outside_inn_night_graphics.inc \
	outside_inn_priority.inc

###

outside_inn_graphics.inc:	\
	outside_inn.zx02
	echo "outside_inn_zx02: .incbin \"outside_inn.zx02\"" > outside_inn_graphics.inc

outside_inn_night_graphics.inc:	\
	outside_inn_night.zx02
	echo "outside_inn_night_zx02: .incbin \"outside_inn_night.zx02\"" > outside_inn_night_graphics.inc


###

outside_inn.zx02:	outside_inn.hgr
	$(ZX02) -f outside_inn.hgr outside_inn.zx02

outside_inn.hgr:	outside_inn.png
	$(PNG2HGR) outside_inn.png > outside_inn.hgr

###

outside_inn_night.zx02:	outside_inn_night.hgr
	$(ZX02) -f outside_inn_night.hgr outside_inn_night.zx02

outside_inn_night.hgr:	outside_inn_night.png
	$(PNG2HGR) outside_inn_night.png > outside_inn_night.hgr


###

outside_inn_priority.inc:  \
	outside_inn_priority.zx02
	echo "outside_inn_priority_zx02: .incbin \"outside_inn_priority.zx02\"" > outside_inn_priority.inc

####

outside_inn_priority.zx02:	outside_inn_priority.combined
	$(ZX02) -f outside_inn_priority.combined outside_inn_priority.zx02

outside_inn_priority.combined:	outside_inn_priority.gr outside_inn_collision.bin
	cat outside_inn_priority.gr >  outside_inn_priority.combined
	cat outside_inn_collision.bin >> outside_inn_priority.combined

outside_inn_priority.gr:	outside_inn_priority.png
	$(PNG2GR) outside_inn_priority.png outside_inn_priority.gr

outside_inn_collision.bin:	outside_inn_collision.png
	$(PNG2COLLISION) outside_inn_collision.png outside_inn_collision.bin

####

clean:	
	rm -f *~ outside_inn_graphics.inc outside_inn_night_graphics.inc outside_inn_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


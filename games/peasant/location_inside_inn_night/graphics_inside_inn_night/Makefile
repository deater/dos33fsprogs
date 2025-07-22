PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	inside_inn_night_graphics.inc \
	inside_inn_night_priority.inc

###

inside_inn_night_graphics.inc:	\
	inside_inn_night.zx02
	echo "inside_inn_night_zx02: .incbin \"inside_inn_night.zx02\"" > inside_inn_night_graphics.inc

###

inside_inn_night.zx02:	inside_inn_night.hgr
	$(ZX02) -f inside_inn_night.hgr inside_inn_night.zx02

inside_inn_night.hgr:	inside_inn_night.png
	$(PNG2HGR) inside_inn_night.png > inside_inn_night.hgr

###

inside_inn_night_night.zx02:	inside_inn_night_night.hgr
	$(ZX02) -f inside_inn_night_night.hgr inside_inn_night_night.zx02

inside_inn_night_night.hgr:	inside_inn_night_night.png
	$(PNG2HGR) inside_inn_night_night.png > inside_inn_night_night.hgr


###

inside_inn_night_priority.inc:  \
	inside_inn_night_priority.zx02
	echo "inside_inn_night_priority_zx02: .incbin \"inside_inn_night_priority.zx02\"" > inside_inn_night_priority.inc

####

inside_inn_night_priority.zx02:	inside_inn_night_priority.combined
	$(ZX02) -f inside_inn_night_priority.combined inside_inn_night_priority.zx02

inside_inn_night_priority.combined:	inside_inn_night_priority.gr inside_inn_night_collision.bin
	cat inside_inn_night_priority.gr >  inside_inn_night_priority.combined
	cat inside_inn_night_collision.bin >> inside_inn_night_priority.combined

inside_inn_night_priority.gr:	inside_inn_night_priority.png
	$(PNG2GR) inside_inn_night_priority.png inside_inn_night_priority.gr

inside_inn_night_collision.bin:	inside_inn_night_collision.png
	$(PNG2COLLISION) inside_inn_night_collision.png inside_inn_night_collision.bin


####

clean:	
	rm -f *~ inside_inn_night_graphics.inc inside_inn_night_priority.inc *.zx02 *.gr *.hgr *.bin *.combined


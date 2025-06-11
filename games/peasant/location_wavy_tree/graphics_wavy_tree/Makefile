PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	ned_graphics.inc \
	ned_priority.inc

###

ned_graphics.inc:	\
	ned.zx02
	echo "ned_zx02: .incbin \"ned.zx02\"" > ned_graphics.inc

###

ned.zx02:	ned.hgr
	$(ZX02) -f ned.hgr ned.zx02

ned.hgr:	ned.png
	$(PNG2HGR) ned.png > ned.hgr

###

ned_priority.inc:  \
	ned_priority.zx02
	echo "ned_priority_zx02: .incbin \"ned_priority.zx02\"" > ned_priority.inc

####

ned_priority.zx02:	ned_priority.combined
	$(ZX02) -f ned_priority.combined ned_priority.zx02

ned_priority.combined:	ned_priority.gr ned_collision.bin
	cat ned_priority.gr >  ned_priority.combined
	cat ned_collision.bin >> ned_priority.combined

ned_priority.gr:	ned_priority.png
	$(PNG2GR) ned_priority.png ned_priority.gr

ned_collision.bin:	ned_collision.png
	$(PNG2COLLISION) ned_collision.png ned_collision.bin

####

clean:	
	rm -f *~ ned_graphics.inc ned_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


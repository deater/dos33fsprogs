PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	inn_graphics.inc \
	inn_priority.inc

###

inn_graphics.inc:	\
	inn.zx02
	echo "inn_zx02: .incbin \"inn.zx02\"" > inn_graphics.inc

###

inn.zx02:	inn.hgr
	$(ZX02) -f inn.hgr inn.zx02

inn.hgr:	inn.png
	$(PNG2HGR) inn.png > inn.hgr

###

inn_priority.inc:  \
	inn_priority.zx02
	echo "inn_priority_zx02: .incbin \"inn_priority.zx02\"" > inn_priority.inc

####

inn_priority.zx02:	inn_priority.combined
	$(ZX02) -f inn_priority.combined inn_priority.zx02

inn_priority.combined:	inn_priority.gr inn_collision.bin
	cat inn_priority.gr >  inn_priority.combined
	cat inn_collision.bin >> inn_priority.combined

inn_priority.gr:	inn_priority.png
	$(PNG2GR) inn_priority.png inn_priority.gr

inn_collision.bin:	inn_collision.png
	$(PNG2COLLISION) inn_collision.png inn_collision.bin

####

clean:	
	rm -f *~ inn_graphics.inc inn_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr


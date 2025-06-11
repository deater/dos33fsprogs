PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	hidden_glen_graphics.inc \
	hidden_glen_priority.inc

###

hidden_glen_graphics.inc:	\
	hidden_glen.zx02
	echo "hidden_glen_zx02: .incbin \"hidden_glen.zx02\"" > hidden_glen_graphics.inc

###

hidden_glen.zx02:	hidden_glen.hgr
	$(ZX02) -f hidden_glen.hgr hidden_glen.zx02

hidden_glen.hgr:	hidden_glen.png
	$(PNG2HGR) hidden_glen.png > hidden_glen.hgr

###

hidden_glen_priority.inc:  \
	hidden_glen_priority.zx02
	echo "hidden_glen_priority_zx02: .incbin \"hidden_glen_priority.zx02\"" > hidden_glen_priority.inc

####

hidden_glen_priority.zx02:	hidden_glen_priority.combined
	$(ZX02) -f hidden_glen_priority.combined hidden_glen_priority.zx02

hidden_glen_priority.combined:	hidden_glen_priority.gr hidden_glen_collision.bin
	cat hidden_glen_priority.gr >  hidden_glen_priority.combined
	cat hidden_glen_collision.bin >> hidden_glen_priority.combined

hidden_glen_priority.gr:	hidden_glen_priority.png
	$(PNG2GR) hidden_glen_priority.png hidden_glen_priority.gr

hidden_glen_collision.bin:	hidden_glen_collision.png
	$(PNG2COLLISION) hidden_glen_collision.png hidden_glen_collision.bin

####

clean:	
	rm -f *~ hidden_glen_graphics.inc hidden_glen_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr



PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	cliff_graphics.inc \
	priority_cliff.inc

###

cliff_graphics.inc:	\
	cliff_base.hgr.zx02
	echo "cliff_base_zx02: .incbin \"cliff_base.hgr.zx02\"" > cliff_graphics.inc

###

cliff_base.hgr.zx02:	cliff_base.hgr
	$(ZX02) -f cliff_base.hgr cliff_base.hgr.zx02

cliff_base.hgr:	cliff_base.png
	$(PNG2HGR) cliff_base.png > cliff_base.hgr

###

priority_cliff.inc:  \
	cliff_base_priority.zx02
	echo "cliff_base_priority_zx02: .incbin \"cliff_base_priority.zx02\"" > priority_cliff.inc

####

cliff_base_priority.zx02:	cliff_base_priority.combined
	$(ZX02) -f cliff_base_priority.combined cliff_base_priority.zx02

cliff_base_priority.combined:	cliff_base_priority.gr cliff_base_collision.bin
	cat cliff_base_priority.gr > cliff_base_priority.combined
	cat cliff_base_collision.bin >> cliff_base_priority.combined

cliff_base_priority.gr:	cliff_base_priority.png
	$(PNG2GR) cliff_base_priority.png cliff_base_priority.gr

cliff_base_collision.bin:	cliff_base_collision.png
	$(PNG2COLLISION) cliff_base_collision.png cliff_base_collision.bin

####

clean:	
	rm -f *~ cliff_graphics.inc priority_cliff.inc \
		*.combined *.bin *.zx02 *.gr *.hgr


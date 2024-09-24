
PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	cliff_graphics.inc \
	priority_cliff.inc

###

cliff_graphics.inc:	\
	cliff_base.zx02
	echo "cliff_base_zx02: .incbin \"cliff_base.zx02\"" > cliff_graphics.inc

###

cliff_base.zx02:	cliff_base.hgr
	$(ZX02) -f cliff_base.hgr cliff_base.zx02

cliff_base.hgr:	cliff_base.png
	$(PNG2HGR) cliff_base.png > cliff_base.hgr

###

priority_cliff.inc:  \
	cliff_base_priority.zx02
	echo "cliff_base_priority_zx02: .incbin \"cliff_base_priority.zx02\"" > priority_cliff.inc

####

cliff_base_priority.zx02:	cliff_base_priority.gr
	$(ZX02) -f cliff_base_priority.gr cliff_base_priority.zx02

cliff_base_priority.gr:	cliff_base_priority.png
	$(PNG2GR) cliff_base_priority.png cliff_base_priority.gr

####

clean:	
	rm -f *~ cliff_graphics.inc priority_cliff.inc *.zx02 *.gr *.hgr


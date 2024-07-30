include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	doorway_graphics.inc

doorway_graphics.inc:	\
	top_e.hgr.zx02 top_w.hgr.zx02 \
	peephole_w.hgr.zx02 \
	view1_w.hgr.zx02
	echo "top_e_zx02: .incbin \"top_e.hgr.zx02\"" > doorway_graphics.inc
	echo "top_w_zx02: .incbin \"top_w.hgr.zx02\"" >> doorway_graphics.inc
	echo "peephole_w_zx02: .incbin \"peephole_w.hgr.zx02\"" >> doorway_graphics.inc
	echo "view1_w_zx02: .incbin \"view1_w.hgr.zx02\"" >> doorway_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr doorway_graphics.inc


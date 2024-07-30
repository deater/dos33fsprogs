include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	cave_graphics.inc

cave_graphics.inc:	\
	ladder_e.hgr.zx02 ladder_w.hgr.zx02 \
	middle_e.hgr.zx02 middle_w.hgr.zx02 \
	underdoor_e.hgr.zx02
	echo "ladder_e_zx02: .incbin \"ladder_e.hgr.zx02\"" > cave_graphics.inc
	echo "ladder_w_zx02: .incbin \"ladder_w.hgr.zx02\"" >> cave_graphics.inc
	echo "middle_e_zx02: .incbin \"middle_e.hgr.zx02\"" >> cave_graphics.inc
	echo "middle_w_zx02: .incbin \"middle_w.hgr.zx02\"" >> cave_graphics.inc
	echo "underdoor_e_zx02: .incbin \"underdoor_e.hgr.zx02\"" >> cave_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr cave_graphics.inc


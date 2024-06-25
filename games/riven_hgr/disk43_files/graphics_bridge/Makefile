include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	bridge_graphics.inc

bridge_graphics.inc:	\
	bridge_e.hgr.zx02 bridge_w.hgr.zx02 \
	bridge_far_e.hgr.zx02 bridge_far_w.hgr.zx02
	echo "bridge_e_zx02: .incbin \"bridge_e.hgr.zx02\"" > bridge_graphics.inc
	echo "bridge_w_zx02: .incbin \"bridge_w.hgr.zx02\"" >> bridge_graphics.inc
	echo "bridge_far_e_zx02: .incbin \"bridge_far_e.hgr.zx02\"" >> bridge_graphics.inc
	echo "bridge_far_w_zx02: .incbin \"bridge_far_w.hgr.zx02\"" >> bridge_graphics.inc



####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr bridge_graphics.inc


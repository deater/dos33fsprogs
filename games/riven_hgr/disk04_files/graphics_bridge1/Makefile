include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	bridge1_graphics.inc

bridge1_graphics.inc:	\
	bridge1_w.hgr.zx02 bridge1_e.hgr.zx02
	echo "bridge1_w_zx02: .incbin \"bridge1_w.hgr.zx02\"" > bridge1_graphics.inc
	echo "bridge1_e_zx02: .incbin \"bridge1_e.hgr.zx02\"" >> bridge1_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr bridge1_graphics.inc


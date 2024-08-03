include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	tunnel1_graphics.inc

tunnel1_graphics.inc:	\
	tunnel1_w.hgr.zx02 tunnel1_e.hgr.zx02 \
	tunnel2_w.hgr.zx02 tunnel2_e.hgr.zx02
	echo "tunnel1_w_zx02: .incbin \"tunnel1_w.hgr.zx02\"" > tunnel1_graphics.inc
	echo "tunnel1_e_zx02: .incbin \"tunnel1_e.hgr.zx02\"" >> tunnel1_graphics.inc
	echo "tunnel2_w_zx02: .incbin \"tunnel2_w.hgr.zx02\"" >> tunnel1_graphics.inc
	echo "tunnel2_e_zx02: .incbin \"tunnel2_e.hgr.zx02\"" >> tunnel1_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr tunnel1_graphics.inc


include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	tunnel7_graphics.inc

tunnel7_graphics.inc:	\
	tunnel7_w.hgr.zx02 tunnel7_e.hgr.zx02 \
	tunnel8_w.hgr.zx02 tunnel8_e.hgr.zx02 \
	tunnel8_open_e.hgr.zx02
	echo "tunnel7_w_zx02: .incbin \"tunnel7_w.hgr.zx02\"" > tunnel7_graphics.inc
	echo "tunnel7_e_zx02: .incbin \"tunnel7_e.hgr.zx02\"" >> tunnel7_graphics.inc
	echo "tunnel8_w_zx02: .incbin \"tunnel8_w.hgr.zx02\"" >> tunnel7_graphics.inc
	echo "tunnel8_e_zx02: .incbin \"tunnel8_e.hgr.zx02\"" >> tunnel7_graphics.inc
	echo "tunnel8_open_e_zx02: .incbin \"tunnel8_open_e.hgr.zx02\"" >> tunnel7_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr tunnel7_graphics.inc


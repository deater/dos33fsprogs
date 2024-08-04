include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	tunnel4_graphics.inc

tunnel4_graphics.inc:	\
	tunnel4_w.hgr.zx02 tunnel4_e.hgr.zx02 \
	tunnel5_w.hgr.zx02 tunnel5_e.hgr.zx02
	echo "tunnel4_w_zx02: .incbin \"tunnel4_w.hgr.zx02\"" > tunnel4_graphics.inc
	echo "tunnel4_e_zx02: .incbin \"tunnel4_e.hgr.zx02\"" >> tunnel4_graphics.inc
	echo "tunnel5_w_zx02: .incbin \"tunnel5_w.hgr.zx02\"" >> tunnel4_graphics.inc
	echo "tunnel5_e_zx02: .incbin \"tunnel5_e.hgr.zx02\"" >> tunnel4_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr tunnel4_graphics.inc


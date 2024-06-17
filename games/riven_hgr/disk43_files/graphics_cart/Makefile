include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr

all:	cart_graphics.inc

cart_graphics.inc:	\
	cart_n.hgr.zx02 cart_w.hgr.zx02 cart_e.hgr.zx02 cart_s.hgr.zx02 \
	in_cart_e.hgr.zx02
	echo "cart_n_zx02: .incbin \"cart_n.hgr.zx02\"" > cart_graphics.inc
	echo "cart_w_zx02: .incbin \"cart_w.hgr.zx02\"" >> cart_graphics.inc
	echo "cart_e_zx02: .incbin \"cart_e.hgr.zx02\"" >> cart_graphics.inc
	echo "cart_s_zx02: .incbin \"cart_s.hgr.zx02\"" >> cart_graphics.inc
	echo "in_cart_e_zx02: .incbin \"in_cart_e.hgr.zx02\"" >> cart_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr cart_graphics.inc


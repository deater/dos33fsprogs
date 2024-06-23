include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	tunnel_graphics.inc

tunnel_graphics.inc:	\
	tunnel5_s.hgr.zx02 tunnel5_n.hgr.zx02 \
	tunnel6_s.hgr.zx02 tunnel6_n.hgr.zx02 \
	tunnel7_s.hgr.zx02 tunnel7_n.hgr.zx02 \
	tunnel8_s.hgr.zx02 tunnel8_n.hgr.zx02
	echo "tunnel5_s_zx02: .incbin \"tunnel5_s.hgr.zx02\"" > tunnel_graphics.inc
	echo "tunnel5_n_zx02: .incbin \"tunnel5_n.hgr.zx02\"" >> tunnel_graphics.inc
	echo "tunnel6_s_zx02: .incbin \"tunnel6_s.hgr.zx02\"" >> tunnel_graphics.inc
	echo "tunnel6_n_zx02: .incbin \"tunnel6_n.hgr.zx02\"" >> tunnel_graphics.inc
	echo "tunnel7_s_zx02: .incbin \"tunnel7_s.hgr.zx02\"" >> tunnel_graphics.inc
	echo "tunnel7_n_zx02: .incbin \"tunnel7_n.hgr.zx02\"" >> tunnel_graphics.inc
	echo "tunnel8_s_zx02: .incbin \"tunnel8_s.hgr.zx02\"" >> tunnel_graphics.inc
	echo "tunnel8_n_zx02: .incbin \"tunnel8_n.hgr.zx02\"" >> tunnel_graphics.inc



####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr tunnel_graphics.inc


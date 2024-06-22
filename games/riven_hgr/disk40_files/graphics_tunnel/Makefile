include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	tunnel_graphics.inc

tunnel_graphics.inc:	\
	tunnel1_s.hgr.zx02 tunnel1_n.hgr.zx02 \
	tunnel2_s.hgr.zx02 tunnel2_n.hgr.zx02 \
	tunnel3_s.hgr.zx02 tunnel3_n.hgr.zx02 \
	tunnel4_s.hgr.zx02 tunnel4_n.hgr.zx02
	echo "tunnel1_s_zx02: .incbin \"tunnel1_s.hgr.zx02\"" > tunnel_graphics.inc
	echo "tunnel1_n_zx02: .incbin \"tunnel1_n.hgr.zx02\"" >> tunnel_graphics.inc
	echo "tunnel2_s_zx02: .incbin \"tunnel2_s.hgr.zx02\"" >> tunnel_graphics.inc
	echo "tunnel2_n_zx02: .incbin \"tunnel2_n.hgr.zx02\"" >> tunnel_graphics.inc
	echo "tunnel3_s_zx02: .incbin \"tunnel3_s.hgr.zx02\"" >> tunnel_graphics.inc
	echo "tunnel3_n_zx02: .incbin \"tunnel3_n.hgr.zx02\"" >> tunnel_graphics.inc
	echo "tunnel4_s_zx02: .incbin \"tunnel4_s.hgr.zx02\"" >> tunnel_graphics.inc
	echo "tunnel4_n_zx02: .incbin \"tunnel4_n.hgr.zx02\"" >> tunnel_graphics.inc


####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr tunnel_graphics.inc


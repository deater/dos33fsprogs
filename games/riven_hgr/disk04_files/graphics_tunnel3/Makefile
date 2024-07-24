include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	tunnel3_graphics.inc

tunnel3_graphics.inc:	\
	tunnel3_n.hgr.zx02 tunnel3_w.hgr.zx02 tunnel3_e.hgr.zx02 \
	tunnel3_open_n.hgr.zx02
	echo "tunnel3_n_zx02: .incbin \"tunnel3_n.hgr.zx02\"" > tunnel3_graphics.inc
	echo "tunnel3_w_zx02: .incbin \"tunnel3_w.hgr.zx02\"" >> tunnel3_graphics.inc
	echo "tunnel3_e_zx02: .incbin \"tunnel3_e.hgr.zx02\"" >> tunnel3_graphics.inc
	echo "tunnel3_open_n_zx02: .incbin \"tunnel3_open_n.hgr.zx02\"" >> tunnel3_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr tunnel3_graphics.inc


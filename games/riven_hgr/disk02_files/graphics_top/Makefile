include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	top_graphics.inc

top_graphics.inc:	\
	top_n.hgr.zx02 top_s.hgr.zx02 top_e.hgr.zx02 top_w.hgr.zx02
	echo "top_n_zx02: .incbin \"top_n.hgr.zx02\"" > top_graphics.inc
	echo "top_s_zx02: .incbin \"top_s.hgr.zx02\"" >> top_graphics.inc
	echo "top_e_zx02: .incbin \"top_e.hgr.zx02\"" >> top_graphics.inc
	echo "top_w_zx02: .incbin \"top_w.hgr.zx02\"" >> top_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr top_graphics.inc


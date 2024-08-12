include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	mid_graphics.inc

mid_graphics.inc:	\
	mid_n.hgr.zx02 mid_s.hgr.zx02 \
	mid_w.hgr.zx02 mid_e.hgr.zx02 \
	mid_n_open.hgr.zx02
	echo "mid_n_zx02: .incbin \"mid_n.hgr.zx02\"" > mid_graphics.inc
	echo "mid_s_zx02: .incbin \"mid_s.hgr.zx02\"" >> mid_graphics.inc
	echo "mid_w_zx02: .incbin \"mid_w.hgr.zx02\"" >> mid_graphics.inc
	echo "mid_e_zx02: .incbin \"mid_e.hgr.zx02\"" >> mid_graphics.inc
	echo "mid_n_open_zx02: .incbin \"mid_n_open.hgr.zx02\"" >> mid_graphics.inc


####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr mid_graphics.inc


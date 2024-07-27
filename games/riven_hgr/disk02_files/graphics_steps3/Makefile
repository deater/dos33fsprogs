include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	steps3_graphics.inc

steps3_graphics.inc:	\
	steps3_n.hgr.zx02 steps3_s.hgr.zx02 \
	steps4_n.hgr.zx02 steps4_s.hgr.zx02
	echo "steps3_n_zx02: .incbin \"steps3_n.hgr.zx02\"" > steps3_graphics.inc
	echo "steps3_s_zx02: .incbin \"steps3_s.hgr.zx02\"" >> steps3_graphics.inc
	echo "steps4_n_zx02: .incbin \"steps4_n.hgr.zx02\"" >> steps3_graphics.inc
	echo "steps4_s_zx02: .incbin \"steps4_s.hgr.zx02\"" >> steps3_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr steps3_graphics.inc


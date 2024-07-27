include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	steps1_graphics.inc

steps1_graphics.inc:	\
	steps1_n.hgr.zx02 steps1_s.hgr.zx02 \
	steps2_n.hgr.zx02 steps2_s.hgr.zx02
	echo "steps1_n_zx02: .incbin \"steps1_n.hgr.zx02\"" > steps1_graphics.inc
	echo "steps1_s_zx02: .incbin \"steps1_s.hgr.zx02\"" >> steps1_graphics.inc
	echo "steps2_n_zx02: .incbin \"steps2_n.hgr.zx02\"" >> steps1_graphics.inc
	echo "steps2_s_zx02: .incbin \"steps2_s.hgr.zx02\"" >> steps1_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr steps1_graphics.inc


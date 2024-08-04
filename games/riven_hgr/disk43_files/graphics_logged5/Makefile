include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	logged5_graphics.inc

logged5_graphics.inc:	\
	logged5_w.hgr.zx02 logged5_e.hgr.zx02 \
	logged5_n.hgr.zx02 logged5_s.hgr.zx02
	echo "logged5_w_zx02: .incbin \"logged5_w.hgr.zx02\"" > logged5_graphics.inc
	echo "logged5_e_zx02: .incbin \"logged5_e.hgr.zx02\"" >> logged5_graphics.inc
	echo "logged5_n_zx02: .incbin \"logged5_n.hgr.zx02\"" >> logged5_graphics.inc
	echo "logged5_s_zx02: .incbin \"logged5_s.hgr.zx02\"" >> logged5_graphics.inc


####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr logged5_graphics.inc


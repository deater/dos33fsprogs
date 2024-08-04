include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	logged3_graphics.inc

logged3_graphics.inc:	\
	logged3_w.hgr.zx02 logged3_e.hgr.zx02 \
	logged3_n.hgr.zx02 logged3_s.hgr.zx02
	echo "logged3_w_zx02: .incbin \"logged3_w.hgr.zx02\"" > logged3_graphics.inc
	echo "logged3_e_zx02: .incbin \"logged3_e.hgr.zx02\"" >> logged3_graphics.inc
	echo "logged3_n_zx02: .incbin \"logged3_n.hgr.zx02\"" >> logged3_graphics.inc
	echo "logged3_s_zx02: .incbin \"logged3_s.hgr.zx02\"" >> logged3_graphics.inc


####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr logged3_graphics.inc


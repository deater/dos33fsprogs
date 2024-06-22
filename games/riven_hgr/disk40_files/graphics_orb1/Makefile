include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	orb1_graphics.inc

orb1_graphics.inc:	\
	orb_n.hgr.zx02 orb2_n.hgr.zx02
	echo "orb_n_zx02: .incbin \"orb_n.hgr.zx02\"" > orb1_graphics.inc
	echo "orb2_n_zx02: .incbin \"orb2_n.hgr.zx02\"" >> orb1_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr orb1_graphics.inc


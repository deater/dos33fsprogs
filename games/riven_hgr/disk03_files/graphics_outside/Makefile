include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	outside_graphics.inc

outside_graphics.inc:	\
	outside_n.hgr.zx02 outside_s.hgr.zx02
	echo "outside_n_zx02: .incbin \"outside_n.hgr.zx02\"" > outside_graphics.inc
	echo "outside_s_zx02: .incbin \"outside_s.hgr.zx02\"" >> outside_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr outside_graphics.inc


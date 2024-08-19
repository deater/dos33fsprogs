include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	15_graphics.inc

15_graphics.inc:	\
	pillars_15_in.hgr.zx02 pillars_15_out.hgr.zx02
	echo "pillars_15_in_zx02: .incbin \"pillars_15_in.hgr.zx02\"" > 15_graphics.inc
	echo "pillars_15_out_zx02: .incbin \"pillars_15_out.hgr.zx02\"" >> 15_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr 15_graphics.inc


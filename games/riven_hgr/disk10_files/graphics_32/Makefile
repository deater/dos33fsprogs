include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	32_graphics.inc

32_graphics.inc:	\
	pillars_32_in.hgr.zx02 pillars_32_out.hgr.zx02
	echo "pillars_32_in_zx02: .incbin \"pillars_32_in.hgr.zx02\"" > 32_graphics.inc
	echo "pillars_32_out_zx02: .incbin \"pillars_32_out.hgr.zx02\"" >> 32_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr 32_graphics.inc


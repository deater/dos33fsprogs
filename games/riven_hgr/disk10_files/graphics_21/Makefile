include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	21_graphics.inc

21_graphics.inc:	\
	pillars_21_in.hgr.zx02 pillars_21_out.hgr.zx02
	echo "pillars_21_in_zx02: .incbin \"pillars_21_in.hgr.zx02\"" > 21_graphics.inc
	echo "pillars_21_out_zx02: .incbin \"pillars_21_out.hgr.zx02\"" >> 21_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr 21_graphics.inc


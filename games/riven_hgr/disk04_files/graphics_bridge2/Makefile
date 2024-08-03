include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	bridge2_graphics.inc

bridge2_graphics.inc:	\
	bridge2_w.hgr.zx02 bridge2_e.hgr.zx02
	echo "bridge2_w_zx02: .incbin \"bridge2_w.hgr.zx02\"" > bridge2_graphics.inc
	echo "bridge2_e_zx02: .incbin \"bridge2_e.hgr.zx02\"" >> bridge2_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr bridge2_graphics.inc


include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	bridge2_graphics.inc

bridge2_graphics.inc:	\
	dome_bridge2_n.hgr.zx02 dome_bridge2_s.hgr.zx02
	echo "dome_bridge2_n_zx02: .incbin \"dome_bridge2_n.hgr.zx02\"" > bridge2_graphics.inc
	echo "dome_bridge2_s_zx02: .incbin \"dome_bridge2_s.hgr.zx02\"" >> bridge2_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr bridge2_graphics.inc


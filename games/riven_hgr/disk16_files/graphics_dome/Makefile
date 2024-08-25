include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	dome_graphics.inc

dome_graphics.inc:	\
	inside_dome_n.hgr.zx02 inside_dome_s.hgr.zx02
	echo "inside_dome_n_zx02: .incbin \"inside_dome_n.hgr.zx02\"" > dome_graphics.inc
	echo "inside_dome_s_zx02: .incbin \"inside_dome_s.hgr.zx02\"" >> dome_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr dome_graphics.inc


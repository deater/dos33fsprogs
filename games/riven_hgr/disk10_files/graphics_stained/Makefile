include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	stained_graphics.inc

stained_graphics.inc:	\
	stained03.hgr.zx02
	echo "stained03_zx02: .incbin \"stained03.hgr.zx02\"" > stained_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr stained_graphics.inc


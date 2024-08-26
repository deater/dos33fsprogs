include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	spires_graphics.inc

spires_graphics.inc:	\
	spires_n.hgr.zx02
	echo "spires_n_zx02: .incbin \"spires_n.hgr.zx02\"" > spires_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr spires_graphics.inc

